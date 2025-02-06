import 'package:flutter/material.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;

mixin SyncStatusCheck<T extends StatefulWidget> on State<T> {
  bool synced = false;

  void syncingCheck(VoidCallback onSynced) async {
    await ps.db.waitForFirstSync();
    if (mounted) {
      setState(() {
        synced = true;
      });
      onSynced();
    }
  }
}
