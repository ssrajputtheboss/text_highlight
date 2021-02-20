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
  String _text , _mode;
  double _fontSize, _padding;
  TextOverflow richTextOverflow;
  bool softWrap;
  HighlightTheme _theme = HighlightTheme.defaultDarkTheme();
  var _modes = [
    'python' , 'java' , 'javascript' , 'text' , 'auto' , 'c' , 'cpp' , 'c++' , 'csharp' , 'c#' , 'go' , 'r' , 'swift' ,
  ];

  HighlightText(String text, {double fontSize = 15,
    double padding = 0,
    HighlightTheme theme,
    String mode = HighlightTextModes.AUTO,
    this.richTextOverflow = TextOverflow.clip,
    this.softWrap = true
  }) {
    _fontSize = fontSize;
    _padding = padding;
    _theme = theme == null ? _theme : theme;
    _text = text;
    _mode = mode;
  }
  setMode(){
    if(_mode == HighlightTextModes.AUTO){
      var lines = _text.split('\n');
      if(lines.length<=1){
        _mode = HighlightTextModes.TEXT;
        return Text(_text , style: TextStyle( fontSize:  _fontSize,color: _theme.textColor ), );
      }
      String firstLine = lines[0];
      String mode = firstLine.replaceAll(':', '').trim().toLowerCase();
      _mode = _modes.contains(mode) ? mode : HighlightTextModes.TEXT;
      if(_modes.contains(mode))_text = _text.replaceFirst(firstLine+'\n','' );
    }
    if(_mode==HighlightTextModes.PYTHON)
      return PyText(_text, fontSize: _fontSize, theme: _theme, richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.JAVA)
      return JavaText(_text ,fontSize: _fontSize, theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.JAVASCRIPT)
      return JavaScriptText(_text , fontSize: _fontSize, theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.C)
      return CText(_text ,fontSize: _fontSize, theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.CPP || _mode=='c++')
      return CppText(_text ,fontSize: _fontSize,  theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.CSHARP || _mode=='c#')
      return CSharpText(_text ,fontSize: _fontSize,  theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.GO)
      return GoText(_text ,fontSize: _fontSize, theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.R)
      return RText(_text ,fontSize: _fontSize,  theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    if(_mode==HighlightTextModes.SWIFT)
      return SwiftText(_text ,fontSize: _fontSize,  theme: _theme,richTextOverflow: richTextOverflow, softWrap: softWrap,);
    return Text(_text ,overflow: richTextOverflow, softWrap: softWrap, style: TextStyle( fontSize:  _fontSize,color: _theme.textColor ), );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(_padding),
        decoration: BoxDecoration(
          color: _theme.backgroundColor(),
        ),
        child: setMode()
    );
  }

}
