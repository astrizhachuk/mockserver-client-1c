# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Request
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: RequestUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.RequestUndefinedConstructor(Context());' |

@OnServer
Scenario: RequestReInitWrongConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.RequestReInitWrongConstructor(Context());' |

@OnServer
Scenario: RequestStringJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.RequestStringJson(Context());' |