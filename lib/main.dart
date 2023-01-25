import 'package:custom_from_widget/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/parent_chips.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => DataProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void fetchData(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).getInitCat();
  }

  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StateOne(),
    );
  }
}
