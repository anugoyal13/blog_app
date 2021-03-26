// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'blogpage.dart';
// import 'model/data.dart';
//
// class blogdetail_page extends StatefulWidget {
//   final Data listdata;
//   blogdetail_page({this.listdata});
//   @override
//   _blogdetail_pageState createState() => _blogdetail_pageState();
// }
//
// class _blogdetail_pageState extends State<blogdetail_page> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //appBar:AppBar(
//           //title: Text("Explore",style: TextStyle(),),
//        // ) ,
//         body:PageView(
//           children: [
//             Container(
//               height:MediaQuery.of(context).size.height ,
//                width:MediaQuery.of(context).size.width ,
//               child: Image.network(widget.listdata.image1,fit:BoxFit.fill,),
//             ),
//             Container(
//               height:MediaQuery.of(context).size.height*0.35 ,
//               child: Image.network(widget.listdata.image2,fit:BoxFit.fill),
//             ),
//             Container(
//               height:MediaQuery.of(context).size.height*0.35 ,
//               child: Image.network(widget.listdata.image3,fit:BoxFit.fill),
//             ),
//             Container(
//               height:MediaQuery.of(context).size.height*0.35 ,
//               child: Image.network(widget.listdata.image4,fit:BoxFit.fill),
//             ),
//           ],
//         ),
//
//       ),
//     );
//   }
// }
