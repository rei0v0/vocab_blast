import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vocab_blast/essay_list_page.dart';
import 'package:vocab_blast/home_page2.dart';
import 'package:vocab_blast/my_library_page2.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final pageProvider = StateProvider((ref) => 0);


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeFirebaseAuth();
  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xfff8f8ff),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initializeFirebaseAuth() async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = _firebaseAuth.currentUser;
  if (user == null) {
    await _firebaseAuth.signInAnonymously();
    await FirebaseFirestore.instance
        .collection('user') // コレクションID
        .doc(_firebaseAuth.currentUser!.uid) // ドキュメントID
        .set({'limit': 3,'token': 1000});
  }else{
    print(user.uid);
  }
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocab Blast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'NotoSansJP',
      ),
      routes: {
        '/': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {

  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    final currentIndex = ref.watch(pageProvider);
    return Scaffold(
        backgroundColor: const Color(0xfff8f8ff),
        body: IndexedStack(
          index: currentIndex,
            children: const [
              HomePage2(),
              MyLibraryPage2(),
              EssayListPage(),
            ]
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black.withOpacity(0.8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                GestureDetector(
                  onTap: (){
                    ref.read(pageProvider.notifier).state = 0;
                  },
                  child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentIndex == 0 ? Colors.orange :Colors.white.withOpacity(0.8),
                          ),
                          Text('Home',style: TextStyle(color: Colors.white.withOpacity(0.8)),)
                        ],
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    ref.read(pageProvider.notifier).state = 1;
                  },
                  child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(
                            Icons.library_books,
                            color: currentIndex == 1 ? Colors.orange :Colors.white.withOpacity(0.8),
                          ),
                          Text('My Library',
                            style: TextStyle(
                                color:Colors.white.withOpacity(0.8)
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    ref.read(pageProvider.notifier).state = 2;
                  },
                  child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(
                            Icons.edit_note,
                            color: currentIndex == 2 ? Colors.orange :Colors.white.withOpacity(0.8),
                          ),
                          Text('Essay',
                            style: TextStyle(
                                color:Colors.white.withOpacity(0.8)
                            ),
                          ),
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        )
    );

  }

}


