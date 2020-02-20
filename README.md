# ![api-integration-testing-flutter-kata](https://user-images.githubusercontent.com/5593590/74655803-44849680-518d-11ea-9a92-f1057c12377b.png) 
[![Codemagic build status](https://api.codemagic.io/apps/5e4d20cdb0845116e2c8e3c1/5e4d20cdb0845116e2c8e3c0/status_badge.svg)](https://codemagic.io/apps/5e4d20cdb0845116e2c8e3c1/5e4d20cdb0845116e2c8e3c0/latest_build)


Api integration testing flutter Kata. The main goal is to practice api integration testing using MockWebServer

This kata is a Flutter version of the kata [KataTODOApiClientKotlin][KataTODOApiClientKotlin] of [Karumi][karumi].

- We are here to practice integration testing using flutter HTTP stubbing. 
- We are going to use [MockWebserver][MockWebserver] package to return stub responses.
- We are going to use [test][test] package to write tests and to perform assertions.
- We are going to practice pair programming.

---

## Getting started

This repository contains an API client to interact with the [JSONPlaceholder service](http://jsonplaceholder.typicode.com).

This API Client is based on one class with name ``TodoApiClient`` containing some methods to interact with the API. Using this class we can get all the tasks, get a task using the task id, add a new task, update a task or delete an already created task.

The API client has been implemented using a package named [http][http]. Review the project documentation if needed.

## Tasks

Your task as a Flutter Developer is to **write all the integration tests** needed to check if the API Client is working as expected.

**This repository is ready to build the application, pass the checkstyle using ktlint and your tests in Travis-CI environments.**

My recommendation for this exercise is:

  * Before starting
    1. Fork this repository.
    2. Checkout `api-integration-testing-flutter-kata` branch.
    3. Execute the repository playground and make yourself familiar with the code.
    4. Execute `todo_api_client_test` file and watch the only test it contains pass.

  * To help you get started, these are some tests already written at `todo_api_client_test` file. Review it carefully before to start writing your own tests. Here you have the description of some tests you can write to start working on this Kata:
	1. Test that the ``Accept`` headers are sent.
    2. Test that the list of ``Task`` instances obtained invoking the getter method of the property ``allTasks``  contains the expected values.
    3. Test that the request is sent to the correct path using the correct HTTP method.
    4. Test that adding a task the body sent to the server is the correct one.

## Considerations

* If you get stuck, `master` branch contains all the tests already solved.

* You will find some utilities to help you test the APIClient easily in:
  ``MockApi`` and the test/api/responses directory.

## Extra Tasks

If you've covered all the application functionality using integration tests you can continue with some extra tasks: 

* Create your own API client to consume one of the services described in this web: [http://jsonplaceholder.typicode.com/][jsonplaceholder]

---

## Documentation

There are some links which can be useful to finish these tasks:

* [Flutter Test documentation][fluttertestdoc]
* [HTTP documentation][httpdoc]

# License

Copyright 2020 Jorge Sánchez Fernández

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[MockWebserver]: https://pub.dev/packages/mock_web_server
[fluttertestdoc]: https://flutter.dev/docs/cookbook/testing/unit/introduction
[httpdoc]: https://flutter.dev/docs/cookbook/networking/fetch-data
[test]: https://pub.dev/packages/test
[http]: https://pub.dev/packages/http
[jsonplaceholder]: http://jsonplaceholder.typicode.com/
[KataTODOApiClientKotlin]: https://github.com/Karumi/KataTODOApiClientKotlin
[karumi]: https://github.com/Karumi
