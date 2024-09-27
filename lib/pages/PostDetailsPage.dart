import 'package:flutter/material.dart';
import 'dart:io';

class PostDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final File? image;

  const PostDetailsPage({
    Key? key,
    required this.title,
    required this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Full-screen image
                    if (image != null)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    // Gradient overlay for better visibility of icons
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Back button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 16,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    // Save button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      right: 16,
                      child: IconButton(
                        icon: Icon(Icons.bookmark_border, color: Colors.white),
                        onPressed: () {
                          // Handle bookmark functionality
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Like Count
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.red),
                                SizedBox(width: 4),
                                Text('580',
                                    style: TextStyle(color: Colors.grey[800])),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Author Details and Follow Button
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'), // Replace with actual author image
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thahseen',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800]),
                                ),
                                Text(
                                  'Author',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                // Handle follow functionality
                              },
                              child: Text(
                                'Follow',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffB81736),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Description
                        Text(
                          description,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        // Add extra padding at the bottom to ensure content is not covered by the comment bar
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Comment Input Field fixed at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.fromLTRB(
                  16, 8, 16, 8 + MediaQuery.of(context).padding.bottom),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.send, color: Color(0xffB81736)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
