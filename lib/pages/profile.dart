import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:project_flutter_fiebase/components/background2.dart';
import 'package:project_flutter_fiebase/components/authentication.dart';
import 'package:project_flutter_fiebase/pages/login.dart';
import 'package:project_flutter_fiebase/components/signin_google.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  final GoogleSignInAccount userGoogle = googleSignIn.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background2(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          userProfile(),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Color.fromARGB(255, 253, 71, 71),
                hoverColor: Color.fromARGB(255, 161, 13, 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(05)),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await handleSignOut().whenComplete(() => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => (Login())),
                      ));
                  AuthenticationHelper().signOut().then(
                        (_) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contex) => Login()),
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget userProfile({
    String urlImage,
  }) =>
      InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
            ),
            userGoogle?.photoUrl != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userGoogle.photoUrl))
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.png')),
            SizedBox(
              height: 20,
            ),
            userGoogle?.displayName == null
                ? Container(
                    child: Center(
                      child: Text(
                        user.email,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                : Container(
                    child: Center(
                      child: Text(
                        userGoogle.displayName,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Text(
                  userGoogle?.email ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
}
