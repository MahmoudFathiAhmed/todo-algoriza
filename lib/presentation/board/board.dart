import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/presentation/all/all.dart';
import 'package:todo_algoriza/presentation/completed/completed.dart';
import 'package:todo_algoriza/presentation/favourites/favourites.dart';
import 'package:todo_algoriza/presentation/schedule/schedule.dart';
import 'package:todo_algoriza/presentation/uncompleted/uncompleted.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tabs = [
      const Text(
        'All',
        style: TextStyle(fontSize: 17),
      ),
      const Text(
        'Completed',
        style: TextStyle(fontSize: 17),
      ),
      const Text(
        'Uncompleted',
        style: TextStyle(fontSize: 17),
      ),
      const Text(
        'Favourite',
        style: TextStyle(fontSize: 17),
      ),
    ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          shadowColor: grey2Clr,
          backgroundColor: Colors.white,
          title: const Text(
            'Board',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.black87,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Schedule()));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              tabs: tabs,
              // controller: controller,
              labelColor: Colors.black,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              indicatorColor: Colors.black,
              unselectedLabelColor: grey1Clr,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            ),
            Container(
              height: 3.5,
              color: grey2Clr,
            ),
            Expanded(
              child: TabBarView(
                  // controller: controller,
                  children: [
                    All(),
                    Completed(),
                    UnCompleted(),
                    Favourites(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
