import 'package:flutter/material.dart';
import 'left_action_demo_shell.dart';

class DebugDemoView extends StatelessWidget {
  const DebugDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftActionDemoScaffold(
      title: 'Debug Console',
      description:
          'Inspect logs, track breakpoints, and monitor runtime diagnostics.',
      highlights: const [
        LeftActionHighlight('Active Breakpoints', '4'),
        LeftActionHighlight('Warnings', '12'),
        LeftActionHighlight('Last Build', '2m ago'),
      ],
      trailingSection: const LeftActionDemoListSection(
        title: 'Latest Logs',
        items: [
          '[INFO] Auth service initialized',
          '[WARN] Missing locale strings detected',
          '[DEBUG] Experiment flag enabled: checkout_redesign',
        ],
      ),
    );
  }
}

