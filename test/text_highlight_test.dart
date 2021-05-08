import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:text_highlight/text_highlight.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

void main() {
  test('test', () {
    final theme = HighlightTheme();
    expect( theme.backgroundColor , const Color.fromRGBO(20,20,20,1));
  });

  testWidgets('auto mode test in highlight text',(WidgetTester tester)async{
    var ht = find.byType(HighlightText);
     // testing
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            HighlightText('text:\nlol'  , mode: HighlightTextModes.AUTO,),
          ],
        ),
      ),
    ));
    await tester.pump();

    //output
    expect(find.text('lol'), findsOneWidget);
  } );
}
