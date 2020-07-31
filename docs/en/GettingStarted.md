# Getting Started

The typical sequence for using MockServer is as follows:

* [Start MockServer](#StartMockServer)
* Setup Expectations
* Run Your Test Scenarios
* Verify Requests

## Start MockServer<a name="StartMockServer"></a>

[Running MockServer documentation](https://www.mock-server.com/mock_server/running_mock_server.html)

For example, run the MockServer docker image from project's integrating tests:

```bash
docker run -d --rm -p 1080:1080 --name mockserver-1c-integration mockserver/mockserver -logLevel DEBUG -serverPort 1080
```

Or run docker-compose.yml from root directory of the project:

```bash
docker-compose -f "docker-compose.yml" up -d --build
```
