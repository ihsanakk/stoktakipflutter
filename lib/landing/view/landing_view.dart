import 'package:flutter/material.dart';
import 'package:stoktakip/core/cache_manager.dart';
// import 'package:stoktakip/landing/service/landing_service.dart';
// import 'package:stoktakip/shared/configuration/dio_options.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<StatefulWidget> createState() => _LandingState();
}

class _LandingState extends State<LandingView> with CacheManager {
  // late final LandingService landingService;

  @override
  void initState() {
    super.initState();
    // landingService = LandingService(CustomDio.getDio());
    loadToken();
  }

  loadToken() async {
    final token = await getToken();
    if (token != null) {
      validateLogin();
    } else {
      navigateLogin();
    }
  }

  _isLoginExpired() async {
    int loginTimeStamp = await getLoginDate() ?? 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(loginTimeStamp);
    Duration duration = DateTime.now().difference(dateTime);
    int minutes = duration.inMinutes;
    // 24*60 = 1440 mins => token expires
    int expiredAt = 1440 - 2; // -2 minutes margin for request timeouts
    if (minutes > expiredAt) {
      return true;
    }
    return false;
  }

  validateLogin() async {
    var result = await _isLoginExpired();
    if (!result) {
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
