import 'package:flutter/material.dart';
import 'news/home.dart';
import 'unsplash/Unsplash.dart';
import 'Menu.dart';
import 'day_calculator/DayCalculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeApp(),
        "Unsplash": (context) => Unsplash(),
        "News": (context) => NewsApp(),
        "DayCalculator": (context) => DayCalculator(),
      },
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Home Page 🏠"),
        centerTitle: true,
        // backgroundColor: Colors.black,
      ),
      drawer: Menu(),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg3.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Unsplash()),
                    );
                  },
                  color: Colors.deepOrange,
                  text: 'Unsplash API',
                  description: 'Explore and discover beautiful images from Unsplash.',
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsApp()),
                    );
                  },
                  color: Colors.green,
                  text: 'News App',
                  description: 'Stay informed with the latest news and headlines.',
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DayCalculator()),
                    );
                  },
                  color: Colors.white,
                  text: 'Day Calculator',
                  description: 'Calculate the day of the week for any date.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final String description;

  const AppButton({
    required this.onPressed,
    required this.color,
    required this.text,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [color.withOpacity(0.8), color.withOpacity(1.0)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.white,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
