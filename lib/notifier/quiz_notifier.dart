import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';
import 'package:vocab_blast/model/quiz.dart';

class QuizNotifier extends StateNotifier<Quiz>{

  QuizNotifier(super.state, this._vocabBlastDatabase);

  final VocabBlastDatabase _vocabBlastDatabase;

  Future<void> updateQuiz(int done) async{
    _vocabBlastDatabase.updateQuiz(state.copy(done: done));
  }

}