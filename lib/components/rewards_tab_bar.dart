import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_diving/components/reward_card.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/models/user_rewardedpoints.dart';
import '../constants/app_images.dart';
import '../models/user_reward_model.dart'; // Import your model

class RewardsTabBar extends StatelessWidget {
  final List<UserPoints> rewardList;

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
                Tab(text: '  Pending  '),
                Tab(text: '  Approved  '),
                Tab(text: '  Rejected  '),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                // _buildRewardList(rewardList,),

                _buildRewardList(
                    rewardList.where((r) => r.status == 'pending').toList()),
                _buildRewardList(
                    rewardList.where((r) => r.status == 'approved').toList()),

                _buildRewardList(
                    rewardList.where((r) => r.status == 'rejected').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardList(List<UserPoints> rewards) {
    if (rewards.isEmpty) {
      return const Center(
          child:
              Text("No rewards found", style: TextStyle(color: Colors.white)));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.separated(
        itemCount: rewards.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return RewardCard(
            // title: "${reward.redeemPoints} Points ${reward.status}",
            title:
                "${reward.redeemPoints} Points ${reward.status[0].toUpperCase()}${reward.status.substring(1)}",

            status: reward.status,
            date: DateFormat('MMM dd, yyyy').format(reward.createdAt),
          //   statusIcon:
          //       reward.status == 'approved' ? AppImages.done : AppImages.timer,
          //   statusColor:
          //       reward.status == 'approved' ? Colors.green : Colors.yellow,
          statusIcon: reward.status == 'approved'
    ? AppImages.done
    : reward.status == 'pending'
        ? AppImages.timer
        : AppImages.close, // assuming AppImages.error exists for 'rejected'
statusColor: reward.status == 'approved'
    ? Colors.green
    : reward.status == 'pending'
        ? Colors.orange
        : Colors.red,

           );
        },
      ),
    );
  }
}
