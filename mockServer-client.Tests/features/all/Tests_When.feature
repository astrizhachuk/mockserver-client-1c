# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_When
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WhenParamsString
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenParamsString(Context());' |

@OnServer
Scenario: WhenParamsRequestAction
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenParamsRequestAction(Context());' |

@OnServer
Scenario: WhenWrongParams
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenWrongParams(Context());' |