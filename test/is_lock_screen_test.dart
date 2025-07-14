import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

void main() {
  const MethodChannel channel = MethodChannel('is_lock_screen');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'isLockScreen') {
        return true; // Mock return value
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isLockScreen returns expected value', () async {
    final result = await isLockScreen();
    expect(result, true);
  });

  test('isLockScreen handles platform exception', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(
        code: 'UNAVAILABLE',
        message: 'Lock screen detection not available.',
      );
    });

    final result = await isLockScreen();
    expect(result, null);
  });
}
