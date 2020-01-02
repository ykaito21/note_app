import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/note_model.dart';
import '../screens/write_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _displayedContent(String content) {
      if (content.contains('\n')) {
        final firstLineOfContent = content.split('\n')[0];
        return firstLineOfContent;
      } else {
        return content;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: WatchBoxBuilder(
          box: Hive.box('notes'),
          builder: (context, notesBox) {
            //* maybe add orderBy date
            return Container(
              child: ListView.builder(
                itemCount: notesBox.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // return the header
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  index -= 1;
                  final String key = notesBox.keyAt(index);
                  final NoteModel note = notesBox.get(key) as NoteModel;

                  return Dismissible(
                    onDismissed: (direction) async => notesBox.delete(note.id),
                    key: Key(UniqueKey().toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.only(right: 20.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    child: Container(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WriteScreen(
                                note: note,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          _displayedContent(note.content),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle:
                            Text(DateFormat('yyyy/MM/dd').format(note.date)),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.4),
                            width: 0.2,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WriteScreen(
                note: NoteModel(
                  id: Uuid().v4(),
                  content: '',
                  date: DateTime.now(),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
