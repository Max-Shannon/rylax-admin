import 'package:flutter/material.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class DashboardData extends StatelessWidget {
  const DashboardData({super.key});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: "Dashboard (Non Functional)", fontSize: headingSize),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Container(
                  color: AppColors.mainWhite,
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AppText(textValue: "3", fontSize: 42, fontColor: AppColors.mainGreen),
                      AppText(textValue: "Developments", fontSize: 24),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  color: AppColors.mainWhite,
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AppText(textValue: "13", fontSize: 42, fontColor: AppColors.mainGreen),
                      AppText(textValue: "Buyers", fontSize: 24),
                    ],
                  ),
                ),
              ),

              Card(
                child: Container(
                  color: AppColors.mainWhite,
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AppText(textValue: "13", fontSize: 42, fontColor: AppColors.mainGreen),
                      AppText(textValue: "Verified Buyers", fontSize: 24),
                    ],
                  ),
                ),
              ),

              Card(
                child: Container(
                  color: AppColors.mainWhite,
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AppText(textValue: "340", fontSize: 42, fontColor: AppColors.mainGreen),
                      AppText(textValue: "Properties", fontSize: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 40),

          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: "Recent Activity (Non Functional)", fontSize: headingSize),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Container(
                      color: AppColors.mainWhite,
                      width: 600,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(textValue: "Robert Earls submitted Proof of Address", fontSize: 18),
                          AppText(textValue: "10:31am", fontSize: 18),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Container(
                      color: AppColors.mainWhite,
                      width: 600,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(textValue: "Emma Kavanagh uploaded Document", fontSize: 18),
                          AppText(textValue: "9:37am", fontSize: 18),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Container(
                      color: AppColors.mainWhite,
                      width: 600,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(textValue: "Matt Forkin Added a note for Sarah Moore", fontSize: 18),
                          AppText(textValue: "Yesterday", fontSize: 18),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Container(
                      color: AppColors.mainWhite,
                      width: 600,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppText(textValue: "Matt Forkin verified Solicitor Details for Grapham", fontSize: 18),
                          AppText(textValue: "Yesterday", fontSize: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
