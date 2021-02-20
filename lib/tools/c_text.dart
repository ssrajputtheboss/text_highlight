import 'package:flutter/material.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

class CText extends StatelessWidget{
  String _text;
  double _fontSize;
  TextOverflow richTextOverflow;
  bool softWrap;
  HighlightTheme _theme = HighlightTheme.defaultDarkTheme();
  CText(String text,{double fontSize=20,
    HighlightTheme theme,
    this.richTextOverflow = TextOverflow.clip,
    this.softWrap = false
  }){
    _fontSize = fontSize;
    _theme = theme == null ? _theme  : theme;
    _text = text.replaceAll('\x00', '').replaceAll('\t', '    ');
  }

  TextStyle getTextStyle(String token , spans , lastToken){
    var keywords = [
      "if", "while",  "else" , "do" , "auto", "char",
      "return", "break", "continue", "extern", "void", "register", "short",
      "double", "sizeof", "const", "signed", "float", "long", "struct", "typedef",
      "union" ,  "catch", "int", "goto",
      "for", "switch", "case" , "default", "unsigned",
      "static", "volatile", "enum",
    ];
    var specialIdentifiers = [
      'main' , 'true' , 'false' , 'NULL' , 'include' , 'define' , 'ifdef' , 'undef' , 'ifndef' ,
      'if' , 'else' , 'elif' , 'endif' , 'error' , 'pragma'
    ];
    var operators = ['+','-','*','/','%', '!','?' , ':' ,'^','&','|','=','<','>','>>','<<','++','--','!=','<=','>=','+=','-=','*=','==','/=','%=','|=','&=','^=','>>=','<<=','&&','||'];
    var re = new RegExp(r'\w+');
    if(re.stringMatch(token) == token){
      if (keywords.contains(token)) {
        return _theme.keyword();
      } else if (specialIdentifiers.contains(token)){
        if(lastToken.contains('#')){
          spans.removeAt(spans.length-1);
          spans.add(TextSpan(text: lastToken, style: _theme.specialIdentifier()));
        }
        return _theme.specialIdentifier();
      }
      else if((new RegExp(r'\d+')).stringMatch(token) == token)
        return _theme.numberConstant();
      return _theme.identifier();
    }else{
      if((new RegExp(r'(//.*)|(/\*(.|\n)*?\*/)')).stringMatch(token) == token)
        return _theme.comment();
      else if((new RegExp(r'"(\\\n|\\"|[^"\n])*"' + '|' + r"'(\\\n|\\'|[^'\n])*'")).stringMatch(token) == token)
        return _theme.stringConstant();
      else if(operators.contains(token.trim()))
        return _theme.operator();
      var lt = token.trimLeft();
      if(lt.length>0)
      if(lt[0]=="("  && (new RegExp(r'\w+')).stringMatch(lastToken) == lastToken && !(specialIdentifiers.contains(lastToken) || keywords.contains(lastToken))){//it is a function
        spans.removeAt(spans.length-1);
        spans.add(TextSpan(text: lastToken, style: _theme.functionIdentifier()));
      }
      return _theme.specialCharacter();
    }
  }

  createSpans(String text){
    var spans = <TextSpan>[];
    var rs = r'"(\\\n|\\"|[^"\n])*"' + '|' + r"'(\\\n|\\'|[^'\n])*'";
    var rc = r'/\*(.|\n)*?\*/';
    var lst = [];
    var r = new RegExp(rc + '|' + rs + '|' + r'//.*');
    r.allMatches(text).forEach((i) {
      text = text.replaceFirst(i.group(0), '\x00');
      lst.add(i.group(0));
    });
    var  re = new RegExp(r'(\x00)|([^\x00\?:!%\+\=\-\*/\&\^\|~\w])+|((\w)+)|[\s\?:!%\+\=\-\*/\&\^\|~]+');
    int j=0;
    var lastToken = '';
    re.allMatches(text).forEach((i) {
      if(i.group(0).contains('\x00')){
        var x = i.group(0).replaceFirst('\x00', lst[j]);
        spans.add(TextSpan(text: x,style: getTextStyle(lst[j] , spans , lastToken)));
        j++;
      }else {
        spans.add(TextSpan(text: i.group(0), style: getTextStyle(i.group(0) , spans , lastToken)));
      }
      lastToken = i.group(0);
      // print(i.group(0));
    });
    return  spans;
  }



  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: softWrap,
      overflow: richTextOverflow,
      text: TextSpan(
          text: '',
          style: TextStyle(fontSize: _fontSize),
          children: createSpans(_text)
      ),
    );
  }

}
