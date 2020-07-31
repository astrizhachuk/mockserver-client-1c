# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_RequestMatchers
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WithMethodRewrite
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodRewrite(Context());' |

@OnServer
Scenario: WithQueryStringParametersNotEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithQueryStringParametersNotEmpty(Context());' |