# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_ResponseAction
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WithStatusCodeNotEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_ResponseAction.WithStatusCodeNotEmpty(Context());' |

@OnServer
Scenario: WithStatusCodeRewrite
	And I execute 1C:Enterprise script at server
	| 'Tests_ResponseAction.WithStatusCodeRewrite(Context());' |