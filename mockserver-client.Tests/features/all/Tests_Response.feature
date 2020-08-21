# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Response
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: ResponseUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseUndefinedConstructor(Context());' |

@OnServer
Scenario: ResponseReInitWrongConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseReInitWrongConstructor(Context());' |

@OnServer
Scenario: ResponseRequestExists
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseRequestExists(Context());' |

@OnServer
Scenario: ResponseStringJSON
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseStringJSON(Context());' |