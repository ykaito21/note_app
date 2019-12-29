import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/src/core/models/note_model.dart';
import 'package:note_app/src/ui/screens/write_screen.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: WriteScreen(
            note: NoteModel(id: '1', content: '', date: DateTime.now()))));
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'hello');
    expect(find.text('hello'), findsOneWidget);
  });
}
