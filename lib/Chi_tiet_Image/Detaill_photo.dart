

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPhoto extends StatefulWidget {
  String? image;
  String? userImage;
  String? name;
  String? docId;
  String? userId;
  int? downloads;
  DateTime? date;

  DetailsPhoto({
    required this.image,
    required this.userImage,
    required this.name,
    required this.docId,
    required this.userId,
    required this.downloads,
    required this.date,
  });

  @override
  State<DetailsPhoto> createState() => _DetailsPhotoState();
}

class _DetailsPhotoState extends State<DetailsPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.docId ?? 'defaultTag', // Tag phải trùng với tag ở widget trước
                    child: Container(
                      // ... (Nội dung chi tiết ảnh)
                      child: Image.network(
                        widget.image!,
                        height: 300, // Set the height of the image as needed
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    left: 6,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  // Additional overlay button
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.userImage!),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Uploads By: " + widget.name!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat("dd/MM/yyyy - hh:mm a ")
                    .format(widget.date!)
                    .toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.download,
                    size: 28,
                  ),
                  Text(
                    " " + widget.downloads!.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
            
          ),

          // Additional content in the ListView can be added here
        ],
      ),
    );
  }
}
