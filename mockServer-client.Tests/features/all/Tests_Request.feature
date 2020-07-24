# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_Request
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: RequestUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.RequestUndefinedConstructor(Context());' |

@OnServer
Scenario: RequestWrongConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.RequestWrongConstructor(Context());' |

@OnServer
Scenario: CallRequestRu
	And I execute 1C:Enterprise script at server
	| 'Tests_Request.CallRequestRu(Context());' |