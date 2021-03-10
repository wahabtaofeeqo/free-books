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

  Book book;

  String chatNode = '';
  bool _showSticker = false;

  final controller = new TextEditingController();

  String peerId;
  final userid = FirebaseAuth.instance.currentUser.uid; // Current User

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    this.book = ModalRoute.of(context).settings.arguments;
    this.peerId = book.userid;

    //Load chat between the two users
    BlocProvider.of<BooksBloc>(context)..add(LoadChatEvent(getNode(this.peerId)));

    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Taofeek'),),
          body: WillPopScope(
            child: Stack(
              children: [

                (state is ChatsLoadedState) ? _buildMessages((state).chats) : _buildLoader(),

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

  Widget _buildMessages(List<Chat> chats) {

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, int index) {
          final chat = chats[index];
          if(chat.to == this.userid) {
            return _buildToBubble(chat);
          }
          else {
            return _buildFromBubble(chat);
          }
        },
      ),
    );
  }

  Widget _buildToBubble(Chat chat) {
    return Bubble(
      margin: BubbleEdges.only(top: 10, right: 35),
      stick: true,
      nip: BubbleNip.leftTop,
      child: Text(chat.message, textAlign: TextAlign.left),
    );
  }

  Widget _buildFromBubble(Chat chat) {
    return Bubble(
      margin: BubbleEdges.only(top: 10, left: 35),
      stick: true,
      nip: BubbleNip.rightTop,
      color: Color.fromRGBO(225, 255, 199, 1.0),
      child: Text(chat.message, textAlign: TextAlign.right),
    );
  }

  Widget _buildSticker() {
    return Container();
  }

  Widget _buildMessageInput() {
    return  Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 50,
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

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  String getNode(String peer) {

    String currentUserId = FirebaseAuth.instance.currentUser.uid;
    if (currentUserId.hashCode <= peer.hashCode) {
      return '$currentUserId-$peer';
    } else {
      return '$peer-$currentUserId';
    }
  }

  void _sendMessage() {
    if(this.controller.text.trim().isNotEmpty) {
      String currentUserId = FirebaseAuth.instance.currentUser.uid;

      Chat chat = new Chat();
      chat.from = currentUserId;
      chat.to = this.peerId;
      chat.message = controller.text;
      chat.type = 0;

      BlocProvider.of<BooksBloc>(context).add(SendMessageEvent(chat, getNode(peerId)));

      controller.clear();
      FocusScope.of(context).unfocus();
    }

    print(getNode(peerId));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}