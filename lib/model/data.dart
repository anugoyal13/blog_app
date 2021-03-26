import 'package:blog_app/detailspage.dart';

class Data {
  String blogname;
  String image;
  String description;

 // List<Blogdetails> subtype;


  Data({this.blogname,this.image,this.description});



  Data.fromJson(Map<String, dynamic> json) {
    blogname=json["blogname"];
    image=json["image"];
    description=json["description"];
   // details[]


    //location_name=json["location_name"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogname'] = this.blogname;
    data['image'] = this.image;
    data['description']=this.description;


    //data['location_name'] = this.location_name;

  }  }

