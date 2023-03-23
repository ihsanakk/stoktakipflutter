import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/inventory/view/inventory_view.dart';
import 'package:stoktakip/sales_mode/view/sales_mode_view.dart';
import 'package:stoktakip/shared/model/model_theme.dart';

import '../../inventory/viewmodel/product_model.dart';
import '../../other/view/bar_view.dart';
import '../../product_details/view/product_details_view.dart';
import '../../shared/enumLabel/label_names_enum.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> with CacheManager {
  int _currentIndex = 0;
  String? _userMail;
  void welcomeSnack(String value, BuildContext context) {
    if (value != '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(LabelNames.WELCOME_SNACK),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void loadUserMail() async {
    final mail = await getMail();

    setState(() {
      _userMail = mail;
    });
  }

  void _handleLogout() {
    removeToken();
    navigateLogin();
  }

  navigateLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  void initState() {
    super.initState();
    loadUserMail();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(LabelNames.HOME_POP_ARE_YOU_SURE),
            content: Text(LabelNames.HOME_POP_WANT_EXIT_APP),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: Text(LabelNames.HOME_POP_NO),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: Text(LabelNames.HOME_POP_YES),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LabelNames.INVENTORY_VIEW_APPBAR_TITLES[_currentIndex]),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://c4.wallpaperflare.com/wallpaper/992/545/78/abstract-shapes-hd-wallpaper-preview.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: const [
                    Positioned(
                      bottom: 8.0,
                      left: 4.0,
                      child: Text(
                        "Stok Takip",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.verified_user_rounded),
                title: Text(_userMail ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(LabelNames.LOGOUT),
                onTap: () {
                  _handleLogout();
                },
              ),
              ListTile(
                leading: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny),
                title: Text(LabelNames.CHANGE_THEME),
                onTap: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                },
              )
            ],
          ),
        ),
        body: WillPopScope(onWillPop: _onWillPop, child: body()),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black26,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.inventory_rounded),
                label: LabelNames.BOTTOM_NAVBAR_ITEM_1),
            BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_rounded),
                label: LabelNames.BOTTOM_NAVBAR_ITEM_2),
            BottomNavigationBarItem(
                icon: const Icon(Icons.qr_code_2_rounded),
                label: LabelNames.BOTTOM_NAVBAR_ITEM_3),
            BottomNavigationBarItem(
                icon: const Icon(Icons.history_rounded),
                label: LabelNames.BOTTOM_NAVBAR_ITEM_4),
          ],
          onTap: onTabTapped,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orangeAccent,
          iconSize: 32.0,
          currentIndex: _currentIndex,
        ),
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Product? _product;
  Widget body() {
    switch (_currentIndex) {
      case 0:
        return InventoryView(
          gotoProductPage: (product) {
            _product = product;
            setState(() {
              _currentIndex = 2;
            });
          },
        );
      case 1:
        return SalesMode(
          gotoProductPage: (product) {
            _product = product;
            setState(() {
              _currentIndex = 2;
            });
          },
        );
      case 2:
        return ProductView(
          product: _product,
          gotoInventoryPage: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        );
      case 3:
        return const Bar();
    }
    return const Bar();
  }

  // final List<Widget> _children = const [
  //   InventoryView(),
  //   SalesMode(),
  //   ProductView(),
  //   Bar(),
  // ];
}
