# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_When
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WhenString
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenString(Context());' |

@OnServer
Scenario: WhenRequest
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenRequest(Context());' |

@OnServer
Scenario: WhenWrongType
	And I execute 1C:Enterprise script at server
	| 'Tests_When.WhenWrongType(Context());' |

@OnServer
Scenario: CallWhenRu
	And I execute 1C:Enterprise script at server
	| 'Tests_When.CallWhenRu(Context());' |