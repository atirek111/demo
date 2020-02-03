import 'package:flutter/material.dart';
import 'package:demo/login/loginpage.dart';
import 'package:demo/login/signupPage.dart';
class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}):super(key:key);
  final String title;
  @override
  _WelcomePageState createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage>{
  Widget _loginButton(){
    return InkWell(
      onTap:(){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>LoginPage())
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:EdgeInsets.symmetric(vertical:13),
        alignment:Alignment.center,
        decoration:BoxDecoration(
          color: Colors.black,
        ),
        child: Text(
            'login',
            style:TextStyle(fontSize: 20, color: Colors.white)
        ),
      ),
    );
  }
  Widget _signupButton(){
    return InkWell(
      onTap:(){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>SignupPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:EdgeInsets.symmetric(vertical:13),
        alignment:Alignment.center,
        decoration:BoxDecoration(
            border: Border.all(color: Colors.black, width:2)
        ),
        child: Text(
            'signup',
            style:TextStyle(fontSize: 20, color: Colors.black)
        ),
      ),
    );
  }
  Widget _label(){
    return Container(child: Text(
        'Welcome to FIWI',
        style: TextStyle(color: Colors.black, fontSize:15)
    ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.wifi, size: 90, color: Colors.black,),
                SizedBox(height: 80),
                _label(),
                SizedBox(height: 30),
                _loginButton(),
                SizedBox(height: 20),
                _signupButton(),

              ],
            ),
          ),
        ],
      ),
    );
  }

}