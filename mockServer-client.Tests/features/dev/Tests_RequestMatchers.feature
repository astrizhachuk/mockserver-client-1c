# language: en

@tree
@classname=ModuleExceptionPath

Feature: mockServer-client.Tests.Tests_RequestMatchers
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: PropertyByStage
	And I execute 1C:Enterprise script at server
	| 'Tests_RequestMatchers.PropertyByStage(Context());' |