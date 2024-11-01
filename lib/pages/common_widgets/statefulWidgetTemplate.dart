import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate({super.key});

  @override
  _StatefulWidgetTemplateState createState() => _StatefulWidgetTemplateState();
}

class _StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(title: 'POGI SI EARL', content: [
      Center(child: Text('Mas pogi si Fred')),
    ]);
  }
}