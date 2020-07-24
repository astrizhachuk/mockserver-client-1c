# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_Response
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: ResponseUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseUndefinedConstructor(Context());' |

@OnServer
Scenario: ResponseWrongConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseWrongConstructor(Context());' |

@OnServer
Scenario: ResponseRequestExists
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.ResponseRequestExists(Context());' |

@OnServer
Scenario: CallResponseRu
	And I execute 1C:Enterprise script at server
	| 'Tests_Response.CallResponseRu(Context());' |