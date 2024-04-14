import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/download_file.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/tag.dart';
import 'package:vocab_blast/model/tagging.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/vocabulary.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';

class DownloadNotifier extends StateNotifier<DownloadFile>{

  final TextBook _textbook;
  DownloadNotifier(this._textbook) : super(const DownloadFile()){
    getInfo();
    getFileSize();
  }

  Future<void> getInfo() async {
    final isExists = await VocabBlastDatabase.instance.textbookExists(_textbook.checkId);
    state = state.copyWith(textId: _textbook.checkId, type: _textbook.type, isExists: isExists);
  }

  Future<void> startDownload() async {
    state = state.copyWith(isDownloading: true);
  }

  Future<void> finishDownload() async {
    state = state.copyWith(isDownloading: false);
  }

  Future<void> downloadFile() async {

    if(_textbook.type == 'vocab'){
      await downloadVocabBook();
    }else if(_textbook.type == 'comp'){
      await downloadCompBook();
    }else if(_textbook.type == 'quiz'){
      print('called');
      await downloadQuizBook();
    }else{
      throw '';
    }
  }

  Future<void> getFileSize() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileRef = storage.ref().child("public_textbooks").child('${_textbook.checkId}.csv');
    final refMetadata = await fileRef.getMetadata();
    final bytes = refMetadata.size;
    if(bytes != null){
      const int KB = 1024;
      const int MB = KB * 1024;
      const int GB = MB * 1024;
      String fileSize= '';
      if (bytes >= GB) {
        fileSize =  '${(bytes / GB).toStringAsFixed(2)} GB';
      } else if (bytes >= MB) {
        fileSize = '${(bytes / MB).toStringAsFixed(2)} MB';
      } else if (bytes >= KB) {
        fileSize = '${(bytes / KB).toStringAsFixed(2)} KB';
      } else {
        fileSize = '$bytes bytes';
      }
      state = state.copyWith(size: fileSize);
    }
  }

  Future<void> downloadCompBook() async{

    //if(_textbook.id == null) throw '';

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileRef = storage.ref().child("public_textbooks").child('${_textbook.checkId}.csv');
    final fileUrl = await fileRef.getData();

    final decoder = utf8.decoder;
    const splitter = LineSplitter();

    final fileData = decoder.convert(fileUrl!);
    final lines = splitter.convert(fileData);
    final  exp = RegExp(r'\"(.*?)\"');
    List<Sentence> allData = [];
    for (var line in lines) {
      final match = exp.allMatches(line);
      String sentence = match.elementAt(0).group(0) ?? '';
      String translation = match.elementAt(1).group(0) ?? '';
      String newSentence = sentence.replaceAll("\"", "");
      String newTranslation = translation.replaceAll("\"", "");
      allData.add(Sentence(textId: _textbook.checkId,sentence: newSentence, translation: newTranslation, done: 0));
    }
    await VocabBlastDatabase.instance.insertSentences(allData);

  }

  Future<void> downloadVocabBook() async{

    //if(_textbook.id == null) throw '';

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileRef = storage.ref().child("public_textbooks").child('${_textbook.checkId}.csv');
    final fileUrl = await fileRef.getData();

    final decoder = utf8.decoder;
    const splitter = LineSplitter();

    final fileData = decoder.convert(fileUrl!);
    final lines = splitter.convert(fileData);
    final  exp = RegExp(r'\"(.*?)\"');

    List<Vocab> allData = [];
    for (var line in lines) {
      final match = exp.allMatches(line);

      String word = match.elementAt(0).group(0) ?? '';
      String meaning = match.elementAt(1).group(0) ?? '';
      String sentence = match.elementAt(2).group(0) ?? '';
      String translation = match.elementAt(3).group(0) ?? '';

      String newWord = word.replaceAll("\"", "");
      String newMeaning = meaning.replaceAll("\"", "");
      String newSentence = sentence.replaceAll("\"", "");
      String newTranslation = translation.replaceAll("\"", "");

      allData.add(Vocab(textId: _textbook.checkId, word: newWord, meaning: newMeaning, sentence: newSentence, translation: newTranslation, done: 0));
    }

    await VocabBlastDatabase.instance.insertVocabs(allData);

  }

  Future<void> downloadQuizBook() async{

    //if(_textbook.id == null) throw '';

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference fileRef = storage.ref().child("public_textbooks").child('${_textbook.checkId}.csv');
    final fileUrl = await fileRef.getData();

    final decoder = utf8.decoder;
    const splitter = LineSplitter();

    final fileData = decoder.convert(fileUrl!);
    final lines = splitter.convert(fileData);
    final  exp = RegExp(r'\"(.*?)\"');

    List<Quiz> allData = [];
    print('start');
    for (var line in lines) {
      final match = exp.allMatches(line);


      String question = match.elementAt(0).group(0) ?? '';
      String choice0 = match.elementAt(1).group(0) ?? '';
      String choice1 = match.elementAt(2).group(0) ?? '';
      String choice2 = match.elementAt(3).group(0) ?? '';
      String choice3 = match.elementAt(4).group(0) ?? '';
      String answer = match.elementAt(5).group(0) ?? '-1';
      String sentence = match.elementAt(6).group(0) ?? '';
      String translation = match.elementAt(7).group(0) ?? '';
      String explanation = match.elementAt(8).group(0) ?? '';

      String newQuestion = question.replaceAll("\"", "");
      String newChoice0 = choice0.replaceAll("\"", "");
      String newChoice1 = choice1.replaceAll("\"", "");
      String newChoice2 = choice2.replaceAll("\"", "");
      String newChoice3 = choice3.replaceAll("\"", "");
      String answerStr = answer.replaceAll("\"", "");

      int newAnswer = int.parse(answerStr);
      String newSentence = sentence.replaceAll("\"", "");
      String newTranslation = translation.replaceAll("\"", "");
      String newExplanation = explanation.replaceAll("\"", "");

      allData.add(Quiz(textId: _textbook.checkId, question: newQuestion, choice0 : newChoice0, choice1: newChoice1, choice2: newChoice2, choice3: newChoice3, answer: newAnswer, sentence: newSentence, translation: newTranslation, explanation: newExplanation, done: 0));
    }

    print('finished');
    await VocabBlastDatabase.instance.insertQuizzes(allData);

  }

  Future<void> insertTextBook(List<String> tagNames) async {

    final vocabBlastDatabase = VocabBlastDatabase.instance;

    final newTextbook = await vocabBlastDatabase.createTextbook(_textbook.copy(date: ''));
    state = state.copyWith(isExists: true);
    List<Tag> tags = tagNames.map((tag)=> Tag(name: tag)).toList();

    for (var tag in tags) {
      if(await vocabBlastDatabase.tagExists(tag.name)){
        final tagId = await vocabBlastDatabase.readTagId(tag);
        final tagging = Tagging(tagId: tagId, textbookId: newTextbook.id!);
        await vocabBlastDatabase.createTagging(tagging);
      }else{
        final newTag = await vocabBlastDatabase.createTag(tag);
        final tagging = Tagging(tagId: newTag.id!, textbookId: newTextbook.id!);
        await vocabBlastDatabase.createTagging(tagging);
      }
    }
  }


}