import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/home_page.dart';
import 'package:vocab_blast/model/user_setting.dart';
import 'package:vocab_blast/notifier/book_notifier.dart';
import 'package:vocab_blast/model/book.dart';
import 'package:vocab_blast/model/textbook.dart';


final visibilityProvider = StateProvider.autoDispose((ref) => true);

class ListPage extends ConsumerWidget{

  const ListPage(this.textbook, {super.key});

  final TextBook textbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserSetting userSetting = ref.watch(userSettingProvider);
    final Book book = ref.watch(booksStateProvider(Tuple2(textbook,userSetting)));
    final bool isVisible = ref.watch(visibilityProvider);
    //final size = MediaQuery.of(context).size;

    int itemCount = 0;
    if(textbook.type == 'vocab') itemCount = book.vocabBook.length;
    if(textbook.type == 'comp') itemCount = book.compBook.length;
    if(textbook.type == 'quiz') itemCount = book.quizBook.length;

    return Scaffold(
      backgroundColor: const Color(0xfff8f8ff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
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
        title: const Text('一覧',style: TextStyle(color: Colors.black87),),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: itemCount,
          itemBuilder:(BuildContext context, int index){
            if(textbook.type == 'vocab') {
              return Card(
                margin: const EdgeInsets.only(left: 15, right: 15.0,top: 4.0,bottom: 4.0),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: book.vocabBook[index].done == 2 ?Colors.red.withOpacity(0.7) : Colors.transparent,
                    width: 3.0
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xeeeeeeee),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book.vocabBook[index].word,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),overflow: TextOverflow.visible,),
                            Text(book.vocabBook[index].meaning,style: TextStyle(fontSize: 14,color: isVisible ? Colors.black87 :  Colors.transparent),overflow: TextOverflow.visible,),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      title: Text(book.vocabBook[index].translation,style: const TextStyle(fontSize: 14),softWrap: true,),
                      subtitle: Text(book.vocabBook[index].sentence,style: TextStyle(fontSize: 15,color: isVisible ? Colors.grey :  Colors.transparent),softWrap: true,),
                    ),
                  ],
                ),
              );
            }else if(textbook.type == 'comp'){
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: book.compBook[index].done == 2 ?Colors.red.withOpacity(0.7) : Colors.transparent,
                      width: 3.0
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0,bottom: 8.0),
                  child: ListTile(
                      tileColor: Colors.white.withOpacity(0.3),
                      title: Text(book.compBook[index].translation,style: const TextStyle(fontSize: 17),),
                      subtitle: Text(book.compBook[index].sentence,style:  TextStyle(fontSize: 14,color: isVisible ? Colors.grey :  Colors.transparent),)

                  ),
                ),
              );
            }else if(textbook.type == 'quiz'){
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: book.quizBook[index].done == 2 ?Colors.red.withOpacity(0.7) : Colors.transparent,
                      width: 3.0
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0,bottom: 8.0),
                  child: ListTile(
                      tileColor: Colors.white.withOpacity(0.3),
                      title: Text(book.quizBook[index].translation,style: const TextStyle(fontSize: 17),),
                      subtitle: Text(book.quizBook[index].sentence,style:  TextStyle(fontSize: 14,color: isVisible ? Colors.grey :  Colors.transparent),)
                  ),
                ),
              );
            }else{
              return null;
            }
          }
        ),
      ),
      floatingActionButton: GestureDetector(
        onLongPressEnd: (details){
          ref.read(visibilityProvider.notifier).state = true;
        },
        onTapUp: (details){
          ref.read(visibilityProvider.notifier).state = true;
        },
        onLongPress: (){
          ref.read(visibilityProvider.notifier).state = false;
        },
        onLongPressDown: (details){
          ref.read(visibilityProvider.notifier).state = false;
        },
        child: const FloatingActionButton(
          onPressed: null,
          backgroundColor: Color(0xffcbf1e7),
          child: Icon(Icons.visibility_off,color: Colors.black54,),
        ),
      ),
    );
  }



}