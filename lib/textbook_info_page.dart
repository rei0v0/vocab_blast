import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/card_view_page.dart';
import 'package:vocab_blast/list_page.dart';
import 'package:vocab_blast/model/book.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/vocabulary.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';
import 'package:vocab_blast/notifier/interstitial_ad_notifier.dart';
import 'package:vocab_blast/notifier/user_notifier.dart';
import 'package:vocab_blast/workbook_page.dart';
import 'package:vocab_blast/notifier/book_notifier.dart';

class TextbookInfoPage extends ConsumerWidget{

  const TextbookInfoPage(this._textbook, {super.key});

  final TextBook _textbook;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final String bookType = _textbook.type;
    final userSetting = ref.watch(userInfoProvider);
    final Book book = ref.watch(booksStateProvider(Tuple2(_textbook,userSetting)));
    final userNotifier = ref.read(userInfoProvider.notifier);

    double percent = 0.0;
    int numDone = 0;
    int numUndone = 0;

    if(bookType == 'vocab' && book.vocabBook.isNotEmpty){
      percent = book.vocabBook.where((element) => element.done == 1).length / book.vocabBook.length;
      numDone = book.vocabBook.where((element) => element.done == 1 ).length;
      numUndone = book.vocabBook.where((element) => element.done == 0 || element.done == 2).length;
    }else if(bookType == 'comp' && book.compBook.isNotEmpty){
      percent = book.compBook.where((element) => element.done == 1).length / book.compBook.length;
      numDone = book.compBook.where((element) => element.done == 1 ).length;
      numUndone = book.compBook.where((element) => element.done == 0 || element.done == 2).length;
    }else if(bookType == 'quiz' && book.quizBook.isNotEmpty){
      percent = book.quizBook.where((element) => element.done == 1).length / book.quizBook.length;
      numDone = book.quizBook.where((element) => element.done == 1 ).length;
      numUndone = book.quizBook.where((element) => element.done == 0 || element.done == 2).length;
    }
    final ad = ref.watch(adProvider.notifier);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            //Colors.white,
            Color(0xffe0ffff),
            Color(0xffcbf1e7),
            Color(0xffdbffd7),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (_) {
                    return Consumer(builder: (context, ref, _){
                      final settings = ref.watch(userInfoProvider);
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                        ),
                        actionsPadding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                        title: const Text('設定'),
                        content: SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('１回の問題数',style: TextStyle(fontSize: 13),),
                                  const Spacer(flex: 3),
                                  IconButton(
                                    onPressed: (){
                                      userNotifier.decreaseNumQuizzes();
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.remove,size: 17,color: Colors.red,),

                                  ),
                                  const Spacer(flex: 1),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(settings.numQuizzes.toString(),style: const TextStyle(fontSize: 17),),
                                  ),
                                  const Spacer(flex: 1),
                                  IconButton(
                                    onPressed: (){
                                      userNotifier.increaseNumQuizzes();
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.add,size: 17,color: Colors.red,),

                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('未習得の問題のみ出題する。',style: TextStyle(fontSize: 13),),
                                  const Spacer(),
                                  Checkbox(
                                    activeColor: Colors.red,
                                    value: settings.onlyUnlearnedQuizzes,
                                    onChanged: (value){
                                      if(value != null) userNotifier.setOnlyUnlearnedQuizzes(value);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('ランダムに出題する。',style: TextStyle(fontSize: 13),),
                                  const Spacer(),
                                  Checkbox(
                                    activeColor: Colors.red,
                                    value: settings.isRandom,
                                    onChanged: (value){
                                      if(value != null) userNotifier.setIsRandom(value);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        actions: [
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xaa008080),
                                borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: const Center(child:Text('適用する',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                            ),
                            onTap: (){
                              userNotifier.updateSettings();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                  });
            }, icon: const Icon(Icons.settings,color: Colors.black54)),
            IconButton(onPressed: () async {
             await showModalBottomSheet<int>(
                 backgroundColor: Colors.transparent,
                 context: context, builder: (context){
                   return SafeArea(
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         GestureDetector(
                           child: Container(
                             padding: const EdgeInsets.all(10.0),
                             width: size.width * 0.9,
                             height: 60,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: Colors.white
                             ),
                             child: const Center(child: Text('テキストを削除',style: TextStyle(fontSize: 18))),
                           ),
                           onTap: () async {
                             try{
                               await ref.read(booksStateProvider(Tuple2(_textbook,userSetting)).notifier).deleteData();
                             }catch(e){

                             }finally{
                               Navigator.popUntil(context,ModalRoute.withName('/'));
                             }

                           },
                         ),
                         const SizedBox(
                           height: 10,
                         ),
                         GestureDetector(
                           child: Container(
                             padding: const EdgeInsets.all(10.0),
                             width: size.width * 0.9,
                             height: 60,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: Colors.white
                             ),
                             child: const Center(child: Text('学習データをリセット',style: TextStyle(fontSize: 18))),
                           ),
                           onTap: () async {
                             await ref.read(booksStateProvider(Tuple2(_textbook,userSetting)).notifier).resetData();
                             ref.invalidate(booksStateProvider(Tuple2(_textbook,userSetting)));
                           },
                         ),
                         const SizedBox(
                           height: 10,
                         ),
                         GestureDetector(
                           child: Container(
                             padding: const EdgeInsets.all(10.0),
                             width: size.width * 0.9,
                             height: 60,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: Colors.white
                             ),
                             child: const Center(child: Text('キャンセル',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                           ),
                           onTap: (){
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     ),
                   );
                 }
             );
           }, icon: const Icon(Icons.delete,color: Colors.black54),),
          ],
        ),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_textbook.name,style: const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              const Spacer(flex: 1,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7), //色
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(-5, -5),
                    ),
                    const BoxShadow(
                      color: Colors.black26, //色
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(3, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: CircularPercentIndicator(
                  radius: size.width * 0.3,
                  lineWidth: 20.0,
                  animation: true,
                  percent: percent,
                  center:  Text("${(percent * 100).toInt()}%", style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.black12,
                  linearGradient: const LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors:  [
                      Color(0xff7fffd4),
                      Color(0xff00fa9a),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(flex: 2,),
                  SizedBox(
                    width: size.width * 0.35,
                    //height: size.width * 0.35 / 3,
                    child: Column(
                      children: [
                        Text('$numDone問',style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                        const Text('習得済み',style: TextStyle(fontSize: 15,color: Colors.black54),)
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  SizedBox(
                    width: size.width * 0.35,
                    //height: size.width * 0.35 / 3,
                    child: Column(
                      children: [
                        Text('$numUndone問',style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                        const Text('未習得',style: TextStyle(fontSize: 15,color: Colors.black45),)
                      ],
                    ),
                  ),
                  const Spacer(flex: 2,),
                ],
              ),
              const Spacer(flex: 1,),
              Row(
                children: [
                  const Spacer(flex: 2),
                  GestureDetector(
                    onTap: () async {
                      userNotifier.updateTimes();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListPage(_textbook)),
                      );

                      if(5 < userSetting.times){
                        await userNotifier.subTimes();
                        await ad.showAd();
                        ref.invalidate(adProvider);
                        ref.invalidate(myLibraryProvider);
                      }
                      print(userSetting.times);
                      ref.invalidate(booksStateProvider(Tuple2(_textbook,userSetting)));
                    },
                    child: Container(
                      width: size.width * 0.35,
                      height: size.width * 0.35 / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8), //色
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(-1, -1),
                            ),
                            const BoxShadow(
                              color: Colors.black26, //色
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.red
                      ),
                      child: const Center(child: Text('一覧',style: TextStyle(color: Colors.white, fontSize: 20),)),
                    ),
                  ),
                  const Spacer(flex: 1),
                  GestureDetector(
                    onTap: () async{

                      ref.read(myLibraryProvider.notifier).updateDate(_textbook);

                      if(_textbook.type == 'quiz'){
                        List<Quiz> quizzes;
                        if(userSetting.onlyUnlearnedQuizzes){
                          quizzes = List.from(book.quizBook.where((quiz) => quiz.done != 1).toList());
                        }else{
                          quizzes = List.from(book.quizBook);
                        }

                        if(quizzes.isEmpty){
                          quizzes = List.from(book.quizBook);
                        }

                        if(userSetting.isRandom)quizzes.shuffle();

                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WorkbookPage(quizzes.sublist(0,quizzes.length<userSetting.numQuizzes ? quizzes.length :userSetting.numQuizzes),0,_textbook)),
                        );

                      }else{

                        List<Vocab> vocabs;
                        List<Sentence> sentences;
                        if(userSetting.onlyUnlearnedQuizzes){
                          vocabs = List.from(book.vocabBook.where((vocab) => vocab.done != 1).toList());
                          sentences = List.from(book.compBook.where((sentence) => sentence.done != 1).toList());
                        }else{
                          vocabs = List.from(book.vocabBook);
                          sentences = List.from(book.compBook);
                        }

                        if(vocabs.isEmpty && sentences.isEmpty){
                          vocabs = List.from(book.vocabBook);
                          sentences = List.from(book.compBook);
                        }

                        if(userSetting.isRandom){
                          vocabs.shuffle();
                          sentences.shuffle();
                        }

                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardViewPage(
                              _textbook,
                              vocabs.sublist(0,vocabs.length<userSetting.numQuizzes ? vocabs.length :userSetting.numQuizzes),
                              sentences.sublist(0,sentences.length<userSetting.numQuizzes ? sentences.length :userSetting.numQuizzes),
                          )),
                        );

                      }


                    },
                    child: Container(
                      width: size.width * 0.35,
                      height: size.width * 0.35 / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8), //色
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(-1, -1),
                          ),
                          const BoxShadow(
                            color: Colors.black26, //色
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(2, 2),
                          ),
                        ],
                        color: Colors.red
                      ),
                      child:  const Center(child: Text('学習',style: TextStyle(color: Colors.white, fontSize: 20),)),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const Spacer(flex: 9,),
            ],
          ),
        ),
      ),
    );
  }

}