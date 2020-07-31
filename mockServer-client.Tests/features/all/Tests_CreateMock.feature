# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockserver-client.Tests.Tests_CreateMock
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: CreateNewClientsWithoutServer
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateNewClientsWithoutServer(Context());' |

@OnServer
Scenario: CreateNewClientsWithServer
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateNewClientsWithServer(Context());' |

@OnServer
Scenario: CreateClientNotDefaultUrl
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateClientNotDefaultUrl(Context());' |

@OnServer
Scenario: CreateClientOnlyServerName
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateClientOnlyServerName(Context());' |

@OnServer
Scenario: CreateClientServerNameAndPort
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateClientServerNameAndPort(Context());' |

@OnServer
Scenario: CreateClientAndResetAfter
	And I execute 1C:Enterprise script at server
	| 'Tests_CreateMock.CreateClientAndResetAfter(Context());' |