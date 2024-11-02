import 'package:flutter/material.dart';
import 'package:helper/presentation/app/navigator_handler.dart';
import 'package:helper/presentation/app_wrapper.dart';
import 'package:helper/res/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hackathon 2024',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: themeLight,
      darkTheme: themeDark,
      builder: (_, child) => AppWrapper(child!),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サインイン'),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.6 / 2,
                    ),
                    child: TextFormField(
                      key: _key,
                      decoration: const InputDecoration(
                        hintText: 'ユーザ名',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('参加する'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
