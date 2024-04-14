import 'package:vocab_blast/notifier/banner_ad_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:vocab_blast/db/vocab_blast_database.dart';
import 'package:vocab_blast/model/sentence.dart';
import 'package:vocab_blast/model/textbook.dart';
import 'package:vocab_blast/model/vocabulary.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vocab_blast/notifier/interstitial_ad_notifier.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vocab_blast/notifier/book_notifier.dart';
import 'package:vocab_blast/notifier/user_notifier.dart';
import 'package:vocab_blast/model/user_setting.dart';

final learnedNumberProvider = StateProvider.autoDispose((ref) => 0);

class CardViewPage extends ConsumerWidget{

  final TextBook textbook;
  final List<Vocab> vocabCards;
  final List<Sentence> compCards;
  const CardViewPage(this.textbook, this.vocabCards,this.compCards,  {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final controller = SwipableStackController();
    final String bookType = textbook.type;

    final UserSetting userSetting = ref.watch(userInfoProvider);

    final padding = MediaQuery.of(context).padding;
    final windowHeight = size.height - padding.top - padding.bottom;
    var bottomSize =  (windowHeight - appBarHeight - 50 - size.width - 30) / 4;

    if(bottomSize > 50) bottomSize = 50;

    int bookLength = 0;
    if(bookType == 'vocab' && vocabCards.isNotEmpty){
      bookLength = vocabCards.length;
    }else if(bookType == 'comp'&& compCards.isNotEmpty){
      bookLength = compCards.length;
    }

    final List<PageController> controllers = List.generate(
      bookLength, (index) => PageController(initialPage: 0),
    );

    final banner = ref.watch(bannerAdProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            Color(0xffe0ffff),
            Color(0xffcbf1e7),
            Color(0xffdbffd7),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: ()async{
              ref.invalidate(booksStateProvider(Tuple2(textbook,userSetting)));
              Navigator.pop(context);
              await ref.read(userInfoProvider.notifier).updateTimes();
              if(5 < userSetting.times){
                await ref.read(userInfoProvider.notifier).subTimes();
                ref.read(adProvider.notifier).showAd();
              }
            },
            icon: const Icon(Icons.close, color: Colors.black87,),

          ),
        ),
        body: Consumer(builder: (context, ref, _) {
          return Column(
            children: [
              Container(
                width: 320,
                height: 50,
                color: Colors.transparent,
                child: banner.isLoaded
                    ?AdWidget(ad: banner.ad!)
                    : null,
              ),
              if(compCards.isNotEmpty)SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SwipableStack(
                      controller: controller,
                      onWillMoveNext: (index, direction) {
                        final allowedActions = [
                          SwipeDirection.right,
                          SwipeDirection.left,
                          SwipeDirection.up,
                        ];
                        return allowedActions.contains(direction);
                      },

                      onSwipeCompleted: (index, direction) async{

                        if(controller.currentIndex + 1 == bookLength){
                          ref.invalidate(booksStateProvider(Tuple2(textbook,userSetting)));
                          Navigator.of(context).pop();
                          await ref.read(userInfoProvider.notifier).updateTimes();
                          if(5 < userSetting.times){
                            await ref.read(userInfoProvider.notifier).subTimes();
                            ref.read(adProvider.notifier).showAd();
                          }
                        }

                        if(controller.currentIndex < bookLength){
                          ref.read(learnedNumberProvider.notifier).state = index+1;
                        }

                        switch(direction){

                          case SwipeDirection.right:
                            await updateComp(compCards[index].copy(done: 1));
                            break;
                          case SwipeDirection.left:
                            await updateComp(compCards[index].copy(done: 2));
                            break;
                          case SwipeDirection.up:
                            await updateComp(compCards[index].copy(done: 0));
                            break;
                          case SwipeDirection.down:
                            break;
                        }
                      },
                      itemCount: compCards.length,
                      builder: (context, properties) {
                        final index = properties.index;
                        final centerPosition = size.width / 2;
                        return Stack(
                          children: [
                            Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controllers[index],
                                children: [
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        compCards[index].translation,
                                        style: const TextStyle(fontSize: 25.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        compCards[index].sentence,
                                        style: const TextStyle(fontSize: 25.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmoothPageIndicator(
                                  controller: controllers[index],
                                  count: 2,
                                  effect: const WormEffect(
                                    dotHeight: 12,
                                    dotWidth: 12,
                                    type: WormType.thin,
                                    // strokeWidth: 5,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapUp: (details){
                                if(centerPosition < details.globalPosition.dx && controllers[controller.currentIndex].page!.round() < 1){
                                  controllers[controller.currentIndex].nextPage(duration: const Duration(microseconds: 1), curve: Curves.easeIn);
                                }else if(centerPosition >= details.globalPosition.dx && 0 < controllers[controller.currentIndex].page!.round()){
                                  controllers[controller.currentIndex].previousPage(duration: const Duration(milliseconds: 1), curve: Curves.linear);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  )
              )
              else if(vocabCards.isNotEmpty)SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SwipableStack(
                      controller: controller,
                      onWillMoveNext: (index, direction) {
                        final allowedActions = [
                          SwipeDirection.right,
                          SwipeDirection.left,
                          SwipeDirection.up,
                        ];
                        return allowedActions.contains(direction);
                      },
                      onSwipeCompleted: (index, direction) async{

                        if(controller.currentIndex + 1 == bookLength){
                          ref.invalidate(booksStateProvider(Tuple2(textbook,userSetting)));
                          Navigator.of(context).pop();
                          await ref.read(userInfoProvider.notifier).updateTimes();
                          if(5 < userSetting.times){
                            await ref.read(userInfoProvider.notifier).subTimes();
                            ref.read(adProvider.notifier).showAd();
                          }
                        }

                        if(controller.currentIndex < bookLength){
                          ref.read(learnedNumberProvider.notifier).state = index+1;
                        }

                        switch(direction){

                          case SwipeDirection.right:
                            await updateVocab(vocabCards[index].copy(done: 1));
                            break;
                          case SwipeDirection.left:
                            await updateVocab(vocabCards[index].copy(done: 2));
                            break;
                          case SwipeDirection.up:
                            await updateVocab(vocabCards[index].copy(done: 0));
                            break;
                          case SwipeDirection.down:
                            break;
                        }
                      },
                      itemCount: vocabCards.length,
                      builder: (context, properties) {
                        final index = properties.index;
                        final centerPosition = size.width / 2;
                        return Stack(
                          children: [
                            Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controllers[index],
                            onPageChanged: (int newIndex) {
                            },
                            children: [
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: Center(
                                  child: Text(
                                    vocabCards[index].word,
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: Center(
                                  child: Text(
                                    vocabCards[index].meaning,
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: Center(
                                  child: Text(
                                    vocabCards[index].translation,
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: Center(
                                  child: Text(
                                    vocabCards[index].sentence,
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmoothPageIndicator(
                                  controller: controllers[index],
                                  count: 4,
                                  effect: const WormEffect(
                                    dotHeight: 12,
                                    dotWidth: 12,
                                    type: WormType.thin,
                                    // strokeWidth: 5,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapUp: (details){
                                if(centerPosition < details.globalPosition.dx && controllers[controller.currentIndex].page!.round() < 3){
                                  controllers[controller.currentIndex].nextPage(duration: const Duration(microseconds: 1), curve: Curves.easeIn);
                                }else if(centerPosition >= details.globalPosition.dx && 0 < controllers[controller.currentIndex].page!.round()){
                                  controllers[controller.currentIndex].previousPage(duration: const Duration(milliseconds: 1), curve: Curves.linear);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  )
              )
              else SizedBox(
                  width: size.width,
                  height: size.width,
                ),

            ],
          );
        }),

        //floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Consumer(builder: (context, ref, _) {

          double percent = 0.0;
          final learnedNumber = ref.watch(learnedNumberProvider);

          if(bookType == 'vocab' && vocabCards.isNotEmpty){
            percent = learnedNumber / bookLength;
          }else if(bookType == 'comp'&& compCards.isNotEmpty){
            percent = learnedNumber / bookLength;
          }

          return Container(
            color: Colors.transparent,
            height: windowHeight - appBarHeight -50 - size.width - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child : CircularPercentIndicator(
                    radius: 65.0,
                    lineWidth: 15.0,
                    animation: false,
                    percent: percent,
                    center:  Text("${learnedNumber.toInt()} / $bookLength", style: const TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                    circularStrokeCap: CircularStrokeCap.round,
                    linearGradient: const LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors:  [
                        Color(0xff7fffd4),
                        Color(0xff00fa9a),
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfff8f8ff),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, //色
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: GestureDetector(

                        onTap: () {
                          if(bookType == 'vocab' && controllers[controller.currentIndex].page!.round() < 3){
                            controllers[controller.currentIndex].nextPage(duration: const Duration(microseconds: 1), curve: Curves.easeIn);
                          }
                          if(bookType == 'comp' && controllers[controller.currentIndex].page!.round() < 1){
                            controllers[controller.currentIndex].nextPage(duration: const Duration(microseconds: 1), curve: Curves.easeIn);
                          }
                        },
                        child: Icon(Icons.arrow_right,size: bottomSize,color: Colors.black54,),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfff8f8ff),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, //色
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: GestureDetector(

                        onTap: () {
                          if(0 < controllers[controller.currentIndex].page!.round()){
                            controllers[controller.currentIndex].previousPage(duration: const Duration(milliseconds: 1), curve: Curves.linear);
                          }
                        },
                        child: Icon(Icons.arrow_left,size: bottomSize ,color: Colors.black54,),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfff8f8ff),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, //色
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: GestureDetector(

                        onTap: () {
                          if(controller.canRewind){
                            controller.rewind(duration: const Duration(milliseconds: 500));
                            ref.read(learnedNumberProvider.notifier).state = controller.currentIndex;
                          }
                        },
                        child: Icon(Icons.replay,size: bottomSize,color: Colors.black54,),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xfff8f8ff),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12, //色
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ]
                      ),
                      child: GestureDetector(
                        onTap:  () async {
                          if(controller.currentIndex < bookLength){
                            controller.next(swipeDirection: SwipeDirection.right, duration: const Duration(milliseconds: 500));
                          }
                        },
                        child: Icon(Icons.check,size: bottomSize,color: Colors.redAccent,),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfff8f8ff),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, //色
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if(controller.currentIndex < bookLength){
                            controller.next(swipeDirection: SwipeDirection.up, duration: const Duration(milliseconds: 500));
                          }
                        },
                        child: Icon(Icons.question_mark_sharp,size: bottomSize,color: Colors.orangeAccent.shade200,),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfff8f8ff),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12, //色
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if(controller.currentIndex < bookLength){
                            controller.next(swipeDirection: SwipeDirection.left, duration: const Duration(milliseconds: 500));
                          }
                        },
                        child:  Icon(Icons.close,size: bottomSize,color: Colors.black87,),
                      ),
                    ),
                    const Spacer(),

                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> updateVocab(Vocab vocab) async{
    final database = VocabBlastDatabase.instance;
    database.updateVocab(vocab);
  }

  Future<void> updateComp(Sentence sentence) async{
    final database = VocabBlastDatabase.instance;
    database.updateSentence(sentence);
  }



}

