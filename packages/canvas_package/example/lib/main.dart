import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NodeFlowController<String> controller;
  final newNodeId = DateTime.now().microsecondsSinceEpoch.toString();
  final Map<String, int> _childCounts = {};

  @override
  void initState() {
    super.initState();
    controller = NodeFlowController<String>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Prepare initial nodes from JSON structure (you can change this)
    var initialList = KuickNodeData<String>.fromJson(
      {
        "nodes": [
          {
            "id": "n1",
            "type": "Chat Message",
            "data": "Root Node",
            "x": 100,
            "y": 100,
            "height": 170,
            "width": 250,
            "children": []
          },
        ]
      },
          (json) => json.toString(), // <--- convert JSON to String
    ).nodes ?? [];


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: KuickCanvas(
        controller: controller,
        initialNodes: initialList,
        nodeBuilder: (context, node) => _buildNodeCard(node),
        gridSize: 1,
        theme: NodeFlowTheme.dark,
      ),
    );
  }

  Map<String, dynamic> _getNodeConfig(String nodeType) {
    switch (nodeType) {
      case 'Chat Message':
        return {'color': Colors.orange, 'icon': Icons.chat_bubble_outline};
      case 'AI Agent':
        return {'color': Colors.blue, 'icon': Icons.smart_toy};
      case 'HTTP Request':
        return {'color': Colors.purple, 'icon': Icons.http};
      case 'Database':
        return {'color': Colors.green, 'icon': Icons.storage};
      case 'Condition':
        return {'color': Colors.green, 'icon': Icons.code};
      case 'Success':
        return {'color': Colors.green, 'icon': Icons.check_circle};
      case 'Email':
        return {'color': Colors.purple, 'icon': Icons.email};
      case 'Failure':
        return {'color': Colors.red, 'icon': Icons.error};
      default:
        return {'color': Colors.grey, 'icon': Icons.circle};
    }
  }

  Widget _buildNodeCard(Node<String> node) {
    final nodeType = node.type;
    final subtitle = node.data;
    final nodeConfig = _getNodeConfig(nodeType);

    return Container(
      width: Size(250, 170).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Colored header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: nodeConfig['color'] as Color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  nodeConfig['icon'] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    nodeType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content area
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.place, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      'Pos: (${node.position.value.dx.toStringAsFixed(0)}, '
                          '${node.position.value.dy.toStringAsFixed(0)})',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      _addChildNode(node.id);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add,color: Colors.blue,),
                        SizedBox(width: 4),
                        Text('Add Child'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addChildNode(String parentNodeId) {
    final parentNode = controller.getNode(parentNodeId);
    if (parentNode == null) {
      debugPrint('Parent node $parentNodeId not found');
      return;
    }

    final childIndex = _childCounts[parentNodeId] ?? 0;
    _childCounts[parentNodeId] = childIndex + 1;

    final parentPosition = parentNode.position.value;
    final parentSize = parentNode.size.value;

    const double verticalSpacing = 220.0;
    const double horizontalSpacing = 260.0;

    final horizontalOffset = _horizontalOffsetForChild(childIndex, horizontalSpacing);

    final projectedPosition = Offset(
      parentPosition.dx + parentSize.width / 2 - Size(250, 170).width / 2 + horizontalOffset,
      parentPosition.dy + parentSize.height + verticalSpacing,
    );

    final snappedPosition = _snapToGrid(projectedPosition);

    final newNodeId = DateTime.now().microsecondsSinceEpoch.toString();
    final newNodeType = _getNextNodeType(parentNode.type);
    final newNodeData = _getNodeData(newNodeType);

    final newNode = Node<String>(
      id: newNodeId,
      type: newNodeType,
      position: snappedPosition,
      data: newNodeData,
      size: Size(250, 170),
      inputPorts: [
        _createCenteredPort(
          id: 'in',
          position: PortPosition.top,
          nodeSize: Size(250, 170),
        ),
      ],
      outputPorts: [
        _createCenteredPort(
          id: 'out',
          position: PortPosition.bottom,
          nodeSize: Size(250, 170),
          multiConnections: true,
        ),
      ],
    );

    // Add node synchronously, then schedule connection on next frame so ports are registered.
    controller.addNode(newNode);
    _childCounts[newNodeId] = 0;

    // Use post frame callback to ensure node + ports are registered before creating connection.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        controller.createConnection(
          parentNodeId,
          'out',
          newNodeId,
          'in',
        );
      } catch (e) {
        // If the framework hasn't registered the ports yet, try a tiny delayed retry.
        Future.delayed(const Duration(milliseconds: 20), () {
          try {
            controller.createConnection(parentNodeId, 'out', newNodeId, 'in');
          } catch (err) {
            debugPrint('Failed to create connection: $err');
          }
        });
      }
    });
  }

  Offset _snapToGrid(Offset position) {
    final gridSize = controller.config.gridSize.value;
    return Offset(
      (position.dx / gridSize).round() * gridSize,
      (position.dy / gridSize).round() * gridSize,
    );
  }

  String _getNextNodeType(String currentType) {
    final types = [
      'Chat Message',
      'AI Agent',
      'HTTP Request',
      'Database',
      'Condition',
      'Success',
      'Email',
      'Failure',
    ];
    final currentIndex = types.indexOf(currentType);
    if (currentIndex >= 0 && currentIndex < types.length - 1) {
      return types[currentIndex + 1];
    }
    return types[0];
  }

  String _getNodeData(String nodeType) {
    switch (nodeType) {
      case 'Chat Message':
        return 'When Received';
      case 'AI Agent':
        return 'Process with AI';
      case 'HTTP Request':
        return 'Call API';
      case 'Database':
        return 'Store Data';
      case 'Condition':
        return 'If/Else logic';
      case 'Success':
        return 'Workflow Complete';
      case 'Email':
        return 'Send Email';
      case 'Failure':
        return 'Error Handling';
      default:
        return 'Node';
    }
  }

  Port _createCenteredPort({
    required String id,
    required PortPosition position,
    required Size nodeSize,
    bool multiConnections = false,
  }) {
    late Offset offset;
    switch (position) {
      case PortPosition.top:
      case PortPosition.bottom:
        offset = Offset(nodeSize.width / 2 - 24 / 2, 0);
        break;
      case PortPosition.left:
      case PortPosition.right:
        offset = Offset(0, nodeSize.height / 2 - 24 / 2);
        break;
    }

    return Port(
      id: id,
      name: id,
      position: position,
      offset: offset,
      multiConnections: multiConnections,
      // make ports connectable so `createConnection` works reliably
      isConnectable: true,
      showLabel: false,
    );
  }

  double _horizontalOffsetForChild(int index, double spacing) {
    if (index == 0) return 0;
    if (index.isOdd) {
      final magnitude = ((index + 1) / 2).ceilToDouble();
      return magnitude * spacing;
    }
    final magnitude = (index / 2).ceilToDouble();
    return -magnitude * spacing;
  }
}

