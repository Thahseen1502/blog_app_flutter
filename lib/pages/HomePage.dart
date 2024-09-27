import 'package:blog_app/pages/AddPostPage.dart';
import 'package:blog_app/pages/PostDetailsPage.dart';
import 'package:blog_app/pages/WelcomeScreen.dart';
import 'package:blog_app/pages/category.dart';
import 'package:blog_app/pages/notification.dart';
import 'package:blog_app/pages/profilePage.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:blog_app/pages/EditProfilePage.dart';

// class BlogPost {
//   final String title;
//   final String description;
//   final File? image;

//   BlogPost({required this.title, required this.description, this.image});
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = 'Username';
  File? profileImage;
  List<BlogPost> blogPosts = [];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  void addNewPost(BlogPost post) {
    setState(() {
      blogPosts.insert(0, post); // Insert new post at the top
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        centerTitle: true,
        title: !isSearching
            ? RichText(
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
              )
            : TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (query) {
                  // Add the functionality to filter/search the posts
                },
              ),
        actions: [
          !isSearching
              ? IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = true; // Show the search bar
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.cancel, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                    });
                  },
                ),
        ],
        backgroundColor: Color(0xffB81736),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffB81736),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            name: username,
                            profession: '',
                            dob: '',
                            about: '',
                            image: profileImage,
                          ),
                        ),
                      );

                      if (updatedData != null) {
                        setState(() {
                          username = updatedData['name'];
                          profileImage = updatedData['image'];
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : AssetImage('assets/profile_placeholder.png')
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('My Posts'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Saved Posts'),
              onTap: () {
                // Navigate to Saved Posts page
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text('Downloads'),
              onTap: () {
                // Navigate to Dowloads page
              },
            ),
            Spacer(), // Pushes Logout to the bottom
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
                Navigator.pushReplacementNamed(context, '/signIn');
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff2B1836)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Scrollable Categories Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryCard(title: 'Food', icon: Icons.food_bank),
                    CategoryCard(title: 'Design', icon: Icons.design_services),
                    CategoryCard(
                        title: 'Health', icon: Icons.health_and_safety),
                    CategoryCard(title: 'Cars', icon: Icons.directions_car),
                    CategoryCard(title: 'Journal', icon: Icons.book),
                    CategoryCard(title: 'Sky', icon: Icons.cloud),
                    CategoryCard(title: 'Drawing', icon: Icons.brush),
                    CategoryCard(title: 'UI/UX', icon: Icons.laptop),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: blogPosts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailsPage(
                                title: blogPosts[index].title,
                                description: blogPosts[index].description,
                                image: blogPosts[index].image,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (blogPosts[index].image != null)
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            FileImage(blogPosts[index].image!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                SizedBox(height: 10),
                                Text(
                                  blogPosts[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  blogPosts[index].description,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        LikeButton(),
                                        SizedBox(width: 10),
                                        // Replacing the DislikeButton with a comment icon
                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CommentDialog(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // Replacing the comment icon with a share icon
                                        IconButton(
                                          icon: Icon(Icons.share),
                                          onPressed: () {
                                            // Add functionality for sharing
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        SaveButton(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostPage(),
            ),
          );
          if (result != null && result is BlogPost) {
            addNewPost(result);
          }
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xffB81736),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Color(0xffB81736),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
                },
              ),
              SizedBox(width: 20), // Spacer between home and add icon
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Category Card Widget
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Placeholder for LikeButton
class LikeButton extends StatefulWidget {
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false; // To track the like state

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Animation duration
      curve: Curves.easeInOut,
      child: IconButton(
        icon: Icon(
          Icons.thumb_up,
          color: isLiked
              ? Colors.red
              : Colors.black, // Black before liked, red after
        ),
        onPressed: () {
          setState(() {
            isLiked = !isLiked; // Toggle like state
          });
        },
      ),
    );
  }
}

// class DislikeButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.thumb_down),
//       onPressed: () {
//         // Add functionality for Dislike button here
//       },
//     );
//   }
// }

// Placeholder for SaveButton
class SaveButton extends StatefulWidget {
  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isSaved = false; // To track save state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.bookmark,
        color: isSaved
            ? Colors.blue
            : Colors.black, // Grey before saved, blue after
      ),
      iconSize: 24,
      onPressed: () {
        setState(() {
          isSaved = !isSaved; // Toggle save state
        });
      },
    );
  }
}

// Placeholder for CommentDialog
class CommentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a Comment'),
      content: TextField(
        decoration: InputDecoration(hintText: "Type your comment"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Add functionality to post comment
            Navigator.of(context).pop();
          },
          child: Text('Post'),
        ),
      ],
    );
  }
}

// Placeholder for SearchDialog
class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search'),
      content: TextField(
        decoration: InputDecoration(hintText: "Enter search term"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Add functionality for search
            Navigator.of(context).pop();
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}
