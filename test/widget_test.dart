// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustedmaid/core/di/injection_container.dart' as di;
import 'package:trustedmaid/main.dart';

class MockAssetBundle extends CachingAssetBundle {
  final Uint8List transparentPng = Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
    0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
  ]);

  @override
  Future<ByteData> load(String key) async {
    if (key == 'assets/logo/trusted-maid.png') {
      return ByteData.sublistView(transparentPng);
    }
    if (key == 'AssetManifest.bin') {
      return const StandardMessageCodec().encodeMessage(<Object?, Object?>{})!;
    }
    if (key == 'AssetManifest.json') {
      return ByteData.sublistView(utf8.encode('{}'));
    }
    throw FlutterError('Unknown asset: $key');
  }
}

void main() {
  setUpAll(() async {
    // Initialize dependency injection for the test environment
    await di.init();
  });

  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: MockAssetBundle(),
        child: const MyApp(),
      ),
    );

    // Verify that our splash screen text starts.
    expect(find.text('TrustedMaid'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}

