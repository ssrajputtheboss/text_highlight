import 'package:flutter/material.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

class CppText extends StatelessWidget{
  String _text;
  double _fontSize;
  TextOverflow richTextOverflow;
  bool softWrap;
  HighlightTheme _theme = HighlightTheme.defaultDarkTheme();
  CppText(String text,{double fontSize=20,
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
      'alignas', 'decltype', 'namespace', 'struct', 'alignof', 'default', 'new', 'switch',
      'and', 'delete', 'noexcept', 'template', 'and_eq', 'do', 'not', 'this', 'asm', 'double',
      'not_eq', 'thread_local', 'auto', 'dynamic_cast', 'nullptr', 'throw', 'bitand', 'else',
      'operator', 'true', 'bitor', 'enum', 'or', 'try', 'bool', 'explicit', 'or_eq', 'typedef',
      'break', 'export', 'private', 'typeid', 'case', 'extern', 'protected', 'typename', 'catch',
      'false', 'public', 'union', 'char', 'float', 'register', 'unsigned', 'char16_t', 'for',
      'reinterpret_cast', 'using', 'char32_t', 'friend', 'return', 'virtual', 'class', 'goto',
      'short', 'void', 'compl', 'if', 'signed', 'volatile', 'const', 'inline', 'sizeof', 'wchar_t',
      'constexpr', 'int', 'static', 'while', 'const_cast', 'long', 'static_assert', 'xor', 'continue',
      'mutable', 'static_cast', 'xor_eq'
    ]
    ;
    var specialIdentifiers = [
      'main' , 'true' , 'false' , 'NULL' , 'include' , 'define' , 'ifdef' , 'undef' , 'ifndef' ,
      'if' , 'else' , 'elif' , 'endif' , 'error' , 'pragma'
    ];
    var operators = ['+','-','*','/','%', '!','?' , ':' , '::','^','&','|','=','<','>','>>','<<','++','--','!=','<=','>=','+=','-=','*=','==','/=','%=','|=','&=','^=','>>=','<<=','&&','||'];
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
    var  re = new RegExp(r'(\x00)|([^\?:!%\x00\+\=\-\*/\&\^\|~\w])+|((\w)+)|[\s\?:!%\+\=\-\*/\&\^\|~]+');
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
