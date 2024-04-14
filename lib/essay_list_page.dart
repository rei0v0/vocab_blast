import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocab_blast/model/reward_ad_state.dart';
import 'package:vocab_blast/model/topic.dart';
import 'package:vocab_blast/model/topic_notifier.dart';
import 'package:vocab_blast/notifier/reword_ad_for_token_notifier.dart';
import 'package:vocab_blast/topic_list.dart';


final topicStateProvider = StateNotifierProvider<TopicsNotifier, List<Topic>>((ref) {
  return TopicsNotifier();
});

final rewardAdForTokenProvider = StateNotifierProvider<RewardAdForTokenNotifier, RewardAdState>((ref) {
  return RewardAdForTokenNotifier();
});

class EssayListPage extends ConsumerWidget {

  const EssayListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final topics = ref.watch(topicStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Essay with AI',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.black),),
        elevation: 0.0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: [
                Color(0xfff0ffff),
                Color(0xffcbf1e7),
                Color(0xffdbffd7),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.transparent,
                  forceElevated: innerBoxIsScrolled,
                  elevation: 0.0,
                  expandedHeight: 75,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      borderRadius:  BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        colors: [
                          Color(0xfff0ffff),
                          Color(0xffcbf1e7),
                          Color(0xffdbffd7),
                        ],
                      ),
                    ),
                  ),
                  title: const TabBar(
                    isScrollable: false,
                    labelColor: Colors.black,
                    unselectedLabelColor:  Colors.black87,
                    unselectedLabelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                    labelStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(child: Text('トピック',style: TextStyle(fontSize: 20,color: Colors.black87),),),
                      //Tab(child: Text('履歴',style: TextStyle(fontSize: 20,color: Colors.black87),),),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TopicList(topics),
              //Container(),
            ],
          ),
        ),
      )
    );
  }

}