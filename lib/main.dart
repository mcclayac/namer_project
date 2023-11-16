import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer 2 App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // ↓ Add this.
  // void getNext() {
  //   current = WordPair.random();
  //   notifyListeners();
  // }

  void getNext() {
      current = WordPair.random();
      notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A random AWSOME State idea 10:'),
          //Text(appState.current.asSnakeCase),
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
              // print('button pressed!');
            },
            child: Text('Next'),
          ),

        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Text(
          pair.asSnakeCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        )
        //child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}