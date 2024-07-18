import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/ui/screens/register_screen.dart';
import 'package:festivals_exam_4/ui/widgets/register_festival_modal_bootom_sheet.dart';
import 'package:festivals_exam_4/utils/app_styles.dart';
import 'package:festivals_exam_4/utils/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FestivalInfoScreen extends StatefulWidget {
  FestivalModel festival;
  FestivalInfoScreen({super.key, required this.festival});

  @override
  State<FestivalInfoScreen> createState() => _FestivalInfoScreenState();
}

class _FestivalInfoScreenState extends State<FestivalInfoScreen> {
  LatLng festivalLocation = LatLng(37.7749, -122.4194);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    festivalLocation = LatLng(double.parse(widget.festival.location[0]),
        double.parse(widget.festival.location[1]));
    print(festivalLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
              // padding: EdgeInsets.all(20.0),
              child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuZmsL5l93Zdp05KPrVuOoTQX7py0TIm9pAg&s"),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.festival.name,
                    style: AppTextStyles.headline20,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.calendar_month),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.festival.time.formatDateWithWeekday(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.festival.userID,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.calendar_month),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.festival.attendants.toString()} qatnashuvchilar",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                          ),
                          Text("Siz ham qatnashing!")
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.festival.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: festivalLocation,
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('festival_location'),
                          position: festivalLocation,
                          infoWindow: const InfoWindow(
                            title: 'Festival Location',
                            snippet: 'Sample Location',
                          ),
                        ),
                      },
                      onMapCreated: (GoogleMapController controller) {
                        // You can manipulate the map controller here
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const RegistrationBottomSheet();
              },
            );
          },
          child: const Text("Ro'yxatdan o'tish"),
        ),
      ),
    );
  }
}

// import 'package:festivals_exam_4/data/models/festival_model.dart';
// import 'package:flutter/material.dart';

// class FestivalInfoScreen extends StatelessWidget {
//   FestivalModel festival;

//   FestivalInfoScreen({super.key, required this.festival});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
