import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';
import 'package:vocab_blast/explanation_page.dart';
import 'package:vocab_blast/home_page.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/user_setting.dart';
import 'package:vocab_blast/notifier/audio_notifier.dart';
import 'package:vocab_blast/notifier/book_notifier.dart';
import 'package:vocab_blast/notifier/quiz_notifier.dart';
import 'package:vocab_blast/page_route/custom_page_route.dart';


final checkMarkProvider = StateProvider.autoDispose((ref) => false);
final closeMarkProvider = StateProvider.autoDispose((ref) => false);

final quizProvider = StateNotifierProvider.family<QuizNotifier, Quiz, Tuple2<List<Quiz>, int>>((ref, params) {
  final List<Quiz> quizList = params.item1;
  final int quizIndex = params.item2;
  return QuizNotifier(quizList[quizIndex], VocabBlastDatabase.instance);
});

class WorkbookPage extends ConsumerWidget{

  const WorkbookPage(this.quizzes, this.quizIndex, this._textbook, {super.key});

  final List<Quiz> quizzes;
  final int quizIndex;
  final TextBook _textbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final buttonLabel = ['A','B','C','D','E'];
    final showCheckMark = ref.watch(checkMarkProvider);
    final showCloseMark = ref.watch(closeMarkProvider);
    final getData = Tuple2(quizzes, quizIndex);
    final quizNotifier = ref.read(quizProvider(getData).notifier);
    final player = ref.read(audioProvider.notifier);
    final UserSetting userSetting = ref.watch(userSettingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            ref.invalidate(booksStateProvider(Tuple2(_textbook,userSetting)));
            Navigator.pop(context);
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q${quizIndex + 1}',style: const TextStyle(fontSize: 18),),
                        Text(quizzes[quizIndex].question,style: const TextStyle(fontSize: 17),),
                        const SizedBox(height: 30,),
                        if(quizzes[quizIndex].choice0 != '')Text('(A) ${quizzes[quizIndex].choice0}',style: const TextStyle(fontSize: 17),),
                        if(quizzes[quizIndex].choice1 != '')Text('(B) ${quizzes[quizIndex].choice1}',style: const TextStyle(fontSize: 17),),
                        if(quizzes[quizIndex].choice2 != '')Text('(C) ${quizzes[quizIndex].choice2}',style: const TextStyle(fontSize: 17),),
                        if(quizzes[quizIndex].choice3 != '')Text('(D) ${quizzes[quizIndex].choice3}',style: const TextStyle(fontSize: 17),),
                      ],
                    ),
                  ),

                  if(showCheckMark) const SizedBox(
                    width: double.infinity,
                    height: 300,
                    child:  FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(Icons.radio_button_unchecked,color: Color(0xcf00fa9a),),
                    ),
                  ),

                  if(showCloseMark)SizedBox(
                    width: double.infinity,
                    height: 300,
                    child:  FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(Icons.close,color:Colors.red.withOpacity(0.7),),
                    ),
                  )

                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: size.width,
              height: 60,
              child: Row(
                children: [
                  for(int i = 0; i < 4; i++) ... {
                    SizedBox(
                      width: size.width / 4,
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: const BorderSide(
                            color: Colors.black26,
                            width: 0.5
                          ),
                        ),
                        onPressed: () async {
                          if(quizzes[quizIndex].answer == i){
                            ref.read(checkMarkProvider.notifier).state = true;
                            await player.playCorrectSound();
                            quizNotifier.updateQuiz(1);

                          }else{
                            ref.read(closeMarkProvider.notifier).state = true;
                            await player.playIncorrectSound();
                            quizNotifier.updateQuiz(2);
                          }

                          await Future.delayed( const Duration(milliseconds: 500));
                          if (context.mounted) {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                builder: (BuildContext context) {
                                  return ExplanationPage(quizzes,quizIndex,i,_textbook); },
                              ),
                            );
                            Route<dynamic>? currentRoute = ModalRoute.of(context);
                            if(currentRoute != null) Navigator.of(context).removeRoute(currentRoute);
                          }
                        },
                        child: Text(buttonLabel[i],style: const TextStyle(fontSize: 21,color: Colors.black),),
                      ),
                    )
                  }
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}