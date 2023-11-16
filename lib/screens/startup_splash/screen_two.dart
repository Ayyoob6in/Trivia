import 'package:flutter/material.dart';
import 'package:travel_app/screens/startup_splash/screen_three.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/screentwobackground.png',),),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white,Color.fromARGB(255, 9, 83, 117)]),
        ),
        child:  Column(
          children: [
           const SizedBox(height: 200,),
         const Text(' Safe and\n     easy',style: TextStyle(
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
              backgroundColor:const Color.fromARGB(159, 14, 145, 232),
              child: IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenThree()));
              }, icon:const Icon(Icons.arrow_forward,color: Colors.white,),),
            ),  
        ]),
      ),
    );
  }
}