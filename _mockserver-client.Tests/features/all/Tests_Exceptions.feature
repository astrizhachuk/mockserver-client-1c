# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_Exceptions
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: CurrentStageEmptySelfException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.CurrentStageEmptySelfException(Context());' |

@OnServer
Scenario: RequestEmptyMapException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.RequestEmptyMapException(Context());' |

@OnServer
Scenario: ResponseEmptyMapException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.ResponseEmptyMapException(Context());' |

@OnServer
Scenario: RequestBlankException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.RequestBlankException(Context());' |

@OnServer
Scenario: ResponseBlankException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.ResponseBlankException(Context());' |

@OnServer
Scenario: ConstructorPropertyByStageException
	And I execute 1C:Enterprise script at server
	| 'Tests_Exceptions.ConstructorPropertyByStageException(Context());' |