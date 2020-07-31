# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_ResponseAction
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WithStatusCode
	And I execute 1C:Enterprise script at server
	| 'Tests_ResponseAction.WithStatusCode(Context());' |

@OnServer
Scenario: WithStatusCodeRewrite
	And I execute 1C:Enterprise script at server
	| 'Tests_ResponseAction.WithStatusCodeRewrite(Context());' |

@OnServer
Scenario: WithBody
	And I execute 1C:Enterprise script at server
	| 'Tests_ResponseAction.WithBody(Context());' |