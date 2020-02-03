import 'package:flutter/material.dart';
import 'package:demo/login/forgotPage.dart';
import 'package:demo/student/studentDashboard.dart';
import 'package:demo/admin/adminDashboard.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController();
  TextEditingController roll = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String error = '';

  Future<void> _signup() async {
    try {
      FormData formData =
      new FormData.from({
        "name": name.text,
        "roll": roll.text,
        "email": email.text,
        "password": pass.text,
        });

      Response response = await Dio().post(
          "https://stridulous-instruct.000webhostapp.com/api-d/user/login.php",
          data: formData);

      if (response.data['res_code'] == 200) {
        if (response.data['type'] == 'admin') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminDashbord()));
        } else if (response.data['type'] == 'student') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StudentDashbord()));
        }
      } else if (response.data['res_code'] == 201) {
        _showSnackBarMsg(
            "you are not active to login. please contact to admin");
      } else if (response.data['res_code'] == 202) {
        _showSnackBarMsg("you have entered wrong password");
      } else if (response.data['res_code'] == 203) {
        _showSnackBarMsg("you have entered wrong email or rollno");
      } else if (response.data['res_code'] == null) {
        _showSnackBarMsg("check your internet connection");
      }
    } catch (e) {
      print('ExceptionCut:$e');
    }
  }

  void _showSnackBarMsg(String msg) {
    _scaffoldState.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.wifi, size: 90, color: Colors.black),
                        Text(
                          'signup to Fiwi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        _buildNameTf(),
                        SizedBox(
                          height:15,
                        ),
                        _buildRollnoTf(),
                        SizedBox(
                          height: 15,
                        ),
                        _buildEmailTf(),
                        SizedBox(
                          height: 15,
                        ),
                        _buildPasswordTf(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }Widget _buildNameTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: name,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              contentPadding: EdgeInsets.only(
                top: 14,
              ),
              prefixIcon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              hintText: 'enter your name',
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildRollnoTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: roll,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              contentPadding: EdgeInsets.only(
                top: 14,
              ),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              hintText: 'enter your rollno',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: roll,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              contentPadding: EdgeInsets.only(
                top: 14,
              ),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'enter email or rollno',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: pass,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              contentPadding: EdgeInsets.only(
                top: 14,
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'enter your password',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: RaisedButton(
        onPressed: (){
          _checkinternet();
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),),
        color: Colors.black,
        child: Text(
          'Signup',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _checkinternet()async{
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
      _showSnackBarMsg("check your internet connection");
    } else{
      _signup();
    }
  }
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Already have an account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
