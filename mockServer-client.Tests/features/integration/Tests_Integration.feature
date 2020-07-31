# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Integration
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: MockServerDockerUp
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.MockServerDockerUp(Context());' |

@OnServer
Scenario: MatchRequestByPath
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.MatchRequestByPath(Context());' |

@OnServer
Scenario: MatchRequestByQueryParameterWithRegexValue
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.MatchRequestByQueryParameterWithRegexValue(Context());' |

@OnServer
Scenario: TODO
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.TODO(Context());' |