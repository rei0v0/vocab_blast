import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';

class MyTextbookRepository {

  final VocabBlastDatabase _vocabBlastDatabase;

  MyTextbookRepository(this._vocabBlastDatabase);

  Future<List<TextBook>> getVocabBook() async {
    final List<TextBook> textbooks = await _vocabBlastDatabase.readVocabBook();
    return await _linkTag(textbooks);
  }

  Future<List<TextBook>> getCompBook() async {
    final List<TextBook> textbooks = await _vocabBlastDatabase.readCompBook();
    return await _linkTag(textbooks);
  }

  Future<List<TextBook>> getQuizBook() async {
    final List<TextBook> textbooks = await _vocabBlastDatabase.readQuizBook();
    return await _linkTag(textbooks);
  }

  Future<void> update(TextBook textbook) async {
    await _vocabBlastDatabase.updateTextbook(textbook);
  }

  Future<List<TextBook>> _linkTag(List<TextBook> textbooks) async{

    List<TextBook> linkedTextBook = [];

    for(var textbook in textbooks){
      final tagIds =  await _vocabBlastDatabase.readTaggingId(textbook);
      final tagNames =  await _vocabBlastDatabase.readTagName(tagIds);
      linkedTextBook.add(textbook.copy(tags: tagNames));
    }

    return linkedTextBook;
  }

}