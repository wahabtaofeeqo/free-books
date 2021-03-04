import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/blocs/users/users.dart';
import 'package:free_books/models/models.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _phone;
  String _password;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: SafeArea(
            child:  Column(
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

                            //Name
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Name'
                                  ),

                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Your Name',
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.grey,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    validator: (val) {
                                      return val.trim().isEmpty ? 'Enter Your name' : null;
                                    },

                                    onSaved: (val) => _name = val,
                                  )
                                ],
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

                            //Phone Number
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Phone Number'
                                  ),

                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Your Name',
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.grey,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),

                                    validator: (val) {
                                      return val.trim().isEmpty ? 'Enter Your Phone Number' : null;
                                    },

                                    onSaved: (val) => _phone = val,
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
                                    user.name = _name;
                                    user.phone = _phone;
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
          )
        );
      },
    );
  }
}