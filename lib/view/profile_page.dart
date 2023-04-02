import 'package:ambulance_staff/resource/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_staff/Controller/authentication_functions.dart';
import 'package:ambulance_staff/utilities/routes/routes.dart';
import 'package:flutter/material.dart';
import '../resource/constants/colors.dart';
import '../resource/constants/sized_box.dart';
import '../utilities/InfoDisplay/dialogbox.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final userID = Authentication().currentUser!.uid;
    final _userProfile =
        FirebaseFirestore.instance.collection('Users').doc(userID).get();
    List userDocs;
    return FutureBuilder(
        future: _userProfile,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: " + snapshot.hasError.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("Error: " + snapshot.error.toString());
          }
          //clearing the productsDocs list
          userDocs = [];
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              backgroundColor: AppColors.appBar_theme,
            ),
            body: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _width,
                        // height: _height,
                        decoration: BoxDecoration(
                          color: AppColors.appBar_theme,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${data['Name']}",
                                style: MyTextStyle().profile_page_credentials,
                              ),
                              Text(
                                "Email: ${data['Email']}",
                                style: MyTextStyle().profile_page_credentials,
                              ),
                              Text(
                                "Department: ${data['Category']}",
                                style: MyTextStyle().profile_page_credentials,
                              ),
                              Text(
                                "Phone Number: ${data['PhoneNumber']}",
                                style: MyTextStyle().profile_page_credentials,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addVerticalSpace(60),
                    _featureTiles(
                      text: 'Feedback',
                      onPress: () {
                        return ShowDialog().showFeedbackForm(context, () {});
                      },
                    ),
                    _featureTiles(
                      text: 'User Guide',
                      onPress: () {
                        Navigator.pushNamed(context, RoutesName.userGuide);
                      },
                    ),
                    _featureTiles(
                      text: 'Report Bug',
                      onPress: () {
                        ShowDialog().reportBug(context, () {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _featureTiles extends StatelessWidget {
  String text;
  VoidCallback onPress;
  _featureTiles({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: onPress,
        child: ListTile(
          selectedTileColor: AppColors.appBar_theme,
          tileColor: Colors.blueAccent,
          selected: true,
          title: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
