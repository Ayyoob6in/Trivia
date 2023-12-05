import 'package:flutter/material.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/screenthreebackground.png',),),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white,Color.fromARGB(255, 28, 206, 64)]),
        ),
        child:  Column(
          children: [
           const SizedBox(height: 200,),
         const Text('Welcome To\n      Trivia',style: TextStyle(
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
              backgroundColor: Color.fromARGB(255, 31, 218, 121),
              child: IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
              }, icon:const Icon(Icons.arrow_forward,color: Colors.white,),),
            ),  
        ]),
      ),
    );
  }
}