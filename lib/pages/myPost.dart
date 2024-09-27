import 'package:flutter/material.dart';
import 'dart:io';

class BlogPost {
  final String title;
  final String description;
  final File? image;
  final String category;

  BlogPost({
    required this.title,
    required this.description,
    this.image,
    required this.category,
  });
}

class MyPostPage extends StatelessWidget {
  final List<BlogPost> posts;

  const MyPostPage({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
        title: const Text(
          'My Posts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: posts.isEmpty
          ? Center(
              child: const Text(
                'No Posts Yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (post.image != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.file(
                            post.image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2B1836),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Chip(
                              label: Text(
                                post.category,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xffB81736),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
