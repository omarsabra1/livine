import 'package:app/categories/breakfast.dart';
import 'package:flutter/material.dart';

class Snacks extends StatelessWidget {
  const Snacks({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return Scaffold(
      appBar: AppBar(
        title: Text('Snacks'),
        centerTitle: true,
        elevation: 1.2,
        backgroundColor: Color(0xfff4361EE),
      ),
        body: GridView.count(crossAxisCount: 1, 
        children: [
            Category(
              image: 'images/calories/snacks/nuts.jpg',
              name: 'Mixed Nuts',
            ),
          Category(
            image: 'images/calories/snacks/red.jpg',
            name: 'Red pepper guacamole',
          ),
          Category(
            image: 'images/calories/snacks/yogurt.jpg',
            name: 'Yogurt with mixed berries',
          ),
          Category(
            image: 'images/calories/snacks/apple.jpg',
            name: 'Apple slices with peanut',
          ),
          Category(
            image: 'images/calories/snacks/cottage.jpg',
            name: 'Cottage cheese',
          ),
          Category(
            image: 'images/calories/snacks/cheese.jfif',
            name: 'Celery sticks with Cheese',
          ),
        ],));
  }
}