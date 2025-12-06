// To parse this JSON data, do
//
//     final fetchNodeFlowArgModel = fetchNodeFlowArgModelFromJson(jsonString);

import 'dart:convert';

FetchNodeFlowArgModel fetchNodeFlowArgModelFromJson(String str) => FetchNodeFlowArgModel.fromJson(json.decode(str));

String fetchNodeFlowArgModelToJson(FetchNodeFlowArgModel data) => json.encode(data.toJson());

class FetchNodeFlowArgModel {
  FetchNodeInputData? inputData;

  FetchNodeFlowArgModel({
    this.inputData,
  });

  factory FetchNodeFlowArgModel.fromJson(Map<String, dynamic> json) => FetchNodeFlowArgModel(
    inputData: json["inputData"] == null ? null : FetchNodeInputData.fromJson(json["inputData"]),
  );

  Map<String, dynamic> toJson() => {
    "inputData": inputData?.toJson(),
  };
}

class FetchNodeInputData {
  String? pageId;
  String? widgetId;
  String? serverId;

  FetchNodeInputData({
    this.pageId,
    this.widgetId,
    this.serverId,
  });

  factory FetchNodeInputData.fromJson(Map<String, dynamic> json) => FetchNodeInputData(
    pageId: json["pageId"],
    widgetId: json["widgetId"],
    serverId: json["serverId"],
  );

  Map<String, dynamic> toJson() => {
    "pageId": pageId,
    "widgetId": widgetId,
    "serverId": serverId,
  };
}
