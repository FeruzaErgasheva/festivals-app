import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_bloc.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';
import 'package:festivals_exam_4/services/festivals/festivals_http_services.dart';
import 'package:festivals_exam_4/ui/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBottomSheet extends StatefulWidget {
  FestivalModel festival;
  RegistrationBottomSheet({super.key, required this.festival});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationBottomSheetState createState() =>
      _RegistrationBottomSheetState();
}

class _RegistrationBottomSheetState extends State<RegistrationBottomSheet> {
  int _count = 0;
  String _selectedPaymentMethod = 'Click';

  FestivalsHttpServices festivalsHttpServices = FestivalsHttpServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ro\'yxatdan O\'tish',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Joylar sonini tanlang'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _count > 0 ? () => setState(() => _count--) : null,
              ),
              Text('$_count', style: TextStyle(fontSize: 20)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _count++),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('To\'lov turini tanlang'),
          const SizedBox(height: 8),
          Column(
            children: [
              RadioListTile(
                title: const Text('Click'),
                value: 'Click',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value!),
              ),
              RadioListTile(
                title: Text('Payme'),
                value: 'Payme',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value!),
              ),
              RadioListTile(
                title: Text('Naqd'),
                value: 'Naqd',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value!),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle button press
              // context.read<FestivalsBloc>().add(IncrementFestivalAttendantsEvent(id: widget.festival.id, attendants: widget.festival.attendants, orders: _count));
              context.read<FestivalsBloc>().add(
                  IncrementFestivalAttendantsEvent(
                      id: widget.festival.id,
                      attendants: widget.festival.attendants + _count));
              if (_count > 0) {
                _count = 0;

                showDialog(
                  context: context,
                  builder: (context) {
                    return SuccessDialog(festival: widget.festival);
                  },
                );
              } else {
                _count = 0;
                Navigator.of(context).pop();
              }
              setState(() {});
              // setState(() {});
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Keyingi'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
