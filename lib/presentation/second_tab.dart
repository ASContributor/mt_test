import 'package:flutter/material.dart';

import '../data/models/post.dart';

class SecondTab extends StatelessWidget {
  final Post postData;
  const SecondTab({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 81, 81),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, semanticLabel: 'Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(postData.avatar),
                  radius: 90,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                postData.first_name + ' ' + postData.last_name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                postData.email,
                style: TextStyle(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 126, 126, 126)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
