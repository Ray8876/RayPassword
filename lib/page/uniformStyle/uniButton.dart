import 'package:flutter/material.dart';

class UniButton extends StatefulWidget {
  @required final onPressed;
  final String text;

  const UniButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UniButtonState();
  }
}

class _UniButtonState extends State<UniButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      color: Colors.grey[100],
      child: Text(
        widget.text ?? "",
      ),
    );
  }
}
