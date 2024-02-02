import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'chatambulance.dart';

void main() {
  runApp(MaterialApp(
    home: AmbulanceScreen(),
  ));
}

class AmbulanceScreen extends StatefulWidget {
  final XFile? initialPicture;

  AmbulanceScreen({Key? key, this.initialPicture}) : super(key: key);

  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  bool isCalling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.local_hospital,
              size: 120,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Ambulance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lumanosimo',
              ),
            ),
            SizedBox(height: 20),
            if (!isCalling)
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Call Now',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            if (isCalling)
              ElevatedButton(
                onPressed: () {
                  _showCancelCallDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Cancel Call',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToChatScreen(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Call'),
          content: Text('Are you sure you want to make this call?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
            TextButton(
              child: Text('Call'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
                _makePhoneCall(
                    "tel:999"); // Replace "policePhoneNumber" with the actual police phone number.
                setState(() {
                  isCalling = true; // Set the call state to true.
                });
              },
            ),
          ],
        );
      },
    );
  }

  _showCancelCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Call'),
          content: Text('Do you want to cancel the call?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
                _cancelPhoneCall(); // Implement call cancellation logic.
                setState(() {
                  isCalling = false; // Set the call state to false.
                });
              },
            ),
          ],
        );
      },
    );
  }

  _makePhoneCall(String phoneNumber) {
    // This function simulates making a call to the police.
    print("Simulating a call to $phoneNumber");
  }

  _cancelPhoneCall() {
    // Implement call cancellation logic.
    print("Call has been canceled.");
  }

  void _navigateToChatScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatScreenAmbulans(),
    ));
  }
}
