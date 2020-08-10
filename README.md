# MockServer client for 1C:Enterprise Platform

[![Quality Gate Status](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)
[![Maintainability Rating](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=sqale_rating)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)

[русский](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/ru/README.md)

*[MockServer](https://www.mock-server.com/#what-is-mockserver)-client-1c* is designed to [controll](https://www.mock-server.com/mock_server/mockserver_clients.html) MoskServer using 1C:Enterprise Platform. This *client* is distributed as *cfe*, but it can be used as *epf*.

## How it works

```text
 Mock = DataProcessors.MockServerClient.Create();
 Mock.Server("localhost", "1080")
  .When(
   Mock.Request()
    .WithMetod("GET")
    .WithPath("/some/path")
    .Headers()
      .WithHeader("foo", "boo")
  ).Respond(
   Mock.Response()
    .WithStatusCode(200)
  );
```

That's all! Mock is created!

## Dependencies

The project built with:

1. [1C:Enterprise](https://1c-dn.com) 8.3.16.1502+ (8.3.16 compatibility mode)
2. [1C:Enterprise Development Tools](https://edt.1c.ru) 2020.4 RC1
3. [1Unit](https://github.com/DoublesunRUS/ru.capralow.dt.unit.launcher) 0.4.0+
4. [vanessa-automation](https://github.com/Pr-Mex/vanessa-automation)
5. [dt.bslls.validator](https://github.com/DoublesunRUS/ru.capralow.dt.bslls.validator)
6. [BSL Language Server](https://github.com/1c-syntax/bsl-language-server)

Working with HTTP is implemented using the following libraries:

* [HTTPConnector](https://github.com/vbondarevsky/Connector)
* [HTTPStatusCodes](https://github.com/astrizhachuk/HTTPStatusCodes)

## Getting Started

[Overview](https://www.mock-server.com/mock_server/getting_started.html)

The typical sequence for using MockServer is as follows:

* [Start MockServer](#StartMockServer)
* [Create an instance of the client](#CreateInstance)
* [Setup Expectations](#SetupExpectations)
* Run Your Test Scenarios
* Verify Requests

### Start MockServer<a name="StartMockServer"></a>

[Running MockServer documentation](https://www.mock-server.com/mock_server/running_mock_server.html)

For example, start the MockServer docker container:

```bash
docker run -d --rm -p 1080:1080 --name mockserver-1c-integration mockserver/mockserver -logLevel DEBUG -serverPort 1080
```

Or run docker-compose.yml from root directory of the project:

```bash
docker-compose -f "docker-compose.yml" up -d --build
```

### Create an instance of the client<a name="CreateInstance"></a>

Connect to the default server:

```bash
Mock = DataProcessors.MockServerClient.Create();
```

Connect to the server at the specified host and port:

```bash
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server" );
# or
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server", "1099" );
```

Connect to the server at the specified host and port with a completely MockServer [reset](https://www.mock-server.com/mock_server/clearing_and_resetting.html):

```bash
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server", "1099", True );
```

### Setup Expectations<a name="SetupExpectations"></a>

Setup expectation (and verify requests) consists of two stages: preparing conditions (json) and sending an action (PUT json).

There are two types of methods: **intermediate** (returns self-object) and **terminal** (perform action). Some object's methods as parameters can accept a reference to themselves or a json-format string. Before executing the action, a json will be auto-generated.

Use method chaining style (fluent interface):

```bash
  # full json without auto-generating
  Mock.Server( "localhost", "1080" )
    .When( "{""name"":""value""}" )
    .Respond();

  # httpRequest property in json-style
  Mock.Server( "localhost", "1080" )
    .When(
      Mock.Request( """name"":""value""" )
    )
    .Respond();

  # combined style
  Mock.Server( "localhost", "1080" )
    .When(
      Mock.Request()
        .WithMethod( "GET" )
        .WithPath( "some/path" )
    )
    .Respond(
        Mock.Response( """statusCode"": 404" )
    );

```
