import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/bookshelf_page.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';

class MyLibraryPage2 extends ConsumerWidget{

  const MyLibraryPage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = width / 24;
    final myLibrary = ref.watch(myLibraryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text('Library',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black),),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: [
                Color(0xfff0ffff),
                Color(0xffcbf1e7),
                Color(0xffdbffd7),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.transparent,
                    forceElevated: innerBoxIsScrolled,
                    elevation: 0.0,
                    expandedHeight: 75,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
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
                      ),
                    ),
                    title: TabBar(
                      isScrollable: false,
                      labelColor: Colors.black,
                      unselectedLabelColor:  Colors.black87,
                      unselectedLabelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                      labelStyle: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(child: Text('単語',style: TextStyle(fontSize: fontSize,color: Colors.black87),),),
                        Tab(child: Text('瞬間英作文',style: TextStyle(fontSize: fontSize,color: Colors.black87),),),
                        Tab(child: Text('問題集',style: TextStyle(fontSize: fontSize,color: Colors.black87),),),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                BookShelf(myLibrary.vocabBooks, myLibrary.vocabTags),
                BookShelf(myLibrary.compBooks, myLibrary.compTags),
                BookShelf(myLibrary.quizBooks, myLibrary.quizTags),
              ],
            ),
          ),
      ),
    );
  }
}

