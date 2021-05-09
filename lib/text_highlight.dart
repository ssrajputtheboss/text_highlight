library text_highlight;

import 'package:flutter/material.dart';
import 'package:text_highlight/tools/c_text.dart';
import 'package:text_highlight/tools/cpp_text.dart';
import 'package:text_highlight/tools/csharp_text.dart';
import 'package:text_highlight/tools/go_text.dart';
import 'package:text_highlight/tools/highlight_theme.dart';
import 'package:text_highlight/tools/java_text.dart';
import 'package:text_highlight/tools/javascript_text.dart';
import 'package:text_highlight/tools/pytext.dart';
import 'package:text_highlight/tools/r_text.dart';
import 'package:text_highlight/tools/swift_text.dart';



class HighlightTextModes {
  static const PYTHON = 'python';
  static const JAVA = 'java';
  static const JAVASCRIPT = 'javascript';
  static const C = 'c';
  static const CPP = 'cpp';
  static const CSHARP = 'csharp';
  static const GO = 'go';
  static const R = 'r';
  static const SWIFT = 'swift';
  static const TEXT = 'text';
  static const AUTO = 'auto';
}

class HighlightTextModeNotFoundException implements Exception {
  HighlightTextModeNotFoundException(String mode){
    Exception('HighlightTextModeNotFoundException HighlightText cannot found mode $mode');
  }
}


class HighlightText extends StatelessWidget{
  final String text , mode;
  final double fontSize, padding;
  final TextOverflow richTextOverflow;
  final bool softWrap;
  final HighlightTheme theme;

  HighlightText(this.text, {this.fontSize = 20,
    this.padding = 0,
    this.theme = const  HighlightTheme(),
    this.mode = HighlightTextModes.AUTO,
    this.richTextOverflow = TextOverflow.clip,
    this.softWrap = true
  });
  setMode(){
    final _modes = const [
      'python' , 'java' , 'javascript' , 'text' , 'auto' , 'c' , 'cpp' , 'c++' , 'csharp' , 'c#' , 'go' , 'r' , 'swift' ,
    ];
    String text = this.text;
    String mode = this.mode;
    if(mode == HighlightTextModes.AUTO){
      var lines = text.split('\n');
      if(lines.length<=1){
        return Text(text , style: TextStyle( fontSize:  fontSize,color: theme.textColor ), );
      }
      String firstLine = lines[0];
      String mode = firstLine.replaceAll(':', '').trim().toLowerCase();
      mode = _modes.contains(mode) ? mode : HighlightTextModes.TEXT;
      if(_modes.contains(mode))text = text.replaceFirst(firstLine+'\n','' );
    }
    if(mode==HighlightTextModes.PYTHON)
      return PyText(text, fontSize: fontSize, theme: theme, richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.JAVA)
      return JavaText(text ,fontSize: fontSize, theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.JAVASCRIPT)
      return JavaScriptText(text , fontSize: fontSize, theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.C)
      return CText(text ,fontSize: fontSize, theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.CPP || mode=='c++')
      return CppText(text ,fontSize: fontSize,  theme:theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.CSHARP || mode=='c#')
      return CSharpText(text ,fontSize: fontSize,  theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.GO)
      return GoText(text ,fontSize: fontSize, theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.R)
      return RText(text ,fontSize: fontSize,  theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(mode==HighlightTextModes.SWIFT)
      return SwiftText(text ,fontSize: fontSize,  theme: theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    return Text(text ,overflow: richTextOverflow, softWrap: softWrap, style: TextStyle( fontSize:  fontSize,color: theme.textColor ), );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
        ),
        child: setMode()
    );
  }

}
