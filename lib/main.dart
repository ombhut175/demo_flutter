import 'package:demo_flutter/auth/sign_up.dart';
import 'package:demo_flutter/firebase_options.dart';
import 'package:demo_flutter/pages/home.dart';
import 'package:demo_flutter/utils/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL); // Remove this line

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black.withAlpha(153) // 0.6 * 255 ≈ 153
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withAlpha(128) // 0.5 * 255 ≈ 128
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorSize = 70.0
    ..radius = 15.0
    ..textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Arial',
      letterSpacing: 1.2,
      color: Colors.white,
    )
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return getCircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const Home();
          }
          return const SignUpPage();
        },
      ),
    );
  }
}

