// الملف ده: جذر الأب (Root Widget).
// وظيفته: يجمع الـ Cubits كلها (Auth/Rides/Requests) + الثيم (Light/Dark) + الراوتر (GoRouter).
// اللي هيشتغل هنا: يضيف أي Cubit جديد في MultiBlocProvider بس، وممنوع يكتب UI هنا.

import 'package:flutter/material.dart';

class SikkaApp extends StatelessWidget {
  const SikkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: رجع MaterialApp.router هنا + ضيف MultiBlocProvider
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Sikka - ابدأ من هنا'))),
    );
  }
}
