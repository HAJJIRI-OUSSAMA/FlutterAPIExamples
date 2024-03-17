import 'package:dateappfinal/unsplash/screens/photo.page.dart';
import 'package:flutter/material.dart';

class Unsplash extends StatefulWidget {
  const Unsplash({super.key});

  @override
  State<Unsplash> createState() => _UnsplashState();
}

class _UnsplashState extends State<Unsplash> {
  @override
  Widget build(BuildContext context) {
    return PhotoPage();
  }
}

