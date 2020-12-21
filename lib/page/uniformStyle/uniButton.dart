import 'package:flutter/material.dart';

class UniButton extends StatefulWidget {
  @required final onPressed;
  final String text;
  final Color color;
  final Color textColor;
  const UniButton({Key key, this.text, this.onPressed, this.color, this.textColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UniButtonState();
  }
}

class _UniButtonState extends State<UniButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed ?? (){},
      color: widget.color ?? Colors.grey[100],
      child: Text(
        widget.text ?? "",
        style: TextStyle(
          color: widget.textColor ?? Colors.black,
        ),
      ),
    );
  }
}
