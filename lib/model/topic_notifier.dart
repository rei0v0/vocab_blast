import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocab_blast/model/topic.dart';

class TopicsNotifier extends StateNotifier<List<Topic>> {

  final userUid = FirebaseAuth.instance.currentUser?.uid;
  final _topicCollection = FirebaseFirestore.instance.collection('topics');

  TopicsNotifier() : super([]){
    if(userUid != null && state.isEmpty){
      print('fetch topics');
      print(state.length);
      _fetchPublicText();
    }else{
      state = [];
    }
  }


  Future<void> _fetchPublicText() async {
    final snapshot = await _topicCollection.get();
    final List<Topic> topics = snapshot.docs.map((document){
      Map<String,dynamic> data = document.data();
      final String topic = data['topic'] ?? '' ;
      final String translation = data['translation'] ?? '';
      return Topic(topic: topic, translation: translation);
    }).toList();

    state = topics;
  }
}