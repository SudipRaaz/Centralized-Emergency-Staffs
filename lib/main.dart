import 'package:ambulance_staff/model/department_manager.dart';
import 'package:ambulance_staff/utilities/routes/route_path.dart';
import 'package:ambulance_staff/utilities/routes/routes.dart';
import 'package:ambulance_staff/view/dashboard_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/tab_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabManager()),
        Provider(create: (context) => DepartmentManager()),
        Provider(create: (_) => DashboardPage()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initial routing to splash screen
        initialRoute: RoutesName.splashScreen,
        // path to generating routes
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
