import 'package:flutter/material.dart';
import 'package:heroanimations/paginas/home.dart';

void main() {
  runApp(HeroAnimations());
}

class HeroAnimations extends StatelessWidget {
  const HeroAnimations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Hero Animations",
        home: Home());
  }
}
