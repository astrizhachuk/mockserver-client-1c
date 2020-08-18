# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_OpenAPI
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: OpenAPIExpectationOnlySource
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIExpectationOnlySource(Context());' |

@OnServer
Scenario: OpenAPIExpectationSourceAndOperations
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIExpectationSourceAndOperations(Context());' |

@OnServer
Scenario: OpenAPIExpectationSourceAndOperations2
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIExpectationSourceAndOperations2(Context());' |