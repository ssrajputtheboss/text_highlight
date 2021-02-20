# Examples

Here is complete example specially how auto mode works : -
```dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:text_highlight/text_highlight.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child:Text('Text Editor')),
        ),
        body: Center(
          child: Temp(),
        ),
      ),
    );
  }

}

class Temp extends StatefulWidget{
  Temp({Key key}) : super(key : key);
  @override
  _Temp createState() => _Temp();

}

class _Temp extends State<Temp>{
  TextEditingController _controller= TextEditingController();
  String _text ='';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
       Align(
         alignment: Alignment.topRight,
         child: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             HighlightText('''
// java example
class Hello{
public static void main(String args[]){
  System.out.println("Hello world");
}
}''' , mode: HighlightTextModes.JAVA,fontSize: 15,),
           ],
         ),
       ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''c#:
//csharp example 
namespace HelloWorld
{
    class Hello {         
        static void Main(string[] args)
        {
            System.Console.WriteLine("Hello World!");
        }
    }
}''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''python:
# python example
print("""Hello world""")''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''c:
//c example
#include<stdio.h>
void main(){
  printf("Hello World\\n");
}
''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''c++:
// c++/cpp example
#include<iostream>
using namespace std;
int main(){
cout<<"Hello World";
}''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''r:
# r example
print('Hello World')
''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''swift:
// swift example
import Swift
var hw = "Hello World"
print(hw)''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''Go:
// go example
package main
import "fmt"
func main(){
  fmt.Println("Hello World");
}''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText('''javascript:
//javascript example
console.log('Hello world')
''' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HighlightText( 'Namaste , this is a normal text \n' , mode: HighlightTextModes.AUTO,fontSize: 15,),
            ],
          ),
        ),
      ],
    );
  }

}
``` 

## custom HighlightTheme example

```dart
var MyTheme = HighlightTheme(
    bgColor: Colors.brown,
    keywordStyle: TextStyle(color: Colors.red),
    specialIdentifiersStyle: TextStyle(color: Colors.black87),
    functionIdentifierStyle: TextStyle(color: Colors.yellow),
    identifierStyle: TextStyle(color: Colors.lightBlue),
    specialCharacterStyle: TextStyle(color: Colors.white),
    operatorStyle: TextStyle(color: Colors.indigo),
    stringConstantStyle: TextStyle(color: Colors.green),
    commentStyle: TextStyle(color: Colors.grey , fontStyle: FontStyle.italic),
    multiLineCommentStyle: TextStyle(color: Colors.grey , fontStyle: FontStyle.italic),
    numberConstantStyle: TextStyle(color: Colors.deepOrange),
    textColor: Colors.white, // this will not affect your code this is for text mode only
  );
  HighlightText(
    'for i in range(10):\n\tprint("gg!" , end = "\\n")',
    mode: HighlightTextModes.PYTHON,
    theme: MyTheme,
    fontSize: 20,
    padding: 1,
  );
```

## overflow not working ? 

if HighlightText is overflowing then wrap it up in a Flexible or a Expanded widget.

