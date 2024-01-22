import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStudentsInfo extends StatefulWidget {
  final _mentor_userid;
  const MyStudentsInfo(this._mentor_userid, {Key? key}) : super(key: key);

  @override
  State<MyStudentsInfo> createState() => _MyStudentsInfoState(_mentor_userid);
}

class _MyStudentsInfoState extends State<MyStudentsInfo> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ClassController = TextEditingController();
  final TextEditingController _JoiningDateController = TextEditingController();
  final TextEditingController _FeePaidUptoController = TextEditingController();
  final TextEditingController _AddMessageForStuController =
      TextEditingController();

  CollectionReference get _productss =>
      FirebaseFirestore.instance.collection('StudentsDetails_$mentor_userid');

  final mentor_userid;
  _MyStudentsInfoState(this.mentor_userid);

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _ClassController.text = documentSnapshot['Class'];
      _JoiningDateController.text = documentSnapshot['JoiningDate'];
      _FeePaidUptoController.text = documentSnapshot['FeePaidUpto'];
      _AddMessageForStuController.text = documentSnapshot['AddMessageForStu'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(labelText: 'Name of Student'),
                ),
                TextField(
                  controller: _ClassController,
                  decoration:
                      const InputDecoration(labelText: 'Class of Student'),
                ),
                TextField(
                  controller: _JoiningDateController,
                  decoration: const InputDecoration(labelText: 'Joining Date'),
                ),
                TextField(
                  controller: _FeePaidUptoController,
                  decoration: const InputDecoration(labelText: 'Fee Paid Upto'),
                ),
                TextField(
                  controller: _AddMessageForStuController,
                  decoration:
                      const InputDecoration(labelText: 'Additional Message'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String Class = _ClassController.text;
                    final String JoiningDate = _JoiningDateController.text;
                    final String FeePaidUpto = _FeePaidUptoController.text;
                    final String AddMessageForStu =
                        _AddMessageForStuController.text;

                    if (action == 'create') {
                      // Persist a new product to Firestore
                      await _productss.add({
                        "name": name,
                        "Class": Class,
                        "JoiningDate": JoiningDate,
                        "FeePaidUpto": FeePaidUpto,
                        "AddMessageForStu": AddMessageForStu,
                      });

                      if (action == 'update') {
                        // Update the product
                        await _productss.doc(documentSnapshot!.id).update({
                          "name": name,
                          "Class": Class,
                          "JoiningDate": JoiningDate,
                          "FeePaidUpto": FeePaidUpto,
                          "AddMessageForStu": AddMessageForStu,
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _ClassController.text = '';
                      _JoiningDateController.text = '';
                      _FeePaidUptoController.text = '';
                      _AddMessageForStuController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully a Student Data')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          'My Students Details',
          style: GoogleFonts.patuaOne(
              textStyle: const TextStyle(color: Colors.white)),
        ),
      )),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        // height: 80,
                        margin: const EdgeInsets.only(
                            bottom: 5.0, left: 5.0, right: 5.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "${index + 1}.    ${documentSnapshot['name']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.amber,
                              onHighlightChanged: (value) => Colors.green,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30.0),
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: null,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Class  ${documentSnapshot['Class']}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.purple,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30.0),
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: null,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Joined On  ${documentSnapshot['JoiningDate']}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.green,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30.0),
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: null,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Fee Paid Upto  ${documentSnapshot['FeePaidUpto']}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              splashColor: Colors.blue,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30.0),
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: null,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Remarks :  ${documentSnapshot['AddMessageForStu']}",
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot)),
                            const SizedBox(
                              width: 6,
                            ),
                            // This icon button is used to delete a single product
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteProduct(documentSnapshot.id)),
                          ],
                        ),
                      ),

                      // Text(documentSnapshot['name']),
                      // Text(documentSnapshot['Class'])
                    ],
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text("Finished"),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
