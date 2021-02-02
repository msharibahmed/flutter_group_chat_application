import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
      String email, String userName, String password, bool isLogin) submitFn;
  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail, _userUserName, _userPassword;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail, _userUserName, _userPassword, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
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
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Enter valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email address',
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        )),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
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
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be greater than seven characters. ';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(
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
                        ? CircularProgressIndicator(strokeWidth: 1,backgroundColor: Colors.black,)
                        : Text(_isLogin ? 'Login' : 'Signup'),
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if(!widget.isLoading)
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
                              _isLogin ? 'Register' : 'I already have account!',
                              style: TextStyle(color: Colors.blue)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
