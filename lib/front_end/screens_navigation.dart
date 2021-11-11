import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';

///________________________________________________________________________________________________
/// Screen Pushing Funkcions:
class NavigationFunctions {
  static void Function(Widget screen) pushFullScreen = (screen) {};
  static void Function(Widget screen, BuildContext context) pushScreen = (screen, context) {};
  static void Function() popFullScreen = () {};
  static void Function(int screenIndex) gotoScreen = (screenIndex) {};
  static BuildContext? globalBuildContext;
  static List<Function> popFunctionStack = [];
} // ova klasa sadrzi staticke metode koje se pozivaju iz svih drugih delova front-end-a
///________________________________________________________________________________________________
/// Screens Navigation:
class ScreensNavigation extends StatefulWidget {
  const ScreensNavigation({Key? key}) : super(key: key);

  @override
  _ScreensNavigationState createState() => _ScreensNavigationState();
}

class _ScreensNavigationState extends State<ScreensNavigation> {

  List<BottomNavigationBarItem> navBarItems = [];
  List<Widget> screens = [];
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    activeIndex = 0;

    /// NavigationFunctions class initialization:
    /// region navBarItems = [...]
    navBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Feed'
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Tasks'
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chats'
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
      ),
    ];
    /// endregion
    /// region screens = [...]
    screens = [
      Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch(settings.name) {
            case '/':
              builder = (BuildContext context) => const HomeScreen();
              break;
            default:
              builder = (BuildContext context) => Container();
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        },
      ), /// Home
      const Center(child: Text('search')),
      Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch(settings.name) {
            case '/':
              builder = (BuildContext context) => const Center(child: Text('tasks'));
              break;
            default:
              builder = (BuildContext context) => Container();
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        },
      ),
      const Center(child: Text('chats')),
      const Center(child: Text('profile'))
    ];
    /// endregion
    /// region pushFullScreen = ...
    NavigationFunctions.pushFullScreen = (screen) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      NavigationFunctions.popFunctionStack.add(() => Navigator.pop(context));
    };
    /// endregion
    /// region pushScreen = ...
    NavigationFunctions.pushScreen = (screen, localContext) {
      Navigator.push(localContext, MaterialPageRoute(builder: (contex) => screen));
      NavigationFunctions.popFunctionStack.add(() => Navigator.pop(localContext));
    };
    /// endregion
    /// region globalBuildContext = context
    NavigationFunctions.globalBuildContext = context;
    /// endregion
    /// region List<Function> gotoFunctions = [...]
    List<Function> gotoFunctions = List.generate(
      screens.length,
      (index) => () {
        setState(() {
          activeIndex = index;
        });
      },
    );
    /// endregion
    /// region gotoScreen = ...
    NavigationFunctions.gotoScreen = (newScreenIndex) {
      int startIndex= activeIndex;
      NavigationFunctions.popFunctionStack.remove(gotoFunctions[newScreenIndex]);
      NavigationFunctions.popFunctionStack.add(gotoFunctions[startIndex]);
      setState(() => gotoFunctions[newScreenIndex].call());
    };
    /// endregion
  } // Inicijalizuju se navBarItems i screens

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar? navBar = BottomNavigationBar(
      items: navBarItems,
      currentIndex: activeIndex,
      onTap: (tappedIndex) => NavigationFunctions.gotoScreen(tappedIndex),
      backgroundColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ); // NavigationBar sa svim osobinama

    return Scaffold(
      body: IndexedStack(
        index: activeIndex,
        children: screens
      ), /// IndexedStack se koristi za glavnu navigaciju
      bottomNavigationBar: navBar
    );
  }
}
///________________________________________________________________________________________________