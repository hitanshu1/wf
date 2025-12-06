// To parse this JSON data, do
//
//     final nodeConfigDataModel = nodeConfigDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:canvas_package/kuick_canvas.dart' hide Bottom;

import '../workflow_model.dart';

NodeConfigDataModel nodeConfigDataModelFromJson(String str) => NodeConfigDataModel.fromJson(json.decode(str));

String nodeConfigDataModelToJson(NodeConfigDataModel data) => json.encode(data.toJson());

class NodeConfigDataModel {
  String? title;
  String? subtitle;
  String? icon;
  String? color;
  NodeConfigPlusPositions? plusPositions;
  KuickNodeShape? shape;
  int? width;
  int? height;

  NodeConfigDataModel({
    this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.plusPositions,
    this.shape,
    this.width,
    this.height,
  });

  factory NodeConfigDataModel.fromJson(Map<String, dynamic> json) =>
      NodeConfigDataModel(
        title: json["title"],
        subtitle: json["subtitle"],
        icon: json["icon"],
        color: json["color"],
        plusPositions: json["plusPositions"] == null
            ? null
            : NodeConfigPlusPositions.fromJson(json["plusPositions"]),
        shape: json["shape"] == null
            ? null
            : KuickNodeShape.values.byName(json["shape"]),
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subtitle": subtitle,
    "icon": icon,
    "color": color,
    "plusPositions": plusPositions?.toJson(),
    "shape": shape?.name,
    "width": width,
    "height": height,
  };
}


class NodeConfigPlusPositions {
  List<Bottom>? top;
  List<Bottom>? bottom;
  List<Bottom>? left;
  List<Bottom>? right;

  NodeConfigPlusPositions({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory NodeConfigPlusPositions.fromJson(Map<String, dynamic> json) => NodeConfigPlusPositions(
    top: json["top"] == null ? [] : List<Bottom>.from(json["top"]!.map((x) => Bottom.fromJson(x))),
    bottom: json["bottom"] == null ? [] : List<Bottom>.from(json["bottom"]!.map((x) => Bottom.fromJson(x))),
    left: json["left"] == null ? [] : List<Bottom>.from(json["left"]!.map((x) => Bottom.fromJson(x))),
    right: json["right"] == null ? [] : List<Bottom>.from(json["right"]!.map((x) => Bottom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "top": top == null ? [] : List<dynamic>.from(top!.map((x) => x.toJson())),
    "bottom": bottom == null ? [] : List<dynamic>.from(bottom!.map((x) => x.toJson())),
    "left": left == null ? [] : List<dynamic>.from(left!.map((x) => x.toJson())),
    "right": right == null ? [] : List<dynamic>.from(right!.map((x) => x.toJson())),
  };
}
