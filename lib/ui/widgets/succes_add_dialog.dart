import 'package:festivals_exam_4/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccesAddDialog extends StatelessWidget {
  String name;
  SuccesAddDialog({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Container(
              height: 80,
              width: 80,
              child: Lottie.asset(
                'assets/lottie/success.json', // Make sure you have this animation in your assets
                repeat: false,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tabriklaymiz!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Siz ${name} tadbirini muvaffaqiyatli yaratdingiz.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
                },
                child: const Text(
                  'Bosh Sahifa',
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
    ;
  }
}
