import 'dart:io';
import 'package:hive_demo/book.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(BookAdapter());
  await Hive.openBox<Book>("book");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String key;
  String deleteKey;
  String value;
  Box<Book> bookBox;
  @override
  void initState() {
    bookBox = Hive.box<Book>('book');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hive'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (newValue) {
                  key = newValue;
                },
              ),
              TextField(
                onChanged: (newValue) {
                  value = newValue;
                },
              ),
              FlatButton(
                onPressed: () {
                  for (int i = 0; i < bookBox.values.length; i++) {
                    print(bookBox.keyAt(i));
                    print(bookBox.getAt(i).toString());
                  }
                },
                color: Colors.red,
                child: Text('Show'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      Book book =
                          Book(author: 'Nisarg', name: value, pages: 126);
                      bookBox.put(key, book);
                      print('Added');
                    },
                    color: Colors.red,
                    child: Text('Add'),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Update is same as Add,You can use Add in used key for Update.
                    },
                    color: Colors.red,
                    child: Text('Update'),
                  ),
                  FlatButton(
                    onPressed: () {
                      bookBox.delete(deleteKey);
                      print('deleted');
                    },
                    color: Colors.red,
                    child: Text('Delete'),
                  ),
                ],
              ),
              TextField(
                onChanged: (newValue) {
                  deleteKey = newValue;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
