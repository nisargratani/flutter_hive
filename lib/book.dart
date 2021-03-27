import 'package:hive/hive.dart';
part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String author;
  @HiveField(2)
  int pages;
  Book({this.author, this.name, this.pages});

  @override
  String toString() {
    return 'Book_Name:${this.name} and Book_Author:${this.author} and Pages:${this.pages}';
  }
}
