import 'package:convenient_way_sender/app/data/models/route_model.dart';

class InfoUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? photoUrl;
  String? gender;
  List<RouteAcc>? routes;

  InfoUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.routes,
      this.gender,
      this.photoUrl});

  InfoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    photoUrl = json['photoUrl'];
    if (json['routes'] != null) {
      routes = <RouteAcc>[];
      json['routes'].forEach((v) {
        routes?.add(RouteAcc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['photoUrl'] = photoUrl;
    if (routes != null) {
      data['routes'] = routes?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
