import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/photo.model.dart';
import '../repository/photo.data.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  TextEditingController _ctr = TextEditingController();
  late Future<List<Photo>> photos;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      photos = getPhotos('BMW', page: currentPage);
    });
  }

  Future<void> _downloadImage(String url, String imageName) async {
    var response = await http.get(Uri.parse(url));
    var bytes = response.bodyBytes;

    final directory = await getExternalStorageDirectory();
    File imgFile = File('${directory!.path}/$imageName.png');
    await imgFile.writeAsBytes(bytes);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image downloaded successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctr,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 56, // Set the height to match the search field
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1; // Reset page when performing a new search
                        photos = getPhotos(_ctr.text, page: currentPage);
                      });
                    },
                    child: Icon(Icons.search, size: 30),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: photos,
                builder: (context, snp) {
                  if (snp.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: snp.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          child: GestureDetector(
                            onTap: () {
                              _downloadImage(snp.data![index].url, snp.data![index].name);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(snp.data![index].url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Text(
                                    snp.data![index].name,
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snp.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text('No Data', style: TextStyle(color: Colors.red));
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 1
                      ? () {
                    setState(() {
                      currentPage--;
                      photos = getPhotos(_ctr.text, page: currentPage);
                    });
                  }
                      : null,
                  icon: Icon(Icons.arrow_back),
                ),
                for (int i = currentPage - 1; i <= currentPage + 1; i++)
                  if (i > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = i;
                          photos = getPhotos(_ctr.text, page: currentPage);
                        });
                      },
                      child: Text(i.toString()),
                    ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentPage++;
                      photos = getPhotos(_ctr.text, page: currentPage);
                    });
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
