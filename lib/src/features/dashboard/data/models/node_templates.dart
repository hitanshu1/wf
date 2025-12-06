import 'dart:convert';
import 'package:flutter/material.dart';
import '../static_json.dart';
import 'workflow_node.dart';

class NodeTemplates {
  /// Builds available nodes from the embedded static JSON.
  /// This is synchronous and intended to provide a small default set
  /// while keeping the public API `getAvailableNodes()` the same.
  static List<WorkflowNode> getAvailableNodes() {
    try {
      final Map<String, dynamic> parsed = json.decode(flowUpdateJson) as Map<String, dynamic>;
      final data = parsed['data'] as Map<String, dynamic>?;
      if (data == null) return [];

      final workFlow = data['work_flow'] as Map<String, dynamic>?;
      if (workFlow == null || workFlow.isEmpty) return [];

      final firstFlow = workFlow.values.first as Map<String, dynamic>?;
      if (firstFlow == null) return [];

      final flowData = firstFlow['flowData'] as Map<String, dynamic>?;
      final actions = flowData != null ? flowData['actions'] as List<dynamic>? : null;

      if (actions == null || actions.isEmpty) return [];

      return actions.map((a) {
        if (a is Map<String, dynamic>) {
          return WorkflowNode.fromJson(a);
        }
        return WorkflowNode.create(
          type: NodeType.action,
          title: a.toString(),
          icon: Icons.extension,
          color: Colors.blue,
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}