

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final ScrollController _scrollController = ScrollController();

//   // Function to scroll down when the button is pressed
//   void scrollToBottom() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
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
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: 100, // Example list items
//         itemBuilder: (context, index) {
//           return ListTile(title: Text('Item $index'));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: scrollToBottom, // Call the function to scroll down
//         child: const Icon(Icons.arrow_downward),
//       ),
//     );
//   }
// }




// ########### section scroll

/*

// 1 -step
GlobalKey _containerKey = GlobalKey();


// 2nd step

Container(
  key: _containerKey,
  // other footer widgets
),

// 3rd  step

onPressed: () {
                setState(() {
                  pageSelected = 'Non-IT Companies';
                });
                Scrollable.ensureVisible(
                  _containerKey.currentContext!,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },




*/
