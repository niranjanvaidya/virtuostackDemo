import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:virtuostack/HomeScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
   dynamic username='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign In', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('Sign In With your facebook account'),
              SizedBox(height: 15,),

              SignInButton(Buttons.Facebook, onPressed: (){
                FacebookAuth.instance.login(
                    permissions: ["email"]).then((value) {
                  FacebookAuth.instance.getUserData().then((userData) {
                    username = userData['name'];
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return HomeScreen(username: username,);
                    }));
                  });
                });
              }),
            ],
          )

          ,
        ),
      ),
    );
  }
}
