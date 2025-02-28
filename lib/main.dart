import 'package:african_interview/presentation/bloc/country_bloc.dart';
import 'package:african_interview/presentation/pages/country/countries_page.dart';
import 'package:african_interview/presentation/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ioc.dart' as di;


void main() {
  // Initialize dependency injection
  di.init();
  
  runApp(const AfricanCountriesApp());
}

class AfricanCountriesApp extends StatelessWidget {
  const AfricanCountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => di.sl<CountriesBloc>(),
       child: MaterialApp(
          title: 'African Countries',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:SplashScreen(),
        )
    );
  }
}