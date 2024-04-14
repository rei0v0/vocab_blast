import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/correction page.dart';
import 'package:vocab_blast/model/topic.dart';

final selectedNumWordsProvider = StateProvider.autoDispose<String>((ref) => '60 ~ 80');
final selectedLevelProvider = StateProvider.autoDispose<String>((ref) => '中学生');

class EssayTopicsPage extends ConsumerWidget{

  const EssayTopicsPage(this.topic, {super.key});

  final Topic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final numWords = ['25 ~ 35','60 ~ 80','80 ~ 100', '120 ~ 150', '200 ~ 240'];
    final levels = ['小学生','中学生','高校生','大学生'];

    final selectedNumWords = ref.watch(selectedNumWordsProvider);
    final selectedLevel = ref.watch(selectedLevelProvider);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topRight,
          colors: [
            Color(0xfff0ffff),
            Color(0xffcbf1e7),
            Color(0xffdbffd7),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text('設定',style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: Container(
            width: width * 0.8,
            height: height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), //色
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('topic : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Text(topic.topic,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Text('文字数 : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      const Spacer(),
                      DropdownButton(
                        value: selectedNumWords,
                        items: numWords.map((String text){
                          return DropdownMenuItem(
                            value: text,
                            child: Text(text),
                          );
                        }).toList(),
                        onChanged: (String? value){
                          if(value != null) ref.read(selectedNumWordsProvider.notifier).state = value;
                        }
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Text('目標レベル : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      const Spacer(),
                      DropdownButton(
                        value: selectedLevel,
                        items: levels.map((String level){
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (String? value){
                          if(value != null) ref.read(selectedLevelProvider.notifier).state = value;
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CorrectionPage(topic.topic, selectedNumWords, selectedLevel)),
                      );
                    },
                    child: Container(
                      width: width * 0.5,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff80faaa),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(child: Text('はじめる',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}