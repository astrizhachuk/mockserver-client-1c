# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_Integration
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Reset
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.Reset(Context());' |

@OnServer
Scenario: RespondResponse
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.RespondResponse(Context());' |