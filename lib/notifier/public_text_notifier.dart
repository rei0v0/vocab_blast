import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:intl/intl.dart';

class PublicTextbooksNotifier extends StateNotifier<List<TextBook>> {

  final userUid = FirebaseAuth.instance.currentUser?.uid;
  final _textbookCollection = FirebaseFirestore.instance.collection('public_textbooks');

  PublicTextbooksNotifier() : super([]){
    if(userUid != null && state.isEmpty){
      print('fetch books');
      print(state.length);
      _fetchPublicText();
    }else{
      state = [];
    }
  }


  Future<void> _fetchPublicText() async {
    final snapshot = await _textbookCollection.get();
    final List<TextBook> textbooks = snapshot.docs.map((document){
      Map<String,dynamic> data = document.data();
      final String name = data['name'];
      final String checkId = document.id;
      final String type = data['type'];
      final Timestamp uploadDate = data['date'];
      final String date = DateFormat('yyyy-MM-dd').format(uploadDate.toDate());
      final List<String> tags = data['tag'].cast<String>() ?? [];
      return TextBook(name: name, checkId: checkId ,  type: type, date: date,tags: tags);
    }).toList();
    textbooks.sort((a,b)=> a.name.compareTo(b.name));
    state = textbooks;
  }
}