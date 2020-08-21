# MockServer client for 1C:Enterprise Platform

[![Quality Gate Status](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)
[![Maintainability Rating](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=sqale_rating)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)

[русский](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/ru/README.md)

*[MockServer](https://www.mock-server.com/#what-is-mockserver)-client-1c* is designed to [controll](https://www.mock-server.com/mock_server/mockserver_clients.html) MoskServer using 1C:Enterprise Platform. This *client* is distributed as *cfe* and implemented as *DataProcessor* that interacts with the MockServer via the [REST API](https://app.swaggerhub.com/apis/jamesdbloom/mock-server-openapi/5.11.x). MockServer supports OpenAPI v3 specifications in either JSON or YAML format.

## How it works

```text
 Mock = DataProcessors.MockServerClient.Create();
 Mock.Server("http://localhost", "1080")
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

```text
// @unit-test
Procedure Verify(Context) Export
  // given
  Mock = DataProcessors.MockServerClient.Create();
  Mock.Server( "http://localhost", "1080", true );
  HTTPConnector.Get( "http://localhost:1080/some/path" );
  HTTPConnector.Get( "http://localhost:1080/some/path" );
  // when
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .AtLeast(2)
    );
  // then
  Assert.IsTrue(Mock.IsOk());
EndProcedure
```

Tested!

[Code Examples](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/en/Examples.md)

[Public API](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/en/PublicAPI.md)

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

```text
docker run -d --rm -p 1080:1080 --name mockserver-1c-integration mockserver/mockserver -logLevel DEBUG -serverPort 1080
```

Or run docker-compose.yml from root directory of the project:

```text
docker-compose -f "docker-compose.yml" up -d --build
```

### Create an instance of the client<a name="CreateInstance"></a>

Connect to the default server:

```text
Mock = DataProcessors.MockServerClient.Create();
```

Connect to the server at the specified host and port:

```text
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server" );
# or
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server", "1099" );
```

Connect to the server at the specified host and port with a completely MockServer [reset](https://www.mock-server.com/mock_server/clearing_and_resetting.html):

```text
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server", "1099", True );
```

### Setup Expectations<a name="SetupExpectations"></a>

Setup expectation (and verify requests) consists of two stages: preparing conditions (json) and sending an action (PUT json).

There are two types of methods: **intermediate** (returns self-object) and **terminal** (perform action). Some object's methods as parameters can accept a reference to themselves with preparing conditions or a json-format string. Before executing the action, the necessary json will be automatically generated depending on the selected terminal operation and preconditions.

Use method chaining style (fluent interface):

```text
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
