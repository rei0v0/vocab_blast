import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/home_page.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';

final tagFlagProvider = StateProvider.family((ref, List<String>tags){
  return List.generate(tags.length + 1, (index){
    if(index == 0)return true;
    return false;
  });
});

class TextbookListPage extends ConsumerWidget{

  final List<TextBook> textbooks;
  final List<String> tags;

  const TextbookListPage(this.textbooks, this.tags, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final List<bool> tagFlag = ref.watch(tagFlagProvider(tags));
    List<String> selectedTags = [];
    tagFlag.asMap().forEach((index, value) {
      if(value == true && index != 0) selectedTags.add(tags[index-1]);
    });

    final List<TextBook> selectedTextbooks = textbooks.where((textbook){
      if(selectedTags.isEmpty) return true;
      for(int i = 0;i<selectedTags.length;i++){
        if(!textbook.tags.contains(selectedTags[i])){
          return false;
        }
      }
      return true;
    }).toList();
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
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: 60,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(
                  label: const Text('all'),
                  labelStyle: TextStyle(
                      color: tagFlag[0] ? Colors.white : Colors.black54
                  ),
                  selected: tagFlag[0],
                  backgroundColor: Colors.white,
                  selectedColor: Colors.grey[700],
                  side: const BorderSide(
                      color: Colors.black12
                  ),
                  onSelected: (bool value){
                    var newFlag = List.generate(tags.length + 1, (i)=>false);
                    newFlag[0] = true;
                    ref.read(tagFlagProvider(tags).notifier).state = newFlag;
                  },
                ),
                for(int i = 1; i < tags.length+1; i++) ... {
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                    child: ChoiceChip(
                      label: Text(tags[i-1]),
                      labelStyle: TextStyle(
                          color: tagFlag[i] ? Colors.white : Colors.black54
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.grey[700],
                      selected: tagFlag[i],
                      side: const BorderSide(
                          color: Colors.black12
                      ),
                      onSelected: (bool value){
                        var newFlag = List.generate(tags.length + 1, (index){
                          return tagFlag[index];
                        });
                        newFlag[0] = false;
                        newFlag[i] = value;
                        if(!newFlag.contains(true))newFlag[0] = true;
                        ref.read(tagFlagProvider(tags).notifier).state = newFlag;
                      },
                    ),
                  )

                }
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: selectedTextbooks.length,
              itemBuilder: (BuildContext context, int index){
                String tagText = '';
                for (final tag in selectedTextbooks[index].tags) {
                  tagText += '#$tag ';
                }
                Color iconColor = Colors.transparent;
                if(selectedTextbooks[index].type == 'vocab') iconColor = const Color(0xff87cefa);
                if(selectedTextbooks[index].type == 'comp') iconColor = const Color(0xfff08080);
                if(selectedTextbooks[index].type == 'quiz') iconColor = const Color(0xff8fbc8f);
                return GestureDetector(
                  onTap: () async{
                    await _showDialog(context, selectedTextbooks[index]);
                  },
                  child: Card(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: width * 0.8 * 0.3,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: iconColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.folder_outlined,color: Colors.white,size: 30,),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: width * 0.65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(selectedTextbooks[index].name,maxLines: 2,
                                  overflow:TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize : 17, fontWeight:FontWeight.bold, color:Colors.black54),
                                ),
                                Text('投稿日 : ${selectedTextbooks[index].date}',
                                  style: const TextStyle(fontSize : 14, color:Colors.black54),
                                ),
                                Text(tagText, style: const TextStyle(fontSize : 14, color:Colors.black54),),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
  Future _showDialog(BuildContext context, TextBook textbook) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, _) {
            final downloadFile = ref.watch(downloadFileProvider(textbook));
            final downloadProvider = ref.read(downloadFileProvider(textbook).notifier);
            final isAllowed = ref.read(userSettingProvider.notifier).checkCredit();
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
                              ref.read(userSettingProvider.notifier).useCredit();
                              await Future.delayed(const Duration(milliseconds: 5));
                              ref.read(percentProvider.notifier).state = 0.5;
                              await Future.delayed(const Duration(seconds: 1));
                              ref.read(percentProvider.notifier).state = 0.8;
                              await Future.delayed(const Duration(seconds: 1));

                            } catch (e) {

                            } finally {
                              ref.read(percentProvider.notifier).state = 1.0;
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