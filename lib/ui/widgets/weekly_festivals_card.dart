import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/ui/screens/festival_info_screen.dart';
import 'package:festivals_exam_4/utils/app_styles.dart';
import 'package:flutter/material.dart';

class WeeklyFestivalsCard extends StatelessWidget {
  FestivalModel festival;
  WeeklyFestivalsCard({super.key, required this.festival});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FestivalInfoScreen(
              festival: festival,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(30),
          clipBehavior: Clip.hardEdge,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content inside the card
            children: [
              Text(
                festival.time.day.toString(),
              ),
              Text(
                festival.name,
                style: AppTextStyles.headline20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
