import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:free_books/blocs/blocs.dart';
import 'package:free_books/models/models.dart';

class ChatScreen extends StatefulWidget {

  static const routeName = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  int type = 0; //Text

  String chatNode = '';
  bool _showSticker = false;

  Book book;

  final controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    this.book = ModalRoute.of(context).settings.arguments;
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Taofeek'),),
          body: WillPopScope(
            child: Stack(
              children: [

                _buildMessages(),

                (_showSticker) ? _buildSticker() : Container(),

                _buildMessageInput(),
              ],
            ),
            onWillPop: _onBackPressed,),
        );
      }
    );
  }

  Future<bool> _onBackPressed() {
    if(_showSticker) {
      setState(() {
        _showSticker = false;
      });
    }
    else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  void getSticker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showSticker = !_showSticker;
    });
  }

  Widget _buildMessages() {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Bubble(
            stick: true,
            color: Color.fromRGBO(212, 234, 244, 1.0),
            child: Text('TODAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            stick: true,
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            child: Text('Hello, World!', textAlign: TextAlign.right),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            stick: true,
            nip: BubbleNip.leftTop,
            child: Text('Hi, developer!'),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            stick: true,
            nip: BubbleNip.rightBottom,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            child: Text('Hello, World!', textAlign: TextAlign.right),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            stick: true,
            nip: BubbleNip.leftBottom,
            child: Text('Hi, developer!'),
          ),
          Bubble(
            margin: BubbleEdges.only(top: 10),
            stick: true,
            nip: BubbleNip.no,
            color: Color.fromRGBO(212, 234, 244, 1.0),
            child: Text('TOMORROW', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
          ),
        ],
      ),
    );
  }

  Widget _buildSticker() {
    return Container();
  }

  Widget _buildMessageInput() {
    return  Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 60,
        color: Colors.black12,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Icon(Icons.filter),
                onTap: () => getSticker(),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.emoji_emotions_outlined),
            ),

            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Message'
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Icon(Icons.send),
                onTap: () {
                  _sendMessage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage() {

    EasyLoading.show(status: 'Sending...');

    if(controller.text.isNotEmpty) {
      print(controller.text);
    }

    print(FirebaseAuth.instance.currentUser.uid.hashCode);
    print(FirebaseAuth.instance.currentUser.uid);

    String currentUserId = FirebaseAuth.instance.currentUser.uid;
    String peerId = book.userid;

    if (currentUserId.hashCode <= peerId.hashCode) {
      chatNode = '$currentUserId-$peerId';
    } else {
      chatNode = '$peerId-$currentUserId';
    }

    Chat chat = new Chat();
    chat.from = currentUserId;
    chat.to = peerId;
    chat.message = controller.text;
    chat.type = 0;

    BlocProvider.of<BooksBloc>(context).add(SendMessageEvent(chat, chatNode));

    controller.clear();
    FocusScope.of(context).unfocus();
    EasyLoading.dismiss(animation: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}