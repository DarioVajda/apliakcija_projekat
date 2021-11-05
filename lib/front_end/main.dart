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
      theme: ThemeData.light(), // tema aplikacije
      home: const SafeArea(child: GlobalNavigation())
    );
  }
}

class GlobalNavigation extends StatelessWidget {
  const GlobalNavigation({Key? key}) : super(key: key);

  /// funkcija za WillPopScope
  Future<bool> _popFunctions() async {
    if(NavigationFunctions.popFunctionStack.isEmpty) {
      return true;
    } /// ako je stack prazan onda je vreme za napustanje aplikacije
    else {
      int len = NavigationFunctions.popFunctionStack.length;
      NavigationFunctions.popFunctionStack[len - 1].call();
      NavigationFunctions.popFunctionStack.removeAt(len - 1);
      return false;
    } /// ako ima funkcija u stack-u onda jos moze da se ide unazad
  }

  @override
  Widget build(BuildContext context) {
    /// detektuje system back button i poziva odgovarajuce funkcije za to:
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
      ), /// ovo je navigator koji se koristi za full screen prozore
    );
  }
}

