import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CompetitionsUpdatePage.dart';
import 'InternshipUpdatePage.dart';
import 'JobUpdatePage.dart';

class LatestUpdates extends StatefulWidget {
  final String s;
  const LatestUpdates(this.s, {super.key});

  @override
  State<LatestUpdates> createState() => _LatestUpdatesState(s);
}

class _LatestUpdatesState extends State<LatestUpdates> {
  final String IT_or_NonIT;
  _LatestUpdatesState(this.IT_or_NonIT);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "internships",
                      style: GoogleFonts.alexandria(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "jobs",
                      style: GoogleFonts.alexandria(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "competitions",
                      style: GoogleFonts.alexandria(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
                isScrollable: true,
                automaticIndicatorColorAdjustment: true,
                splashFactory: InkRipple.splashFactory,
                indicatorColor: const Color.fromARGB(255, 1, 0, 8),
                indicatorWeight: 3,
              ),
              Expanded(
                child: TabBarView(children: [
                  // 1st Tab
                  InternshipUpdateScreen(IT_or_NonIT),
                  // 2nd Tab
                  JobUpdateScreen(IT_or_NonIT),
                  // 3rd Tab
                  CompetitionUpdatesScreen(IT_or_NonIT)
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
