import 'package:flutter/material.dart';
import 'core/navigation/main_layout.dart'; // Yeni yazdığımız iskeleti import ediyoruz

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeYesem Mobil',
      home: MainLayout(), // Uygulama artık MainLayout ile başlıyor
    );
  }
}
