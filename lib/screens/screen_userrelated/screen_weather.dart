import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/screens/screen_userrelated/wether_api.dart';
import 'package:weather/weather.dart';

class ScreenWeather extends StatefulWidget {
  const ScreenWeather({super.key});

  @override
  State<ScreenWeather> createState() => _ScreenWeatherState();
}

class _ScreenWeatherState extends State<ScreenWeather> {
  final WeatherFactory _wf = WeatherFactory(OPEN_WEATHER_API);
  Weather? _weather;
  TextEditingController searchController=TextEditingController();
  bool showWeather=false; 
  
   
   @override
  void initState() {
    super.initState();
   _getWeatherForCity("kerala");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title:   Text(_weather?.areaName??"",),
      titleTextStyle:const TextStyle(color: Colors.black,fontSize: 20),
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){
        Navigator.of(context).pop();
      },
       icon: const Icon(Icons.arrow_back_ios,color: Colors.black ,)),
     ),
     body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 10),
              child: searchplace(),
            ),
           SizedBox(height: MediaQuery.of(context).size.height*.08,),
           _dateTimeInfo(),
           SizedBox(height: MediaQuery.of(context).size.height*.04,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud,color: Colors.lightBlue,),
              Icon(Icons.sunny,color: Colors.orange,),
            ],
            ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
          currentTemp(),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
          moreInfo(),
          SizedBox(height: 20,),
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("T",style: GoogleFonts.amiri(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 70,
                    )
                    )),
                    Text("rivia",style: GoogleFonts.aleo(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                    )
                    )),
                ],
              )   
      
           
          ],
        ),
      ),
     ),
    );
  }
  Widget _dateTimeInfo() {
  if (_weather != null && _weather!.date != null) {
    DateTime now = _weather!.date!;
    return Column(
      children: [ 
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(color: Colors.black,
          fontSize: 45
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(
          DateFormat("EEEE").format(now),
          style: const TextStyle(color: Colors.black,
          fontSize: 15
          ),
        ),
        const SizedBox(width: 10,),
         Text(
         "${DateFormat("dd.MM.yyy").format(now)} ",
          style: const TextStyle(color: Colors.black,
          fontSize: 15
          ),
        )
        ],),
      ],
      
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget currentTemp(){
  return Text( "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",style:const TextStyle(
    color: Colors.black,
    fontSize: 65,
    fontWeight: FontWeight.bold
  ),);
}

Widget moreInfo(){
  return Container(
   height: MediaQuery.of(context).size.height *0.15,
   width: MediaQuery.of(context).size.width *0.80,
   decoration: BoxDecoration(
    color: Colors.black,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
    boxShadow:const [
      BoxShadow(
        color: Colors.black,
        blurRadius: 10,
      )
    ]
   ),
   padding:const EdgeInsets.all(8.0),
   child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
   Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",style:
    const TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w400
    ),),
     Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",style:
    const TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w400
    ),)
   ],),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",style:
    const TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w400
    ),),
     Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",style:
    const TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w400
    ),),
   ],),  
   ]),
 
  );
}
Widget searchplace(){
  return TextFormField(
    controller: SearchController(),
    onChanged: (value) {
      _getWeatherForCity(value);
    },
    style:const TextStyle(color: Colors.black),
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide:const BorderSide(color: Colors.black)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide:const BorderSide(color: Colors.black)
    ),
    suffixIcon: IconButton(onPressed: (){
      _getWeatherForCity(searchController.text);
    }, icon: const Icon(Icons.search,color: Colors.black,)),
    label: const Text("Search Place",style: TextStyle(color: Colors.black),),
    labelStyle: TextStyle(color: Colors.black),
  ),
  cursorColor: Colors.black,
  );
}
 Future<void> _getWeatherForCity(String cityName) async {
    final weather = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      _weather = weather;
      showWeather=true;
    });
  }

}