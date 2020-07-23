# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_MockServerClient
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: MockServerDockerUp
	And I execute 1C:Enterprise script at server
	| 'Tests_MockServerClient.MockServerDockerUp(Context());' |

@OnServer
Scenario: InitServer
	And I execute 1C:Enterprise script at server
	| 'Tests_MockServerClient.InitServer(Context());' |