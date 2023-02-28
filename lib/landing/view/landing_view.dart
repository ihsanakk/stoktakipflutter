import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<StatefulWidget> createState() => _LandingState();
}

class _LandingState extends State<LandingView> {
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((value) => {
          _username = (value.getString('username') ?? ""),
          if (_username == "")
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', ModalRoute.withName('/login')),
            }
          else
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', ModalRoute.withName('/home')),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
