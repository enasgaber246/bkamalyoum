import 'package:flutter/cupertino.dart';

class TextTitle extends StatelessWidget {
  String text;
  double fontSize;
  double horizontal = 10.0;
  double vertical = 10.0;
  TextAlign textAlign;
  TextStyle textStyle;
  FontWeight fontWeight;
  int lines;

  TextTitle(this.text, this.textStyle,
      {this.fontSize,
      this.horizontal,
      this.vertical,
      this.textAlign = TextAlign.end,
      this.fontWeight,
      this.lines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,

    );
  }
}
