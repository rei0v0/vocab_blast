import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/bookshelf_page.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';



class MyLibraryPage extends ConsumerWidget{

  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = width / 23;
    final myLibrary = ref.watch(myLibraryProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xffdbf1e7),
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Color(0xfff0ffff),
                  Color(0xffcbf1e7),
                  Color(0xffdbffd7),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffdcdcdc), //色
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(5, 1),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 10),
                  child: Text('Library',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black),),
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor:  Colors.black87,
                      unselectedLabelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                      labelStyle: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: false,
                      tabs: <Widget>  [
                        Tab(child: Text('単語',style: TextStyle(fontSize: fontSize),),),
                        Tab(child: Text('瞬間英作文',style: TextStyle(fontSize: fontSize),),),
                        Tab(child: Text('問題集',style: TextStyle(fontSize: fontSize),),),
                      ],
                      onTap: (int index){
                        ref.read(myLibraryProvider.notifier).updateIndex(index);
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xfff8f8ff),
          child: TabBarView(
            children: [
              BookShelf(myLibrary.vocabBooks, myLibrary.vocabTags),
              BookShelf(myLibrary.compBooks, myLibrary.compTags),
              BookShelf(myLibrary.quizBooks, myLibrary.quizTags),
            ],
          ),
        ),
      )
    );
  }
}

