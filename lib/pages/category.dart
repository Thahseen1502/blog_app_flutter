import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(name: 'Food', icon: Icons.fastfood),
    CategoryItem(name: 'Design', icon: Icons.design_services),
    CategoryItem(name: 'Health', icon: Icons.health_and_safety),
    CategoryItem(name: 'Cars', icon: Icons.directions_car),
    CategoryItem(name: 'Journal', icon: Icons.book),
    CategoryItem(name: 'Sky', icon: Icons.cloud),
    CategoryItem(name: 'Drawing', icon: Icons.brush),
    CategoryItem(name: 'UI/UX', icon: Icons.laptop),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: const TextSpan(
            text: 'Blog',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff2B1836),
            ),
            children: [
              TextSpan(
                text: 'Spot',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff2B1836)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add functionality for when the category is clicked
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24, // Light overlay color
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(2, 4), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 40,
              color: Colors.white, // Icon color
            ),
            SizedBox(height: 10),
            Text(
              category.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
