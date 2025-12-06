// To parse this JSON data, do
//
//     final errorRes = errorResFromJson(jsonString);

import 'dart:convert';

ErrorRes errorResFromJson(String str) => ErrorRes.fromJson(json.decode(str));

String errorResToJson(ErrorRes data) => json.encode(data.toJson());

class ErrorRes {
  String? error;
  String? message;

  ErrorRes({this.error, this.message});

  factory ErrorRes.fromJson(Map<String, dynamic> json) =>
      ErrorRes(error: json["error"], message: json["message"]);

  Map<String, dynamic> toJson() => {"error": error, "message": message};
}
