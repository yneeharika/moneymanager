import 'package:flutter/material.dart';
import 'package:moneymanager/auth.dart';
import 'package:moneymanager/pages/helper.dart';
import 'package:moneymanager/pages/homepage.dart';
import 'package:moneymanager/pages/name.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future getName() async {
    String? name = await dbHelper.getName();
    if (name != null) {
      bool? auth = await dbHelper.getLocalAuth();
      if (auth != null && auth) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FingerPrintAuth(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddName(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Image.asset(
            "assets/images/icon.png",
            width: 64.0,
            height: 64.0,
          ),
        ),
      ),
    );
  }
}
