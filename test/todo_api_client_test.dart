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

      test('parse current news properly getting all current news', () async {
        await mockApi.enqueueMockResponse(fileName: getTasksResponse);

        final tasks = await _todoApiClient.getAllTasks();

        expectTasksContainsExpectedValues(tasks[0]);
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
