# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_OpenAPI
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: OpenAPIUndefinedConstructor
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIUndefinedConstructor(Context());' |

@OnServer
Scenario: OpenAPIStringJson
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIStringJson(Context());' |

@OnServer
Scenario: OpenAPIWhenOpenAPIMap
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIWhenOpenAPIMap(Context());' |

@OnServer
Scenario: OpenAPIExpectationOnlySource
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIExpectationOnlySource(Context());' |

@OnServer
Scenario: OpenAPIExpectationSourceAndOperations
	And I execute 1C:Enterprise script at server
	| 'Tests_OpenAPI.OpenAPIExpectationSourceAndOperations(Context());' |