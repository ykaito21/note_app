import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'ui/screens/home_screen.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.teal,
          ),
        ),
      ),
      // home: HomeScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/write': (context) => WriteScreen(),
      // },
      home: FutureBuilder(
        future: Hive.openBox('notes'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return _scaffold(
                Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                ),
              );
            else
              return HomeScreen();
          }
          // Although opening a Box takes a very short time,
          // we still need to return something before the Future completes.
          else
            return _scaffold(
              Center(
                child: CircularProgressIndicator(),
              ),
            );
        },
      ),
    );
  }

  Widget _scaffold(Widget child) {
    return Scaffold(
      appBar: AppBar(),
      body: child,
    );
  }
}
