library is_lock_screen;

import 'package:flutter/services.dart';

const _channel = MethodChannel('is_lock_screen');

/// Detects if the device is currently on the lock screen.
///
/// Returns `true` if the device is on the lock screen, `false` otherwise.
/// Returns `null` if the detection fails or is not supported on the platform.
Future<bool?> isLockScreen() async {
  try {
    final result = await _channel.invokeMethod<bool>('isLockScreen');
    return result;
  } on PlatformException {
    // Platform-specific error occurred
    return null;
  } catch (e) {
    // Other unexpected errors
    return null;
  }
}
