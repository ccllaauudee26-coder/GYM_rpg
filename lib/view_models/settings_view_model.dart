import 'package:flutter/foundation.dart';

import '../services/user_progress.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _isResetting = false;

  String? _error;

  bool get isResetting => _isResetting;

  String? get error => _error;

  Future<bool> resetProgress() async {
    if (_isResetting) {
      return false;
    }

    _isResetting = true;
    _error = null;

    notifyListeners();

    try {
      await UserProgress.resetProgress();

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    } finally {
      _isResetting = false;

      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}