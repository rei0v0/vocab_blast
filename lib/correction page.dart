import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/reward_ad_state.dart';
import 'package:vocab_blast/notifier/reword_ad_for_token_notifier.dart';
import 'package:vocab_blast/notifier/user_notifier.dart';
import 'notifier/essay_notifier.dart';

final rewardAdForTokenProvider = StateNotifierProvider<RewardAdForTokenNotifier, RewardAdState>((ref) {
  return RewardAdForTokenNotifier();
});

final isFinishProvider = StateProvider.autoDispose((ref) => false);

class CorrectionPage extends ConsumerWidget {

  const CorrectionPage(this.topic, this.essayLength, this.level, {super.key});

  final String topic;
  final String essayLength;
  final String level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    final essayNotifier = ref.read(essayProvider(topic).notifier);
    final textEditingController = essayNotifier.textEditingController;
    final essay = ref.watch(essayProvider(topic));
    final Map<String, int> maxLength = {
      '25 ~ 35' : 35,
      '60 ~ 80' : 80,
      '80 ~ 100' : 100,
      '120 ~ 150' : 150,
      '200 ~ 240' : 240,
    };

    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topRight,
            colors: [
              Color(0xfff0ffff),
              Color(0xffcbf1e7),
              Color(0xffdbffd7),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: const Text('ライティング',style: TextStyle(color: Colors.black),),
            actions: [
              TextButton.icon(
                onPressed: () async{
                  final bool? result =  await _showBottomSheetMenu(context,essayLength);
                  final userInfo = ref.watch(userInfoProvider);
                  final userInfoNotifier = ref.read(userInfoProvider.notifier);

                  if(result == true && essayNotifier.checkState(userInfo, essayLength) ){

                    bool consent = false;
                    if(context.mounted && result == true){consent = await _askForConsent(context);}

                    if(consent){
                      final String rule = essayNotifier.makePrompt(topic, essayLength, level);
                      await userInfoNotifier.useToken(essayLength);
                      essayNotifier.chatCompleteWithSSE(rule);
                    }


                  }else if(result == true && context.mounted){
                    final Map<String, String> message = essayNotifier.makeMessage(userInfo, essayLength);
                    await _showAlert(context,message['title'] ?? '',message['content'] ?? '');
                  }

                },
                icon: const Icon(Icons.rule,color: Colors.black,), //アイコン
                label: const Text('添削する',style: TextStyle(color: Colors.black),), //テキスト
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), //色
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(topic),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: width * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), //色
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: textEditingController,
                              maxLength: null,
                              enabled: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Write here',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(!essay.isValidInput)const Text('使用できない文字が入力されています ',style: TextStyle(color: Colors.red,fontSize: 13),),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('${essay.numWords} / ${maxLength[essayLength]}'),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    if(essay.comment != '')Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4), //色
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(essay.comment),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xffdbffd7),
            onPressed: () {

            },
            child: const Icon(Icons.save,color: Colors.black,),
          ),

           */
        )
    );
  }

  Future _showAlert(BuildContext context, String title, String content) async {

    await showDialog(
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, _){
            final isFinished = ref.watch(isFinishProvider);

            return AlertDialog(
              title:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
              content:  Text(content),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child:  GestureDetector(
                        onTap:  (){
                          Navigator.of(context).pop();
                        },


                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 40,
                          child:  Center(
                            child: Text(
                              isFinished ? "閉じる" : 'はい',
                              style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            );
          }

          );
        }
    );
  }

  Future<bool> _askForConsent(BuildContext context) async {

    final bool result = await showDialog(
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, _){

            return AlertDialog(
              title:  Text('添削しますか？',style: const TextStyle(fontWeight: FontWeight.bold),),
              content:  Text('AIによって自動添削を行います。出力には間違いが含まれる可能性がありますがよろしいですか？'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child:  GestureDetector(
                        onTap:  (){
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1.0),
                          ),
                          height: 40,
                          child:  const Center(
                            child: Text(
                              'いいえ',
                              style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child:  GestureDetector(
                        onTap:  (){
                          Navigator.of(context).pop(true);
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 40,
                          child:  const Center(
                            child: Text(
                              'はい',
                              style:  TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            );
          }

          );
        }
    );
    return result ?? false;
  }
  Future<bool?> _showBottomSheetMenu(BuildContext context,String essayLength) async {

    final Map<String, int> willUseToken = {
      '25 ~ 35' : 600,
      '60 ~ 80' : 800,
      '80 ~ 100' : 1000,
      '120 ~ 150' : 1500,
      '200 ~ 240' : 2000,
    };

    final bool? result = await showModalBottomSheet<bool>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          final width = MediaQuery.of(context).size.width;
          return Consumer(builder: (context, ref, _) {
            final rewardAdNotifier = ref.read(rewardAdForTokenProvider.notifier);
            final rewardAd = ref.watch(rewardAdForTokenProvider);
            final userNotifier = ref.read(userInfoProvider.notifier);
            final userInfo = ref.watch(userInfoProvider);
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('保有トークン',style: TextStyle(fontSize: 17),),
                            const Spacer(),
                            const Icon(Icons.token),
                            Text(userInfo.token.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            IconButton(
                                onPressed: rewardAd.isLoaded
                                    ? () async{
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Consumer(builder: (context, ref, _){
                                          final isFinished = ref.watch(isFinishProvider);
                                          return AlertDialog(
                                            title: const Text("広告を視聴してトークンを獲得しますか？",style: TextStyle(fontWeight: FontWeight.bold),),
                                            content: const Text("トークンが2000付与されます。"),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child:  GestureDetector(
                                                      onTap: isFinished ? (){
                                                        Navigator.of(context).pop();
                                                      }
                                                          : () async {

                                                        await rewardAdNotifier.showAd(() async {
                                                          await userNotifier.addToken();
                                                          ref.read(isFinishProvider.notifier).state = true;
                                                        });
                                                        ref.invalidate(rewardAdForTokenProvider);

                                                      },

                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        height: 40,
                                                        child:  Center(
                                                          child: Text(
                                                            isFinished ? "閉じる" : 'はい',
                                                            style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        }

                                        );
                                      }
                                  );

                                } : null,
                                icon: Icon(Icons.add_circle,size: 35,color: rewardAd.isLoaded ? Colors.blue : Colors.grey,)
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child:  Padding(
                            padding:  EdgeInsets.all(4.0),
                            child: Text('広告を視聴してトークンを獲得できます。',style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold,color: Colors.grey),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.token,color: Colors.black,size: 40,),
                      Text(willUseToken[essayLength].toString(),style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      const SizedBox(width: 20,),
                      Container(
                        width: width * 0.4,
                        child: Text('添削に${willUseToken[essayLength]}トークン必要です。',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      )

                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: width * 0.7,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child:  Text('添削',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),),
                    ),
                  ),
                ],
              ),
            );
          });
        });
    return result;
  }

}

