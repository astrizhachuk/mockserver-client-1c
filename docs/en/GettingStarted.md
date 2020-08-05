# Getting Started

The typical sequence for using MockServer is as follows:

* [Start MockServer](#StartMockServer)
* [Create an instance of the client](#CreateInstance)
* Setup Expectations
* Run Your Test Scenarios
* Verify Requests

## Start MockServer<a name="StartMockServer"></a>

[Running MockServer documentation](https://www.mock-server.com/mock_server/running_mock_server.html)

For example, start the MockServer Docker container as done in the project's integration tests:

```bash
docker run -d --rm -p 1080:1080 --name mockserver-1c-integration mockserver/mockserver -logLevel DEBUG -serverPort 1080
```

Or run docker-compose.yml from root directory of the project:

```bash
docker-compose -f "docker-compose.yml" up -d --build
```

## Create an instance of the client<a name="CreateInstance"></a>

To the default server:

```bash
Mock = DataProcessors.MockServerClient.Create();
```

To the specific server:

```bash
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server" );
# or
Mock = Mock.Server( "http://server", "1099" );
```

To the specific server with a completely MockServer reset:

```bash
Mock = DataProcessors.MockServerClient.Create();
Mock = Mock.Server( "http://server", "1099", true );
```
