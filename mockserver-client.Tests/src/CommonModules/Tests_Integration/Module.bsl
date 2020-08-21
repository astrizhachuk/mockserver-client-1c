#Region Internal

// @unit-test:prepare
Procedure MockServerDockerUp(Context) Export

	ExitStatus = Undefined;
	RunApp("docker kill mockserver-1c-integration", , True, ExitStatus);
	RunApp("docker run -d --rm -p 1080:1080"
						+ " --name mockserver-1c-integration mockserver/mockserver"
						+ " -logLevel DEBUG -serverPort 1080",
						,
						True,
						ExitStatus);
						
	If ExitStatus <> 0 Then
		
		Raise NStr("en = 'Container mockserver-1c-integration isn't created.'");
		
	EndIf;
	
	Wait(5);
	
EndProcedure

// @unit-test:integration
Procedure ExpectationFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true).When("{}").Respond();
	// then
	Assert.IsFalse(Mock.IsOk());

EndProcedure

// @unit-test:integration
Procedure RequestAndResponseJSONFormat(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request("""path"": ""/some/path""")
		).Respond(
			Mock.Response("""body"": ""some_response_body""")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

#Region ClearingAndResetting

// @unit-test:integration
Procedure Resetting(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080").Reset();
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

#EndRegion

#Region RequestPropertiesMatcher

// match request by path
// 
// @unit-test:integration
Procedure MatchRequestByPath(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithPath("/some/path")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

// match request by method regex
// 
// @unit-test:integration
Procedure MatchRequestByMethodRegex(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithMethod("P.*{2,3}")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

// match request by not matching method
// 
// @unit-test:integration
Procedure MatchRequestByNotMatchingMethod(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithMethod("!GET")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

// match request by query parameter with regex value
// 
// @unit-test:integration
Procedure MatchRequestByQueryParameterWithRegexValue(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithPath("/some/path")
				.WithQueryStringParameter("cartId", "[A-Z0-9\\-]+")
				.WithQueryStringParameter("anotherId", "[A-Z0-9\\-]+")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

// match request by headers
// 
// @unit-test:integration
Procedure MatchRequestByHeaders(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithMethod("GET")
				.WithPath("/some/path")
				.Headers()
					.WithHeader("Accept", "application/json")
					.WithHeader("Accept-Encoding", "gzip, deflate, br")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

#EndRegion

#Region ResponseAction

// literal response with body only
// 
// @unit-test:integration
Procedure LiteralResponseWithBodyOnly(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);	
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

// literal response with status code and reason phrase
// 
// @unit-test:integration
Procedure LiteralResponseWithStatusCodeAndReasonPhrase(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080", true)
		.When(
			Mock.Request()
				.WithPath("/some/path")
				.WithMethod("POST")
		).Respond(
			Mock.Response()
				.WithStatusCode(418)
				.WithReasonPhrase("I'm a teapot")
		);	
	// then
	Assert.IsTrue(Mock.IsOk());

EndProcedure

#EndRegion

#Region OpenAPI

// @unit-test:integration
Procedure OpenAPIExpectationOnlySource(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	// when
	Mock.OpenAPIExpectation( "https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json" );
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure OpenAPIExpectationSourceAndOperations(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	// when
	Mock.OpenAPIExpectation( "https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json",
								"""listPets"": ""200""" );
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

#EndRegion

#Region VerifyingRepeatingRequests

// verify requests received at least twice
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedAtLeastTwice(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.AtLeast(2)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedAtLeastTwiceFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.AtLeast(2)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received at most twice
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedAtMostTwice(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/another" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.AtMost(2)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedAtMostTwiceFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.AtMost(2)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received exactly twice
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedExactlyTwice(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/another" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Exactly(2)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedExactlyTwiceFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Exactly(2)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received at least twice by openapi
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedAtLeastTwiceByOpenAPI(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/another" );
	// when
	Mock.When(
			Mock.OpenAPI()
				.WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
		).Verify(
			Mock.Times()
				.AtLeast(2)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedAtLeastTwiceByOpenAPIFailed(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.OpenAPI()
				.WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
		).Verify(
			Mock.Times()
				.AtLeast(2)
		);
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received at exactly once by openapi and operation
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperation(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/pets" );
	// when
	Mock.When(
			Mock.OpenAPI()
				.WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
				.WithOperationId("listPets")
		).Verify(
			Mock.Times()
				.Once()
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedAtExactlyOnceByOpenAPIAndOperationFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/pets" );
	HTTPConnector.Get( "http://localhost:1080/pets" );
	// when
	Mock.When(
			Mock.OpenAPI()
				.WithSource("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
				.WithOperationId("listPets")
		).Verify(
			Mock.Times()
				.Once()
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received at exactly once
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedOnce(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/another" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Once()
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedOnceFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Once()
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests received between n and m times
// 
// @unit-test:integration
Procedure VerifyRequestsReceivedBetween(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Between(2, 3)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedBetweenLessFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Between(2, 3)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsReceivedBetweenMoreFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Between(2, 3)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

// verify requests never received
// 
// @unit-test:integration
Procedure VerifyRequestsNeverReceived(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Exactly(0)
		);
	// then
	Assert.IsTrue(Mock.IsOk());
	Assert.IsTrue(Mock.Успешно());

EndProcedure

// @unit-test:integration
Procedure VerifyRequestsNeverReceivedFail(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("localhost", "1080", true);
	HTTPConnector.Get( "http://localhost:1080/some/path" );
	// when
	Mock.When(
			Mock.Request()
				.WithPath("/some/path")
		).Verify(
			Mock.Times()
				.Exactly(0)
		);	
	// then
	Assert.IsFalse(Mock.IsOk());
	Assert.IsFalse(Mock.Успешно());

EndProcedure

#EndRegion

#EndRegion

#Region Private

Procedure Wait( Val Wait) Export
	
	End = CurrentDate() + Wait;
	
	While (True) Do
		
		If CurrentDate() >= End Then
			Return;
		EndIf;
		 
	EndDo;
	 
EndProcedure

#EndRegion
