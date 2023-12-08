import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPrivacy extends StatelessWidget {
  const ScreenPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Center(child: Text("PRIVACY POLICY")),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black, fontSize: 20,fontWeight: FontWeight.w300
          ),
        backgroundColor: Colors.white,
          elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10 ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(children:  [
       const  Text(''' Welcome to Trivia ! We are committed to protecting your privacy and ensuring a secure experience while using our travel planning application. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information. By accessing or using our app, you agree to the terms outlined in this policy.

1. Information We Collect:

1.1. Personal Information:
We may collect personally identifiable information, such as your name, email address, and location data, when you voluntarily provide it during account creation, trip planning, or other interactions within the app.

1.2. Non-Personal Information:
We also gather non-personal information, such as device information, app usage statistics, and other technical data, to enhance user experience and app functionality.

2. How We Use Your Information:

2.1. Personal Information:
Your personal information may be used to create and manage your account, personalize your app experience, communicate important updates, and facilitate travel planning activities.

2.2. Non-Personal Information:
Non-personal information is utilized for analyzing app usage patterns, improving features, troubleshooting technical issues, and enhancing overall app performance.

3. Information Sharing:

3.1. Third-Party Service Providers:
We may share your information with trusted third-party service providers to assist us in delivering our services, such as hosting, analytics, and customer support.

3.2. Legal Compliance:
We may disclose your information if required by law, legal processes, or to protect our rights, privacy, safety, or property, as well as those of our users and the public.

3.3. Business Transfers:
In the event of a merger, acquisition, or sale of all or a portion of our assets, user information may be part of the transferred assets.

4. Cookies and Similar Technologies:
We may use cookies and similar technologies to enhance user experience, personalize content, and analyze usage patterns. You can manage your cookie preferences through your device settings.

5. Security:
We implement security measures to protect your information from unauthorized access, disclosure, alteration, and destruction. However, no data transmission or storage system is completely secure, and we cannot guarantee absolute security.

6. User Control:

6.1. Account Settings:
You have the right to review, update, or delete your account information through the app settings.

6.2. Communication Preferences:
You can manage your communication preferences by adjusting notification settings.

7. Children's Privacy:
Our app is not intended for users under the age of 13. We do not knowingly collect or solicit personal information from children. If we learn that we have collected personal information from a child under 13, we will promptly delete it.

8. Changes to the Privacy Policy:
We may update this Privacy Policy periodically to reflect changes in our practices. You will be notified of significant changes, and your continued use of the app constitutes acceptance of the updated policy.

9. Contact Us:
If you have any questions, concerns, or requests regarding your privacy or this Privacy Policy, please contact us at ayyoobmirorr7@gmail.com.

Conclusion:
Thank you for trusting Trivia. This Privacy Policy aims to ensure transparency and protect your privacy throughout your use of our travel planning application. We appreciate your support and value your feedback as we continuously strive to improve our services.''',style: TextStyle(
  color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16
),),
const SizedBox(height: 20,), 

Center(
  child:   InkWell(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Container(
      height: MediaQuery.of(context).size.height*0.04 ,
      width:MediaQuery.of(context).size.width*.3,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, strokeAlign: 1,style:BorderStyle.none  ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow:const [BoxShadow(
          color: Colors.black,
          blurRadius: 2,
          blurStyle: BlurStyle.solid
        )]
      ), child:  Center(child: Text("THANK YOU",style: GoogleFonts.sahitya(
        color: const Color.fromARGB(203, 0, 0, 0),fontWeight: FontWeight.w300,
      ),)),
    ),
  ),
),
const SizedBox(height: 10,)


        ]),
      ),
    );
  }
}