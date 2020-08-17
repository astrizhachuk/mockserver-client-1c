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
Scenario: ExpectationFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.ExpectationFail(Context());' |

@OnServer
Scenario: MatchRequestByPath
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.MatchRequestByPath(Context());' |

@OnServer
Scenario: MatchRequestByQueryParameterWithRegexValue
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.MatchRequestByQueryParameterWithRegexValue(Context());' |

@OnServer
Scenario: LiteralResponseWithStatusCodeAndReasonPhrase
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.LiteralResponseWithStatusCodeAndReasonPhrase(Context());' |

@OnServer
Scenario: OpenAPIExpectationOnlySource
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.OpenAPIExpectationOnlySource(Context());' |

@OnServer
Scenario: OpenAPIExpectationSourceAndOperations
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.OpenAPIExpectationSourceAndOperations(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtLeastTwice
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtLeastTwice(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtLeastTwiceFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtLeastTwiceFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtMostTwice
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtMostTwice(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtMostTwiceFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtMostTwiceFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedExactlyTwice
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedExactlyTwice(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedExactlyTwiceFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedExactlyTwiceFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtLeastTwiceByOpenAPI
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtLeastTwiceByOpenAPI(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtLeastTwiceByOpenAPIFailed
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtLeastTwiceByOpenAPIFailed(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperation
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperation(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperationFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperationFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedOnce
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedOnce(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedOnceFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedOnceFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedBetween
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedBetween(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedBetweenLessFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedBetweenLessFail(Context());' |

@OnServer
Scenario: VerifyRequestsReceivedBetweenMoreFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsReceivedBetweenMoreFail(Context());' |

@OnServer
Scenario: VerifyRequestsNeverReceived
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsNeverReceived(Context());' |

@OnServer
Scenario: VerifyRequestsNeverReceivedFail
	And I execute 1C:Enterprise script at server
	| 'Tests_Integration.VerifyRequestsNeverReceivedFail(Context());' |