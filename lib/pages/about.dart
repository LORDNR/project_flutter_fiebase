import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "สมาชิกในกลุ่ม",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    image(
                      assetImage: AssetImage("assets/images/sian.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายคัมภีร์  กันตังกุล 6250110001  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/pup.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายปณฐนันท์ พัชประเสริฐสุข 6250110005  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/non.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายรัชชานนท์ สองเมือง 6250110009  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/palm.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายฐนิสพงศ์ ทรัพย์ทวีจรุง 6250110024  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                    image(
                      assetImage: AssetImage("assets/images/cus.jpg"),
                    ),
                    SizedBox(height: 10),
                    name(
                      text: Text(
                        "นายนวพงศ์ กาญจนพลฤทธิ์ 6250110031  ICM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class name extends StatelessWidget {
  const name({Key key, this.text}) : super(key: key);

  final Text text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB(255, 168, 220, 255),
        onPressed: () {},
        child: Row(
          children: [
            Image.asset(
              "assets/images/user.png",
              width: 35,
            ),
            SizedBox(width: 30),
            Expanded(
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}

class image extends StatelessWidget {
  const image({Key key, this.assetImage}) : super(key: key);

  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 115,
        width: 115,
        child: CircleAvatar(
          backgroundImage: assetImage,
        ),
      ),
    );
  }
}
