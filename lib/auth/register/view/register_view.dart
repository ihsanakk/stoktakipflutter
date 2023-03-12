import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stoktakip/auth/register/model/register_request_model.dart';
import 'package:stoktakip/auth/register/service/register_service.dart';
import 'package:stoktakip/core/cache_manager.dart';
import 'package:stoktakip/shared/enumLabel/label_names_enum.dart';

import '../../../shared/configuration/dio_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterView> with CacheManager {
  late final RegisterService registerService;

  @override
  void initState() {
    super.initState();
    registerService = RegisterService(CustomDio.getDio());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
      final response = await registerService
          .register(RegisterRequest(email: _email, password: _password));
      if (response != null) {
        navigateLogin();
        showInSnackBar(LabelNames.SUCCESS_REGISTER);
      } else {
        showInSnackBar(LabelNames.FAIL_REGISTER);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void navigateLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'),
        arguments: _email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(LabelNames.REGISTER_VIEW_TITLE),
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
                    decoration: InputDecoration(
                        labelText: LabelNames.LOGIN_VIEW_LABEL_EMAIL),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => {_email = value},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_EMAIL_REQUIRED;
                      } else if (!EmailValidator.validate(value)) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_INVALID_EMAIL;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
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
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                        labelText:
                            LabelNames.REGISTER_VIEW_LABEL_PASSWORD_CONFIRM),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_PASSWORD_REQUIRED;
                      } else if (value.length < 8) {
                        return LabelNames.LOGIN_VIEW_MESSAGE_INVALID_PASSWORD;
                      } else if (value != _passwordController.text) {
                        return LabelNames
                            .REGISTER_VIEW_MESSAGE_INVALID_PASSWORD;
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
                          label: Text(LabelNames.REGISTER_BUTTON_REGISTER)),
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
