import 'dart:ui';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailspage.dart';
import 'model/data.dart';

class MyBlog extends StatefulWidget {
  @override
  _MyBlogState createState() => _MyBlogState();
}

class _MyBlogState extends State<MyBlog> {
  TextEditingController blognamecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("myblogs");
  Map<String, dynamic> blogtoadd;
  addBlog() {
    blogtoadd = {
      "blogname": blognamecontroller.text,
      "image": imagecontroller.text,
      "description": desccontroller.text,
    };
    ref.add(blogtoadd).whenComplete(() => Navigator.pop(context));
    blognamecontroller.text = " ";
    imagecontroller.text = " ";
    desccontroller.text = " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDD835),
      appBar: AppBar(
        //title: Text("Welcome to My Blogs"),
        elevation: 0,
        backgroundColor: Color(0xFFFDD835),

        //leading: Icon(Icons.arrow_back,color: Colors.black),
        //actions: [(Icon(Icons.search,color: Colors.black))],

        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(800)),
          child: Container(
            decoration: BoxDecoration(
              gradient: SweepGradient(
                endAngle: 7,
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.indigo,
                  Colors.purpleAccent,
                  Colors.white
                ],
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(600)),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Welcome to",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "My Blogs",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
          //  ),

          //  ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          blognamecontroller.text = " ";
          imagecontroller.text = " ";
          desccontroller.text = " ";
          showDialog(
              context: context,
              builder: (_) => Dialog(
                      child: Container(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: blognamecontroller,
                              decoration: InputDecoration(
                                  hintText: "Blog name",
                                  labelText: "blog name"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: imagecontroller,
                              decoration: InputDecoration(
                                  hintText: "Image", labelText: "image"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: desccontroller,
                              decoration: InputDecoration(
                                  hintText: "Description",
                                  labelText: "Description"),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            color: Colors.black45,
                            child: FlatButton(
                                onPressed: () {
                                  addBlog();
                                },
                                child: Text(
                                  "Create a new Blog",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    ),
                  )));
          // Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => detailspage()));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network(src),
            StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // List<Data> dataList=snapshot.data.docs.map((e) => Data.fromJson(e.data()));
                  List<Data> dataList = snapshot.data.docs
                      .map((e) => Data.fromJson(e.data()))
                      .toList();
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //reverse: true,
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // crossAxisCount: 2),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => detailspage(
                                        listdata: dataList[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              //height: 500,
                              // width: 600,
                              child: Column(
                                children: [
                                  Text(dataList[index].blogname,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Card(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            blognamecontroller.text =
                                                dataList[index].blogname;
                                            imagecontroller.text =
                                                dataList[index].image;
                                            desccontroller.text =
                                                dataList[index].description;
                                            showDialog(
                                                context: context,
                                                builder: (_) => Dialog(
                                                      child: Container(
                                                        height: 350,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        blognamecontroller,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "Blog name",
                                                                        labelText:
                                                                            "blog name"),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        imagecontroller,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "Image",
                                                                        labelText:
                                                                            "image"),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        desccontroller,
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            "Description",
                                                                        labelText:
                                                                            "Description"),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 25,
                                                                ),
                                                                Container(
                                                                  color: Colors
                                                                      .black45,
                                                                  child:
                                                                      FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            snapshot.data.docs[index].reference.update({
                                                                              "blogname": blognamecontroller.text,
                                                                              "image": imagecontroller.text,
                                                                              "description": desccontroller.text,
                                                                            });
                                                                            //   widget.listdata.ref.update(data) {
                                                                            //     "blogname": blognamecontroller.text,
                                                                            //   "image": imagecontroller.text,
                                                                            //   "description": desccontroller.text,
                                                                            // };
                                                                            //   ),
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "update",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold),
                                                                          )),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ));
                                          },
                                        ),
                                        Container(
                                          height: 100,
                                          width: 200,
                                          child: Image.network(
                                            dataList[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            snapshot.data.docs[index].reference
                                                .delete()
                                                .whenComplete(() =>
                                                    Navigator.pop(context));

                                          },
                                          child: Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

// class myblog extend
// s StatefulWidget {
//   @override
//   _myblogState createState() => _myblogState();
// }

// class _myblogState extends State<myblog> {
//   TextEditingController blognamecontroller=TextEditingController();
//   TextEditingController imagecontroller=TextEditingController();
//   final ref = FirebaseFirestore.instance.collection("myblogs");
//   Map<String,dynamic>blogtoadd;
//   addBlog(){
//     blogtoadd= {
//       "blogname": blognamecontroller.text,
//       "image": imagecontroller.text,
//     };
//     ref.add(blogtoadd).whenComplete(() => print("blog added"),);
//
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFDD835),
//       appBar: AppBar(
//         //title: Text("Welcome to My Blogs"),
//           elevation:0,
//          backgroundColor: Color(0xFFFDD835),
//
//         //leading: Icon(Icons.arrow_back,color: Colors.black),
//         //actions: [(Icon(Icons.search,color: Colors.black))],
//
//         flexibleSpace:ClipRRect(
//         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(800)),
//          child: Container(
//             decoration: BoxDecoration(
//               gradient: SweepGradient(
//                 endAngle: 7,
//                 colors: [Colors.red,Colors.orange,
//                   Colors.yellow,Colors.green,
//                   Colors.blue,Colors.indigo,Colors.purpleAccent,Colors.white],
//               ),
//             ),
//           ),
//
//        ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(bottomRight: Radius.circular(600)),
//         ),
//
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(180),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left:5),
//                 child: Text("Welcome to", style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600,),),
//               ),
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.only(left:10.0),
//                 child: Text("My Blogs", style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w600, ),),
//               ),
//               SizedBox(height: 80,)
//             ],
//           ),
//       //  ),
//
//     //  ),
//       ),
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         backgroundColor:Colors.black,
//         child: Icon(Icons.add),
//         onPressed: () {
//           showDialog(context:context,builder:(_)=>Dialog(
//               child:Container(
//                 height: 300,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         controller: blognamecontroller,
//                         decoration: InputDecoration(
//                             hintText: "Blog name",
//                             labelText: "blog name"
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         controller: imagecontroller,
//                         decoration: InputDecoration(
//                             hintText: "Image",
//                             labelText: "image"
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25,),
//                     Container(
//                       color: Colors.black45,
//                       child: FlatButton(
//                           onPressed:(){
//                             addBlog();
//
//                           } ,
//                           child:Text("Create a new Blog",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),)
//                       ),
//                     )
//
//                   ],
//                 ),
//
//
//               )
//           ));
//           // Navigator.push(
//           //    context, MaterialPageRoute(builder: (context) => detailspage()));
//         },
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//            // Image.network(src),
//             StreamBuilder(
//               stream: ref.snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasData) {
//                  // List<Data> dataList=snapshot.data.docs.map((e) => Data.fromJson(e.data()));
//                   List<Data> dataList=snapshot.data.docs.map((e) => Data.fromJson(e.data())).toList();
//                   return GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       reverse: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2),
//                       itemCount: dataList.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: (){
//                            Navigator.push(context,MaterialPageRoute(builder: (_)=>detailspage(listdata: dataList[index])));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Container(
//                               height:500 ,
//                               width:600 ,
//                               child: Column(
//                                 children: [
//                                   Text(dataList[index].blogname,
//                                       style:TextStyle(color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17)),
//                                   SizedBox(height: 15,),
//                                   Container(
//                                     height: 100,
//                                     width: 120,
//                                     child: Image.network(
//                                         dataList[index].image,fit: BoxFit.fill,),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//
//                 }
//                 else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
