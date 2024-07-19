import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  FestivalModel festival;
  SuccessDialog({super.key, required this.festival});

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
                'Siz ${festival.name} tadbiriga muvaffaqiyatli ro\'yxatdan o\'tdingiz.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Action for Eslatma Belgilash
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text('Eslatma Belgilash'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Bosh Sahifa',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
