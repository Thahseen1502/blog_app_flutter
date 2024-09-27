import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String profession;
  final String dob;
  final String about;
  final File? image;

  EditProfilePage({
    required this.name,
    required this.profession,
    required this.dob,
    required this.about,
    this.image,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController professionController;
  late TextEditingController dobController;
  late TextEditingController aboutController;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    nameController = TextEditingController(text: widget.name);
    professionController = TextEditingController(text: widget.profession);
    dobController = TextEditingController(text: widget.dob);
    aboutController = TextEditingController(text: widget.about);
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _showImagePickerOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Picture'),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: TextSpan(
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
        backgroundColor: Color(0xffB81736),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff2B1836)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/profile_placeholder.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => _showImagePickerOptions(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffB81736),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ProfileTextField(
                controller: nameController,
                label: 'Name',
                hint: 'Enter your name',
              ),
              ProfileTextField(
                controller: professionController,
                label: 'Profession',
                hint: 'Enter your profession',
              ),
              ProfileTextField(
                controller: dobController,
                label: 'Date of Birth',
                hint: 'Enter your date of birth',
              ),
              ProfileTextField(
                controller: aboutController,
                label: 'About',
                hint: 'Tell something about yourself',
                maxLines: 4,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'profession': professionController.text,
                    'dob': dobController.text,
                    'about': aboutController.text,
                    'image': _image,
                  });
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffB81736),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;

  const ProfileTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.white38),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white38),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
