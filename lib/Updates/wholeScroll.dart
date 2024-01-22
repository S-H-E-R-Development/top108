// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState();
//   final ScrollController _scrollController = ScrollController();
//   final Map<String, double> sectionOffsets = {
//     'home': 0.0,
//     'company': 0.0, // You can set the offsets for other sections here
//   };

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Calculate the offsets for each section after the widgets are built
//       for (var key in sectionOffsets.keys) {
//         final keyContext = _scaffoldKey.currentContext?.findRenderObject();
//         final sectionContext = keyContext?.findRenderObject();
//         if (sectionContext != null) {
//           sectionOffsets[key] = sectionContext.localToGlobal(Offset.zero).dy;
//         }
//       }
//     });
//   }

//   void scrollToSection(String section) {
//     _scrollController.animateTo(
//       sectionOffsets[section] ?? 0.0,
//       duration: Duration(seconds: 1),
//       curve: Curves.fastOutSlowIn,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Scrolling App Bar Button'),
//       ),
//       body: ListView(
//         controller: _scrollController,
//         children: [
//           SectionWidget(sectionName: 'home', content: 'Home Section Content'),
//           SectionWidget(sectionName: 'company', content: 'Company Section Content'),
//           // Add more sections here
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: sectionOffsets.keys.map((section) {
//           return FloatingActionButton(
//             onPressed: () => scrollToSection(section),
//             child: Text(section),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class SectionWidget extends StatelessWidget {
//   final String sectionName;
//   final String content;

//   SectionWidget({required this.sectionName, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           Text(sectionName),
//           SizedBox(height: 10.0),
//           Text(content),
//         ],
//       ),
//     );
//   }
// }




  // Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: Container(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8),
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border.all(
  //                               style: BorderStyle.solid,
  //                               color: Colors.white24)),
  //                       width: 120,
  //                       height: 40,
  //                       child: dropDownButton(context, companiesList)),
  //                 ),