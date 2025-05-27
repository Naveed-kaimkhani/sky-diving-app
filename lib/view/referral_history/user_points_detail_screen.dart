import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sky_diving/constants/app_colors.dart';
import 'package:sky_diving/models/user_reward_model.dart';
import 'package:sky_diving/view_model/user_reward_controller.dart';

class UserPointsDetailScreen extends StatelessWidget {
  final String userName;
  final String userId;
  final int totalPoints;

  const UserPointsDetailScreen({
    Key? key,
    required this.userName,
    required this.userId,
    required this.totalPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRewardController = Get.find<UserRewardController>();
    
    // Filter rewards for this specific user
    final userRewards = userRewardController.rewards
        .where((reward) => reward.userReferalId == userId)
        .toList();
    

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('$userName\'s Points', 
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (userRewardController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (userRewardController.error.value.isNotEmpty) {
          return Center(
            child: Text(userRewardController.error.value,
                style: TextStyle(color: Colors.red)),
          );
        }

        return Column(
          children: [
            // Header with total points
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor.withOpacity(0.7), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Points Earned',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      '$totalPoints pts',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Points history list
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        'Points History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (userRewards.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'No points history found',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: userRewards.length,
                          itemBuilder: (context, index) {
                            final reward = userRewards[index];
                            return _buildPointItem(reward);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPointItem(UserReward reward) {
    final date = DateFormat('dd MMM yyyy').format(reward.createdAt);
    final isBonus = reward.status == 'bonus'; // Adjust based on your status values

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isBonus
                  ? Colors.amber.withOpacity(0.2)
                  : AppColors.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isBonus ? Icons.card_giftcard : Icons.rocket_launch,
              color: isBonus ? Colors.amber : AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBonus ? 'Bonus Points' : 'Activity Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+${reward.points} pts',
            style: TextStyle(
              color: isBonus ? Colors.amber : AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}