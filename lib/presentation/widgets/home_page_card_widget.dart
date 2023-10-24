import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.26),
              offset: const Offset(3, 3),
              spreadRadius: 2,
              blurRadius: 2
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10,),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
