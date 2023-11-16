
import 'package:flutter/material.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';
import 'package:travel_app/screens/startup_splash/screen_two.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/screenOnebackground.png')),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange,Colors.yellow]),
        ),
        child:  Column(
          children: [
           const SizedBox(height: 200,),
         const Text(' Explorer\nthe world',style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          ),
         const SizedBox(height: 30,),
        const  Text("Let's start here !",style: TextStyle(
            fontWeight: FontWeight.bold,
            ),
            ),
           const SizedBox(height: 30,),
            CircleAvatar(
              radius: 30 ,
              backgroundColor: Colors.deepOrange,
              child: IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenTwo()));
              }, icon:const Icon(Icons.arrow_forward,color: Colors.white,),),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 30 ,
              width: 55 ,
              decoration: BoxDecoration(
                border: Border.all(color:Colors.white),
                borderRadius: BorderRadius.circular(15),
               color: Colors.transparent
                
              ),
              child: TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
              }, 
              child:const Text('Skip',style: 
              TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold),
                ),
                ),
                ),          
        ]),
      ),
    );
  }
 
}

