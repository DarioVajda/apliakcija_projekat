import 'package:flutter/material.dart';
import 'screens_navigation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const SafeArea(child: GlobalNavigation())
    );
  }
}

class GlobalNavigation extends StatelessWidget {
  const GlobalNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch(settings.name) {
          case '/':
            builder = (BuildContext context) => const ScreensNavigation();
            break;
          default:
            builder = (BuildContext context) => Container();
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}

