import 'package:flutter/material.dart';

class RegistrationBottomSheet extends StatefulWidget {
  const RegistrationBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationBottomSheetState createState() => _RegistrationBottomSheetState();
}

class _RegistrationBottomSheetState extends State<RegistrationBottomSheet> {
  int _count = 0;
  String _selectedPaymentMethod = 'Click';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             const  Text(
                'Ro\'yxatdan O\'tish',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Joylar sonini tanlang'),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _count > 0 ? () => setState(() => _count--) : null,
              ),
              Text('$_count', style: TextStyle(fontSize: 20)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => setState(() => _count++),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('To\'lov turini tanlang'),
          SizedBox(height: 8),
          Column(
            children: [
              RadioListTile(
                title: Text('Click'),
                value: 'Click',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
              ),
              RadioListTile(
                title: Text('Payme'),
                value: 'Payme',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
              ),
              RadioListTile(
                title: Text('Naqd'),
                value: 'Naqd',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: Text('Keyingi'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}