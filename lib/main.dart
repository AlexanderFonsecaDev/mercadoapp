import 'package:flutter/material.dart';
import 'ui/list_categories.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListCategoriesScreen(),
    );
  }
}