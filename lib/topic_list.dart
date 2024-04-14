import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/essay_topics_page.dart';
import 'package:vocab_blast/model/topic.dart';

class TopicList extends ConsumerWidget {


  const TopicList(this.topics, {super.key});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final width = MediaQuery.of(context).size.width;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 16.0),
      itemCount: topics.length,
      itemBuilder: (BuildContext context, int index) {
        final topic = topics[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          child: ListTile(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EssayTopicsPage(topic)),
              );
            },
            //tileColor: const Color(0xffffe4e1),
            contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 16.0),
            leading: Container(
              width: width * 0.35 * 0.3,
              height: width * 0.35 * 0.3,
              decoration: const BoxDecoration(
                color: Color(0xff6a5acd),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            title:Text(
              topic.topic,
              maxLines: 2,
              overflow:TextOverflow.ellipsis,
              style: const TextStyle(fontSize : 20, fontWeight:FontWeight.bold, ),
            ),
            subtitle: Text(topic.translation)
          ),
        );
      }
    );
  }

}