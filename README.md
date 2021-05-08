# text_highlight

A richtext widget for highlighting programming languages like python , c++ , c# etc. Currently supports 9 programming languages 
c, c++, c#, go, java, javascript, python, r, swift. The widget is fully customizable , you can create theme of your own using 
HighlightTheme class , by default theme is dark mode.

# Usage

## importing package

```dart
import 'package:text_highlight/text_highlight.dart';
```

## Using text_highlight for a particular language mode :

```dart
HighlightText(
    '''
    # python example
    print("""Hello world""")
    ''' ,
    mode: HighlightTextModes.PYTHON,
    fontSize: 15,
)
```
similarly you can specify any of the 9 languages to set its mode. mode is actually simply string you can pass mode like this:
mode : 'python' ,
but make sure u don't pass a mode which does not exist , otherwise it will throw HighlightTextModeNotFoundException error.

## AUTO mode

```dart
HighlightTextModes.AUTO
```
auto mode let the user decide which language he wants to highlight. A complete example can be seen at examples/README.md section.
Based on the input string it automatically sets language . Remember it does not analyzes whole input string , it analyzes only 
first line of input string and sees which language is mentioned. So in auto mode first line should contain only name of language 
and a colon(colon is optional). If none of the modes matches the first line it will set mode to TEXT.
Here is an example of AUTO mode for highlighting python code:
```dart
HighlightText(
    '''python:
    # python example
    print("""Hello world""")
    ''' ,
    mode: HighlightTextModes.AUTO,
    fontSize: 15,
)
// first line of string should be the name of language and a colon.
```

## Custom HighlightTheme 

by default the only two themes are available defaultDarkTheme and defaultLightTheme. But two themes are definitely not enough 
, you can create your own theme if you want using HighlightTheme class. you can see the example in example/README.md section.

## sample outputs => 

![](https://github.com/ssrajputtheboss/testing/blob/main/IMG_20210220_122626.jpg)

