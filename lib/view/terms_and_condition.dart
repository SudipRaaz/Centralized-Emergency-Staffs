import 'package:ambulance_staff/resource/constants/sized_box.dart';
import 'package:flutter/material.dart';

import '../resource/constants/colors.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
        backgroundColor: AppColors.appBar_theme,
      ),
      body: ListView(
        children: [
          Column(
            // setting column axis
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use of the application
              paragraph(
                  "By accessing and using the App, you agree to be bound by the following terms and conditions:"),
              paragraphHeading("Use of the App"),
              listings(
                  'The App is intended to be used for emergency services such as medical, police, or fire services, and is not to be used for non-emergency purposes.'),
              listings(
                  'The App is available only to individuals who are at least 18 years old and have the legal capacity to enter into binding agreements.'),
              listings(
                  'You agree to use the App only for lawful purposes and in compliance with all applicable laws and regulations.'),
              // account creation
              paragraphHeading('Account Creation'),
              listings(
                  'To use the App, you must create an account and provide accurate and complete information, including your name, phone number, and email address.'),
              listings(
                  'You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.'),
              listings(
                  'You agree to notify us immediately of any unauthorized use of your account or any other breach of security.'),

              // Emergency Requests
              paragraphHeading('Emergency Requests'),
              listings(
                  'By using the App, you acknowledge and agree that any emergency requests made through the App will be forwarded to the appropriate emergency services provider based on your location.'),
              listings(
                  'You agree that the emergency services provider will contact you directly for additional information and assistance as needed.'),
              listings(
                  'You acknowledge and agree that the emergency services provider, and not the App, is solely responsible for the provision of emergency services.'),

              // Limitation of Liability
              paragraphHeading('Limitation of Liability'),
              listings(
                  'The App is provided on an "as is" and "as available" basis, and we make no representations or warranties of any kind, express or implied, regarding the emergency services.'),
              listings(
                  'We are not liable for any loss, damage, or injury arising from the use of the App, including but not limited to any emergency services provided or not provided.'),
              listings(
                  'We are not liable for any loss of data, interruption of service, or any other damages resulting from the use of the App.'),

              // Termination of Service
              paragraphHeading('Termination of Service'),
              listings(
                  'We reserve the right to terminate or suspend your access to the App at any time and for any reason without notice.'),
              listings(
                  'We may also modify, suspend or discontinue the App or any part of it at any time without notice.'),

              // Changes to the Terms and Conditions
              paragraphHeading('Changes to the Terms and Conditions'),
              listings(
                  'We may revise these terms and conditions at any time and without notice.'),
              listings(
                  'Your continued use of the App after any changes to these terms and conditions will constitute your acceptance of the revised terms.'),

              //
              paragraph(
                  'By using the App, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions. If you do not agree to these terms and conditions, you must immediately cease using the App.'),
              addVerticalSpace(100)
            ],
          )
        ],
      ),
    );
  }

  // paragraph heading d
  Widget paragraphHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  // paragraph texts
  Widget paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 8, right: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  // listed items
  Widget listings(String text) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}
