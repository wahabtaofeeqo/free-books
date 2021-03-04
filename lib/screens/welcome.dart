import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/book.png',
              width: 97.0,
              height: 115.0,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'FreeBOOKS',
              style: TextStyle(fontSize: 24,
                  color: Color(0xFF174D73),
                  fontFamily: 'Helvetica'
              ),
            ),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              margin: EdgeInsets.only(top: 16.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Text('Login', style: TextStyle(fontWeight: FontWeight.w500),),
                padding: EdgeInsets.all(14.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                color: Colors.white,
              ),
              color: Colors.blue,
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text('Register', style: TextStyle(fontWeight: FontWeight.w500),),
                padding: EdgeInsets.all(14.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                color: Colors.white,
              ),
              color: Colors.blue,
            ),

            Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: Text('Login to Upload Books and do more!', style: TextStyle(fontSize: 16, color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}