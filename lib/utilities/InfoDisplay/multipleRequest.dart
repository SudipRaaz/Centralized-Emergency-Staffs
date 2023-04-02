import 'package:flutter/material.dart';

import '../../resource/constants/sized_box.dart';
import '../../resource/constants/style.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool checkAmbulance = false;

  bool checkFireBrigade = false;

  TextEditingController requestService = TextEditingController();

  bool checkPolice = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Multiple Service'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                Checkbox(
                    value: checkAmbulance,
                    onChanged: ((value) {
                      checkAmbulance = !checkAmbulance;
                    })),
                const Text('Ambulance'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: checkFireBrigade,
                    onChanged: ((value) {
                      checkAmbulance = !checkAmbulance;
                    })),
                const Text('Fire Brigade'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: checkPolice,
                    onChanged: ((value) {
                      checkAmbulance = !checkAmbulance;
                    })),
                const Text('Police'),
              ],
            ),
            addVerticalSpace(15),
            const Text('Additional Message (Optional)'),
            addVerticalSpace(15),
            TextField(
              controller: requestService,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: MyStyle().elevatedButtonSecondary,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                // onPress;
              },
            ),
            addHorizontalSpace(10),
            ElevatedButton(
              style: MyStyle().elevatedButtonPrimary,
              child: const Text('Confirm Request'),
              onPressed: () {
                Navigator.of(context).pop();
                // onPress;
              },
            ),
          ],
        ),
      ],
    );
  }
}
