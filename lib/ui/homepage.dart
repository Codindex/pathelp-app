import 'package:flutter/material.dart';

import '../model/index.dart';
import 'request_data.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => onClick<InterestPoint>(context),
              child: const Text("Fetch points")
            ),
            TextButton(
              onPressed: () => onClick<Category>(context),
              child: const Text("Fetch categories")
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onLogin(context),
        child: const Icon(Icons.person),
      ),
    );
  }

  void onClick<T extends Data>(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return RequestDataList<T>();
            }
        )
    );
  }

  void onLogin(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return const LoginPage();
            }
        )
    );
  }
}