# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Times
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: TimesUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Times.TimesUndefinedConstructor(Context());' |

@OnServer
Scenario: TimesReInitWrongConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Times.TimesReInitWrongConstructor(Context());' |

@OnServer
Scenario: TimesRequestExists
	And I execute 1C:Enterprise script at server
	| 'Tests_Times.TimesRequestExists(Context());' |

@OnServer
Scenario: TimesStringJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Times.TimesStringJSON(Context());' |