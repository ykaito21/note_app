import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/models/note_model.dart';

class NoteBloc {
  final BehaviorSubject<NoteModel> _contentController =
      BehaviorSubject<NoteModel>();
  final notesBox = Hive.box('notes');

  NoteBloc() {
    _contentController
        .debounceTime(Duration(milliseconds: 500))
        .listen((NoteModel note) {
      if (note.content.isNotEmpty) {
        print('saved');
        notesBox.put(note.id, note);
      }
    });
    //     .switchMap(
    //   (NoteModel note) async* {
    //     if (note.content.isNotEmpty) {
    //       print('saved');
    //       yield notesBox.put(note.id, note);
    //     }
    //   },
    // ).listen(
    //   (note) => print('call'),
    // );
  }

  Function(NoteModel) get setNote => _contentController.add;

  // Stream<NoteModel> get contentStream => _contentController.stream;
  // void setContent(NoteModel note) => _contentController.add(note);

  void dispose() {
    _contentController.close();
  }
}
