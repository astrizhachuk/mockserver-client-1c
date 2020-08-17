# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_OpenAPI
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: OpenAPIOnlySource
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIOnlySource(Context());' |

@OnServer
Scenario: OpenAPISourceAndOperations
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPISourceAndOperations(Context());' |