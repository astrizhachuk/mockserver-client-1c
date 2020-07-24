# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_MockCreate
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: CreateNewObjectsWithoutServer
	And I execute 1C:Enterprise script at server
	| 'Tests_MockCreate.CreateNewObjectsWithoutServer(Context());' |

@OnServer
Scenario: CreateNewObjectsWithServer
	And I execute 1C:Enterprise script at server
	| 'Tests_MockCreate.CreateNewObjectsWithServer(Context());' |