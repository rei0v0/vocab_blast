import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';
import 'package:vocab_blast/model/book.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/user_setting.dart';
import 'package:vocab_blast/model/vocabulary.dart';
import 'package:vocab_blast/repository/vocab_book_repository.dart';

final booksStateProvider = StateNotifierProvider.family.autoDispose<BookNotifier, Book, Tuple2<TextBook,UserSetting>>((ref,params) {
  final TextBook textbook = params.item1;
  final UserSetting userSetting = params.item2;
  return BookNotifier(
    VocabBookRepository(textbook,VocabBlastDatabase.instance,),userSetting
  );
});
class BookNotifier extends StateNotifier<Book>{

  BookNotifier(this._vocabBookRepository, this._userSetting) : super(const Book()){
    getBook();
  }

  final VocabBookRepository _vocabBookRepository;
  final UserSetting _userSetting;

  Future<void> getBook() async {
    final String type = _vocabBookRepository.getType();
    final List<dynamic> book = await _vocabBookRepository.getBook();

    List<dynamic> cards = [];
    if(_userSetting.onlyUnlearnedQuizzes){
      cards = List.from(book.where((card) => card.done != 1).toList());
    }else{
      cards = List.from(book);
    }

    if(cards.isEmpty){
      cards = List.from(book);
    }

    if(_userSetting.isRandom)cards.shuffle();

    if(type == 'vocab'){
      state = state.copyWith(
          vocabBook: book as List<Vocab>
      );
    }else if(type == 'comp'){
      state = state.copyWith(
          compBook: book as List<Sentence>
      );
    }else if(type == 'quiz'){
      state = state.copyWith(
        quizBook: book as List<Quiz>
      );
    }

  }

  Future<void> updateVocabCard(Vocab vocab) async{
    await _vocabBookRepository.updateVocab(vocab);
  }

  Future<void> updateSentenceCard(Sentence sentence) async{
    await _vocabBookRepository.updateSentence(sentence);
  }

  Future<void> updateQuiz(Quiz quiz) async{
    await _vocabBookRepository.updateQuiz(quiz);
  }

  Future<void> resetData() async {
    await _vocabBookRepository.resetRecode();
  }

  Future<void> deleteData() async {
    await _vocabBookRepository.deleteData();
  }

}