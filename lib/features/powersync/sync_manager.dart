import 'dart:async';
import 'package:school_erp/features/powersync/db.dart';

class SyncStatusManager {
  SyncStatusManager._internal();
  static final SyncStatusManager _instance = SyncStatusManager._internal();
  factory SyncStatusManager() => _instance;

  // to be used for initial check
  bool isSyncing = false;
  StreamController<bool>? _syncController;

  StreamController<bool> get syncController {
    _syncController ??= StreamController<bool>.broadcast();
    return _syncController!;
  }

  Stream<bool> get syncStream => syncController.stream;

  void initialize() {
    if (_syncController?.isClosed ?? true) {
      _syncController = StreamController<bool>.broadcast();
    }

    db.statusStream.listen((status) {
      final isConnectedSyncing = status.connected && !(status.downloading || status.uploading);
      final notConnected = !status.connected;

      if (isConnectedSyncing || notConnected) {
        isSyncing = false;
        syncController.add(false);
      } else {
        isSyncing = true;
        syncController.add(true);
      }
    });
  }

  void dispose() {
    _syncController?.close();
    _syncController = null;
  }
}

final syncStatusManager = SyncStatusManager();
