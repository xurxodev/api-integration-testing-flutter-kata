import 'package:api_testing_flutter_kata/exceptions/todo_api_client_exceptions.dart';
import 'package:api_testing_flutter_kata/model/task.dart';
import 'package:api_testing_flutter_kata/todo_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/mock_api.dart';

const getTasksResponse = '/get_tasks_response.json';
const getTaskByIdResponse = '/get_task_by_id_response.json';
const addTaskRequest = '/add_task_request.json';
const addTaskResponse = '/add_task_response.json';
const updateTaskRequest = '/update_task_request.json';
const updateTaskResponse = '/update_task_response.json';

TodoApiClient _todoApiClient;
MockApi mockApi = MockApi();
String anyTaskId = '1';
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

        await _todoApiClient.getTasksById(anyTaskId);

        mockApi.expectRequestSentTo('/todos/$anyTaskId');
      });

      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(fileName: getTaskByIdResponse);

        await _todoApiClient.getTasksById(anyTaskId);

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });

      test('parse tasks properly getting all task', () async {
        await mockApi.enqueueMockResponse(fileName: getTaskByIdResponse);

        final task = await _todoApiClient.getTasksById(anyTaskId);

        expectTasksContainsExpectedValues(task);
      });

      test(
          'throws ItemNotFoundException if there is no task with the passed id',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 404);

        expect(() => _todoApiClient.getTasksById(anyTaskId),
            throwsA(isInstanceOf<ItemNotFoundException>()));
      });

      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.getTasksById(anyTaskId),
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
      test('parse task properly getting all task', () async {
        await mockApi.enqueueMockResponse(
            fileName: addTaskResponse, httpCode: 201);

        final task = await _todoApiClient.addTask(anyTask);

        expectTasksContainsExpectedValues(task);
      });
      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.addTask(anyTask),
            throwsA(isInstanceOf<UnKnowApiException>()));
      });
    });

    group('UpdateTask should', () {

      test('sends get request to the correct endpoint', () async {
        await mockApi.enqueueMockResponse(fileName: updateTaskResponse);

        await _todoApiClient.updateTask(anyTask);

        mockApi.expectRequestSentTo('/todos/1');
      });

      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(fileName: updateTaskResponse);

        await _todoApiClient.updateTask(anyTask);

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });

      test('sends content-type header', () async {
        await mockApi.enqueueMockResponse(fileName: updateTaskResponse);

        await _todoApiClient.updateTask(anyTask);

        mockApi.expectRequestContainsHeader('content-type', 'application/json');
      });

      test('sends the correct body adding a new task', () async {
        await mockApi.enqueueMockResponse(fileName: updateTaskResponse);

        await _todoApiClient.updateTask(anyTask);

        mockApi.expectRequestContainsBody(updateTaskRequest);
      });

      test('parse task properly getting all task', () async {
        await mockApi.enqueueMockResponse(fileName: updateTaskResponse);

        final task = await _todoApiClient.updateTask(anyTask);

        expectTasksContainsExpectedValues(task);
      });

      test(
          'throws ItemNotFoundException if there is no task with the passed id',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 404);

        expect(() => _todoApiClient.updateTask(anyTask),
            throwsA(isInstanceOf<ItemNotFoundException>()));
      });

      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.updateTask(anyTask),
            throwsA(isInstanceOf<UnKnowApiException>()));
      });
    });

    group('DeleteTaskById should', () {

      test('sends get request to the correct endpoint', () async {
        await mockApi.enqueueMockResponse();

        await _todoApiClient.deleteTaskById(anyTaskId);

        mockApi.expectRequestSentTo('/todos/1');
      });

      test('sends accept header', () async {
        await mockApi.enqueueMockResponse(
            fileName: updateTaskResponse);

        await _todoApiClient.deleteTaskById(anyTaskId);

        mockApi.expectRequestContainsHeader('accept', 'application/json');
      });

      test(
          'throws ItemNotFoundException if there is no task with the passed id',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 404);

        expect(() => _todoApiClient.deleteTaskById(anyTaskId),
            throwsA(isInstanceOf<ItemNotFoundException>()));
      });

      test(
          'throws UnknownErrorException if there is not handled error getting news',
          () async {
        await mockApi.enqueueMockResponse(httpCode: 454);

        expect(() => _todoApiClient.updateTask(anyTask),
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
