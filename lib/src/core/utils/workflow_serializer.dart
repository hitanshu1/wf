import 'dart:convert';
import '../../features/dashboard/data/models/workflow_node.dart';

class WorkflowSerializer {
  static Map<String, dynamic> serializeWorkflow(
      List<WorkflowNode> nodes,
      List<Connection> connections,
      ) {
    return {
      'version': '1.0',
      'nodes': nodes.map((node) => {
        'id': node.id,
        'type': node.type.toString(),
        'title': node.title,
        'subtitle': node.subtitle,
        'position': {
          'x': node.position.dx,
          'y': node.position.dy,
        },
        'config': node.config,
      }).toList(),
      'connections': connections.map((conn) => {
        'id': conn.id,
        'fromNodeId': conn.fromNodeId,
        'toNodeId': conn.toNodeId,
        'fromPort': conn.fromPort,
        'toPort': conn.toPort,
      }).toList(),
    };
  }

  static String serializeToJson(
      List<WorkflowNode> nodes,
      List<Connection> connections,
      ) {
    return jsonEncode(serializeWorkflow(nodes, connections));
  }
}