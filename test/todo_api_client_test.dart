import 'package:api_testing_flutter_kata/exceptions/todo_api_client_exceptions.dart';
import 'package:api_testing_flutter_kata/model/task.dart';
import 'package:api_testing_flutter_kata/todo_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/mock_api.dart';

TodoApiClient _todoApiClient;
MockApi mockApi = MockApi();
String anyId = '1';
Task anyTask =
    Task(id: 1, userId: 1, title: 'Finish this kata', completed: false);

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
    group('GetTaskById should', () {
      test('sends get request to the correct endpoint', () async {
        await mockApi.enqueueMockResponse(fileName: getTaskByIdResponse);

        await _todoApiClient.getTasksById(anyId);

        mockApi.expectRequestSentTo('/todos/$anyId');
      });
      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(fileName: getTaskByIdResponse);

        await _todoApiClient.getTasksById(anyId);

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });
      test('parse current news properly getting all current news', () async {
        await mockApi.enqueueMockResponse(fileName: getTaskByIdResponse);

        final task = await _todoApiClient.getTasksById(anyId);

        expectTasksContainsExpectedValues(task);
      });
      test(
          'throws ItemNotFoundException if there is no task with the passed id',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 404);

        expect(() => _todoApiClient.getTasksById(anyId),
            throwsA(isInstanceOf<ItemNotFoundException>()));
      });
      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.getTasksById(anyId),
            throwsA(isInstanceOf<UnKnowApiException>()));
      });
    });
    group('AddTask should', () {
      test('sends get request to the correct endpoint', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        await _todoApiClient.addTask(anyTask);

        mockApi.expectRequestSentTo('/todos');
      });
      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        await _todoApiClient.addTask(anyTask);

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });
      test('sends content-type header', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        await _todoApiClient.addTask(anyTask);

        mockApi.expectRequestContainsHeader('content-type', 'application/json');
      });
      test('sends the correct body adding a new task', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        await _todoApiClient.addTask(anyTask);

        mockApi.expectRequestContainsBody(addTaskRequest);
      });
      test('parse current news properly getting all current news', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        final task = await _todoApiClient.addTask(anyTask);

        expectTasksContainsExpectedValues(task);
      });
      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() =>  _todoApiClient.addTask(anyTask),
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
