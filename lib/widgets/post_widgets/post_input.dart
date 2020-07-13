import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:provider/provider.dart';

class PostInput extends StatefulWidget {
  @override
  _PostInputState createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  //final postMessage=Provider.of<NewPostProvider>(context);
  TextEditingController tec;

  @override
  void initState() {
    tec = TextEditingController(
        text: Provider.of<NewPostProvider>(context, listen: false).message);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('post editor build');
    return Consumer<NewPostProvider>(
      builder: (context, NewPostProvider newMessage, Widget child) {
        return Scrollbar(
          child: TextField(
            controller: tec,
            textAlign:
                newMessage.noBgColor ? TextAlign.start : TextAlign.center,
            //scrollPadding: EdgeInsets.symmetric(vertical: 20),

            maxLines: null,
            autocorrect: true,
            textCapitalization: TextCapitalization.sentences,
            //scrollPadding: EdgeInsets.all(20),
            style: TextStyle(
              fontSize: newMessage.fontSize,
              color: newMessage.noBgColor ? Colors.black : Colors.white,
              fontWeight:
                  newMessage.noBgColor ? FontWeight.normal : FontWeight.w900,
            ),
            decoration: InputDecoration(
              hintText: 'What do you want\nto talk about?',
              hintStyle: TextStyle(
                fontSize: 25,
              ),
            ),
            onChanged: (text) {
              newMessage.message = text;
              newMessage.setFont(text);
            },
          ),
        );
      },
    );
  }
}
