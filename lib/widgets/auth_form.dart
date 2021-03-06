import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final bool isFbLoading;
  final void Function(String email, String userName, String password,
      bool isLogin, File image) submitFn;
  final void Function() fbLogin;
  AuthForm(this.submitFn, this.isLoading, this.fbLogin, this.isFbLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail, _userUserName, _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: const Text('Please pick profile photo!')));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail, _userUserName, _userPassword, _isLogin, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Card(
          elevation: 5,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _isLogin ? 'Log In' : 'Sign Up',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Enter valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email address',
                          icon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          )),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Username must be atleast four characters.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            icon: Icon(
                              Icons.account_box,
                              color: Colors.black,
                            )),
                        onSaved: (value) {
                          _userUserName = value;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be greater than seven characters. ';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                      ),
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      onPressed: _submit,
                      child: widget.isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 1,
                              backgroundColor: Colors.black,
                            )
                          : Text(_isLogin ? 'Login' : 'Signup'),
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (!widget.isLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_isLogin ? "Don't have account?" : ""),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                  _isLogin
                                      ? 'Register'
                                      : 'I already have account!',
                                  style: const TextStyle(color: Colors.blue)))
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLogin && !widget.isFbLoading)
          RaisedButton.icon(
            icon: Image.asset(
              'assets/images/fb.png',
              width: 25,
              height: 25,
            ),
            onPressed: widget.fbLogin,
            label: const Text('Login with facebook',
                style: const TextStyle(color: Colors.white)),
          ),
        if (widget.isFbLoading)
          RaisedButton(
            onPressed: () {},
            child: const CircularProgressIndicator(
                strokeWidth: 1, backgroundColor: Colors.black),
          )
      ]),
    );
  }
}
