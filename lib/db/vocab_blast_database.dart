import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocab_blast/model/quiz.dart';
import 'package:vocab_blast/model/tag.dart';
import 'package:vocab_blast/model/tagging.dart';
import 'package:vocab_blast/model/vocabulary.dart';

import '../model/sentence.dart';
import '../model/textbook.dart';


class VocabBlastDatabase {

  static final VocabBlastDatabase instance = VocabBlastDatabase._init();

  static Database? _database;
  VocabBlastDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('VocabBlast.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade,);
  }

  Future _createDB(Database db, int version) async {

    print('calledddd');

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textIdType = 'TEXT NOT NULL';
    const stringType = 'TEXT NOT NULL';
    const doneType = 'INT NOT NULL';
    const connectionIdType = 'INTEGER NOT NULL';
    const intType = 'INT NOT NULL';


    await db.execute('''
     CREATE TABLE $tableComp (
     ${SentenceFields.id} $idType,
     ${SentenceFields.textId} $textIdType,
     ${SentenceFields.sentence} $stringType,
     ${SentenceFields.translation} $stringType,
     ${SentenceFields.done} $doneType
     )
    ''');

    await db.execute('''
     CREATE TABLE $tableTag (
     ${TagFields.id} $idType,
     ${TagFields.name} $stringType
     )
    ''');

    await db.execute('''
     CREATE TABLE $tableTagging (
     ${TaggingFields.id} $idType,
     ${TaggingFields.textbookId} $connectionIdType,
     ${TaggingFields.tagId} $connectionIdType
     )
    ''');

    await db.execute('''
     CREATE TABLE $tableTextbook (
     ${TextbookFields.id} $idType,
     ${TextbookFields.checkId} $stringType,
     ${TextbookFields.name} $stringType,
     ${TextbookFields.type} $stringType,
     ${TextbookFields.date} $stringType
     )
    ''');

    await db.execute('''
     CREATE TABLE $tableVocab (
     ${VocabFields.id} $idType,
     ${VocabFields.textId} $textIdType,
     ${VocabFields.word} $stringType,
     ${VocabFields.meaning} $stringType,
     ${VocabFields.sentence} $stringType,
     ${VocabFields.translation} $stringType,
     ${VocabFields.done} $doneType
     )
    ''');

    await db.execute('''
     CREATE TABLE $tableQuiz (
     ${QuizFields.id} $idType,
     ${QuizFields.textId} $textIdType,
     ${QuizFields.question} $stringType,
     ${QuizFields.choice0} $stringType,
     ${QuizFields.choice1} $stringType,
     ${QuizFields.choice2} $stringType,
     ${QuizFields.choice3} $stringType,
     ${QuizFields.answer} $intType,
     ${QuizFields.sentence} $stringType,
     ${QuizFields.translation} $stringType,
     ${QuizFields.explanation} $stringType,
     ${QuizFields.done} $doneType
     )
    ''');

  }
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textIdType = 'TEXT NOT NULL';
    const stringType = 'TEXT NOT NULL';
    const doneType = 'INT NOT NULL';
    const intType = 'INT NOT NULL';
    if (newVersion > oldVersion) {
      await db.execute('''
     CREATE TABLE $tableQuiz (
     ${QuizFields.id} $idType,
     ${QuizFields.textId} $textIdType,
     ${QuizFields.question} $stringType,
     ${QuizFields.choice0} $stringType,
     ${QuizFields.choice1} $stringType,
     ${QuizFields.choice2} $stringType,
     ${QuizFields.choice3} $stringType,
     ${QuizFields.answer} $intType,
     ${QuizFields.sentence} $stringType,
     ${QuizFields.translation} $stringType,
     ${QuizFields.explanation} $stringType,
     ${QuizFields.done} $doneType
     )
    ''');
    }
  }

// table of sentence
  Future insertSentences(List<Sentence> sentences) async {
    final database = await instance.database;
    sentences.forEach((sentence) async {
      final id = await database.insert(tableComp, sentence.toJson());
      sentence.copy(id: id);
    });
  }

  Future<List<Sentence>> readSentence(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableComp,
        where: '${SentenceFields.textId} = ?',
        whereArgs: [textId]
    );
    if(result.isNotEmpty){
      return result.map((json) => Sentence.fromJson(json)).toList();
    }else{
      return [];
    }
  }

  Future<void> updateSentence(Sentence sentence) async {
    final database = await instance.database;
    await database.update(
        tableComp,
        sentence.toJson(),
        where: "_id = ?",
        whereArgs: [sentence.id]
    );
  }

  Future<void> resetDoneRecodeOfSentence(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableComp,
        where: '${SentenceFields.textId} = ?',
        whereArgs: [textId]
    );

    if(result.isNotEmpty){
      final sentences = result.map((json) => Sentence.fromJson(json)).toList();
      sentences.forEach((sentence) async{
        final resetData = sentence.copy(done: 0);
        await database.update(
            tableComp,
            resetData.toJson(),
            where: "_id = ?",
            whereArgs: [sentence.id]
        );
      });
    }
  }

  Future<void> deleteSentence(TextBook textbook) async {
    final database = await instance.database;
    await database.delete(
        tableComp,
        where: '${SentenceFields.textId} = ?',
        whereArgs: [textbook.checkId]
    );
  }
  //table of vocab
  Future insertVocabs(List<Vocab> vocabs) async {
    final database = await instance.database;
    vocabs.forEach((vocab) async {
      final id = await database.insert(tableVocab, vocab.toJson());
      vocab.copy(id: id);
    });
  }

  Future<List<Vocab>> readVocabs(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableVocab,
        where: '${VocabFields.textId} = ?',
        whereArgs: [textId]
    );
    if(result.isNotEmpty){
      return result.map((json) => Vocab.fromJson(json)).toList();
    }else{
      return [];
    }
  }

  Future<void> updateVocab(Vocab vocab) async {
    final database = await instance.database;
    await database.update(
        tableVocab,
        vocab.toJson(),
        where: "_id = ?",
        whereArgs: [vocab.id]
    );
  }

  Future<void> resetDoneRecodeOfVocab(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableVocab,
        where: '${VocabFields.textId} = ?',
        whereArgs: [textId]
    );

    if(result.isNotEmpty){
      final vocabs = result.map((json) => Vocab.fromJson(json)).toList();
      vocabs.forEach((vocab) async{
        final resetData = vocab.copy(done: 0);
        await database.update(
            tableVocab,
            resetData.toJson(),
            where: "_id = ?",
            whereArgs: [vocab.id]
        );
      });
    }
  }

  Future<void> deleteVocabs(TextBook textbook) async {
    final database = await instance.database;
    await database.delete(
        tableVocab,
        where: '${VocabFields.textId} = ?',
        whereArgs: [textbook.checkId]
    );
  }

  //table of tag
  Future<Tag> createTag(Tag tag) async {
    final database = await instance.database;
    final id = await database.insert(tableTag, tag.toJson());
    return tag.copy(id: id);
  }

  Future<bool> tagExists(String name) async {
    final db = await instance.database;
    final maps = await db.query(
        tableTag,
        where: '${TagFields.name} = ?',
        whereArgs: [name]
    );

    if(maps.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  Future<int> readTagId(Tag tag) async{
    final db = await instance.database;
    final results = await db.query(
        tableTag,
        where: '${TagFields.name} = ?',
        whereArgs: [tag.name]
    );

    if(results.isNotEmpty){
      return results.map((json) => Tag.fromJson(json)).first.id!;
    } else {
      return -1;
    }
  }

  Future<List<String>> readTagName(List<Tagging> tagIds) async {

    final db = await instance.database;
    List<String> tagNames = [];

    for (var tagging in tagIds){
      final results = await db.query(
          tableTag,
          where: '${TagFields.id} = ?',
          whereArgs: [tagging.tagId]
      );

      if(results.isNotEmpty){
        tagNames.add(
            Tag.fromJson(results.first).name
        );
      }
    }
    return tagNames;
  }

  //table of tagging

  Future<Tagging> createTagging(Tagging tagging) async {
    final database = await instance.database;
    final id = await database.insert(tableTagging, tagging.toJson());
    return tagging.copy(id: id);
  }

  Future<List<Tagging>> readTaggingId(TextBook textbook) async {
    final db = await instance.database;
    final results = await db.query(
        tableTagging,
        where: '${TaggingFields.textbookId} = ?',
        whereArgs: [textbook.id]
    );

    if(results.isNotEmpty){
      return results.map((json) => Tagging.fromJson(json)).toList();
    } else {
      return [];
    }

  }

  Future<void> deleteTagging(TextBook textbook) async{
    final db = await instance.database;
    await db.delete(
        tableTagging,
        where: '${TaggingFields.textbookId} = ?',
        whereArgs: [textbook.id]);
  }

  //table of textbook

  Future<TextBook> readTextbook(int id) async {
    final db = await instance.database;
    final maps = await db.query(
        tableTextbook,
        where: '${TextbookFields.id} = ?',
        whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return TextBook.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TextBook>> readAllTextBook() async {
    final db = await instance.database;
    final result = await db.query(tableTextbook);
    return result.map((json) => TextBook.fromJson(json)).toList();
  }

  Future<List<TextBook>> readVocabBook() async {
    final db = await instance.database;

    final result = await db.query(
        tableTextbook,
        where: '${TextbookFields.type} = ?',
        whereArgs: ['vocab']
    );

    if(result.isNotEmpty){
      return result.map((json) => TextBook.fromJson(json)).toList();
    } else {
      return [];
    }

  }
  Future<List<TextBook>> readCompBook() async {
    final db = await instance.database;

    final result = await db.query(
        tableTextbook,
        where: '${TextbookFields.type} = ?',
        whereArgs: ['comp']
    );

    if(result.isNotEmpty){
      return result.map((json) => TextBook.fromJson(json)).toList();
    } else {
      return [];
    }

  }

  Future<List<TextBook>> readQuizBook() async {
    final db = await instance.database;

    final result = await db.query(
        tableTextbook,
        where: '${TextbookFields.type} = ?',
        whereArgs: ['quiz']
    );

    if(result.isNotEmpty){
      return result.map((json) => TextBook.fromJson(json)).toList();
    } else {
      return [];
    }

  }

  Future<int> updateTextbook(TextBook textBook) async {
    final db = await instance.database;
    return db.update(
      tableTextbook,
      textBook.toJson(),
      where: '${TextbookFields.id} = ?',
      whereArgs: [textBook.id],
    );
  }

  Future<int> deleteTextbook(int id) async {
    final db = await instance.database;
    return db.delete(
      tableTextbook,
      where: '${TextbookFields.id} = ?',
      whereArgs: [id],
    );
  }


  Future<bool> textbookExists(String checkId) async {
    final db = await instance.database;
    final maps = await db.query(
        tableTextbook,
        where: '${TextbookFields.checkId} = ?',
        whereArgs: [checkId]
    );

    if(maps.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  Future<TextBook> createTextbook(TextBook textBook) async {
    final database = await instance.database;
    final id = await database.insert(tableTextbook, textBook.toJson());
    return textBook.copy(id: id);
  }

  // table of quiz
  Future insertQuizzes(List<Quiz> quizzes) async {
    final database = await instance.database;
    quizzes.forEach((quiz) async {
      final id = await database.insert(tableQuiz, quiz.toJson());
      quiz.copy(id: id);
    });
  }

  Future<List<Quiz>> readQuizzes(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableQuiz,
        where: '${QuizFields.textId} = ?',
        whereArgs: [textId]
    );
    if(result.isNotEmpty){
      return result.map((json) => Quiz.fromJson(json)).toList();
    }else{
      return [];
    }
  }

  Future<void> updateQuiz(Quiz quiz) async {
    final database = await instance.database;
    await database.update(
        tableQuiz,
        quiz.toJson(),
        where: "_id = ?",
        whereArgs: [quiz.id]
    );
  }

  Future<void> resetDoneRecodeOfQuiz(String textId) async {
    final database = await instance.database;
    final result = await database.query(
        tableQuiz,
        where: '${QuizFields.textId} = ?',
        whereArgs: [textId]
    );

    if(result.isNotEmpty){
      final vocabs = result.map((json) => Quiz.fromJson(json)).toList();
      vocabs.forEach((quiz) async{
        final resetData = quiz.copy(done: 0);
        await database.update(
            tableQuiz,
            resetData.toJson(),
            where: "_id = ?",
            whereArgs: [quiz.id]
        );
      });
    }
  }

  Future<void> deleteQuizzes(TextBook textbook) async {
    final database = await instance.database;
    await database.delete(
        tableQuiz,
        where: '${QuizFields.textId} = ?',
        whereArgs: [textbook.checkId]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}