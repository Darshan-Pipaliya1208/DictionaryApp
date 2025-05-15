import 'package:dictionary/SplashScreen.dart';
import 'package:dictionary/openWord.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/DicDatabaseHelper.dart';
import 'package:dictionary/WordMeaningClass.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DbHelper controller = DbHelper();
  List<words> allWords = [];
  List<words> searchList = [];
  bool searchEnabled = false;

  @override
  void initState() {
    super.initState();
    create();
  }

  void create() {
    controller.createdatabase().then((value) {
      controller.database = value;
      getData();
    });
  }

  void getData() {
    controller.getdata(controller.database!).then((value) {
      setState(() {
        allWords = value;
        searchList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Dictionary",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: searchEnabled
                  ? TextField(
                onChanged: (value) {
                  setState(() {
                    searchList = allWords
                        .where((e) => e.word
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Search word",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: Colors.deepPurple),
                    onPressed: () {
                      setState(() {
                        searchEnabled = false;
                        searchList = allWords;
                      });
                    },
                  ),
                ),
              )
                  : InkWell(
                onTap: () {
                  setState(() {
                    searchEnabled = true;
                    searchList = allWords;
                  });
                },
                borderRadius: BorderRadius.circular(25),
                child: IgnorePointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Search word...",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: searchList.isEmpty
                  ? Center(
                child: Text(
                  "No results found.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: searchList.length,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Openword(
                          word: searchList[index].word,
                          meaning: searchList[index].meaning ?? "No meaning available",
                        ),
                      ),
                    );
                    ;},
                      child: ListTile(
                        title: Text(
                          searchList[index].word,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        subtitle: Text(
                          searchList[index].meaning ?? "No meaning found.",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
