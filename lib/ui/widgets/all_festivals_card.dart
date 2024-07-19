import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/ui/screens/festival_info_screen.dart';
import 'package:festivals_exam_4/utils/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllFestivalsCard extends StatefulWidget {
  final FestivalModel festival;
  AllFestivalsCard({super.key, required this.festival});

  @override
  State<AllFestivalsCard> createState() => _AllFestivalsCardState();
}

class _AllFestivalsCardState extends State<AllFestivalsCard> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.festival.addedDate.toDateTime();
  }

  Future<List<String>> fetchAndDisplayPlaceMarks() async {
    List<String> placeMarkStrings = await widget.festival.getPlaceMarkStrings();
    placeMarkStrings.forEach((placeMarkString) {
      print(placeMarkString); // Display each placemark string
    });
    return placeMarkStrings;
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FestivalInfoScreen(
                  festival: widget.festival,
                );
              },
            ));
          },
          child: FutureBuilder(
              future: fetchAndDisplayPlaceMarks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Ma'lumotlar mavjud emas"),
                  );
                }
                final locationName = snapshot.data;
                return locationName == null
                    ? const Center(
                        child: Text("Ma'lumotlar mavjud emas"),
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 120,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                      widget.festival.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.4),
                                          Colors.black.withOpacity(0.1),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.festival.name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      date.formatDateWithWeekday(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      locationName.toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
