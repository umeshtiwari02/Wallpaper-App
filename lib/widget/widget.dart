import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_practice/models/photo_model.dart';
import 'package:chat_practice/pages/full_screen.dart';
import 'package:flutter/material.dart';

Widget wallpaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: const EdgeInsets.all(5),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: listPhotos.map((PhotosModel photosModel) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullScreen(imagePath: photosModel.src!.portrait!),
              ),
            );
          },
          child: Hero(
            tag: photosModel.src!.portrait!,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: photosModel.src!.portrait!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
