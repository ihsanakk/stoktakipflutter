import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../shared/configuration/dio_options.dart';
import '../model/login_request.dart';
import '../service/login_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginView> with CacheManager {
  late final LoginService loginService;

  @override
  void initState() {
    super.initState();
    loginService = LoginService(CustomDio.getDio());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 3),
    ));
  }

  bool _isLoading = false;

  void _handleSubmitted() async {
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      showInSnackBar(LabelNames.LOGIN_VIEW_MESSAGE_INVALID_FORM);
    } else {
      form.save();
      setState(() {
        _isLoading = true;
      });
      final response = await loginService
          .login(LoginRequest(email: _email, password: _password));
      if (response != null) {
        saveToken(response.token ?? '');
        saveUserMail(response.email ?? '');
        navigateHome();
        showInSnackBar(LabelNames.WELCOME_SNACK);
      } else {
        showInSnackBar(LabelNames.FAIL_LOGIN);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void navigateHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'));
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
                      } else if (!EmailValidator.validate(value)) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_INVALID_EMAIL;
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
                      } else if (value.length < 8) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_INVALID_PASSWORD;
                      }
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
                  ),
                  Center(
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : null),
                ],
              ),
            ),
          ),
        ));
  }
}
