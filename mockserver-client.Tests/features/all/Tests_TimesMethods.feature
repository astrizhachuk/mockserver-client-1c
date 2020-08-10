# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_TimesMethods
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: AtLeast
	And I execute 1C:Enterprise script at server
	| 'Tests_TimesMethods.AtLeast(Context());' |

@OnServer
Scenario: AtMost
	And I execute 1C:Enterprise script at server
	| 'Tests_TimesMethods.AtMost(Context());' |

@OnServer
Scenario: Exactly
	And I execute 1C:Enterprise script at server
	| 'Tests_TimesMethods.Exactly(Context());' |

@OnServer
Scenario: Once
	And I execute 1C:Enterprise script at server
	| 'Tests_TimesMethods.Once(Context());' |

@OnServer
Scenario: Between
	And I execute 1C:Enterprise script at server
	| 'Tests_TimesMethods.Between(Context());' |