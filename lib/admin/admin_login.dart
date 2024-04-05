import 'package:chat_practice/admin/add_wallpaper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
                padding:
                    const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 53, 51, 51),
                      Colors.black,
                    ], begin: Alignment.topLeft, end: Alignment.topRight),
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(width, 110.0))),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Let's start with\nAdmin",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30.0),
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: height / 2.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 50),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 2.0, top: 2.0),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 160, 160, 147),
                                      ),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: TextFormField(
                                      controller: userNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Username';
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username',
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 2.0, top: 2.0),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 160, 160, 147),
                                      ),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: TextFormField(
                                      controller: userPasswordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Password';
                                        }
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                GestureDetector(
                                  onTap: () {
                                    LoginAdmin();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 20.0),
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != userNameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Your id is not correct",
              style: TextStyle(fontSize: 18),
            ),
          ));
        }

        if (result.data()['password'] != userPasswordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Your password is not correct",
              style: TextStyle(fontSize: 18),
            ),
          ));
        } else {
          Route route = MaterialPageRoute(builder: (context) => const AddWallpaper());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
