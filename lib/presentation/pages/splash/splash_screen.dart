// ignore_for_file: use_build_context_synchronously

import 'package:african_interview/presentation/pages/country/countries_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CountriesListPage(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            FlutterLogo(size: 50),
            SizedBox(height: 20),
            Text(
              'African Countries',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
