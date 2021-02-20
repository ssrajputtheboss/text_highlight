import 'package:flutter/material.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

class PyText extends StatelessWidget{
  String _text;
  double _fontSize;
  TextOverflow richTextOverflow;
  bool softWrap;
  HighlightTheme _theme = HighlightTheme.defaultDarkTheme();
  PyText(String text,{fontSize=20,
    HighlightTheme theme,
    this.richTextOverflow = TextOverflow.clip,
    this.softWrap = true
  }){
    _fontSize = fontSize;
    _theme = theme == null ? _theme  : theme;
    _text = text.replaceAll('\x00', '').replaceAll('\t', '    ');
  }

  TextStyle getTextStyle(String token , spans , lastToken){
    var keywords = [
      'False',	'await',	'else',	'import',	'pass',
      'None',	'break',	'except',	'in'	,'raise',
      'True',	'class',	'finally',	'is',	'return',
      'and',	'continue',	'for',	'lambda',	'try',
      'as',	'def',	'from',	'nonlocal'	,'while',
      'assert',	'del',	'global',	'not',	'with',
      'async'	,'elif'	,'if',	'or'	,'yield',
    ];
    var defaultFunctions = ["abs", "all", "any", "bin", "bool", "bytearray", "callable", "chr",
      "classmethod", "compile", "complex", "delattr", "dict", "dir", "divmod",
      "enumerate", "eval", "filter", "float", "format", "frozenset",
      "getattr", "globals", "hasattr", "hash", "help", "hex", "id",
      "input", "int", "isinstance", "issubclass", "iter", "len",
      "list", "locals", "map", "max", "memoryview", "min", "next",
      "object", "oct", "open", "ord", "pow", "property", "range",
      "repr", "reversed", "round", "set", "setattr", "slice",
      "sorted", "staticmethod", "str", "sum", "super", "tuple",
      "type", "vars", "zip", "__import__", "NotImplemented",
      "Ellipsis", "__debug__"];
    var operators = ['+','-','*','/','//','%','^','&','|','~','=','<','>','>>','<<','**','!=','<=','>=','+=','-=','*=','==','/=','//=','%=','|=','&=','^=','>>=','<<=','**='];
    var re = new RegExp(r'\w+');
    if(re.stringMatch(token) == token){
      if (keywords.contains(token)) {
        return _theme.keyword();
      } else if (defaultFunctions.contains(token))
        return _theme.specialIdentifier();
      else if((new RegExp(r'\d+')).stringMatch(token) == token)
        return _theme.numberConstant();
      return _theme.identifier();
    }else{
      if((new RegExp(r'#.*')).stringMatch(token) == token)
        return _theme.comment();
      else if((new RegExp(r'''('(.|\n)*')|("(.|\n)*")''')).stringMatch(token) == token)
        return _theme.stringConstant();
      else if(operators.contains(token.trim()))
        return _theme.operator();
      var lt = token.trimLeft();
      if(lt.length>0)
        if(lt[0]=="("  && (new RegExp(r'\w+')).stringMatch(lastToken) == lastToken && !(defaultFunctions.contains(lastToken) || keywords.contains(lastToken))){//it is a function
          spans.removeAt(spans.length-1);
          spans.add(TextSpan(text: lastToken, style: _theme.functionIdentifier()));
        }
      return _theme.specialCharacter();
    }
  }

  createSpans(String text){
    var spans = <TextSpan>[];
    var re1 = r'"(\\\n|\\"|[^"\n])*"';
    var re2 = r"'(\\\n|(\\')|[^'\n])*'";
    var re3 = r'"""(.|\n)*?"""';
    var re4 = r"'''(.|\n)*?'''";
    var rs = re1+'|'+re2;
    var rc = re3 + '|' + re4;
    var lst = [];
    var r = new RegExp(rc + '|' + rs + '|' + r'#.*');
    r.allMatches(text).forEach((i) {
      text = text.replaceFirst(i.group(0), '\x00');
      lst.add(i.group(0));
    });
    var  re = new RegExp(r'(\x00)|([^\x00!%\+\=\-\*/\&\^\|~\w])+|((\w)+)|[\s!%\+\=\-\*/\&\^\|~]+');
    int j=0;
    var lastToken = '';
    re.allMatches(text).forEach((i) {
      if(i.group(0).contains('\x00')){
        var x = i.group(0).replaceFirst('\x00', lst[j]);
        var lt = lastToken.trimRight();
        lt = lt==''?' ':lt;
        if(!lt[lt.length-1].contains(new RegExp(r'\+|=|\*|\(')) && (new RegExp(r'"""(.|\n)*"""'+'|'+r"'''(.|\n)*'''").hasMatch(lst[j]))){
          //it is a multiline comment
          spans.add(TextSpan(text: x,style: _theme.multilineComment()));
        }else
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

