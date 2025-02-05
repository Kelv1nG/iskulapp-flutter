import 'dart:async';
import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';

class SyncStatusManager {
// to be used for initial check
  bool isSyncing = true;
  StreamController<bool>? _syncController;
  StreamSubscription<SyncStatus>? _dbStatusSubscription;

  SyncStatusManager._internal();
  static final SyncStatusManager _instance = SyncStatusManager._internal();
  factory SyncStatusManager() => _instance;

  StreamController<bool> get syncController {
    _syncController ??= StreamController<bool>.broadcast();
    return _syncController!;
  }

  Stream<bool> get syncStream => syncController.stream;

  void initialize() {
    if (_syncController?.isClosed ?? true) {
      _syncController = StreamController<bool>.broadcast();
    }

    _dbStatusSubscription = db.statusStream.listen((status) {
      final isConnectedSyncing =
          status.connected && !(status.downloading || status.uploading);
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
    _dbStatusSubscription?.cancel();
    _dbStatusSubscription = null;
    // succeeding calls to initialize should still have isSyncing = true as init value
    isSyncing = true;
  }
}

final syncStatusManager = SyncStatusManager();
