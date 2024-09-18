import 'package:e_property/Models/UserHomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryImage extends StatefulWidget {
  List<dynamic>? image;

  GalleryImage({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        PhotoViewGallery.builder(
          itemCount: widget.image!.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.image![index].toString()),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4,
            );
          },
          onPageChanged: (value) {
            setState(() {
              setState(() {
                currentIndex = value;
              });
            });
          },
        ),
        Positioned(
          bottom: 100,
          left: 20,
          child: Text(
            "Image ${currentIndex + 1}/${widget.image!.length}",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ));
  }
}
