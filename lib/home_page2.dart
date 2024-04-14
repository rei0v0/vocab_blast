import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vocab_blast/model/download_file.dart';
import 'package:vocab_blast/model/reward_ad_state.dart';
import 'package:vocab_blast/notifier/download_notifier.dart';
import 'package:vocab_blast/notifier/public_text_notifier.dart';
import 'package:vocab_blast/notifier/reward_ad_notifier.dart';
import 'package:vocab_blast/notifier/user_notifier.dart';
import 'package:vocab_blast/textbook_list_page.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';
import 'model/textbook.dart';

final rewardAdProvider = StateNotifierProvider<RewardAdNotifier, RewardAdState>((ref) {
  return RewardAdNotifier();
});

final isFinishProvider = StateProvider.autoDispose((ref) => false);

final publicTextbooksStateProvider = StateNotifierProvider<PublicTextbooksNotifier, List<TextBook>>((ref) {
  return PublicTextbooksNotifier();
});
final downloadFileProvider = StateNotifierProvider.family<DownloadNotifier, DownloadFile,TextBook>((ref, textbook) {
  return DownloadNotifier(textbook);
});

final progressProvider = StateProvider.autoDispose((ref) => false);
final percentProvider = StateProvider.autoDispose((ref) => 0.0);

class HomePage2 extends ConsumerWidget{

  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    final publicTextbooks = ref.watch(publicTextbooksStateProvider);
    final userInfo = ref.watch(userInfoProvider);
    final userNotifier = ref.read(userInfoProvider.notifier);
    final rewardAd = ref.read(rewardAdProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello there!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black),),
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0), //
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25.0, top: 10.0, bottom: 10.0, ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Download limit ',style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: Colors.black54),),
                        Text('${userInfo.limit}回',style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54),)
                      ],
                    ),
                    const Divider(indent: 0.0, endIndent: 0.0,thickness: 2.0,height: 5,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(

                        onPressed: 0 < userInfo.limit ? null : () async{
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return Consumer(builder: (context, ref, _){
                                  final isFinished = ref.watch(isFinishProvider);
                                  return AlertDialog(
                                    title: const Text("広告を視聴してクレジットを増やしますか？",style: TextStyle(fontWeight: FontWeight.bold),),
                                    content: const Text("クレジットが３回分付与されます。"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child:  GestureDetector(
                                              onTap: isFinished ? (){
                                                Navigator.of(context).pop();
                                              }
                                                  : () async {

                                                await rewardAd.showAd(() async {
                                                  await userNotifier.addCredit();
                                                  ref.read(isFinishProvider.notifier).state = true;
                                                });
                                                ref.invalidate(rewardAdProvider);

                                              },

                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                height: 40,
                                                child:  Center(
                                                  child: Text(
                                                    isFinished ? "閉じる" : 'はい',
                                                    style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                );
                              }
                          );
                        },
                        icon: Icon(Icons.add,color: 0 < userInfo.limit ? Colors.black54 :Colors.black),
                        label: Text('add credit',style: TextStyle(color: 0 < userInfo.limit ? Colors.black54 :Colors.black),),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black54,
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          side: BorderSide(color: 0 < userInfo.limit ? Colors.black54 :Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          elevation: 0.0,
                        ),),
                    ),
                  ],
                ),
              ),

            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,top: 20.0,right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('English Vocabulary',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black87),),
                        TextButton(
                            onPressed: (){
                              final textbooks = publicTextbooks.where((element) => element.type == 'vocab').toList();
                              List<String> tags = [];
                              for(int i = 0; i < textbooks.length; i++){
                                tags = tags + textbooks[i].tags;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TextbookListPage(textbooks,tags.toSet().toList())),
                              );
                            },
                            child: const Text('see All',style: TextStyle(color: Colors.black54),)
                        )
                      ],
                    ),
                    SizedBox(
                      width: width,
                      height: width * 0.45 * 3 / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemExtent: width * 0.45,
                        itemCount: publicTextbooks.where((element) => element.type == 'vocab').length,
                        itemBuilder: (BuildContext context, int index){
                          final books = publicTextbooks.where((element) => element.type == 'vocab').toList();
                          return GestureDetector(
                            onTap: () async {
                              _showDialog(context, books.elementAt(index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffd0efff),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.35 * 0.3,
                                        height: width * 0.35 * 0.3,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff87cefa),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.folder_outlined,color: Colors.white,),
                                      ),
                                      const Spacer(),
                                      Text(books.elementAt(index).name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize :  width * 0.45 / 10,fontWeight: FontWeight.bold, color:const Color(0xff4169e1)),),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('English Composition',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black87),),
                        TextButton(
                            onPressed: (){
                              final textbooks = publicTextbooks.where((element) => element.type == 'comp').toList();
                              List<String> tags = [];
                              for(int i = 0; i < textbooks.length; i++){
                                tags = tags + textbooks[i].tags;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TextbookListPage(textbooks,tags.toSet().toList())),
                              );
                            },
                            child: const Text('see All',style: TextStyle(color: Colors.black54),)
                        )
                      ],
                    ),
                    SizedBox(
                      width: width,
                      height: width * 0.45 * 3 / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemExtent: width * 0.45,
                        itemCount: publicTextbooks.where((element) => element.type == 'comp').length,
                        itemBuilder: (BuildContext context, int index){
                          final books = publicTextbooks.where((element) => element.type == 'comp').toList();
                          return GestureDetector(
                            onTap: () async {
                              _showDialog(context, books.elementAt(index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffffe4e1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.35 * 0.3,
                                        height: width * 0.35 * 0.3,
                                        decoration: const BoxDecoration(
                                          color: Color(0xfff08080),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.folder_outlined,color: Colors.white,),
                                      ),
                                      const Spacer(),
                                      Text(books.elementAt(index).name,maxLines: 2, overflow:TextOverflow.ellipsis, style: TextStyle(fontSize : width * 0.45 / 10, fontWeight:FontWeight.bold, color:const Color(0xfff08080)),),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Workbook',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black87),),
                        TextButton(
                            onPressed: (){
                              final textbooks = publicTextbooks.where((element) => element.type == 'quiz').toList();
                              List<String> tags = [];
                              for(int i = 0; i < textbooks.length; i++){
                                tags = tags + textbooks[i].tags;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TextbookListPage(textbooks,tags.toSet().toList())),
                              );
                            },
                            child: const Text('see All',style: TextStyle(color: Colors.black54),)
                        )
                      ],
                    ),
                    SizedBox(
                      width: width,
                      height: width * 0.45 * 3 / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemExtent: width * 0.45,
                        itemCount: publicTextbooks.where((element) => element.type == 'quiz').length,
                        itemBuilder: (BuildContext context, int index){
                          final books = publicTextbooks.where((element) => element.type == 'quiz').toList();
                          return GestureDetector(
                            onTap: () async {
                              _showDialog(context, books.elementAt(index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffccffcc),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.35 * 0.3,
                                        height: width * 0.35 * 0.3,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff8fbc8f),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.folder_outlined,color: Colors.white,),
                                      ),
                                      const Spacer(),
                                      Text(books.elementAt(index).name,maxLines: 2, overflow:TextOverflow.ellipsis, style: TextStyle(fontSize : width * 0.45 / 10, fontWeight:FontWeight.bold, color:const Color(0xff669900)),),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _showDialog(BuildContext context, TextBook textbook) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, _) {
            final downloadFile = ref.watch(downloadFileProvider(textbook));
            final downloadProvider = ref.read(downloadFileProvider(textbook).notifier);
            final isAllowed = ref.read(userInfoProvider.notifier).checkCredit();
            return AlertDialog(
              title: Text(textbook.name,
                style: const TextStyle(fontWeight: FontWeight.bold),),
              content: Text('ファイルサイズ : ${downloadFile.size}',),

              actions: [
                Center(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: (downloadFile.isExists || !isAllowed) ? null : () async {

                          final result = await confirm(context);

                          if(result){
                            try {
                              showProgress(context);
                              await downloadProvider.insertTextBook(textbook.tags);
                              ref.read(percentProvider.notifier).state = 0.2;
                              await downloadProvider.downloadFile();
                              ref.read(userInfoProvider.notifier).useCredit();
                              await Future.delayed(const Duration(milliseconds: 5));
                              ref.read(percentProvider.notifier).state = 0.5;
                              await Future.delayed(const Duration(seconds: 1));
                              ref.read(percentProvider.notifier).state = 0.8;
                              await Future.delayed(const Duration(seconds: 1));
                              ref.read(percentProvider.notifier).state = 1.0;
                            } catch (e) {

                            } finally {
                              await Future.delayed(const Duration(milliseconds: 5));
                              ref.read(progressProvider.notifier).state = true;
                              ref.invalidate(myLibraryProvider);
                            }
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.black.withOpacity(0.8),
                          disabledBackgroundColor: const Color(0xffdcdcdc),
                        ),
                        icon: downloadFile.isExists
                            ? const Icon(Icons.file_download_done, color: Colors.black)
                            : showIcon(isAllowed),
                        label: downloadFile.isExists
                            ? const Text('ダウンロード済み', style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),)
                            : showText(isAllowed)
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
  Widget showText(bool isAllowed) {
    if(isAllowed){
      return const Text('ダウンロード', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold),);
    }else{
      return const Text('クレジット不足', style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold),);
    }
  }
  Widget showIcon(bool isAllowed){
    if(isAllowed){
      return const Icon(Icons.file_download,color: Colors.orange,);
    }else{
      return const Icon(Icons.block_sharp,color: Colors.black,);
    }
  }

  Future confirm(BuildContext context) async {
    final width = MediaQuery.of(context).size.width;

    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context){
        return  AlertDialog(

          title: const Text('ダウンロードしますか？'),
          content: const Text('ダウンロードするとクレジットが１回消費されます。',style: TextStyle(fontSize: 17),),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    shadowColor: Colors.black12,
                    elevation: 5,
                    shape: const StadiumBorder(),
                  ),
                  child: SizedBox(
                      width: width/5,
                      child: const Center(child: Text('いいえ',style: TextStyle(color: Colors.black),))
                  ),
                ),
                const SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shadowColor: Colors.black12,
                    elevation: 5,
                    shape: const StadiumBorder(),
                  ),
                  child: SizedBox(
                    width: width / 5,
                    child: const Center(child:  Text('はい',style: TextStyle(color: Colors.black),)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future showProgress(BuildContext context) async {


    final width = MediaQuery.of(context).size.width;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return Consumer(builder: (context, ref, _) {
          final percent = ref.watch(percentProvider);
          final isDownloaded = ref.watch(progressProvider);
          if(isDownloaded) Navigator.of(context).pop();
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: SingleChildScrollView(
                child: Center(
                  child: Container(
                      width: width * 0.7,
                      height: width * 0.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        animation: false,
                        percent: percent,
                        center: Text("${(ref.watch(percentProvider)*100).toInt()}%"),
                        progressColor: Colors.green,
                      )
                  ),
                ),
              ),

            ),
          );
        });
      },
    );
  }

}