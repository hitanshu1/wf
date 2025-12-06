import 'package:flutter/material.dart';
import 'left_action_demo_shell.dart';

class DeviceDemoView extends StatelessWidget {
  const DeviceDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftActionDemoScaffold(
      title: 'Connected Devices',
      description:
          'Manage simulator sessions, physical devices, and remote debugging targets.',
      highlights: const [
        LeftActionHighlight('Online Devices', '5'),
        LeftActionHighlight('Simulators', '3'),
        LeftActionHighlight('Remote Sessions', '2'),
      ],
      trailingSection: const LeftActionDemoListSection(
        title: 'Device Feed',
        items: [
          'Pixel 8 • Hot reload successful',
          'iPhone 15 • Screenshot captured',
          'QA Tablet • Crash log uploaded',
        ],
      ),
    );
  }
}

