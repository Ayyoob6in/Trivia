import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/screens/screen_adminrelated/screen_add_package.dart';
import 'package:travel_app/screens/screen_userrelated/screen_package_related.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';
import 'package:travel_app/screens/models/allmodels.dart';

class ScreenAdmin extends StatefulWidget {
  const ScreenAdmin({super.key});

  @override
  State<ScreenAdmin> createState() => _ScreenAdminState();
}

class _ScreenAdminState extends State<ScreenAdmin> {
  int selectedChipIndex = 0;
late List<bool> isIconChangedList;
List<bool> isSelected = List.generate(6, (index) => false);

final List<String> chipLabels = [
    "Hill station",
    "Mountains",
    "WaterFalls",
    "Beaches",
    "Deserts",
    "Monuments",
  ];

final List<List<String>> imageUrl = [
   
   [
    "https://images.pexels.com/photos/14278173/pexels-photo-14278173.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/11024977/pexels-photo-11024977.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/16060830/pexels-photo-16060830/free-photo-of-mountains-with-lake.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/17054028/pexels-photo-17054028/free-photo-of-hillside-houses-in-shimla.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/2961109/pexels-photo-2961109.jpeg",
    "https://images.unsplash.com/photo-1614056965546-42fbe24eb36c?q=80&w=3029&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.pexels.com/photos/15896015/pexels-photo-15896015/free-photo-of-laxmanjhula-ramjhula-rishikesh-uttarakhand.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.unsplash.com/photo-1609276804051-8c5e906cc430?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.pexels.com/photos/13691355/pexels-photo-13691355.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.unsplash.com/photo-1599922760936-e840fa373d8d?q=80&w=2778&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   ],
   [
    "https://c0.wallpaperflare.com/path/30/524/33/himalayas-himachal-india-mountains-a72782844fb682c145489069a5ca6c7b.jpg",
    "https://static2.tripoto.com/media/filter/nxl/img/88796/TripDocument/1574314663_dsc00224.jpg",
    "https://www.himalayanhikers.in/wp-content/uploads/2019/11/Chandrakhani-pass-trek.jpg",
    "https://media2.thrillophilia.com/images/photos/000/035/746/original/chokra11.jpg?width=975&height=600",
    "https://www.lehladakhindia.com/blog/wp-content/uploads/2014/04/markha-valley.jpeg",
    "https://ghumakkadd.com/wp-content/uploads/2017/09/Rupin-pass.jpg",
    "https://www.tourmyindia.com/treks/wp-content/uploads/2020/08/dzongri-trek.jpg",
    "https://treksnrapids.com/wp-content/uploads/2017/07/rp5.jpg"

    ],

   [
    "https://casualwalker.com/wp-content/uploads/2019/10/Palaruvi_Waterfalls_Kollam_Kerala_15.jpg",
    "https://www.tirunelveli.today/wp-content/uploads/2016/07/Kutralam-falls.png",
    "https://3.bp.blogspot.com/-4h___8welzk/UJATpqdiFjI/AAAAAAAADcw/-3Yl2JlNCMo/s400/276.JPG",
    "https://adventurebuddha.com/wp-content/uploads/2020/05/Magod-Falls.jpg",
    "https://gumlet.assettype.com/outlooktraveller%2Fimport%2Foutlooktraveller%2Fpublic%2Fuploads%2Farticles%2Fexplore%2FKerala_Athirapally_Waterfall.jpg?auto=format%2Ccompress&fit=max&format=webp&w=768&dpr=2.0",
    "https://files.yappe.in/place/full/dudhsagar-waterfall-6643544.webp",
    "https://adventurebuddha.com/wp-content/uploads/2020/05/jog-falls-tour-with-Adventure-Buddha-1280x720.jpg",
    "https://2.bp.blogspot.com/-iCKtyIjOS8s/UN5McsFyZrI/AAAAAAAAAxI/ecLihA3j9xE/s1600/unchallifallsfirstviewpoint.JPG"
   ],
   [
   "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/3e/36/95/baga-sea-beach.jpg?w=500&h=400&s=1",
   "https://www.keralatourism.org/images/destination/mobile/kovalam20131031105847_236_1.jpg",
   "https://www.adotrip.com/public/images/blogs/master_images/5c73c3f66464b-Varkala_Beach_1.jpg",
   "https://i.ytimg.com/vi/1lzoEZ4QR7k/maxresdefault.jpg",
   "https://www.tripsavvy.com/thmb/6RMDP2pyso0vDepNL74Z0yKWlEU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-580758119-a4b344ced3f14d87941823a5b65e0f8c.jpg"
    ],

   [
    "https://assets.traveltriangle.com/blog/wp-content/uploads/2016/09/Untitled-design1.jpg",
    "https://www.travelerarchives.com/wp-content/uploads/2021/02/IMG_20200125_173231-1-scaled.jpg",
    "https://m.economictimes.com/thumb/msid-56335508,width-1200,height-900,resizemode-4,imgsize-44301/soak-in-the-heritage-culture-of-the-desert-in-bikaner.jpg",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/89/dd/17/desert-safari-planner.jpg?w=700&h=-1&s=1"
   ],
   [
    "https://images.pexels.com/photos/3881104/pexels-photo-3881104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://indiano.travel/wp-content/uploads/2022/08/Gateway-of-india.png",
    "https://images.pexels.com/photos/13471509/pexels-photo-13471509.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/15694515/pexels-photo-15694515/free-photo-of-illuminated-castle-facade-at-night.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/6060943/pexels-photo-6060943.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/2563598/pexels-photo-2563598.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"

   ],
    
  ];
  List<List<String>>imagepackagDetails=[
    ["Manali","Gulmarg","Nainital","Shimla","Kasol","Srinagar","Musoorie","Shillong","Munnar","Coorg"],//=====> Hill station
    ["HamtaPass","Beas Khund","ChandraKhani","Chokramudi","Markha Valley","Rupin Pass","Dzongri","RoopKund"],//======> Mountains
    ["Palaruvi ","Kutralam ","Sathodi ","Magoda ","Athirappilly ","Dudhsagar","Jog ","Unchalli "],//=====> Water falls
    ["Goa","Kovalam","Varkala","Kochi","Mumbai",],//=====>beaches
    ["Jaiselmer","Kutch","Bikaner","Barmer"],//=====>Desert
     ["Taj Mahal","Gateway Of India","Agra Fort","Hawa Mahal","Amber fort","ellora Caves"],//=======>Monuments
     
  ];
  List<List<String>>packageInformation=[
    [
      "Manali, nestled in the Indian state of Himachal Pradesh, is a picturesque hill station situated in the northern part of the Kullu Valley. Surrounded by snow-capped peaks, lush pine forests, and the Beas River, it offers breathtaking landscapes. Renowned for adventure sports, temples, and vibrant markets, Manali is a captivating destination.",
      "Gulmarg, nestled in the Pir Panjal range of the Himalayas, is a scenic hill station in Jammu and Kashmir, India. Renowned for its pristine landscapes and world-class ski resorts, Gulmarg attracts visitors with its snow-capped peaks, lush meadows, and the iconic Gulmarg Gondola. It's a haven for nature enthusiasts and adventure seekers.",
      "Nainital, a charming hill station in Uttarakhand, India, is nestled around the pear-shaped Naini Lake. Surrounded by the Kumaon Hills, it offers breathtaking views and a pleasant climate. Famous for its boat rides and vibrant markets, Nainital is a picturesque destination, drawing visitors with its natural beauty and serene atmosphere.",
      "Shimla, nestled in the Indian state of Himachal Pradesh, is a charming hill station renowned for its scenic beauty and colonial architecture. Situated in the Himalayas, it serves as the state capital. Tourists are drawn to its pleasant climate, picturesque landscapes, and historical landmarks, making it a popular destination year-round.",
      "Kasol, nestled in the Parvati Valley of Himachal Pradesh, India, is a serene hill station known for its breathtaking landscapes and vibrant culture. Situated along the banks of the Parvati River, it offers a perfect blend of natural beauty and tranquility, attracting travelers with its scenic views, trekking opportunities, and vibrant hippie vibes.",
      "Srinagar, a captivating hill station nestled in the heart of the Kashmir Valley, is located in the northern part of India. Surrounded by the Himalayan ranges, it boasts serene Dal Lake and Nishat Bagh. Renowned for its picturesque landscapes and houseboats, Srinagar offers a tranquil escape with vibrant markets and Mughal gardens.",
      "Mussoorie, a picturesque hill station in the Indian state of Uttarakhand, is nestled in the Garhwal Himalayas. Known as the Queen of Hills, it offers panoramic views of the Himalayan range. Popular for its pleasant climate and colonial architecture, Mussoorie is a cherished destination for nature lovers and adventure enthusiasts.",
      "Shillong, the capital of Meghalaya in northeastern India, is nestled amidst lush hills at an elevation of 1,496 meters. Renowned for its pleasant climate and scenic beauty, Shillong offers captivating landscapes, cascading waterfalls, and vibrant markets. Known as the Scotland of the East, it attracts visitors with its rich cultural heritage and welcoming locals.",
      "Munnar, nestled in the Western Ghats of Kerala, India, is a breathtaking hill station renowned for its lush tea plantations, mist-covered mountains, and diverse flora. Located at an elevation of 1,600 meters, Munnar offers a serene escape with its pleasant climate and captivating landscapes, making it a popular tourist destination.",
      "Coorg, a picturesque hill station nestled in the Western Ghats of Karnataka, India, captivates with its lush coffee plantations, mist-covered mountains, and cascading waterfalls. Renowned for its scenic beauty, Coorg offers a tranquil escape. Visitors can explore Abbey Falls, Dubare Elephant Camp, and the rich local culture, making it a nature lover's paradise.",

    ],
     [
      "Hamtapass is a scenic mountain pass situated in the Pir Panjal range of the Himalayas, connecting Kullu Valley and Lahaul Valley in Himachal Pradesh, India. Renowned for its breathtaking landscapes and diverse flora, the pass stands at an elevation of 4,270 meters, offering trekkers a challenging yet rewarding alpine experience.",
      "Beshkund, nestled in the breathtaking Himalayan range, is a serene mountain located in the Kullu district of Himachal Pradesh, India. Renowned for its pristine beauty, Beshkund offers mesmerizing panoramic views and lush alpine meadows. This tranquil destination attracts nature enthusiasts seeking solace amidst the grandeur of the Himalayas.",
      "Chandrakhani Pass, nestled in the Indian state of Himachal Pradesh, boasts breathtaking landscapes at an altitude of around 3,660 meters. Renowned for its scenic trekking trails, it offers mesmerizing views of the Pir Panjal and Parvati mountain ranges. This Himalayan gem is a haven for adventure seekers and nature enthusiasts.",
      "Chokramudi, a majestic mountain, is nestled in the Western Ghats of Kerala, India. Towering at an elevation of 7,200 feet, it offers breathtaking views of the Idukki Reservoir. This pristine location, embraced by lush greenery, attracts adventure enthusiasts and nature lovers, providing a serene escape in God's Own Country.",
      "Markha Valley is a Himalayan region nestled in Ladakh, India, renowned for its breathtaking landscapes and cultural richness. Embraced by the Zanskar Range and Stok Kangri peaks, the valley offers panoramic views. Trekkers traverse vibrant Buddhist villages, lush meadows, and traverse the scenic Markha River, immersing in Ladakh's unparalleled beauty.",
      "The Rupin Pass is a high-altitude mountain pass in the Indian Himalayas, situated in the state of Himachal Pradesh. It is renowned for its breathtaking landscapes, encompassing snow-capped peaks, alpine meadows, and dense forests. Trekkers navigate challenging terrains, crossing the pass at an elevation of about 15,250 feet, to witness awe-inspiring vistas.",
      "Dzongri is a breathtaking mountain located in the Himalayas, nestled within the Kanchenjunga National Park in Sikkim, India. Renowned for its panoramic views, Dzongri offers trekkers an awe-inspiring vista of snow-capped peaks, lush valleys, and pristine lakes. Situated at an elevation of about 4,000 meters, this alpine haven is a paradise for adventure seekers.",
      "Roopkund is a high-altitude glacial lake nestled in the Chamoli district of Uttarakhand, India. Positioned at an elevation of 16,499 feet (5,029 meters) in the Himalayas, it is renowned for its mysterious skeletal remains, dating back to the 9th century. The trek to Roopkund offers breathtaking vistas of snow-clad peaks and lush alpine meadows.",
    ],
     [
     "Palaruvi, a breathtaking waterfall, is nestled in the Southern Western Ghats near Aryankavu in Kollam district, Kerala, India. Cascading from an elevation of around 300 feet, the milky waters of Palaruvi create a mesmerizing spectacle amid lush greenery, offering a serene retreat for nature enthusiasts and adventure seekers alike.",
     "Kutralam, also known as Courtallam, is a picturesque town in Tamil Nadu, India, renowned for its spectacular waterfalls. Nestled in the Western Ghats, it boasts numerous cascades such as Main Falls, Five Falls, and Old Courtallam Falls. A popular pilgrimage and tourist destination, Kutralam's lush greenery and therapeutic waters attract visitors seeking natural rejuvenation.",
     "Sathodi Waterfall, nestled in the Western Ghats near Yellapur, Karnataka, India, captivates with its pristine beauty. Surrounded by lush greenery, the falls cascade into a serene pool, offering a tranquil escape. Accessible through a scenic trek, Sathodi Waterfall is a nature lover's paradise in the heart of Karnataka.",
     "Magoda Waterfall, nestled in the heart of nature, is a captivating cascade located in Magoda, Tanzania. Surrounded by lush greenery, this scenic wonder offers a tranquil escape. Visitors can revel in the mesmerizing beauty of the falls and embrace the serenity of this hidden gem in the East African landscape.",
     "Athirapally Waterfall, situated in Kerala, India, is a breathtaking natural wonder renowned for its scenic beauty. Cascading from the Chalakudy River, it is surrounded by lush greenery and diverse flora. This captivating waterfall stands tall as a prominent tourist attraction, offering a serene escape into nature's embrace.",
     "Dudhsagar Waterfall, situated in the Western Ghats of Goa, India, is a breathtaking natural spectacle. Cascading from a height of 310 meters, it is renowned for its milky white waters, resembling a sea of milk. Nestled amidst lush greenery, Dudhsagar captivates with its pristine beauty and tranquil surroundings.",
     "Jog Falls, situated in Karnataka, India, is a majestic waterfall renowned for its natural beauty. Cascading from the Sharavathi River, it plunges from a height of 830 feet, making it the second-highest waterfall in the country. Surrounded by lush greenery, Jog Falls is a breathtaking and serene natural wonder.",
     "Unchalli Falls, nestled in the pristine Western Ghats of Karnataka, India, is a captivating natural wonder. Cascading gracefully from a height of about 116 meters, this breathtaking waterfall is situated near Siddapura in the Uttara Kannada district. Surrounded by lush greenery, Unchalli Falls offers a serene and picturesque escape into nature.",
    ],
     [
      "Goa, a coastal paradise in western India, is renowned for its sun-kissed beaches, vibrant nightlife, and Portuguese-influenced architecture. Nestled along the Arabian Sea, its popular beaches like Baga and Calangute attract visitors seeking relaxation and water sports. Goa's unique blend of cultural heritage and scenic beauty makes it a sought-after destination.",
      "Kovalam, nestled along the southwestern coast of India in Kerala, is renowned for its pristine beaches and lush landscapes. Famous for its crescent-shaped sandy shores and crystal-clear waters, Kovalam attracts global travelers seeking relaxation and water adventures. The vibrant local culture and delectable seafood further enrich the coastal charm of this tranquil haven.",
      "Varkala, situated along the southwestern coast of India in the state of Kerala, is renowned for its stunning cliff-lined beach. Nestled atop these cliffs are vibrant shops and eateries, offering breathtaking views of the Arabian Sea. The beach is not just a scenic delight but also a spiritual hub with the ancient Janardana Swamy Temple nearby.",
      "Kochi, a vibrant coastal city in Kerala, India, is known for its picturesque beaches. Fort Kochi Beach, nestled along the Arabian Sea, captivates visitors with its historic Chinese fishing nets and colonial architecture. The tranquil shores offer a blend of cultural charm and natural beauty, making Kochi a must-visit destination.",
      "Mumbai, India's bustling metropolis, boasts a captivating beach along the Arabian Sea. Known as Marine Drive, this iconic waterfront stretches along South Mumbai, offering breathtaking views of the skyline. Popular for evening strolls, it's a haven for locals and tourists seeking tranquility amidst the city's vibrant energy."
    ],
    [
     "Jaiselmar, a delightful dessert, is a culinary masterpiece located in the heart of Jaisalmer, India. Nestled amid the vibrant streets, this sweet treat captivates with its rich flavors and traditional craftsmanship. Indulge in the essence of Jaiselmar, savoring every bite as you explore the enchanting cultural tapestry of this desert city.",
     "Kutch is a vast desert district situated in the north-western part of India, primarily in the state of Gujarat. Known for its mesmerizing white salt flats, the Great Rann of Kutch, it offers a unique and surreal landscape. This arid region, bordering Pakistan, attracts visitors with its cultural festivals, traditional crafts, and the ethereal beauty of the salt marshes.",
     "Bikaner, a vibrant city in the northwestern Indian state of Rajasthan, is renowned for its delectable desserts, particularly the iconic Bikaneri Bhujia—a spicy, crispy snack. Nestled in the Thar Desert, Bikaner captivates with its historic architecture, including the Junagarh Fort. This culinary and cultural gem beckons with flavors and tales of the desert.",
     "Barmer, a city in Rajasthan, India, is renowned for its captivating desert landscapes. Nestled in the Thar Desert, it offers a unique experience with its vast sand dunes and traditional Rajasthani culture. Barmer's ancient architecture and vibrant markets make it a must-visit destination, providing a glimpse into Rajasthan's rich heritage.",
    ],
    [
      "The Taj Mahal, an iconic marble mausoleum, stands in Agra, India, on the south bank of the Yamuna River. Built by Emperor Shah Jahan in memory of his wife Mumtaz Mahal, it is a UNESCO World Heritage Site. Known for its breathtaking beauty and intricate architecture, the Taj Mahal attracts millions of visitors annually.",
      "The Gateway of India is an iconic monument situated in Mumbai, India, overlooking the Arabian Sea. Built in 1924, it serves as a prominent landmark and historical symbol. This architectural marvel combines Indo-Saracenic and Islamic styles, attracting millions of visitors annually to witness its grandeur and enjoy the bustling surroundings of Mumbai Harbor.",
      "Agra Fort, a UNESCO World Heritage site in Agra, India, is an iconic Mughal fortress. Situated near the Taj Mahal, it stands as a testament to India's rich history. This imposing red sandstone structure, built in the 16th century, served as the main residence of the emperors of the Mughal Dynasty.",
      "Hawa Mahal, located in Jaipur, India, is a renowned historical monument. Constructed of pink sandstone, this iconic palace is part of the City Palace complex. Built in 1799 by Maharaja Sawai Pratap Singh, it features intricate latticework and 953 windows, allowing royal women to observe street festivities while remaining unseen. A masterpiece of Rajput architecture.",
      "Amber Fort, a majestic fortress, graces the Aravalli Range near Jaipur, India. Renowned for its Rajput-Mughal architecture, the fort overlooks Maota Lake, creating a picturesque setting. Constructed in the 16th century, it stands as a testament to India's rich history, blending artistic brilliance and strategic brilliance in a captivating manner.",
      "Ellora Caves, a UNESCO World Heritage Site, is located near Aurangabad, India. This ancient monument comprises a stunning complex of rock-cut caves representing Hindu, Jain, and Buddhist traditions. Carved between the 6th and 10th centuries, the Ellora Caves showcase intricate sculptures and architecture, making it a cultural and historical treasure."
    ],
  ];
  List<List<String>>packageprice=[
    ["1,000","2,000","3,000","4,000","5,000","6,000","3,000","4,000","5,000","6,000"],
    ["1,000","2,000","3,000","4,000","5,000","600","700","800"],
    ["1,000","2,000","3,000","4,000","5,000","600","700","800"],
    ["1,000","2,000","3,000","4,000","5,000"],
    ["1,000","2,000","3,000","4,000",],
    ["1,000","2,000","3,000","4,000","5,000","6,000"],
  ];


  @override
  void initState() {
    super.initState();
    setState(() {
      selectedChipIndex = 0;
      isSelected = List.generate(chipLabels.length, (i) => i == 0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 22, right: 20),
            child: Text(
              'Trivia',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color.fromARGB(141, 106, 198, 240)])),
          child: ListView(
            children: [
              drawerSection(
                icon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, size: 20, color: Colors.white),
                ),
                bgcolor: Colors.lightBlueAccent,
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
                text: const Text('Add Packages'),
                bgcolor: Colors.green,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddPackages()));
                },
              ),
              drawerSection(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, size: 20, color: Colors.white),
                ),
                text: const Text('Logout'),
                bgcolor: Colors.grey,
                ontap: () {
                   _showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15 , right: 15),
        child: Column(
              
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Live your life', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            const Row(
              children: [
                Text('By a ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                Text('compass ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.blue)),
                Text('not a clock', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15 )),
                suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 28)),
                hintText: 'search here',
              ),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height*.08,
               child: ListView(
                scrollDirection: Axis.horizontal,
                 children: List<Widget>.generate(
                   chipLabels.length, (index) =>  Padding(
                     padding:const EdgeInsets.only(left: 5,top: 5),
                     child: ActionChip(
                       label:Text(chipLabels[index],style: TextStyle(color: isSelected[index]?Colors.white : Colors.black,),
                       ),
                       backgroundColor: isSelected[index]?Colors.purple[300]: Colors.blue[200],
                     onPressed: () {
                      
                      setState(() {
                        if(index==0){
                        isSelected=List.generate(chipLabels.length, (i) => i==0) ;
                        selectedChipIndex=0;
                      }else{
                        selectedChipIndex=index;
                        isSelected=List.generate(chipLabels.length, (i) => i==index) ;
                      }
                      });
                      
                     },
                     ),
                   ),
                   ),
               ),
             ),
             
              Expanded(
                child: GridView.builder( 
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                    ),
                    itemCount:imageUrl[selectedChipIndex].length ,
                itemBuilder: (context, index) {
                 return Stack(
                 fit: StackFit.passthrough,
                 children: [ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PackageDetails(details: ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]
                          ),
                         currentIndex: index,
                         imagePackageDetails:ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]
                               
                          ), 
                          packageInformation: ImageDetails(
                          imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index]             
                           ) ,
                           packagePrize: ImageDetails(
                            imageUrl[selectedChipIndex][index],
                          imagepackagDetails[selectedChipIndex][index],
                          packageInformation[selectedChipIndex][index],
                          packageprice[selectedChipIndex][index] 
                           ),
                           ),
                           ),
                           );
                    },
                    child: Image.network(imageUrl[selectedChipIndex][index],fit: BoxFit.cover,))
                   ),
                   Positioned(
                     bottom: 10,
                     left: 5 ,
                     child:Text(imagepackagDetails[selectedChipIndex][index],
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w200 
                     ),)
                     ),
                   ]
                 );
                },
                ),
                
              ),
             const SizedBox(height: 10,) 
              
          ], 
        ),
      ),
    );
  }

  Future<void> _logout() async {
    Navigator.of(context as BuildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
  }

  Future<void>_showAlertDialog(BuildContext context)async{
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black45,
        title:const Text("Are you sure ?",style: TextStyle(
          fontWeight: FontWeight.w500,color: Colors.white
        ),),
       actions: [
        TextButton(onPressed: (){
         Navigator.of(context).pop();
        }, child:const Text("No")),
        TextButton(onPressed: ()async{
         final sharedprefs = await SharedPreferences.getInstance();
         await sharedprefs.clear();
         _logout();
        }, child:const Text("Yes",style: TextStyle(
          color: Colors.red
        ),))
       ],
      );
    });
  }

  Widget drawerSection({
    required IconButton icon,
    Text? text,
    required Color bgcolor,
    void Function()? ontap,
  }) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(
        backgroundColor: bgcolor,
        radius: 18,
        child: icon,
      ),
      title: text,
    );
  } 
}
  
 
