import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/models/models.dart';
import 'package:image_picker/image_picker.dart';

typedef OnSaveCallback = Function(Book book);
class AddEditScreen extends StatefulWidget {

  final bool isEditing;
  final Book book;
  final OnSaveCallback onSave;

  AddEditScreen({Key key, @required this.isEditing, @required this.onSave, this.book}): super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {

  String _name;
  String _dept;

  String _image;
  final ImagePicker picker = ImagePicker();

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffold,
          appBar: AppBar(title: Text('New Book'),),
          body: SafeArea(
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
                            'Book Name'
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Book Title',
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

                          onSaved: (val) => _name = val,
                        )
                      ],
                    ),
                  ),

                  //Department
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Department'
                        ),

                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Department',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (val) {
                            return val.trim().isEmpty ? 'Enter Department' : null;
                          },
                          onSaved: (val) => _dept = val,
                        )
                      ],
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(16.0),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: (_image == null ) ? Image.asset('assets/images/book.png').image : Image.file(File(_image)).image,
                      ),
                    ),
                    child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            _imgFromGallery();
                          },
                          child: Text('Choose Book Image'),)
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                    child: RaisedButton(
                      onPressed: () async {

                        //_test();

                        if(_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          if(_image == null) {
                            _scaffold.currentState.showSnackBar(SnackBar(content: Text('Please Select Book Logo')));
                            return;
                          }
                          else {
                            EasyLoading.show(status: 'Please wait...');
                            final Book book = Book(_name, _dept, _image);
                            book.views = 0;
                            book.userid = FirebaseAuth.instance.currentUser.uid;

                            await BlocProvider.of<BooksBloc>(context).addBook(book);
                            BlocProvider.of<BooksBloc>(context).add(BookAddedEvent(book));
                            EasyLoading.dismiss(animation: true);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text('Submit', style: TextStyle(fontWeight: FontWeight.w500),),
                      padding: EdgeInsets.all(14.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  _imgFromGallery() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image.path;
    });
  }
}