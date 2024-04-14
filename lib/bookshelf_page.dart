import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/notifier/TextbookNotifier.dart';
import 'package:vocab_blast/textbook_info_page.dart';
import 'package:vocab_blast/model/textbook.dart';

final tagFlagProvider = StateProvider.family((ref, List<String>tags){
  return List.generate(tags.length + 1, (index){
    if(index == 0)return true;
    return false;
  });
});

class BookShelf extends ConsumerWidget {

  final List<TextBook> textbooks;
  final List<String> tags;

  const BookShelf(this.textbooks, this.tags, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
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
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 16.0),
            itemCount: selectedTextbooks.length,
            itemBuilder: (BuildContext context, int index) {
              String tagText = '';
              for (final tag in selectedTextbooks[index].tags) {
                tagText += '#$tag ';
              }
              Color iconColor = Colors.transparent;
              if(selectedTextbooks[index].type == 'vocab') iconColor = const Color(0xff87cefa);
              if(selectedTextbooks[index].type == 'comp') iconColor = const Color(0xfff08080);
              if(selectedTextbooks[index].type == 'quiz') iconColor = const Color(0xff8fbc8f);
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextbookInfoPage(selectedTextbooks[index])),
                    );
                    ref.invalidate(myLibraryProvider);
                  },
                  //tileColor: const Color(0xffffe4e1),
                  contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 16.0),
                  leading: Container(
                    width: width * 0.35 * 0.3,
                    height: width * 0.35 * 0.3,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.folder_outlined,
                      color: Colors.white,),
                  ),
                  title:Text(
                    selectedTextbooks[index].name,
                    maxLines: 2,
                    overflow:TextOverflow.ellipsis,
                    style: const TextStyle(fontSize : 20, fontWeight:FontWeight.bold, ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('最終学習日 : ${selectedTextbooks[index].date}'),
                      Text(tagText,softWrap: true,),
                    ],
                  ),
                ),
              );
            },

          ),
        ),
      ],
    );
  }


}