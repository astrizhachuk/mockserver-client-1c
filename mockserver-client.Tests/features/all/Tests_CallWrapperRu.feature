# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_CallWrapperRu
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Server
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Server(Context());' |

@OnServer
Scenario: Reset
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Reset(Context());' |

@OnServer
Scenario: When
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.When(Context());' |

@OnServer
Scenario: Request
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Request(Context());' |

@OnServer
Scenario: Headers
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Headers(Context());' |

@OnServer
Scenario: WithHeader
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithHeader(Context());' |

@OnServer
Scenario: WithMethod
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithMethod(Context());' |

@OnServer
Scenario: WithPath
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithPath(Context());' |

@OnServer
Scenario: WithQueryStringParameter
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithQueryStringParameter(Context());' |

@OnServer
Scenario: Response
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Response(Context());' |

@OnServer
Scenario: WithStatusCode
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithStatusCode(Context());' |

@OnServer
Scenario: WithReasonPhrase
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithReasonPhrase(Context());' |

@OnServer
Scenario: Respond
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Respond(Context());' |

@OnServer
Scenario: Times
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Times(Context());' |

@OnServer
Scenario: AtLeast
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.AtLeast(Context());' |

@OnServer
Scenario: AtMost
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.AtMost(Context());' |

@OnServer
Scenario: Exactly
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Exactly(Context());' |

@OnServer
Scenario: Once
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Once(Context());' |

@OnServer
Scenario: Between
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Between(Context());' |

@OnServer
Scenario: Verify
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.Verify(Context());' |

@OnServer
Scenario: WithSource
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithSource(Context());' |

@OnServer
Scenario: WithOperationId
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.WithOperationId(Context());' |

@OnServer
Scenario: OpenAPIExpectation
	And I execute 1C:Enterprise script at server
	| 'Tests_CallWrapperRu.OpenAPIExpectation(Context());' |