import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/screens/startup_splash/screen_splash.dart';

const saveKey='UserLoggedIn';
const adminKey="adminLoggedIn";

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
        
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.montserrat().fontFamily
          ),
          home:const ScreenSplash(),
       );
  }
}

