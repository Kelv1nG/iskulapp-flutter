import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/features/powersync/sync_manager.dart';

mixin SyncStatusCheck<T extends StatefulWidget> on State<T> {
  StreamSubscription<bool>? _subscription;
  bool isSyncing = true;

  void onSyncStatusChanged(bool syncingState, VoidCallback onSynced) {
    if (!syncingState) {
      setState(() => (isSyncing = false));
      onSynced();
      _subscription?.cancel();
    }
  }

  Future<void> syncingCheck(VoidCallback onSynced) async {
    if (syncStatusManager.isSyncing) {
      _subscription =
          syncStatusManager.syncStream.listen((syncingState) => onSyncStatusChanged(syncingState, onSynced));
    } else {
      setState(() => (isSyncing = false));
      onSynced();
    }
  }
}
