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

## Guidelines

[Getting Started](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/en/GettingStarted.md)

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
