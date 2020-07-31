# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Respond
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: RespondUrlException
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondUrlException(Context());' |

@OnServer
Scenario: RespondWhenFullJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenFullJson(Context());' |

@OnServer
Scenario: RespondWhenRequestJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRequestJson(Context());' |

@OnServer
Scenario: RespondWhenRequestMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRequestMap(Context());' |

@OnServer
Scenario: RespondWhenRespondJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenRespondJson(Context());' |

@OnServer
Scenario: RespondWhenResponseJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenResponseJson(Context());' |

@OnServer
Scenario: RespondWhenResponseMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Respond.RespondWhenResponseMap(Context());' |