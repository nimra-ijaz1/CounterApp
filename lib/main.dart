import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme(), // apply cute font globally
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------- SPLASH SCREEN ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CounterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.dancingScript(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Counter App",
                style: GoogleFonts.pacifico(
                  fontSize: 50,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- COUNTER SCREEN ----------------
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  // Load counter value from SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // Save counter value
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', _counter);
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    _saveCounter();
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Counter 💖", style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Count is:",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: GoogleFonts.dancingScript(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "decrement",
                  onPressed: _decrement,
                  backgroundColor: Colors.purpleAccent,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: "increment",
                  onPressed: _increment,
                  backgroundColor: Colors.pinkAccent,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Reset",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
