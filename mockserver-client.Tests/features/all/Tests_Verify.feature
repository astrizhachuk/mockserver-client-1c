# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Verify
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: VerifyUrlException
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyUrlException(Context());' |

@OnServer
Scenario: VerifyWhenFullJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenFullJson(Context());' |

@OnServer
Scenario: VerifyWhenRequestJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenRequestJson(Context());' |

@OnServer
Scenario: VerifyWhenRequestMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenRequestMap(Context());' |

@OnServer
Scenario: VerifyWhenVerifyJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenVerifyJson(Context());' |

@OnServer
Scenario: VerifyWhenTimesJson
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenTimesJson(Context());' |

@OnServer
Scenario: VerifydWhenTimesMap
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifydWhenTimesMap(Context());' |

@OnServer
Scenario: VerifydWhenRequestAndTimes
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifydWhenRequestAndTimes(Context());' |

@OnServer
Scenario: VerifydWhenRequestInWhenAndTimesInVerify
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifydWhenRequestInWhenAndTimesInVerify(Context());' |

@OnServer
Scenario: VerifyWhenOpenAPIWithSource
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenOpenAPIWithSource(Context());' |

@OnServer
Scenario: VerifyWhenOpenAPIWithOperationId
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenOpenAPIWithOperationId(Context());' |

@OnServer
Scenario: VerifyWhenOpenAPI
	And I execute 1C:Enterprise script at server
	| 'Tests_Verify.VerifyWhenOpenAPI(Context());' |