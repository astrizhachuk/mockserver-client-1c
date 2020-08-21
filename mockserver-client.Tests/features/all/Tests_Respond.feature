# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Respond
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: RespondURLException
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondURLException(Context());' |

@OnServer
Scenario: RespondWhenFullJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenFullJSON(Context());' |

@OnServer
Scenario: RespondWhenRequestJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRequestJSON(Context());' |

@OnServer
Scenario: RespondWhenRequestMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRequestMap(Context());' |

@OnServer
Scenario: RespondWhenRespondJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRespondJSON(Context());' |

@OnServer
Scenario: RespondWhenResponseJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenResponseJSON(Context());' |

@OnServer
Scenario: RespondWhenResponseMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenResponseMap(Context());' |