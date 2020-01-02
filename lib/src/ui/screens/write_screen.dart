import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../app_localizations.dart';
import '../../core/blocs/note_bloc.dart';
import '../../core/models/note_model.dart';

class WriteScreen extends StatefulWidget {
  final NoteModel note;
  const WriteScreen({Key key, @required this.note})
      : assert(note != null),
        super(key: key);

  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController _contentController;
  // String _content;
  NoteBloc _noteBloc;

  NoteModel get note => widget.note;

  @override
  void initState() {
    super.initState();
    _noteBloc = NoteBloc();
    _contentController = TextEditingController(text: note.content);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _noteBloc.dispose();
    super.dispose();
  }

  void _autoSave() {
    _noteBloc.setNote(NoteModel(
      id: widget.note.id,
      date: DateTime.now(),
      content: _contentController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('subTitle'),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _autoSave();
              FocusScope.of(context).unfocus();
              // Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              DateFormat('yyyy/MM/dd hh:mm').format(note.date),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: TextField(
                onChanged: (_) => _autoSave(),
                controller: _contentController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20.0,
                  ),
                  border: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // focusedErrorBorder: InputBorder.none,
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: TextField.noMaxLength,
              ),
            )
          ],
        ),
      ),
    );
  }
}
