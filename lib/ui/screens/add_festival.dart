import 'package:festivals_exam_4/ui/widgets/succes_add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';
import 'package:festivals_exam_4/ui/widgets/google_map.dart';

class EventAddPage extends StatefulWidget {
  @override
  _EventAddPageState createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  LatLng _selectedLocation = LatLng(41.2856806, 69.2034646);

  void _onLocationSelected(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tadbir Qo\'shish'),
      ),
      body: BlocBuilder<FestivalsBloc, FestivalsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nomi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Kuni',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Vaqti',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _timeController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _infoController,
                    decoration: const InputDecoration(
                      labelText: 'Tadbir haqida ma\'lumot',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement image picker functionality
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Rasm'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement video picker functionality
                        },
                        icon: const Icon(Icons.videocam),
                        label: Text('Video'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: GoogleMapPage(
                      onLocationSelected: _onLocationSelected,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FestivalsBloc>().add(
                              AddFestivalEvent(
                                  name: _nameController.text,
                                  addedDate: _dateController.text,
                                  addedTime: _timeController.text,
                                  description: _infoController.text,
                                  location: _selectedLocation,
                                  imageUrl:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Mq101BJcTH0_Ca5F-0lbHqjZ9-6bFy6r4Q&s"),
                            );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SuccesAddDialog(name: _nameController.text);
                          },
                        );
                        // Implement form submission functionality
                      },
                      child: const Text('Qo\'shish'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
