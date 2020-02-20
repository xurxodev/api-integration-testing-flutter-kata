import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';

class MockApi {
  MockWebServer _server;

  Future<void> start() async {
    _server = MockWebServer();
    await _server.start();
  }

  void shutdown() {
    _server.shutdown();
  }

  String get baseAddress => _server.url.substring(0, _server.url.length - 1);

  Future<void> enqueueMockResponse(
      {String fileName = '',
      int httpCode = 200,
      Map<String, String> headers}) async {
    final content = await _getContentFromFile(fileName: fileName);

    _server.enqueue(body: content, httpCode: httpCode, headers: headers);
  }

  void expectRequestSentTo(String endpoint) {
    final StoredRequest storedRequest = _server.takeRequest();

    expect(storedRequest.uri.path, endpoint);
  }

  void expectRequestContainsHeader([String key, String expectedValue, int requestIndex = 0]) {
    final StoredRequest storedRequest = _getRecordedRequestAtIndex(requestIndex);
    final value = storedRequest.headers[key];

    expect(value, contains(expectedValue));
  }

  Future<void> expectRequestContainsBody(String fileName) async {
    final expectedBody = await _getContentFromFile(fileName: fileName);
    final StoredRequest storedRequest = _getRecordedRequestAtIndex(0);

    expect(storedRequest.body, expectedBody);
  }

  Future<String> _getContentFromFile(
      {String testResourcesDir = '/api/resources', String fileName}) async {
    if (fileName == null || fileName.isEmpty) {
      return '';
    }

    final String content =
        await File(_testPath(testResourcesDir + fileName)).readAsString();

    return content;
  }

  String _testPath(String relativePath) {
    //Fix ide test path
    final Directory current = Directory.current;
    final String path =
        current.path.endsWith('/test') ? current.path : current.path + '/test';

    return path + '/' + relativePath;
  }

  StoredRequest _getRecordedRequestAtIndex(int requestIndex) =>
    List<StoredRequest>.generate(requestIndex+1, (i) => _server.takeRequest()).last;
}
