import 'package:api_testing_flutter_kata/exceptions/todo_api_client_exceptions.dart';
import 'package:api_testing_flutter_kata/model/task.dart';
import 'package:api_testing_flutter_kata/todo_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/mock_api.dart';

TodoApiClient _todoApiClient;
MockApi mockApi = MockApi();

void main() {
  setUp(() async {
    await mockApi.start();

    _todoApiClient = TodoApiClient(mockApi.baseAddress);
  });

  tearDown(() {
    mockApi.shutdown();
  });

  group('TodoApiClient', () {
    group('GetAllTasks should', () {
      test('sends get request to the correct endpoint', () async {
        await mockApi.enqueueMockResponse(fileName: getTasksResponse);

        await _todoApiClient.getAllTasks();

        mockApi.expectRequestSentTo('/todos');
      });
      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(fileName: getTasksResponse);

        await _todoApiClient.getAllTasks();

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });
      test('parse current news properly getting all current news', () async {
        await mockApi.enqueueMockResponse(fileName: getTasksResponse);

        final tasks = await _todoApiClient.getAllTasks();

        expectTasksContainsExpectedValues(tasks[0]);
      });
      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.getAllTasks(),
            throwsA(isInstanceOf<UnKnowApiException>()));
      });
    });
  });
}

void expectTasksContainsExpectedValues(Task task) {
  expect(task, isNotNull);
  expect(task.userId, 1);
  expect(task.id, 1);
  expect(task.title, 'delectus aut autem');
  expect(task.completed, false);
}
