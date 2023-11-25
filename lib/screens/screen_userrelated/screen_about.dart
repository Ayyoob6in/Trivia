import 'package:flutter/material.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Center(child: Text("Trivia")),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25,),
        backgroundColor: Colors.blue[100],
          elevation: 1,
      ),
      body: 
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.blue[100],
        child: ListView(children:  [ 
         const Text('''About Trivia: Your Passport to Personalized Adventures

Welcome to Trivia, your ultimate travel planning companion that transforms your wanderlust dreams into seamless, personalized adventures. With Trivia, we redefine the way you plan and experience your journeys, ensuring that each trip becomes a unique chapter in your travel story.

Tailored for You:
At Trivia, we understand that every traveler is unique. Our app is crafted to cater to your individual preferences, offering a tailored experience that aligns with your travel style. Whether you're an adventure seeker, a cultural enthusiast, or a relaxation connoisseur, Trivia adapts to your needs.

Effortless Planning:
Gone are the days of cumbersome trip planning. Trivia's user-friendly interface empowers you to effortlessly create, customize, and refine your itineraries. Plan your days, schedule activities, and ensure a smooth journey from start to finish—all within the palm of your hand.

Discover the Unexplored:
Uncover hidden gems and off-the-beaten-path treasures with Trivia. Our app goes beyond traditional travel guides, providing curated recommendations that introduce you to the authentic heartbeat of each destination. Immerse yourself in local cultures and experiences that define your travel narrative.

Smart Budget Management:
Traveling smart is traveling well. Trivia helps you manage your budget intelligently, allowing you to make the most of your resources without compromising on the quality of your experiences. Plan economically, ensuring that every penny contributes to unforgettable moments.

Real-Time Collaboration:
Embarking on a group adventure? Trivia facilitates real-time collaboration, enabling seamless communication and decision-making among fellow travelers. Share ideas, preferences, and excitement, ensuring that your group creates memories together.

Effortless Bookings:
Booking accommodations, transportation, and activities has never been smoother. Trivia integrates seamlessly with trusted providers, offering you a one-stop-shop for all your travel needs. Enjoy exclusive deals and discounts, making your bookings a stress-free experience.

Safety Assurance:
Your safety is paramount. Trivia keeps you informed with real-time updates on travel advisories, local guidelines, and essential safety information. Feel confident and secure as you traverse new territories.

Capture and Share:
Document your travel journey with Trivia's built-in travel journal. Capture moments, jot down thoughts, and easily share your experiences with friends and family. Your travel story becomes a vivid tapestry of memories that lasts a lifetime.

Trivia Community:
Join a vibrant community of explorers within the Trivia app. Share your travel tales, gain insights from fellow adventurers, and be part of a global network that celebrates the spirit of exploration.

In essence, Trivia is more than an app; it's your passport to a world of personalized adventures. Start your journey with Trivia today, and let every trip be a testament to your unique travel narrative. Adventure awaits—let Trivia be your guide.  '''),
const SizedBox(height: 20,), 
 Center(
   child: InkWell(
    onTap: () {
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
    },
     child: Container(
      height: MediaQuery.of(context).size.height*.04,
      width: MediaQuery.of(context).size.width*.4 ,

      decoration: BoxDecoration(
        border: Border.all(color: Colors.white ),
        borderRadius: BorderRadius.circular(20),
       color: Colors.blue
      ),
      child: const Center(child: Text("Continue With Trivia",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
     ),
   ),
 )
        ],),

      ),
    );
  }
}