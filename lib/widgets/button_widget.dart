
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class ButtonWidget extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key, 
    required this.buttonText, 
    required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        constraints: BoxConstraints(
            minHeight: MySizes.minimumHeightInputs
        ),
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}
