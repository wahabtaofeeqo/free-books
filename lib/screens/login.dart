import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/users/users.dart';
import 'package:free_books/models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _email;
  String _password;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        child: Form(
                          key: _formKey,
                          child: ListView(

                            children: [
                              Container(
                                padding: EdgeInsets.all(45),
                                child: Text(
                                  'FreeBOOKS',
                                  style: TextStyle(fontSize: 24,
                                    color: Color(0xFF174D73),
                                    fontFamily: 'Helvetica',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              //Email
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Email'
                                    ),

                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.grey,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),

                                      validator: (val) {
                                        return val.trim().isEmpty ? 'Enter Your Email' : null;
                                      },

                                      onSaved: (val) => _email = val,
                                    )
                                  ],
                                ),
                              ),

                              //Password
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Password'
                                    ),

                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.grey,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      validator: (val) {
                                        return val.trim().isEmpty ? 'Enter Your Password' : null;
                                      },
                                      onSaved: (val) => _password = val,
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                                child: RaisedButton(
                                  onPressed: () {
                                    if(_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      User user = User();
                                      user.email = _email;
                                      user.password = _password;
                                      BlocProvider.of<UsersBloc>(context).add(AddUserEvent(user));
                                    }
                                  },
                                  child: Text('Register', style: TextStyle(fontWeight: FontWeight.w500),),
                                  padding: EdgeInsets.all(14.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Login if you already have an Account!'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}