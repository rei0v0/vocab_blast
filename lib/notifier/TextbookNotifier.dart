import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';
import 'package:vocab_blast/model/my_library.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/repository/my_textbook_repository.dart';
import 'package:intl/intl.dart';

final myLibraryProvider = StateNotifierProvider.autoDispose<TextbookNotifier,MyLibrary>((ref) => TextbookNotifier(
  MyTextbookRepository(VocabBlastDatabase.instance),
),);

class TextbookNotifier extends StateNotifier<MyLibrary>{
  //TextbookNotifier(super.state);

  TextbookNotifier(this._myTextbookRepository) : super(const MyLibrary()){
    getLibrary();
  }

  final MyTextbookRepository _myTextbookRepository;

  Future<void> getLibrary() async {

    final vocabBooks = await _myTextbookRepository.getVocabBook();
    final compBooks = await _myTextbookRepository.getCompBook();
    final quizBooks = await _myTextbookRepository.getQuizBook();

    List<String> vocabTags = [];
    List<String> compTags = [];
    List<String> quizTags = [];

    for(int i = 0; i < vocabBooks.length; i++){
      vocabTags = vocabTags + vocabBooks[i].tags;
    }

    for(int i = 0; i < compBooks.length; i++){
      compTags = compTags + compBooks[i].tags;
    }

    for(int i = 0; i < quizBooks.length; i++){
      quizTags = quizTags + quizBooks[i].tags;
    }

    state = state.copyWith(
      vocabBooks: vocabBooks, compBooks: compBooks, quizBooks: quizBooks, vocabTags: vocabTags.toSet().toList(), compTags: compTags.toSet().toList(), quizTags: quizTags.toSet().toList()
    );
  }

  void updateIndex(int index){
    state = state.copyWith(index: index);
  }

  Future<void> updateDate(TextBook textbook) async {
    final String date = DateFormat('yyyy/MM/dd HH:mm').format(DateTime.now());
    await _myTextbookRepository.update(textbook.copy(date: date));
  }

}