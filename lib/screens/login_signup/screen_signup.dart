
import 'package:flutter/material.dart';
import 'package:travel_app/db/db_helper.dart';
import 'package:travel_app/jasonModel/user.dart';
import 'package:travel_app/screens/login_signup/screen_login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
   String? _validateEmail(String value) {
    // Define a regular expression for email validation
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    
    return null; // Return null for no validation errors
  }
  final name=TextEditingController();
  String email='';
  final password=TextEditingController();
  final confirmPassword=TextEditingController();
  bool _isVisible=false;
  bool _isVisibleone=false;
   bool _error=false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:const BoxDecoration(
         gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white,Colors.blue])
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 20),
                height: 225 ,
                width: 325,
                child: Image.asset('assets/loginscreen logo.png',fit: BoxFit.cover,),),
              const Text('Welcome !',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),
            const Text('Sign up',style: TextStyle(color: Colors.blue,fontSize: 70 ,fontWeight: FontWeight.bold),),
            const SizedBox(height: 25,),
            //Text field sesction--------------
            Container(
              padding:const EdgeInsets.only(left: 30,right: 30),
              child:  Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
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
                         errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),),
                          focusedErrorBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20),),
                        prefixIcon:const Icon(Icons.person,),
                        prefixIconColor: Colors.blue
                      ),
                      onChanged: (value) {
                        setState(() {
                          if(_error){
                            _error=false;
                          }
                        });
                      },
                      validator:(value) {
                        if(value==null ||value.isEmpty){
                          return 'please enter user name';
                        }
                        return null;
                      },
                    ),
                     const SizedBox(height: 20 ,), 
                     TextFormField(
                      controller: TextEditingController(),
                      onSaved:(value) {
                        email=value!;
                      },
                      style:const TextStyle(color: Colors.blue), 
                      decoration: InputDecoration(
                        label:const Text('email',style: TextStyle(color: Colors.blue),),
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
                        prefixIcon:const Icon(Icons.mail,),
                        prefixIconColor: Colors.blue
                      ),
                      validator:(value) {
                        if(value==null ||value.isEmpty){
                          return 'please enter email';
                        }else if (_validateEmail(value) != null) {
                         return _validateEmail(value);
                         }
                       
                        return null;
                      },
                    ),
                    const SizedBox(height: 20 ,),
                    TextFormField(
                      controller: password,
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
                      onChanged: (value) {
                        setState(() {
                          if(_error){
                            _error=false;
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
                     const SizedBox(height: 20 ,), 
                    TextFormField(
                      controller:confirmPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: !_isVisibleone,
                      style:const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        label:const Text('confirm Password',style: TextStyle(color: Colors.blue),),
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
                            _isVisibleone=!_isVisibleone;
                          });
                        }, icon:const Icon(Icons.visibility,)),
                        suffixIconColor: Colors.blue,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if(_error){
                            _error=false;
                          }
                        });
                      },
                        validator:(value) {
                        if(value==null ||value.isEmpty){
                          return 'please confirm password';
                        } else if(password.text!=confirmPassword.text){
                          return  "Passwords doesn't match";
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
                       final db = DatabaseHelper();
                       db.signup(Users(usrName: name.text, usrPassword: password.text,usremail: email,usrConfirmPassword: confirmPassword.text))
                       .whenComplete((){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
                       });
                    }                   
              },
             child:const Text('Sign up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text('already have an account ?',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
                ),),
              TextButton(onPressed: (){
               Navigator.pop(context);
              }, child:const Text('Sign in',style: TextStyle(
                fontWeight: FontWeight.w800 
              ),))
             ],)
              
            ],
            
          ),
        ),
      
        ),
    );
  }
 
}