import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/essay.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:vocab_blast/model/user_setting.dart';

final essayProvider = StateNotifierProvider.family.autoDispose<EssayNotifier, Essay,String>((ref, topic) {
  return EssayNotifier(topic);
});


class EssayNotifier extends StateNotifier<Essay>{

  EssayNotifier(this.topic) : super(const Essay()){
    state = state.copyWith(topic: topic);
    textEditingController.addListener(_onTextChanged);
  }
  final String topic;
  final TextEditingController textEditingController = TextEditingController();

  final RegExp regex = RegExp(r"^[a-zA-Z0-9!?\-_+.,’'%:;@/()\s]*$");
  final openAI = OpenAI.instance.build(token: dotenv.env['chat_gpt_api'],baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 500)),enableLog: true);

  void _onTextChanged() {
    final text = textEditingController.text;
    final filteredText = _filterInput(text);
    final isValidInput = _isValidInput(text);
    final numWords = _countWords(text);
    state = state.copyWith(content:filteredText,isValidInput: isValidInput,numWords: numWords);
  }

  bool _isValidInput(String input) {
    return regex.hasMatch(input);
  }

  String _filterInput(String input) {
    return regex.allMatches(input).map((match) => match.group(0)).join();
  }

  int _countWords(String input){
    RegExp regExp = RegExp(" ");
    if(input.isEmpty)return 0;
    if(input.endsWith(' ') ) return regExp.allMatches(input).length;
    return regExp.allMatches(input).length + 1;
  }

  void chatCompleteWithSSE(String rule) async {
    final request = ChatCompleteText(messages: [
      Messages(role: Role.system, content: rule),
      Messages(role: Role.system, content: state.content)
    ], maxToken: 1500, model: GptTurboChatModel());

    openAI.onChatCompletionSSE(request: request).listen((it) {
      if(it.choices?.last.message != null){
        state = state.copyWith(comment: state.comment + it.choices!.last.message!.content);
      }
    });
    ChatCTResponse? response = await openAI.onChatCompletion(request: request);
    debugPrint("$response");
  }

  bool checkState(UserSetting userInfo,String wordsLength) {

    final Map<String, int> willUseToken = {
      '25 ~ 35' : 600,
      '60 ~ 80' : 800,
      '80 ~ 100' : 1000,
      '120 ~ 150' : 1500,
      '200 ~ 240' : 2000,
    };
    if(willUseToken[wordsLength] == null) return false;
    if(!state.isValidInput) return false;
    if(state.content == '' || state.numWords < 20) return false;
    if(userInfo.token < willUseToken[wordsLength]!) return false;
    return true;
  }

  Map<String,String> makeMessage(UserSetting userInfo,String wordsLength) {
    String title = '';
    String content = '';
    final Map<String, int> willUseToken = {
      '25 ~ 35' : 600,
      '60 ~ 80' : 800,
      '80 ~ 100' : 1000,
      '120 ~ 150' : 1500,
      '200 ~ 240' : 2000,
    };
    final Map<String, int> maxLength = {
      '25 ~ 35' : 45,
      '60 ~ 80' : 90,
      '80 ~ 100' : 110,
      '120 ~ 150' : 160,
      '200 ~ 240' : 250,
    };

    if(!state.isValidInput){
      title = '使用できない文字が含まれています。';
      content = '文章を修正してください。';
    }
    if(state.numWords < 20){
      title = '文章が短すぎます';
      content = '文章を書き加えてください。';
    }
    if(state.numWords > maxLength[wordsLength]!){
      title = '文字数がオーバーしています。';
      content = '文字数を削減してください。';
    }
    if(userInfo.token < willUseToken[wordsLength]!){
      title = 'トークンが不足しています。';
      content = '広告を視聴しトークンを獲得してください';
    }
    return {'title': title, 'content' : content};
  }

  String makePrompt(String topic, String wordsLength, String yourLevel) {

    final Map<String, String> length = {
      '25 ~ 35' : '25-30',
      '60 ~ 80' : '60-80',
      '80 ~ 100' : '80-100',
      '120 ~ 150' : '120-150',
      '200 ~ 240' : '200-240',
    };

    final Map<String,String> level = {
      '小学生' : 'elementary school students',
      '中学生' : 'middle school students',
      '高校生' : 'high school students',
      '大学生' : 'university students',
    };

    final Map<String,String> essayLevel = {
      '小学生' : 'elementary school level',
      '中学生' : 'middle school level',
      '高校生' : 'high school level',
      '大学生' : 'university level',
    };
    final String prompt =
    '''
#Command: You are a professional English tutor from the United States. Given the following constraints, provide the best corrections to the essay on the given topic.

#Constraints:
・The essay should be within${length[wordsLength]} words
・Easily understandable for Japanese ${level[yourLevel]}
・Correct grammatical errors, suggest better expressions if applicable
・Specify the only corrected parts without the reason for the correction
・Explain the reason for the correction in Japanese
・Separate the corrected parts and the reason for the correction
・List the corrected parts and the reasons for the correction
・Propose a ${essayLevel[yourLevel]} essay within ${length[wordsLength]} words
・Follow the format below

#Topic
$topic 

#Output format
添削後のエッセイ: (write in English)
添削後のエッセイの日本語訳: (write in Japanese)
訂正箇所:
・"-----" → "-----"
訂正理由: (write in Japanese)
提案エッセイ: (write in English)
提案エッセイの日本語訳: (write in Japanese)
''';
    return prompt;
  }


}