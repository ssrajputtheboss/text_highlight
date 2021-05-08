import 'package:flutter/material.dart';
class HighlightTheme {
  final Color bgColor,textColor;
  final TextStyle keywordStyle , commentStyle , multiLineCommentStyle , specialIdentifiersStyle , numberConstantStyle ,
      stringConstantStyle , operatorStyle , specialCharacterStyle , identifierStyle ,functionIdentifierStyle;

  const HighlightTheme({
    this.keywordStyle = const TextStyle(color:Color.fromRGBO(182, 87, 0, 1)),
    this.commentStyle = const TextStyle(color:Colors.grey,fontStyle: FontStyle.italic),
    this.multiLineCommentStyle = const TextStyle(color:Colors.grey,fontStyle: FontStyle.italic),
    this.specialIdentifiersStyle = const TextStyle(color: Color.fromRGBO(160, 96, 255, 1)),
    this.numberConstantStyle = const TextStyle(color: Colors.yellow),
    this.stringConstantStyle = const TextStyle(color: Color.fromRGBO(80,145,0,1)),
    this.operatorStyle = const TextStyle(color:Colors.red),
    this.specialCharacterStyle = const TextStyle(color:Colors.white),
    this.identifierStyle  = const TextStyle(color: Color.fromRGBO(0,130,250,1)),
    this.functionIdentifierStyle  = const TextStyle(color:  Color.fromRGBO(220,120,140,1)),
    this.textColor = Colors.white,
    this.bgColor = const Color.fromRGBO(20,20,20,1)
});

  Color get backgroundColor => bgColor;

  TextStyle get keyword => keywordStyle;

  TextStyle get comment => commentStyle;

  TextStyle get multilineComment => multiLineCommentStyle;

  TextStyle get specialIdentifier => specialIdentifiersStyle;

  TextStyle get numberConstant => numberConstantStyle;

  TextStyle get stringConstant => stringConstantStyle;

  TextStyle get operator => operatorStyle;

  TextStyle get specialCharacter => specialCharacterStyle;

  TextStyle get identifier => identifierStyle;

  TextStyle get functionIdentifier => functionIdentifierStyle;

  static HighlightTheme defaultDarkTheme(){
    return const HighlightTheme();
  }


  static HighlightTheme defaultLightTheme(){
    return const HighlightTheme(
      bgColor: Colors.white,
      operatorStyle: TextStyle(color: Colors.black),
      commentStyle: TextStyle(color: Colors.black45,fontStyle: FontStyle.italic),
      multiLineCommentStyle: TextStyle(color: Colors.black45,fontStyle: FontStyle.italic),
      specialCharacterStyle: TextStyle(color: Colors.orangeAccent),
      textColor: Colors.black
    );
  }
}

