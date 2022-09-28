import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  String countryCode = '91';
  String phoneNumber = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                openEmail(email: 'test@mail.com');
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: const [
                    Icon(Icons.email, size: 24, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Open Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                openSMS(phoneNumber: phoneNumber, countryCode: countryCode);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: const [
                    Icon(Icons.message, size: 24, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Open SMS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                openCallDialer(
                    phoneNumber: phoneNumber, countryCode: countryCode);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: const [
                    Icon(Icons.call, size: 24, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Open Call Dialer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openCallDialer(
      {required String countryCode, required String phoneNumber}) async {
    try {
      final Uri launchUri =
          Uri(scheme: 'tel', path: '$countryCode$phoneNumber');
      debugPrint(
          'canLaunchUrl openCallDialer: ${await canLaunchUrl(launchUri)}');
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint('openCallDialer : ${e.toString()}');
      logger.log('openCallDialer : ${e.toString()}');
    }
  }

  Future<void> openSMS(
      {required String countryCode, required String phoneNumber}) async {
    try {
      final Uri launchUri = Uri(
          scheme: 'sms',
          path: '$countryCode$phoneNumber',
          queryParameters: <String, String>{
            'body': Uri.encodeComponent('Hey There, \n\nGreetings from my app.')
          });
      debugPrint('canLaunchUrl openSMS: ${await canLaunchUrl(launchUri)}');
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint('openSMS : ${e.toString()}');
      logger.log('openSMS : ${e.toString()}');
    }
  }

  Future<void> openEmail({required String email}) async {
    try {
      final Uri launchUri = Uri(scheme: 'mailto', path: email);
      debugPrint('canLaunchUrl openEmail: ${await canLaunchUrl(launchUri)}');
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint('openEmail : ${e.toString()}');
      logger.log('openEmail : ${e.toString()}');
    }
  }
}
