import 'package:aplikacija_projekat/front_end/home_screen/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';

/// Main home screen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> filters = HomeScreenTaskListBE.getHomeScreenFilters();
  String? filter;

  void _changeFilter(String newFilter) => setState(() => filter = newFilter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.appBar(_changeFilter, filters),
      body: HomeScreenBody(filter: filter)
    );
  }
}
///__________________________________________________________________________
/// Body of the HomeScreen widget - contains the refresh functionality
class HomeScreenBody extends StatefulWidget {

  final String? filter;

  const HomeScreenBody({Key? key, this.filter}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshableHomeScreenTaskList(filter: widget.filter);
  }
}
///_________________________________________________________________________
/// Bottom part of the appBar for the HomeScreen widget
///
/// TODO IZ NEKOG NEPOZNATOG RAZLOGA NISTA NE MOGU DA VIDIM KOD BOTTOM DELA ZA NAV BAR KAD JE OVAKAV KOD, A KAD STAVIM DA SE POJAVI SAMO JEDAN TEKST ONDA TO RADI KAKO TREBA
class HomeAppBar {
  static PreferredSizeWidget appBar(Function(String) changeFilter, List<String> filters) {
    return AppBar(
      title: const Text('Home Screen'),
      bottom: PreferredSize(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              return TextButton(
                  onPressed: () => changeFilter(filters[index]),
                  child: Text(filters[index])
              );
            }
        ),
        preferredSize: const Size.fromHeight(50)
      )
    );
  }
}

