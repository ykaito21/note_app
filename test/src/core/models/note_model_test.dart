import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/src/core/models/note_model.dart';

void main() {
  group('fromMap', () {
    test('note with all data', () {
      final String testContent = 'test content';
      final DateTime testDate = DateTime.now();
      final note = NoteModel.fromDb({
        "id": '1',
        "content": testContent,
        "date": testDate.toUtc().toIso8601String(),
      });
      // expect(note.id, 1);
      // expect(note.content, 'test content');
      expect(note, NoteModel(id: '1', content: testContent, date: testDate));
    });

    test('note without content', () {
      final DateTime testDate = DateTime.now();
      final note = NoteModel.fromDb({
        "id": '1',
        "date": testDate.toUtc().toIso8601String(),
      });
      // expect(note.id, 1);
      // expect(note.content, 'test content');
      expect(note, NoteModel(id: '1', content: '', date: testDate));
    });
    group('toMap', () {
      test('valid note data', () {
        final String testContent =
            'Iusto quo ducimus labore deserunt. Voluptatibus dolorem pariatur esse voluptatibus praesentium. Sed omnis eius sint.';
        final DateTime testDate = DateTime.now();
        final note = NoteModel(
          id: '1',
          content: testContent,
          date: testDate,
        );
        expect(note.toMapForDb(), {
          "content": testContent,
          "date": testDate.toUtc().toIso8601String(),
        });
      });
    });
  });
}
