# Code Examples

## Clearing & Resetting

### reset everything

```text
  Mock.Server("http://localhost", "1080").Reset();
```

## Request Properties Matcher

### match request by path

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Respond(
      Mock.Response()
        .WithBody("some_response_body")
    );
```

### match request by method regex

```text
  Mock.When(
      Mock.Request()
        .WithMethod("P.*{2,3}")
    ).Respond(
      Mock.Response()
        .WithBody("some_response_body")
    );
```

### match request by not matching method

```text
  Mock.When(
      Mock.Request()
        .WithMethod("!GET")
    ).Respond(
      Mock.Response()
        .WithBody("some_response_body")
    );
```

### match request by query parameter with regex value

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
        .WithQueryStringParameter("cartId", "[A-Z0-9\\-]+")
        .WithQueryStringParameter("anotherId", "[A-Z0-9\\-]+")
    ).Respond(
      Mock.Response()
        .WithBody("some_response_body")
    );
```

## Verifying Repeating Requests

### verify requests received at least twice

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .AtLeast(2)
    );
```

### verify requests received at most twice

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .AtMost(2)
    );
```

### verify requests received exactly twice

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .Exactly(2)
    );
```

### verify requests received at least twice by openapi

```text
  Mock.When(
      Mock.OpenAPI()
        .WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
    ).Verify(
      Mock.Times()
        .AtLeast(2)
    );
```

### verify requests received at exactly once by openapi and operation

```text
  Mock.When(
      Mock.OpenAPI()
        .WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
        .WithOperationId("listPets")
    ).Verify(
      Mock.Times()
        .Once()
    );
```

### verify requests received at exactly once

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .Once()
    );
```

### verify requests received between n and m times

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .Between(2, 3)
    );
```

### verify requests never received

```text
  Mock.When(
      Mock.Request()
        .WithPath("/some/path")
    ).Verify(
      Mock.Times()
        .Exactly(0)
    );
```
