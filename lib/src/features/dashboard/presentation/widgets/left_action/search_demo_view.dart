import 'package:flutter/material.dart';
import 'left_action_demo_shell.dart';

class SearchDemoView extends StatelessWidget {
  const SearchDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return LeftActionDemoScaffold(
      title: 'Search Workspace',
      description:
          'Find code, designs, or documents instantly with federated project search.',
      highlights: const [
        LeftActionHighlight('Indexed Services', '42'),
        LeftActionHighlight('Saved Queries', '7'),
        LeftActionHighlight('AI Smart Results', '92%'),
      ],
      trailingSection: const LeftActionDemoListSection(
        title: 'Recent Searches',
        items: [
          'error boundary implementation',
          'dark theme tokens',
          'deployment checklist',
        ],
      ),
    );
  }
}

