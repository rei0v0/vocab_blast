import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/user_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userInfoProvider = StateNotifierProvider<UserNotifier, UserSetting>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserSetting> {

  final userUid = FirebaseAuth.instance.currentUser?.uid;

  UserNotifier() : super(const UserSetting()) {
    if(userUid != null){
      getInfo();
    }else{
      state = const UserSetting(uid: '-', limit: 0);
    }
  }

  Future<void> getInfo() async {

     final userRef = FirebaseFirestore.instance.collection('user').doc(userUid!);
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     final int? times = prefs.getInt('times');
     final int? numQuizzes = prefs.getInt('numQuizzes');
     final bool? isRandom = prefs.getBool('isRandom');
     final bool? onlyUnlearnedQuizzes = prefs.getBool('onlyUnlearnedQuizzes');

     if(times == null){
       await prefs.setInt('times', 0);
     }

     if(numQuizzes == null){
       await prefs.setInt('numQuizzes', 5);
     }

     if(isRandom == null){
       await prefs.setBool('isRandom', false);
     }

     if(onlyUnlearnedQuizzes == null){
       await prefs.setBool('onlyUnlearnedQuizzes', true);
     }

     final snapshot = await userRef.get();
     if(snapshot.data()?['token'] == null){
       userRef.update({'token' : 1000});
     }

     userRef.snapshots().listen((user) {
       final Map<String, dynamic>? data = user.data();
       final String uid = user.id;
       final int limit = data?['limit'] ?? 0;
       final int token = data?['token'] ?? 0;
       state = UserSetting(uid: uid, limit: limit,token: token, times: times ?? 0);
     });

  }

  Future<void> updateTimes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? times = prefs.getInt('times');
    if(times != null){
      await prefs.setInt('times', times + 1);
      state = state.copyWith(times: times + 1);
    }
  }
  Future<void> subTimes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int time = state.times - 5;
    if(time < 0) time = 0;
    await prefs.setInt('times', time);
    state = state.copyWith(times: time);
  }

  Future<void> addCredit() async {
    if(userUid != null){
      final userRef = FirebaseFirestore.instance.collection('user').doc(userUid!);
      userRef.update({
        'limit' : state.limit + 3
      });
    }
  }

  Future<void> addToken() async {
    if(userUid != null){
      final userRef = FirebaseFirestore.instance.collection('user').doc(userUid!);
      userRef.update({
        'token' : state.token + 2000
      });
    }
  }

  Future<void> useToken(String essayLength) async {

    final Map<String, int> willUseToken = {
      '25 ~ 35' : 600,
      '60 ~ 80' : 800,
      '80 ~ 100' : 1000,
      '120 ~ 150' : 1500,
      '200 ~ 240' : 2000,
    };
    final int token = willUseToken[essayLength] ?? 1000;
    if(userUid != null){
      final userRef = FirebaseFirestore.instance.collection('user').doc(userUid!);
      userRef.update({
        'token' : state.token - token
      });
    }
  }

  Future<void> useCredit() async {
    if(userUid != null){
      final userRef = FirebaseFirestore.instance.collection('user').doc(userUid!);
      userRef.update({
        'limit' : state.limit - 1
      });
    }
  }

  bool checkCredit() {
    if(0 < state.limit){
      return true;
    }else{
      return false;
    }
  }

  Future<void> updateSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('numQuizzes', state.numQuizzes);
    await prefs.setBool('isRandom', state.isRandom);
    await prefs.setBool('onlyUnlearnedQuizzes', state.onlyUnlearnedQuizzes);
  }

  void increaseNumQuizzes() async{
    if(30 > state.numQuizzes){
      state = state.copyWith(numQuizzes: state.numQuizzes + 5);
    }
  }
  void decreaseNumQuizzes() async{
    if(10 <= state.numQuizzes){
      state = state.copyWith(numQuizzes: state.numQuizzes - 5);
    }
  }

  void setIsRandom(bool value){
    state = state.copyWith(isRandom: value);
  }

  void setOnlyUnlearnedQuizzes(bool value){
    state = state.copyWith(onlyUnlearnedQuizzes: value);
  }


}