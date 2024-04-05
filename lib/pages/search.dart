import 'dart:convert';

import 'package:chat_practice/models/photo_model.dart';
import 'package:chat_practice/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = new TextEditingController();
  bool search = false;
  // API key
  // uUQMq7J0DDpJXOs8UPNLxU6q0yecuV9Tt4tiSIRrcrcnLgeP55z5JUXZ

  getSearchWallpaper(String searchQuery) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30"),
        headers: {
          "Authorization":
              "uUQMq7J0DDpJXOs8UPNLxU6q0yecuV9Tt4tiSIRrcrcnLgeP55z5JUXZ"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {
        search = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Search",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      getSearchWallpaper(searchController.text);
                    },
                    child: search
                        ? GestureDetector(
                            onTap: () {
                              photos = [];
                              search = false;
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.close,
                            ),
                          )
                        : const Icon(
                            Icons.search_outlined,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: wallpaper(photos, context))
          ],
        ),
      ),
    );
  }
}
