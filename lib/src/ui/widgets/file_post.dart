import 'dart:io';

import 'package:flutter/material.dart';

class FilePost extends StatelessWidget {
  
  String mProfileImage;
  File mPostImage;
  String mDescription;
  String mName;
  
  FilePost({
    this.mPostImage,
    this.mProfileImage = "https://lh3.googleusercontent.com/ogw/ADGmqu8kAPERL-6ysEhU-VMqYMynXAFpV8eyHYKMVPnBWw=s64-c-mo",
    this.mDescription = "Por favor, denuncio la calle Sanabria esquina Perez, hay un bache que no permite la circulación correcta de las personas.",
    this.mName = "David Rios"
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 12),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(mProfileImage),
                // backgroundImage: NetworkImage("https://lh3.googleusercontent.com/ogw/ADGmqu8kAPERL-6ysEhU-VMqYMynXAFpV8eyHYKMVPnBWw=s64-c-mo"),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    "0 days ago",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10
                    ),
                  )
                ],        
              )
            ],
          ),
          SizedBox(height: 6),
          Padding(
            child: Text(mDescription),
            padding: const EdgeInsets.symmetric(
              horizontal: 8
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 200,
            width: double.infinity,
            child: Image.file(mPostImage, fit: BoxFit.cover),
          )
        ],
      ),   
    );
  }
}