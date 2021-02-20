import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:text_highlight/text_highlight.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

void main() {
  test('test', () {
    final theme = HighlightTheme();
    expect( theme.backgroundColor() , const Color.fromRGBO(20,20,20,1));
  });
}
