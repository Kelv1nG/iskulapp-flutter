import 'package:flutter/material.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class SampleSyncPage extends StatelessWidget {
  const SampleSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: "sync check", content: [
      SampleSyncCheckWidget(),
    ]);
  }
}

class SampleSyncCheckWidget extends StatefulWidget {
  const SampleSyncCheckWidget({super.key});

  @override
  SampleSyncCheckState createState() => SampleSyncCheckState();
}

class SampleSyncCheckState extends State<SampleSyncCheckWidget> {
  bool synced = false;

  @override
  void initState() {
    super.initState();
    _initializeSync();
  }

  void _initializeSync() async {
    await ps.db.waitForFirstSync();
    if (mounted) {
      setState(() {
        synced = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(synced ? 'has synced' : 'is syncing');
  }
}
