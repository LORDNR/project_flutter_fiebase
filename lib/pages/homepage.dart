import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/pages/about.dart';
import 'package:project_flutter_fiebase/pages/addproduct.dart';
import 'package:project_flutter_fiebase/components/authentication.dart';
import 'package:project_flutter_fiebase/pages/chart.dart';
import 'package:project_flutter_fiebase/pages/login.dart';
import 'package:project_flutter_fiebase/pages/profile.dart';
import 'package:project_flutter_fiebase/components/signin_google.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  final TextEditingController _fname = TextEditingController();
  final TextEditingController _fprice = TextEditingController();
  final TextEditingController _ftype = TextEditingController();
  final TextEditingController _pos = TextEditingController();
  // Create a CollectionReference called _products that references the firestore collection
  final CollectionReference _foods =
      FirebaseFirestore.instance.collection('foods');

  Future<void> _Update([DocumentSnapshot documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _fname.text = documentSnapshot['fname'];
      _fprice.text = documentSnapshot['fprice'].toString();
      _ftype.text = documentSnapshot['ftype'].toString();
      _pos.text = documentSnapshot['pos'].toString();
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
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 80),
            child: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _fname,
                  decoration: const InputDecoration(labelText: 'Food Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _fprice,
                  decoration: const InputDecoration(
                    labelText: 'Food Price',
                  ),
                ),
                TextField(
                  controller: _ftype,
                  decoration: const InputDecoration(
                    labelText: 'Food Type',
                  ),
                ),
                TextField(
                  controller: _pos,
                  decoration: const InputDecoration(
                    labelText: 'Place of sale',
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: Colors.red,
                      hoverColor: Colors.red[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      hoverColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _foods
                            .doc(documentSnapshot.id)
                            .update({
                              "fname": _fname.text,
                              "fprice": double.parse(_fprice.text),
                              "ftype": _ftype.text,
                              "pos": _pos.text
                            })
                            .then((value) => print("Food Updated"))
                            .catchError((error) =>
                                print("Failed to update food: $error"));

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            )),
          );
        });
  }

  Future<void> _deleteFood(String foodID) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove Food?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box

                    _foods
                        .doc(foodID)
                        .delete()
                        .then((value) => print("Food Deleted"))
                        .catchError(
                            (error) => print("Failed to delete food: $error"));
                    // Close the dialog
                    Navigator.of(context).pop();

                    // Show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You have successfully deleted a food')));
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle:
        //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Text(
          "Foods",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Background(
        child: StreamBuilder(
          stream: _foods.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data.docs[index];
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Card(
                      color: Color.fromARGB(255, 157, 216, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 8,
                      child: Container(
                        child: Center(
                          child: ListTile(
                            title: Text(
                              documentSnapshot['fname'],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "ราคา : " +
                                  documentSnapshot['fprice'].toString() +
                                  " บาท" +
                                  "\n" +
                                  "ประเภทอาหาร" +
                                  " : " +
                                  documentSnapshot['ftype'].toString() +
                                  "\n" +
                                  "สถานที่ขาย" +
                                  " : " +
                                  documentSnapshot['pos'].toString(),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  // Press this button to edit a single product
                                  IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _Update(documentSnapshot)),
                                  // This icon button is used to delete a single product
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteFood(documentSnapshot.id)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    AddProduct(),
    Chart(),
    About(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
