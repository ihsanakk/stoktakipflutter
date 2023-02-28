import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  void _handleSubmitted() {
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      showInSnackBar(LabelNames.LOGIN_VIEW_MESSAGE_INVALID_FORM, context);
    } else {
      form.save();
      if (_password == "password") {
        Future<SharedPreferences> prefs = SharedPreferences.getInstance();
        prefs.then((value) => {
              value.setString("username", _email!),
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', ModalRoute.withName('/home'))
            });
      } else {
        showInSnackBar(LabelNames.LOGIN_VIEW_MESSAGE_BAD_CREDENTIALS, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(LabelNames.LOGIN_VIEW_TITLE),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    key: const Key("_mobile"),
                    decoration: const InputDecoration(
                        labelText: LabelNames.LOGIN_VIEW_LABEL_EMAIL),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => {_email = value},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_EMAIL_REQUIRED;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: LabelNames.LOGIN_VIEW_LABEL_PASSWORD),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_PASSWORD_REQUIRED;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ButtonBar(
                    children: <Widget>[
                      ElevatedButton.icon(
                          onPressed: _handleSubmitted,
                          icon: const Icon(Icons.arrow_forward),
                          label:
                              const Text(LabelNames.LOGIN_VIEW_LOGIN_BUTTON)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
