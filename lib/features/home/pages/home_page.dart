import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            'https://www.euro-football.ru/images/gallery/58881096ebd87b37aa4bf19fc89097c6fb1d94df.jpg',
          ),
        ],
      ),
    );
  }
}
