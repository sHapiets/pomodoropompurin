import 'package:flutter/material.dart';
import 'package:pomodoropompurin/main.dart';

class CustomDialogs {
  CustomDialogs._();
  static final singleton = CustomDialogs._();

  void showRewardsEndTimeDialog(int? pomPoints) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // optional
            child: Stack(
              children: [
                Image.asset('assets/images/L7.png'),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Clipped lezgoo')],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
