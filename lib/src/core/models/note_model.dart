import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType()
class NoteModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime date;
  NoteModel({
    @required this.id,
    @required this.content,
    @required this.date,
  })  : assert(content != null),
        assert(date != null);

  NoteModel.fromDb(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        content = map['content'] ?? '',
        date = map['date'] != null
            ? DateTime.parse(map['date']).toLocal()
            : DateTime.now();
  //         from int
  // date = map['date'] != null
  //     ? DateTime.fromMicrosecondsSinceEpoch(map['date']).toLocal()
  //     : DateTime.now();

  Map<String, dynamic> toMapForDb() {
    Map<String, dynamic> map = {
      "content": content,
      // to int
      // "date": date.toUtc().millisecondsSinceEpoch
      "date": date.toUtc().toIso8601String(),
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'id: $id content: $content date: $date';
  }

//* can use equatable package
  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final NoteModel otherNote = other;
    return id == otherNote.id &&
        content == otherNote.content &&
        date == otherNote.date;
  }

  @override
  int get hashCode => hashValues(id, content, date);
}

// List<NoteModel> notes = [
//   NoteModel(
//     content:
//         '''Velit beatae qui reprehenderit atque nihil dolor doloribus quidem impedit.
//         Deserunt aut ab sed beatae officia aut ut quia. Velit provident dolores omnis ut. Minima nemo fugiat ad non nobis animi et veniam non. Qui eligendi occaecati quis eveniet deleniti. Cumque architecto molestiae tempora est ut quisquam. Ab delectus ea enim veritatis veritatis incidunt deserunt inventore autem.

//         Consequatur exercitationem est. Sed qui corrupti earum dolores qui quam dolorem officiis. Omnis veritatis quam sunt dolor illo eum nihil. In unde tenetur asperiores quis ea sit.

//         Magnam assumenda ex vel veritatis architecto molestiae. Iusto quo culpa et minima. Illo veniam voluptas ut.
//         ''',
//     date: DateTime.now(),
//   ),
//   NoteModel(
//     content:
//         'Iusto quo ducimus labore deserunt. Voluptatibus dolorem pariatur esse voluptatibus praesentium. Sed omnis eius sint.',
//     date: DateTime.now(),
//   ),
// ];
