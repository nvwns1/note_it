import 'package:hive/hive.dart';
part 'note.g.dart';



@HiveType(typeId: 0)

class Note extends HiveObject{
  @HiveField(0)
  String? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;


  Note({this.id,required this.title, required this.description});

  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description
    };
  }
}