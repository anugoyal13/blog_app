import 'package:blog_app/blogdetail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'blogpage.dart';
import 'model/data.dart';

class detailspage extends StatefulWidget {
  final Data listdata;
  detailspage({this.listdata});
  //final String blogname;
  // final String image;
  //subtype({this.blogname,this.image})
  @override
  _detailspageState createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  TextEditingController blognamecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("myblogs");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFFDE7),
      appBar: AppBar(
        title: Text(widget.listdata.blogname),
        elevation: 0,
        backgroundColor: Color(0xFFFDD835),
        shadowColor: Colors.yellowAccent,

        //leading: Icon(Icons.arrow_back,color: Colors.black),
        //actions: [(Icon(Icons.search,color: Colors.black))],

        flexibleSpace: ClipRRect(
            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(500),bottomRight: Radius.circular(500))),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(2000),
              topRight: Radius.circular(2000)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //stream:ref.where("blogname",isEqualTo:widget.blogname).snapshots,
            // builder: ,

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(widget.listdata.image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text(
                  widget.listdata.description,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                ),
              ),
            ),

            // InkWell(onTap: (){
            // widget.listdata.delete().whenComplete(() => Navigator.pop(context));
            // },
            // child: Icon(Icons.delete)),
          ],
        ),
      ),
    ));
  }
}
