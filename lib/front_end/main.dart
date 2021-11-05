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

  Future<bool> _popFunctions() async {
    if(NavigationFunctions.popFunctionStack.isEmpty) {
      return true;
    }
    else {
      int len = NavigationFunctions.popFunctionStack.length;
      NavigationFunctions.popFunctionStack[len - 1].call();
      NavigationFunctions.popFunctionStack.removeAt(len - 1);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _popFunctions,
      child: Navigator(
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
      ),
    );
  }
}

