import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/pages/homepage.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _fprice = TextEditingController();
  final TextEditingController _ftype = TextEditingController();
  final TextEditingController _pos = TextEditingController();

  final CollectionReference _foods =
      FirebaseFirestore.instance.collection('foods');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Add Food",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA),
                          fontSize: 36),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      // prevent the soft keyboard from covering text fields
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // email
                        TextFormField(
                          controller: _fname,
                          decoration: InputDecoration(
                              labelText: 'Food Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Food Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _fprice,
                          decoration: InputDecoration(
                              labelText: 'Food Price',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Food Price';
                            }
                            return null;
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _ftype,
                          decoration: InputDecoration(
                              labelText: 'Food Type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Food Type';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _pos,
                          decoration: InputDecoration(
                              labelText: 'Place of Sale',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Place of Sale';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 29,
                        ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNav()));
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
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await _foods
                                        .add({
                                          "fname": _fname.text,
                                          "fprice":
                                              double.tryParse(_fprice.text),
                                          "ftype": _ftype.text,
                                          "pos": _pos.text,
                                        })
                                        .then((value) => print("Food Added"))
                                        .catchError((error) => print(
                                            "Failed to add product: $error" +
                                                _fprice.text));

                                    _fname.text = '';
                                    _fprice.text = '';
                                    _ftype.text = '';
                                    _pos.text = '';

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => BottomNav()),
                                        (Route<dynamic> route) => false);
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
