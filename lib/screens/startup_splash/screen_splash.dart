import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';
import 'package:travel_app/screens/startup_splash/screen_one.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/moon.png')),
         color: Colors.black
        ),
      ),
    );
  }
  gotoScreenOne()async{
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const ScreenOne()));
    
  }
  checkUserLoggedIn()async{
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(saveKey);
    if(userLoggedIn==null || userLoggedIn==false){
     gotoScreenOne();
    }else{
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const HomeScreen()));
    }
  }
}

 