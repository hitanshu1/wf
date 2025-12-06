import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/core/widgets/draggable_box.dart';
import 'package:kuick_workflow/src/core/widgets/interactive_viewer_example.dart';

/// Example page demonstrating InteractiveViewer with draggable boxes
class InteractiveViewerDemo extends StatefulWidget {
  const InteractiveViewerDemo({super.key});

  @override
  State<InteractiveViewerDemo> createState() => _InteractiveViewerDemoState();
}

class _InteractiveViewerDemoState extends State<InteractiveViewerDemo> {
  final List<BoxData> _boxes = [];

  @override
  void initState() {
    super.initState();
    _initializeBoxes();
  }

  void _initializeBoxes() {
    final colors = [
      Colors.red[400]!,
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.teal[400]!,
      Colors.pink[400]!,
      Colors.amber[400]!,
      Colors.indigo[400]!,
      Colors.cyan[400]!,
      Colors.lime[400]!,
      Colors.brown[400]!,
    ];
    
    final icons = [
      Icons.star,
      Icons.favorite,
      Icons.home,
      Icons.settings,
      Icons.person,
      Icons.work,
      Icons.school,
      Icons.shopping_cart,
      Icons.flight,
      Icons.music_note,
      Icons.sports_esports,
      Icons.restaurant,
    ];

    // Create boxes with proper spacing so they don't overlap
    // Each box is 150px wide, so we need at least 180px spacing
    const double spacing = 180.0;
    const int boxesPerRow = 5;
    
    for (int i = 0; i < 20; i++) {
      final row = i ~/ boxesPerRow;
      final col = i % boxesPerRow;
      
      _boxes.add(BoxData(
        id: 'box_$i',
        position: Offset(
          100.0 + col * spacing,
          100.0 + row * spacing,
        ),
        color: colors[i % colors.length],
        label: 'Box ${i + 1}',
        icon: icons[i % icons.length],
      ));
    }
  }

  void _updateBoxPosition(String id, Offset newPosition) {
    setState(() {
      final boxIndex = _boxes.indexWhere((box) => box.id == id);
      if (boxIndex != -1) {
        _boxes[boxIndex] = _boxes[boxIndex].copyWith(position: newPosition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Boxes Demo'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: InteractiveViewerExample(
        showControls: true,
        enableSplitScreen: false,
        minScale: 0.5,
        maxScale: 4.0,
        backgroundColor: Colors.grey[100],
        child: _buildCanvas(),
      ),
    );
  }

  Widget _buildCanvas() {
    return Container(
      width: 3000,
      height: 3000,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Draggable Boxes only
          ..._boxes.map((box) => DraggableBox(
            key: ValueKey(box.id),
            id: box.id,
            initialPosition: box.position,
            color: box.color,
            label: box.label,
            icon: box.icon,
            onPositionChanged: (newPosition) => _updateBoxPosition(box.id, newPosition),
          )),
        ],
      ),
    );
  }
}

class BoxData {
  final String id;
  final Offset position;
  final Color color;
  final String label;
  final IconData icon;

  BoxData({
    required this.id,
    required this.position,
    required this.color,
    required this.label,
    required this.icon,
  });

  BoxData copyWith({
    String? id,
    Offset? position,
    Color? color,
    String? label,
    IconData? icon,
  }) {
    return BoxData(
      id: id ?? this.id,
      position: position ?? this.position,
      color: color ?? this.color,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }
}

