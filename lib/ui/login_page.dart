import 'package:flutter/material.dart';

import '../network/response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your account info"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Enter your username"
              ),
              validator: (String? value) =>
                (value == null || value.isEmpty)
                  ? "Please enter your username"
                  : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Enter your password"
              ),
              obscureText: true,
              validator: (String? value) =>
                (value == null || value.isEmpty)
                  ? "Please enter your password"
                  : null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            return validation(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  void validation(BuildContext context) async {
    fetchLogin(
      _nameController.text,
      _passwordController.text
    );
    Navigator.of(context).pop();
  }
}

