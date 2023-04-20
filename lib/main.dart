import 'package:flutter/material.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/util/router_delegate.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story App',
      theme: ThemeData(
        colorScheme: AppStyle.myColorScheme,
        textTheme: AppStyle.myTextTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: AppStyle.myColorScheme,
        textTheme: AppStyle.myTextTheme,
      ),
      home: Router(
        routerDelegate: myRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
