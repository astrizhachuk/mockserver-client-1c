# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_RequestMatchers
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: WithMethodUndefinedConstructorException
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodUndefinedConstructorException(Context());' |

@OnServer
Scenario: WithMethodEmptyMapException
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodEmptyMapException(Context());' |

@OnServer
Scenario: WithMethodEmptyRequestException
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodEmptyRequestException(Context());' |

@OnServer
Scenario: WithMethodEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodEmpty(Context());' |

@OnServer
Scenario: WithMethodNotEmpty
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodNotEmpty(Context());' |

@OnServer
Scenario: WithMethodRewrite
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.WithMethodRewrite(Context());' |

@OnServer
Scenario: RuCallMethods
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.RuCallMethods(Context());' |