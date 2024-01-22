import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'crudOperations.dart';
import 'materialCard.dart';

class InternshipUpdateScreen extends StatefulWidget {
  final String IT_or_nonIT;

  const InternshipUpdateScreen(this.IT_or_nonIT, {Key? key}) : super(key: key);

  @override
  State<InternshipUpdateScreen> createState() =>
      _InternshipUpdateScreenState(IT_or_nonIT);
}

class _InternshipUpdateScreenState extends State<InternshipUpdateScreen> {
  final String It_or_nonIT;
  late bool accessToken = false;
  _InternshipUpdateScreenState(this.It_or_nonIT);

  String selectedCompany = "all companies";
  String selectedJobType = "Role";
  List<String> companiesList = ['all companies'];
  List<String> jobRoleList = ['selected all', 'A', 'B', 'C'];

  List<String> itCompanies = [
    'all companies',
    'Google',
    'Apple',
    'Microsoft',
    'Oracle',
    'Adobe',
    'Salesforce',
    'SAP',
    'Intuit',
    'IBM',
    'ServiceNow',
    'Schneider Electric',
    'Automatic Data Processing',
    'Synopsys',
    'Palo Alto Networks',
    'Cadence Design Systems',
    'VMware',
    'Workday',
    'Dassault Systèmes',
    'Snowflake',
    'CrowdStrike',
    'Atlassian',
    'Constellation Software',
    'Autodesk',
    'Palantir',
    'Fortinet',
    'Datadog',
    'Trade Desk',
    'Mobileye',
    'Wolters Kluwer',
    'Amadeus IT Group',
    'MongoDB',
    'Veeva Systems',
    'Zscaler',
    'Ansys',
    'Splunk',
    'FICO',
    'Cloudflare',
    'Keysight',
    'HubSpot',
    'Kaspi.kz',
    'Zoom',
    'PTC',
    'Tyler Technologies',
    'FactSet',
    'Akamai',
    'Check Point Software',
    'NetApp',
    'Bentley Systems',
    'Dynatrace',
    'AppLovin',
    'Leidos',
    'EPAM Systems',
    'Samsara',
    'WiseTech Global',
    'Manhattan Associates',
    'SS&C Technologies',
    'Gen Digital',
    'Sage Group',
    'Enphase Energy',
    'ZoomInfo',
    'Okta',
    'NICE',
    'AspenTech',
    'Twilio',
    'Unity Software',
    'Zebra Technologies',
    'Ceridian',
    'Trimble',
    'UiPath',
    'Paycom',
  ];
  List<String> nonITcompanies = [
    'all companies',
    'Tata',
    'Tesla',
    'Schneider Electric',
    'Kaspi.kz',
    'Leidos',
    'WiseTech Global',
    'Manhattan Associates',
    'SS&C Technologies',
    'Gen Digital',
    'Sage Group',
    'Enphase Energy',
    'Zebra Technologies',
    'Ceridian',
    'Trimble',
    'Paycom',
    'National Instruments',
    'Toast',
    'CyberArk',
    'Globant',
    'CCC Intelligent Solutions',
    'Klaviyo',
    'Informatica',
    'Descartes Systems',
    'SPS Commerce',
    'Trend Micro',
    'Qualys',
    'New Relic',
    'Tata Elxsi',
    'BCG',
    'McKinsey & Company',
    'Bain & Company',
    'Kearney',
    'PwC',
    'KPMG',
    'Deloitte',
    'EY',
    'ZS Associates',
    'Alvarez & Marsal',
  ];
  CollectionReference get _product =>
      FirebaseFirestore.instance.collection("${It_or_nonIT}InternshipUpdates");

  fetchUserProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('publicUsers')
          .doc(user!.email)
          .get();

      setState(() {
        accessToken = snapshot['isAmbasdor'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("LOADING..  $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    if (It_or_nonIT == 'IT_') {
      setState(() {
        companiesList = itCompanies;
      });
    } else {
      setState(() {
        companiesList = nonITcompanies;
      });
    }

    fetchUserProfileData();
  }

  @override
  void dispose() {
    super.dispose();
    _product;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            It_or_nonIT == 'IT_' ? "IT companies" : "Non-IT companies",
            style: GoogleFonts.alexandria(
                fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
        ),
        actions: [
          // Container(
          //     decoration: BoxDecoration(
          //         color: Colors.white10,
          //         borderRadius: BorderRadius.circular(20)),
          //     alignment: Alignment.topLeft,
          //     margin: const EdgeInsets.all(2),
          //     width: 120,
          //     height: 35,
          //     child: dropDownButtonJobRole(context, jobRoleList)),
          SizedBox(
            width: width > 800 ? 60 : 20,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(2),
              width: 160,
              height: 35,
              child: dropDownButton(context, companiesList)),
          SizedBox(
            width: width > 800 ? 60 : 10,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _product.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.blueGrey,
              ),
            );
          } else if (streamSnapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (!streamSnapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            var numOfcard = width > 1600
                ? 4
                : width > 1200
                    ? 3
                    : width > 800
                        ? 2
                        : 1;
            final docs = streamSnapshot.data?.docs;

            if (docs != null) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, rowIndex) {
                  late int startingIndex = rowIndex * numOfcard;

                  if ((numOfcard > 1 && selectedCompany == 'all companies')) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < numOfcard; i++)
                          if (startingIndex + i < docs.length)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 250, 250, 250),
                                  ),
                                  gradient: const RadialGradient(colors: [
                                    Colors.white,
                                    Color.fromARGB(255, 216, 227, 245),
                                  ]),
                                ),
                                width: 370,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: addCard(context, _product,
                                      docs[startingIndex + i], accessToken),
                                ),
                              ),
                            ),
                      ],
                    );
                  } else if (docs[rowIndex]['company']
                              .toString()
                              .toLowerCase() ==
                          selectedCompany.toLowerCase() ||
                      numOfcard == 1) {
                    return addCard(
                        context, _product, docs[rowIndex], accessToken);
                  }
                  return const SizedBox(
                    height: 0,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.blueGrey,
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: accessToken == true
          ? FloatingActionButton.small(
              elevation: 5.0,
              shape: const CircleBorder(eccentricity: 1),
              onPressed: () {
                // Add new internship
                createOrUpdate(context, _product);
              },
              backgroundColor: Colors.black,
              focusColor: Colors.green[50],
              splashColor: Colors.amberAccent[100],
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : FloatingActionButton.small(
              elevation: 5.0,
              shape: const CircleBorder(eccentricity: 1),
              onPressed: () {
                // Add new functionality
              },
              backgroundColor: Colors.black,
              focusColor: Colors.green[50],
              splashColor: Colors.amberAccent[100],
              child: const Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
              ),
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

  // Widget dropDownButtonJobRole(BuildContext context, List<String> list) {
  //   return DropdownButton(
  //     items: [
  //       for (String x in list)
  //         DropdownMenuItem(
  //             value: x,
  //             child: Text(
  //               x,
  //               style: GoogleFonts.alexandria(
  //                   fontWeight: FontWeight.bold, color: Colors.blueAccent),
  //             ))
  //     ],
  //     onChanged: (selectedValue_) {
  //       setState(() {
  //         selectedJobType = selectedValue_!;
  //       });
  //     },
  //     icon: const Icon(Icons.download),
  //     iconSize: 28,
  //     isExpanded: true,
  //     iconEnabledColor: Colors.blueAccent,
  //     hint: Text(
  //       selectedJobType,
  //       style: GoogleFonts.alexandria(
  //           fontWeight: FontWeight.bold, color: Colors.blueAccent),
  //     ),
  //     alignment: Alignment.topLeft,
  //     borderRadius: const BorderRadius.all(Radius.circular(
  //       20,
  //     )),
  //     dropdownColor: Colors.white,
  //   );
  // }
}
