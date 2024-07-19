import 'package:festivals_exam_4/ui/screens/near_festivals.dart';
import 'package:festivals_exam_4/ui/screens/personal_festivals.dart';
import 'package:festivals_exam_4/ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class MyFestivals extends StatelessWidget {
  const MyFestivals({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mening tadbirlarim'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tashkil qilganlarim'),
              Tab(text: 'Yaqinda'),
              Tab(text: 'Ishtirok etganlarim'),
              Tab(text: 'Bekor qilganlarim'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PersonalFestivals(),
            NearFestivals(),
            NearFestivals(),
            Center(child: Text('Settings Page')),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
