import 'dart:developer';

import 'package:ambulance_staff/Controller/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/cloud_firestore_base.dart';
import 'package:ambulance_staff/resource/constants/sized_box.dart';
import 'package:ambulance_staff/resource/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Controller/authentication_functions.dart';

class ShowDialog {
  void changeMyPassowrd(BuildContext context, Function onPress) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                addVerticalSpace(15),
                const Text(
                    'Please check you registered Mail box for a Password reset Email '),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // // request service dialog box
  // void requestService(BuildContext context, Function onPress, String category,
  //     String name, String phoneNumber, double lat, double lng) async {
  //   TextEditingController requestService = TextEditingController();
  //   bool ambulance = false;
  //   bool fireBrigade = false;
  //   bool police = false;
  //   double latitude = lat;
  //   double longitude = lng;
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // case id
  //       final caseID = int.parse(MinId.getId('10{d}'));
  //       return AlertDialog(
  //         title: Text('$category Service'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               addVerticalSpace(15),
  //               const Text('Additional Message (Optional)'),
  //               addVerticalSpace(15),
  //               TextField(
  //                 controller: requestService,
  //                 decoration:
  //                     const InputDecoration(border: OutlineInputBorder()),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               ElevatedButton(
  //                 style: MyStyle().elevatedButtonSecondary,
  //                 child: const Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   onPress;
  //                 },
  //               ),
  //               addHorizontalSpace(10),
  //               ElevatedButton(
  //                 style: MyStyle().elevatedButtonPrimary,
  //                 child: const Text('Confirm Request'),
  //                 onPressed: () {
  //                   switch (category) {
  //                     case 'Ambulance':
  //                       ambulance = true;
  //                       break;
  //                     case 'Fire Brigade':
  //                       fireBrigade = true;
  //                       break;
  //                     case 'Police':
  //                       police = true;
  //                       break;
  //                   }
  //                   // current time
  //                   DateTime now = DateTime.now();
  //                   // object of abstract class
  //                   MyCloudStoreBase object = MyCloudStore();
  //                   object.requestService(
  //                       caseID,
  //                       Authentication().currentUser!.uid,
  //                       name,
  //                       phoneNumber,
  //                       ambulance,
  //                       fireBrigade,
  //                       police,
  //                       requestService.text.trim(),
  //                       latitude,
  //                       longitude,
  //                       now,
  //                       "Waiting");
  //                   // dispose widget
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // dialog box for requesting multiple services
  // Future<void> requestMultipleService(BuildContext context, String name,
  //     String phoneNumber, double latitude, double longitude) async {
  //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //   TextEditingController requestServiceTextController =
  //       TextEditingController();
  //   bool checkAmbulance = false;
  //   bool checkFireBrigade = false;
  //   bool checkPolice = false;
  //   return await showDialog(
  //       context: context,
  //       builder: (context) {
  //         // case id
  //         final caseID = int.parse(MinId.getId('10{d}'));
  //         // for stateful layout builder
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             title: const Text('Request Multiple Service'),
  //             content: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: checkAmbulance,
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 log('check ambulance : $checkAmbulance');
  //                                 checkAmbulance = !checkAmbulance;
  //                               });
  //                             }),
  //                         const Text('Ambulance'),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: checkFireBrigade,
  //                             onChanged: ((value) {
  //                               setState(() {
  //                                 checkFireBrigade = !checkFireBrigade;
  //                               });
  //                             })),
  //                         const Text('Fire Brigade'),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Checkbox(
  //                             value: checkPolice,
  //                             onChanged: ((value) {
  //                               setState(() {
  //                                 checkPolice = !checkPolice;
  //                               });
  //                             })),
  //                         const Text('Police'),
  //                       ],
  //                     ),
  //                     addVerticalSpace(15),
  //                     TextFormField(
  //                       controller: requestServiceTextController,
  //                       validator: (value) {
  //                         return value!.isNotEmpty ? null : "Invalid Field";
  //                       },
  //                       decoration: const InputDecoration(
  //                           border: OutlineInputBorder(),
  //                           hintText: "Message (Optional)"),
  //                     ),
  //                   ],
  //                 )),
  //             actions: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   ElevatedButton(
  //                     style: MyStyle().elevatedButtonSecondary,
  //                     child: const Text('Cancel'),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                   addHorizontalSpace(10),
  //                   ElevatedButton(
  //                     style: MyStyle().elevatedButtonPrimary,
  //                     child: const Text('Confirm Request'),
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {
  //                         // current time
  //                         DateTime now = DateTime.now();
  //                         // object of abstract class
  //                         MyCloudStoreBase object = MyCloudStore();
  //                         object.requestService(
  //                             caseID,
  //                             Authentication().currentUser!.uid,
  //                             name,
  //                             phoneNumber,
  //                             checkAmbulance,
  //                             checkFireBrigade,
  //                             checkPolice,
  //                             requestServiceTextController.text.trim(),
  //                             latitude,
  //                             longitude,
  //                             now,
  //                             "Waiting");
  //                         // Do something like updating SharedPreferences or User Settings etc.
  //                         Navigator.of(context).pop();
  //                       }
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  // report bug dialog box
  void reportBug(
    BuildContext context,
    Function onPress,
  ) async {
    TextEditingController reportBug = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Report Bug'),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                addVerticalSpace(15),
                const Text('Please Describe your issue'),
                addVerticalSpace(15),
                TextField(
                  controller: reportBug,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: MyStyle().elevatedButtonPrimary,
              child: const Text('Submit'),
              onPressed: () {
                MyCloudStoreBase objectStore = MyCloudStore();
                objectStore.submitFeedback(null, null, reportBug.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // feedback form dialog
  void showFeedbackForm(BuildContext context, Function onPress) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return RatingDialog(
          initialRating: 1.0,
          // your app's name?
          title: const Text(
            'Experience Rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          // encourage your user to leave a high rating?
          message: const Text(
            'Tap a star to set your rating. \n And Leave us a comment.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          // your app's logo?
          image: const FlutterLogo(size: 100),
          submitButtonText: 'Submit',
          commentHint: 'Leave a comment (Optional)',
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) {
            print('rating: ${response.rating}, comment: ${response.comment}');
            MyCloudStoreBase object = MyCloudStore();
            object.submitFeedback(
                response.rating.toInt(), response.comment, null);
            // TODO: add your own logic
            if (response.rating < 3.0) {
              // send their comments to your email or anywhere you wish
              // ask the user to contact you instead of leaving a bad review
            } else {
              // _rateAndReviewApp();
            }
          },
        );
      },
    );
  }
}
