import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/vocabulary.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';

class VocabBookRepository {

  final TextBook _textBook;
  final VocabBlastDatabase _vocabBlastDatabase;

  VocabBookRepository(this._textBook, this._vocabBlastDatabase);

  Future<List<dynamic>> getBook() async {
    if(_textBook.type == 'vocab'){
      return await getVocabs();
    }else if(_textBook.type == 'comp'){
      return await getSentence();
    }else if(_textBook.type == 'quiz'){
      return await getQuiz();
    }else{
      return [];
    }
  }

  Future<List<Vocab>> getVocabs() async {
    return _vocabBlastDatabase.readVocabs(_textBook.checkId);
  }

  Future<List<Sentence>> getSentence() async {
    return _vocabBlastDatabase.readSentence(_textBook.checkId);
  }

  Future<List<Quiz>> getQuiz() async {
    return _vocabBlastDatabase.readQuizzes(_textBook.checkId);
  }

  String getType(){
    return _textBook.type;
  }

  Future<void> updateVocab(Vocab vocab) async {
    await _vocabBlastDatabase.updateVocab(vocab);
  }

  Future<void> updateSentence(Sentence sentence) async {
    await _vocabBlastDatabase.updateSentence(sentence);
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await _vocabBlastDatabase.updateQuiz(quiz);
  }

  Future<void> resetRecode() async {
    if (_textBook.type == 'vocab') {
      await _vocabBlastDatabase.resetDoneRecodeOfVocab(_textBook.checkId);
    } else if (_textBook.type == 'comp') {
      await _vocabBlastDatabase.resetDoneRecodeOfSentence(_textBook.checkId);
    } else if(_textBook.type == 'quiz') {
      await _vocabBlastDatabase.resetDoneRecodeOfQuiz(_textBook.checkId);
    }
  }

  Future<void> deleteData() async{
    await _vocabBlastDatabase.deleteTextbook(_textBook.id!);
    await _vocabBlastDatabase.deleteTagging(_textBook);
    await _vocabBlastDatabase.deleteSentence(_textBook);
    await _vocabBlastDatabase.deleteVocabs(_textBook);
    await _vocabBlastDatabase.deleteQuizzes(_textBook);
  }


}