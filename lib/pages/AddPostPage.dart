import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BlogPost {
  final String title;
  final String description;
  final File? image;
  final String category;

  BlogPost(
      {required this.title,
      required this.description,
      this.image,
      required this.category});
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  String? _selectedCategory;

  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _categories = [
    {'title': 'Food', 'icon': Icons.food_bank},
    {'title': 'Design', 'icon': Icons.design_services},
    {'title': 'Health', 'icon': Icons.health_and_safety},
    {'title': 'Cars', 'icon': Icons.directions_car},
    {'title': 'Journal', 'icon': Icons.book},
    {'title': 'Sky', 'icon': Icons.cloud},
    {'title': 'Drawing', 'icon': Icons.brush},
    {'title': 'UI/UX', 'icon': Icons.laptop},
    {'title': 'Others', 'icon': Icons.add},
  ];

  // Function to pick image from camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to remove selected image
  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  // Function to clear all fields and image
  void _clearFields() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _image = null;
      _selectedCategory = null;
    });
  }

  // Function to add post
  void _addPost() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedCategory != null) {
      final newPost = BlogPost(
        title: _titleController.text,
        description: _descriptionController.text,
        image: _image,
        category: _selectedCategory!,
      );
      Navigator.pop(context, newPost);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  // Function to open a modal with Camera/Gallery options
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomCategoryDialog() {
    String newCategory = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Custom Category'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter category name'),
            onChanged: (value) {
              newCategory = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (newCategory.isNotEmpty) {
                  setState(() {
                    _selectedCategory = newCategory;
                    if (!_categories
                        .any((category) => category['title'] == newCategory)) {
                      _categories
                          .add({'title': newCategory, 'icon': Icons.category});
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Force rebuild of DropdownButtonFormField
      setState(() {});
    });
  }

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
        actions: [
          TextButton(
            onPressed: _clearFields,
            child: const Text(
              'Clear',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _showImageSourceOptions,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image != null
                      ? Stack(
                          children: [
                            Image.file(
                              _image!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: GestureDetector(
                                onTap: _removeImage,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to add a picture',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['title'],
                    child: Row(
                      children: [
                        Icon(category['icon']),
                        const SizedBox(width: 10),
                        Text(category['title']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == 'Others') {
                    _showCustomCategoryDialog();
                  } else {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPost,
                child: const Text(
                  'Upload',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB81736),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
