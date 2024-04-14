import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/user_setting.dart';
import 'package:vocab_blast/workbook_page.dart';
import 'package:vocab_blast/notifier/book_notifier.dart';
import 'package:vocab_blast/notifier/interstitial_ad_notifier.dart';
import 'notifier/user_notifier.dart';

class ExplanationPage extends ConsumerWidget {

  const ExplanationPage(this.quizzes, this.quizIndex, this.yourAnswerIndex, this._textbook, {super.key});

  final List<Quiz> quizzes;
  final int quizIndex;
  final int yourAnswerIndex;
  final TextBook _textbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final UserSetting userSetting = ref.watch(userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()async{

            ref.invalidate(booksStateProvider(Tuple2(_textbook,userSetting)));
            Navigator.of(context).pop();

            await ref.read(userInfoProvider.notifier).updateTimes();
            if(5 < ref.watch(userInfoProvider).times){
              await ref.read(userInfoProvider.notifier).subTimes();
              ref.read(adProvider.notifier).showAd();
            }
          },
          icon: const Icon(Icons.close, color: Colors.black87,),
        ),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                Color(0xffe0ffff),
                Color(0xffcbf1e7),
                Color(0xffdbffd7),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Q${quizIndex + 1}',style: const TextStyle(fontSize: 18),),
            Text(quizzes[quizIndex].question,style: const TextStyle(fontSize: 17),),
            const SizedBox(height: 30,),

            if(quizzes[quizIndex].choice0 != '')Text('(A) ${quizzes[quizIndex].choice0}',
              style: TextStyle(
                  fontSize: 17,
                  color: colorTheLetters(0,quizzes[quizIndex].answer, yourAnswerIndex)
              ),
            ),

            if(quizzes[quizIndex].choice1 != '')Text('(B) ${quizzes[quizIndex].choice1}',
              style: TextStyle(
                fontSize: 17,
                color: colorTheLetters(1,quizzes[quizIndex].answer, yourAnswerIndex),

              ),
            ),

            if(quizzes[quizIndex].choice2 != '')Text('(C) ${quizzes[quizIndex].choice2}',
              style: TextStyle(
                fontSize: 17,
                color: colorTheLetters(2,quizzes[quizIndex].answer, yourAnswerIndex),
              ),
            ),
            if(quizzes[quizIndex].choice3 != '')Text('(D) ${quizzes[quizIndex].choice3}',
              style: TextStyle(
                fontSize: 17,
                color: colorTheLetters(3,quizzes[quizIndex].answer, yourAnswerIndex),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                child: Text('文と和訳'),
              ),
            ),
            Text(quizzes[quizIndex].sentence,style: const TextStyle(fontSize: 15,color: Colors.black54),),
            const SizedBox(
              height: 10,
            ),
            Text(quizzes[quizIndex].translation,style: const TextStyle(fontSize: 15, color: Colors.black54),),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                child: Text('解説'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(quizzes[quizIndex].explanation,style: const TextStyle(fontSize: 15, color: Colors.black54),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        elevation: 0.0,
        child: const Text('次へ'),
        onPressed: () async {
          if(quizzes.length == (quizIndex + 1)){
            ref.invalidate(booksStateProvider(Tuple2(_textbook,userSetting)));
            Navigator.of(context).pop();
            await ref.read(userInfoProvider.notifier).updateTimes();
            if(5 < ref.watch(userInfoProvider).times){
              await ref.read(userInfoProvider.notifier).subTimes();
              ref.read(adProvider.notifier).showAd();
            }
          }else{
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WorkbookPage(quizzes,quizIndex + 1,_textbook)),
            );
          }
        },
      ),
    );
  }

  Color colorTheLetters(int choiceIndex, int answer, int yourAnswer){
    if(yourAnswerIndex == answer && choiceIndex == answer) return Colors.green;
    if(yourAnswerIndex != answer && choiceIndex == answer) return Colors.green;
    if(choiceIndex == yourAnswerIndex && choiceIndex != answer) return Colors.red;
    return Colors.black;
  }

}