import 'package:flutter/material.dart';
import 'package:stoktakip/core/cache_manager.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<StatefulWidget> createState() => _LandingState();
}

class _LandingState extends State<LandingView> with CacheManager {
  @override
  void initState() {
    super.initState();
    loadToken();
  }

  loadToken() async {
    final token = await getToken();

    if (token != null) {
      navigateHome();
    } else {
      navigateLogin();
    }
  }

  navigateLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  navigateHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
