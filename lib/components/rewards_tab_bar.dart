import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sky_diving/components/reward_card.dart';
import 'package:sky_diving/constants/app_colors.dart';
import '../constants/app_images.dart';
import '../models/user_reward_model.dart'; // Import your model

class RewardsTabBar extends StatelessWidget {
  final List<UserReward> rewardList;

  RewardsTabBar({super.key, required this.rewardList});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.primaryColor,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: '   All   '),
                Tab(text: ' Active '),
                Tab(text: ' Pending  '),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                _buildRewardList(rewardList),
                _buildRewardList(rewardList.where((r) => r.status == 'active').toList()),
                _buildRewardList(rewardList.where((r) => r.status != 'active').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardList(List<UserReward> rewards) {
    if (rewards.isEmpty) {
      return const Center(child: Text("No rewards found", style: TextStyle(color: Colors.white)));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.separated(
        itemCount: rewards.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return RewardCard(
            title: "\$${reward.discount} cash back",
            status: reward.status,
            date: DateFormat('MMM dd, yyyy').format(reward.createdAt),
            statusIcon: reward.status == 'active' ? AppImages.done : AppImages.timer,
            statusColor: reward.status == 'active' ? Colors.green : Colors.yellow,
          );
        },
      ),
    );
  }
}
