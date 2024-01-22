import 'package:flutter/material.dart';

import 'CompetitionsUpdatePage.dart';
import 'InternshipUpdatePage.dart';
import 'JobUpdatePage.dart';

class Top30builder extends StatelessWidget {
  const Top30builder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TabBar(
                tabs: [
                  Tab(
                    child: Text("internships"),
                  ),
                  Tab(
                    child: Text("jobs"),
                  ),
                  Tab(
                    child: Text("competitions"),
                  )
                ],
                isScrollable: true,
              ),
              Expanded(
                child: TabBarView(children: [
                  // 1st Tab
                  InternshipUpdateScreen(''),
                  // 2nd Tab
                  JobUpdateScreen(''),
                  // 3rd Tab
                  CompetitionUpdatesScreen(''),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
