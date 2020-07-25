# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_Reset
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: ResetIntermediateException
	And I execute 1C:Enterprise script at server
	| 'Tests_Reset.ResetIntermediateException(Context());' |

@OnServer
Scenario: ResetTerminalException
	And I execute 1C:Enterprise script at server
	| 'Tests_Reset.ResetTerminalException(Context());' |