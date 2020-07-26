# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_RequestMatchers
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: PropertyByStage
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.PropertyByStage(Context());' |

@OnServer
Scenario: HeadersWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersWithoutParams(Context());' |

@OnServer
Scenario: HeadersWithParams
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersWithParams(Context());' |

@OnServer
Scenario: HeadersByStage
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.HeadersByStage(Context());' |

@OnServer
Scenario: WithMethodNotEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodNotEmpty(Context());' |

@OnServer
Scenario: WithMethodRewrite
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodRewrite(Context());' |

@OnServer
Scenario: WithPathNotEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithPathNotEmpty(Context());' |