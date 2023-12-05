
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/user.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/screens/screen_userrelated/home_screen.dart';
import 'package:travel_app/screens/screen_adminrelated/screen_admin.dart';
import 'package:travel_app/screens/login_signup/screen_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _username = TextEditingController();
  final _userPassword=TextEditingController();
  final adminid='@admin';
  final adminpass='admin123';
  bool error=false;
  bool isLogin=false;
  bool isAdmin=false;
  bool _isVisible=false;
  final db=DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
 login() async {
  final response = await db.login(Users(usrName: _username.text, usrPassword: _userPassword.text));
  if (response == true) {
     final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(saveKey, true);
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }else if(_username.text==adminid&&_userPassword.text==adminpass){
    final sharedprefS=await SharedPreferences.getInstance();
    await sharedprefS.setBool(adminKey, true);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ScreenAdmin()));
  }
  else {
    setState(() {
      isLogin = true;
    });
  }

}
  
   

 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:const BoxDecoration(
           gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white,Colors.blue])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 20),
                height: 215,
                width: 325,
                child: Image.asset('assets/loginscreen logo.png',fit: BoxFit.cover,),),
              const Text('Welcome !',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),
            const Text('Sign in',style: TextStyle(color: Colors.blue,fontSize: 70 ,fontWeight: FontWeight.bold),),
            const SizedBox(height: 25,),
            //Text field sesction--------------
            Container(
              padding:const EdgeInsets.only(left: 30,right: 30),
              child:  Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _username,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style:const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        label:const Text('User name',style: TextStyle(color: Colors.blue),),
                        focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon:const Icon(Icons.person,),
                        prefixIconColor: Colors.blue,
                        errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),),
                          focusedErrorBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),)
                      ),
                      onSaved: (value) {
                        _username.text=value?.trim() ?? '';
                      },
                      onChanged: (value) {
                        setState(() {
                          if(error||isLogin){
                            error=false;
                            isLogin=false;
                          }
                        });
                      },
                      validator:(value) {
                        if( value==null ||value.isEmpty){
                          
                          return 'please enter user name';
                        }
                        
                        return null;
                      },
                    ),
                    
                   const SizedBox(height: 20 ,), 
                    TextFormField(
                      controller: _userPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: !_isVisible,
                      style:const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        label:const Text('Password',style: TextStyle(color: Colors.blue),),
                        focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                         errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),),
                          focusedErrorBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),),
                        prefixIcon:const Icon(Icons.lock),
                        prefixIconColor: Colors.blue,
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _isVisible=!_isVisible;
                          });
                        }, icon:const Icon(Icons.visibility,)),
                        suffixIconColor: Colors.blue,
                      ),
                      onSaved: (value) {
                        _userPassword.text=value?.trim()??'';
                      },
                      onChanged: (value) {
                        setState(() {
                          if(error||isLogin){
                            error=false;
                            isLogin=false;
                          }
                        });
                      },
                        validator:(value) {
                        if(value==null ||value.isEmpty){
                          return 'please enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
           const SizedBox(height: 10,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor:const Color.fromARGB(255, 2, 189, 246),
                shape:const StadiumBorder(),
                fixedSize:const Size(100,20 )
              ),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                      login();
                    }
                   
              },
             child:const Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?",
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600),),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignupScreen()));
                  }, child:const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold),))
      
              ],
             ),
             isLogin?
            const Text('user name or password is incorrect',style: TextStyle(color: Colors.red),
            ):const SizedBox(),
            ],
            
          ),
        
          ),
      ),
    );
  }
  
}
