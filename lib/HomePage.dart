import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Updates/UpdatesPages.dart';
import 'auth/authPage.dart';
import 'authenticatedFeaturesAccess/Notifications.dart';
import 'bottomNavigatorComponent/aboutUs.dart';
import 'careerPage/VolunteeringRegistrationForm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int scrollupdownIndex = 0;
  final GlobalKey _key0 = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  final GlobalKey _key4 = GlobalKey();
  final GlobalKey _key5 = GlobalKey();

  String selectedCompany = "Companies";
  String selectedJobType = "Role";
  List<String> companiesList = ['selected all', 'A', 'B', 'C'];
  List<String> jobRoleList = ['selected all', 'A', 'B', 'C'];
  String pageSelected = 'HOME';
  String isProfileSelected = 'profile';

  double stripPosition = 0.0;
  final double stripWidth = 1.0;

  final double animationSpeed = 1;

  @override
  void dispose() {
    super.dispose();
    dropDownButtonJobRole;
    dropDownButton;
    startAnimation;
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 16), () {
      setState(() {
        stripPosition += animationSpeed;
        if (stripPosition > MediaQuery.of(context).size.width) {
          stripPosition = -stripWidth;
        }
      });
      startAnimation();
    });
  }

  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          width < 600
              ? IconButton(
                  alignment: Alignment.topLeft,
                  tooltip: 'HOME',
                  onPressed: () async {
                    (setState(() {
                      pageSelected = 'HOME';
                      scrollupdownIndex = 0;
                    }));

                    await Scrollable.ensureVisible(
                      _key0.currentContext!,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 47, 74, 78),
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    (setState(() {
                      pageSelected = 'HOME';
                      scrollupdownIndex = 0;
                    }));

                    await Scrollable.ensureVisible(
                      _key0.currentContext!,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    "HOME",
                    style: GoogleFonts.alexandria(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          width < 600
              ? IconButton(
                  tooltip: 'IT-Companies',
                  onPressed: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (pageSelected != 'IT-Companies') {
                        setState(() {
                          pageSelected = 'IT-Companies';
                          scrollupdownIndex = 3;
                        });
                      } else {
                        setState(() {
                          scrollupdownIndex = 3;
                        });
                        await Scrollable.ensureVisible(
                          _key3.currentContext!,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      await displayMessage(context, "Please Sign In");
                      setState(() {
                        scrollupdownIndex = 2;
                      });
                      await Scrollable.ensureVisible(
                        _key2.currentContext!,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.cloud,
                    color: Color.fromARGB(255, 47, 74, 78),
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (pageSelected != 'IT-Companies') {
                        setState(() {
                          pageSelected = 'IT-Companies';
                          scrollupdownIndex = 3;
                        });
                      } else {
                        setState(() {
                          scrollupdownIndex = 3;
                        });
                        await Scrollable.ensureVisible(
                          _key3.currentContext!,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      await displayMessage(context, "Please Sign In");
                      setState(() {
                        scrollupdownIndex = 2;
                      });
                      await Scrollable.ensureVisible(
                        _key2.currentContext!,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    "IT-companies",
                    style: GoogleFonts.alexandria(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          width < 600
              ? IconButton(
                  tooltip: 'Non-IT Companies',
                  onPressed: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (pageSelected != 'Non-IT Companies') {
                        setState(() {
                          pageSelected = 'Non-IT Companies';
                        });
                      } else {
                        setState(() {
                          scrollupdownIndex = 3;
                        });
                        await Scrollable.ensureVisible(
                          _key3.currentContext!,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      await displayMessage(context, "Please Sign In");
                      setState(() {
                        scrollupdownIndex = 2;
                      });
                      await Scrollable.ensureVisible(
                        _key2.currentContext!,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.engineering_outlined,
                    color: Color.fromARGB(255, 47, 74, 78),
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (pageSelected != 'Non-IT Companies') {
                        setState(() {
                          pageSelected = 'Non-IT Companies';
                        });
                      } else {
                        setState(() {
                          scrollupdownIndex = 3;
                        });
                        await Scrollable.ensureVisible(
                          _key3.currentContext!,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      await displayMessage(context, "Please Sign In");
                      setState(() {
                        scrollupdownIndex = 2;
                      });
                      await Scrollable.ensureVisible(
                        _key2.currentContext!,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    "Non-IT-companies",
                    style: GoogleFonts.alexandria(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          IconButton(
              tooltip: 'Notification',
              onPressed: () async {
                setState(() {
                  pageSelected = 'HOME';
                  isProfileSelected = 'notification';
                  scrollupdownIndex = 1;
                });
                await Scrollable.ensureVisible(
                  _key1.currentContext!,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(
                Icons.notification_add_outlined,
                color: Color.fromARGB(255, 47, 74, 78),
              )),
          IconButton(
              tooltip: 'Profile',
              onPressed: () async {
                setState(() {
                  pageSelected = 'HOME';
                  isProfileSelected = 'profile';
                  scrollupdownIndex = 2;
                });
                await Scrollable.ensureVisible(
                  _key2.currentContext!,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 47, 74, 78),
              ))
        ],
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                key: _key0,
                height: height - 60,
                width: width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(
                        ((stripPosition % 250).toInt()), 96, 125, 139),
                    Colors.white,
                    Color.fromARGB(
                        255, ((stripPosition % 250).toInt()), 131, 209),
                    const Color.fromARGB(255, 154, 216, 242),
                  ]),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ClipRect(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: <Widget>[
                            Positioned(
                              left: stripPosition,
                              bottom: stripPosition % 60,
                              // width: 10,
                              child: IconButton(
                                splashColor:
                                    const Color.fromARGB(255, 9, 24, 231),
                                autofocus: true,
                                hoverColor: Colors.black,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.rocket_launch_rounded,
                                  color: Colors.white,
                                  size: width > 350
                                      ? stripPosition % 60
                                      : stripPosition % 50,
                                ),
                              ),
                            ),
                            Text("TOP108 INTERNSHIP",
                                style: GoogleFonts.acme(
                                  fontSize: width > 700 ? 70 : 50,
                                )),
                          ],
                        ),
                        Text("A Step Towards Empowering Employment !",
                            style: GoogleFonts.acme(
                              fontSize: width > 700 ? 30 : 20,
                            )),
                        width > 700
                            ? Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                          "assets/icon-512.png",
                                        ),
                                        // width: 348 - 25000 / (width + 1),
                                        height: 236 - 25000 / (width + 1),
                                        semanticLabel: 'TOP108INTERNSHIP',
                                      ),
                                      Column(
                                        children: [
                                          FloatingActionButton.extended(
                                              splashColor: const Color.fromARGB(
                                                  200, 163, 219, 244),
                                              hoverColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      30, 142, 156, 238),
                                              onPressed: () async {
                                                setState(() {
                                                  scrollupdownIndex = 4;
                                                });
                                                await Scrollable.ensureVisible(
                                                  _key4.currentContext!,
                                                  duration: const Duration(
                                                      milliseconds: 700),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              label: Text(
                                                "opportunities at 108",
                                                style: GoogleFonts.alata(
                                                    letterSpacing: 3),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          MouseRegion(
                                            onHover: (_) => setState(() {
                                              _isHovered = true;
                                            }),
                                            onExit: (event) => setState(() {
                                              _isHovered = false;
                                            }),
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  backgroundColor: _isHovered
                                                      ? Colors.white
                                                      : const Color.fromARGB(
                                                          30,
                                                          142,
                                                          156,
                                                          238), // Set the background color
                                                ),
                                                child: Text(
                                                  """
Recommended Startups'
Opportunity""",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.alata(
                                                      color: Colors.black,
                                                      letterSpacing: 3),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                          "assets/SHER_ROUND.png",
                                        ),
                                        // width: 348 - 25000 / (width + 1),
                                        height:
                                            (200 - 20000 / (width + 1)) * 0.6,
                                        semanticLabel: 'SHER',
                                      ),
                                      Image(
                                        image: const AssetImage(
                                          "assets/MS_Light.png",
                                        ),
                                        // width: 348 - 25000 / (width + 1),
                                        height:
                                            (200 - 20000 / (width + 1)) * 0.6,
                                        semanticLabel:
                                            'IN Partnership with MS Startups',
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                            "assets/icon-512.png",
                                          ),
                                          // width: (312 - 23000 / (width + 1)) ,
                                          height: height > 700
                                              ? (200 - 18000 / (width + 1)) *
                                                  0.9
                                              : (200 - 18000 / (width + 1)) *
                                                  0.7,
                                          semanticLabel: 'TOP30INTERNSHIP',
                                        ),
                                        Column(
                                          children: [
                                            FloatingActionButton.extended(
                                                splashColor:
                                                    const Color.fromARGB(
                                                        200, 163, 219, 244),
                                                hoverColor: Colors.white,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        30, 142, 156, 238),
                                                onPressed: () async {
                                                  setState(() {
                                                    scrollupdownIndex = 4;
                                                  });
                                                  await Scrollable
                                                      .ensureVisible(
                                                    _key4.currentContext!,
                                                    duration: const Duration(
                                                        milliseconds: 700),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                                label: Text(
                                                  "opportunities at 108",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.alata(
                                                      letterSpacing: 3),
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MouseRegion(
                                              onHover: (_) => setState(() {
                                                _isHovered = true;
                                              }),
                                              onExit: (event) => setState(() {
                                                _isHovered = false;
                                              }),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    backgroundColor: _isHovered
                                                        ? Colors.white
                                                        : const Color.fromARGB(
                                                            30,
                                                            142,
                                                            156,
                                                            238), // Set the background color
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    """
Recommended Startups'
Opportunity""",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.alata(
                                                        color: Colors.black,
                                                        letterSpacing: 3),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                            "assets/SHER_ROUND.png",
                                          ),
                                          // width: 348 - 25000 / (width + 1),
                                          height:
                                              (200 - 20000 / (width + 1)) * 0.6,
                                          semanticLabel: 'SHER',
                                        ),
                                        Image.asset(
                                          "MS_Light.png",
                                          height:
                                              (200 - 20000 / (width + 1)) * 0.6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        Stack(
                          children: [
                            Positioned(
                              left: stripPosition,
                              bottom: stripPosition % 90,
                              // width: 10,
                              child: IconButton(
                                splashColor: Colors.amber,
                                autofocus: true,
                                hoverColor: Colors.greenAccent,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.rocket_launch_rounded,
                                  color: Colors.white,
                                  size: stripPosition % 100,
                                ),
                              ),
                            ),
                            Text(
                              "Society of Humanity Education and Research",
                              style: GoogleFonts.abel(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: width > 700 ? 60 : 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                key: _key1,
                height: 2 * height / 3,
                child: const Scaffold(
                  body: NotificationScreen(),
                ),
              ),
              SizedBox(
                key: _key2,
                height: 5 * height / 6,
                child: Scaffold(
                  body: AuthPage(isProfileSelected),
                ),
              ),
              if (FirebaseAuth.instance.currentUser != null)
                pageSelected == 'Non-IT Companies'
                    ? SizedBox(
                        key: _key3,
                        height: height,
                        child: const Scaffold(
                          body: LatestUpdates("nonIT_"),
                        ),
                      )
                    : SizedBox(
                        key: _key3,
                        height: height,
                        child: const Scaffold(
                          body: LatestUpdates("IT_"),
                        ),
                      ),
              Container(
                key: _key4,
                height: width > 600 ? height + ((height + 10) / 3) : height,
                width: width,
                color: const Color.fromARGB(148, 78, 78, 221),
                child: const VolunteeringOpportunity(),
              ),
              Container(
                  key: _key5,
                  height: width > 800 ? (height + 10) / 4 : (height + 10) / 3,
                  width: width,
                  color: const Color.fromARGB(255, 178, 178, 243),
                  child: const AboutUsPage()),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'scrollupFloatButton',
            shape: const CircleBorder(eccentricity: 0),
            tooltip: '',
            backgroundColor: Colors.white24,
            splashColor: Colors.white,
            elevation: 8,
            focusElevation: 0,
            hoverColor: Colors.purple,
            onPressed: () {
              if (scrollupdownIndex > 0) {
                setState(() {
                  scrollupdownIndex -= 1;
                  if (FirebaseAuth.instance.currentUser == null &&
                      scrollupdownIndex == 3) {
                    scrollupdownIndex -= 1;
                  }
                });
                scrollupdownFunction();
              }
            },
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.black,
            ),
          ),
          FloatingActionButton.small(
            heroTag: 'scrolldownFloatButton',
            shape: const CircleBorder(eccentricity: 0),
            tooltip: '',
            backgroundColor: Colors.white24,
            splashColor: Colors.white,
            elevation: 8,
            focusElevation: 0,
            hoverColor: Colors.purple,
            onPressed: () {
              if (scrollupdownIndex < 5) {
                setState(() {
                  scrollupdownIndex += 1;
                  if (FirebaseAuth.instance.currentUser == null &&
                      scrollupdownIndex == 3) {
                    scrollupdownIndex += 1;
                  }
                });
                scrollupdownFunction();
              }
            },
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: height / 3,
          ),
          FloatingActionButton.small(
            heroTag: 'communityFloatButton',
            shape: const CircleBorder(eccentricity: 0),
            tooltip: 'community',
            backgroundColor: Colors.white24,
            splashColor: Colors.white,
            elevation: 8,
            focusElevation: 0,
            hoverColor: Colors.purple,
            onPressed: () {
              setState(() {
                pageSelected = 'HOME';
                isProfileSelected = 'communityPage';
                scrollupdownIndex = 2;
              });
              Scrollable.ensureVisible(
                _key2.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(
              Icons.people,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownButton(BuildContext context, List<String> list) {
    return DropdownButton(
      items: [
        for (String x in list)
          DropdownMenuItem(
              value: x,
              child: Text(
                x,
                style: GoogleFonts.alexandria(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ))
      ],
      onChanged: (selectedValue) {
        setState(() {
          selectedCompany = selectedValue!;
        });
      },
      icon: const Icon(Icons.download),
      iconSize: 25,
      isExpanded: true,
      iconEnabledColor: Colors.blueAccent,
      hint: Text(
        selectedCompany,
        style: GoogleFonts.alexandria(
            fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
      alignment: Alignment.topLeft,
      borderRadius: const BorderRadius.all(Radius.circular(
        20,
      )),
      dropdownColor: Colors.white,
    );
  }

  Widget dropDownButtonJobRole(BuildContext context, List<String> list) {
    return DropdownButton(
      items: [
        for (String x in list)
          DropdownMenuItem(
              value: x,
              child: Text(
                x,
                style: GoogleFonts.alexandria(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ))
      ],
      onChanged: (selectedValue_) {
        setState(() {
          selectedJobType = selectedValue_!;
        });
      },
      icon: const Icon(Icons.download),
      iconSize: 28,
      isExpanded: true,
      iconEnabledColor: Colors.blueAccent,
      hint: Text(
        selectedJobType,
        style: GoogleFonts.alexandria(
            fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
      alignment: Alignment.topLeft,
      borderRadius: const BorderRadius.all(Radius.circular(
        20,
      )),
      dropdownColor: Colors.white,
    );
  }

  bottomBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "TOP108 is powered by Society of Humanity Education and Research",
          style: GoogleFonts.alexandria(color: Colors.black),
        ),
        const AboutUsPage()
      ],
    );
  }

  void scrollupdownFunction() async {
    switch (scrollupdownIndex) {
      case 0:
        await Scrollable.ensureVisible(
          _key0.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
      case 1:
        await Scrollable.ensureVisible(
          _key1.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
      case 2:
        await Scrollable.ensureVisible(
          _key2.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
      case 3:
        await Scrollable.ensureVisible(
          _key3.currentContext!,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        break;
      case 4:
        await Scrollable.ensureVisible(
          _key4.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
      case 5:
        await Scrollable.ensureVisible(
          _key5.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
      default:
        await Scrollable.ensureVisible(
          _key0.currentContext!,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
        break;
    }
  }
}
