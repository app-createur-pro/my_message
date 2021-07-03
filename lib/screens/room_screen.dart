
import 'package:flutter/material.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/message_container_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class RoomScreen extends StatefulWidget {

  RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {

  String _message = "";

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider().reloadFirebase(context: context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            "Jean-Michel",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Image.asset("assets/images/user_images/Jean-Michel.png"),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        crossAxisAlignment: (index == 0) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          MessageContainerWidget(
                            isCurrentUser: (index == 0) ? true : false,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                                Strings.exampleDate,
                                style: MyTextStyles.dateChatScreen,
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Spacer(),
                Expanded(
                    child: TextFieldWidget(
                        textFieldParameters: TextFieldParameters(
                          hintText: Strings.tapMessage,
                          iconWidget: IconWidget(icon: Icons.camera_alt_rounded),
                          textStyle: MyTextStyles.formPlaceHolder.copyWith(
                              fontSize: 17
                          ),
                        ),
                      valueChanged: (value) {
                        _message = value;
                      },
                  ),
                  flex: 18,
                ),
                Spacer(),
                Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {  },
                        child: Icon(
                            Icons.send_sharp,
                            size: 28,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        ),
                      ),
                    ),
                    flex: 3,
                ),
                Spacer()
              ],
            ),
          ),
          SizedBox(height: 25,)
        ],
      ),
    );
  }
}

