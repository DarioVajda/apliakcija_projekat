import 'package:flutter/material.dart';
import 'task_list_item.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';


/// Refreshable list
// koristim biblioteku "custom_refresh_indicator"
// mada mozda bih voleo jednom da napravim svoje za to, ali za sad je i ovo super
class RefreshableHomeScreenTaskList extends StatefulWidget {

  final String? filter;

  const RefreshableHomeScreenTaskList({Key? key, this.filter}) : super(key: key);

  @override
  State<RefreshableHomeScreenTaskList> createState() => _RefreshableHomeScreenTaskListState();
}

class _RefreshableHomeScreenTaskListState extends State<RefreshableHomeScreenTaskList> {

  ScrollController scrollController = ScrollController();
  List<TaskData> tasks = []; // lista zadataka koja se prikazuje

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        tasks = HomeScreenTaskListBE.getHomeScreenList(widget.filter);
      });
    });
  } // funkcija koja se poziva kad se refreshuje

  @override
  Widget build(BuildContext context) {
    tasks = HomeScreenTaskListBE.getHomeScreenList(widget.filter);
    return CustomRefreshIndicator(
        child: HomeScreenTaskList(
          tasks: tasks,
          scrollController: scrollController,
          filter: widget.filter
        ),
        onRefresh: () => onRefresh(),
        builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller
        ) {
          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Transform.translate(
                      offset: const Offset(0, 30),
                      child: CircularProgressIndicator(
                        value: !controller.isLoading
                            ? controller.value.clamp(0.0, 1.0)
                            : null,
                      )
                  ),
                  Transform.translate(
                    offset: Offset(0, 100.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            }
          );
        }
    );
  }
}

///______________________________________________________________________
/// List of tasks
class HomeScreenTaskList extends StatefulWidget {

  final ScrollController scrollController;
  final List<TaskData> tasks;
  final String? filter;

  const HomeScreenTaskList({
    Key? key,
    required this.scrollController,
    required this.tasks,
    this.filter
  }) : super(key: key);

  @override
  State<HomeScreenTaskList> createState() => _HomeScreenTaskListState();
}

class _HomeScreenTaskListState extends State<HomeScreenTaskList> {

  ScrollController scrollController = ScrollController();

  scrollListener(ScrollController sc) {
    // TODO - ovo cu morati da promenim jer ovo uopste nije optimalan nacin za ucitavanje novih podataka
    if(sc.position.maxScrollExtent == sc.offset) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          widget.tasks.addAll(HomeScreenTaskListBE.getHomeScreenList(widget.filter));
        });
      });
    }
  } // funkcija koja ucitava nove zadatke

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
    scrollController.addListener(() => scrollListener(scrollController)); // dodaje se listener
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      controller: scrollController,
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        Widget lastElem;
        if (index == widget.tasks.length - 1) {
          lastElem = Column(
            children: const [
              SizedBox(height: 15),
              CircularProgressIndicator(),
              SizedBox(height: 15)
            ],
          );
        }
        else {
          lastElem = Column(
            children: const [
              SizedBox(height: 6),
              Divider(
                  thickness: 1,
                  height: 12
              )
            ],
          );
        }
        return Column(
          children: [
            SingleTask(data: widget.tasks[index]),
            lastElem
          ],
        );
      }, // funkcija za bildovanje elemenata u listi
    );
  }
}
