# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_RequestMatchers
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: HeadersWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersWithoutParams(Context());' |

@OnServer
Scenario: HeadersWithParams
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersWithParams(Context());' |

@OnServer
Scenario: HeadersByStage
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersByStage(Context());' |