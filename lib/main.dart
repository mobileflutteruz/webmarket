import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_shop/presentation/home/home_view.dart';
import 'package:web_shop/presentation/home/web/whome/home_page_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add your Firebase configuration here
  const firebaseConfig = {
    // Replace with your own Firebase config values
    'apiKey': 'AIzaSyC06GdE0jALpQSGBKMdxNeg4zgeOecN1h8',
    'authDomain': 'webmarket-6e86f.firebaseapp.com',
    'projectId': 'webmarket-6e86f',
    'storageBucket': 'webmarket-6e86f.appspot.com',
    'messagingSenderId': '650823189030',
    'appId': '1:650823189030:web:9e5018c21e522ebb3d9ce7',
    // 'measurementId': 'YOUR_MEASUREMENT_ID',
  };
  try {
    // Initialize Firebase based on platform
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyC06GdE0jALpQSGBKMdxNeg4zgeOecN1h8',
          appId: '1:650823189030:web:9e5018c21e522ebb3d9ce7',
          messagingSenderId: '650823189030',
          projectId: 'webmarket-6e86f',
          authDomain: 'webmarket-6e86f.firebaseapp.com',
          databaseURL:
              'https://webmarket-6e86f-default-rtdb.europe-west1.firebasedatabase.app',
          storageBucket: 'webmarket-6e86f.appspot.com',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Web Shop',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // Decide which homepage to show based on platform
            home: HomeScreen()
            // home: kIsWeb ? HomeScreenWeb() : MHomePage(),
            );
      },
    );
  }
}
