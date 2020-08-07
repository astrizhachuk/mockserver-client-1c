#Region Internal

// @unit-test:fast
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
	
EndProcedure

// Request Properties Matcher Code Examples

// match request by path
// 
// @unit-test:integration
Procedure MatchRequestByPath(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080")
		.When(
			Mock.Request()
				.WithPath("/some/path")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 201);
	Assert.AreEqual(Mock.MockServerResponse.URL, "http://localhost:1080/mockserver/expectation");

EndProcedure

// match request by query parameter with regex value
// 
// @unit-test:integration
Procedure MatchRequestByQueryParameterWithRegexValue(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080")
		.When(
			Mock.Request()
				.WithPath("/some/path")
				.WithQueryStringParameters("cartId", "[A-Z0-9\\-]+")
				.WithQueryStringParameters("anotherId", "[A-Z0-9\\-]+")
		).Respond(
			Mock.Response()
				.WithBody("some_response_body")
		);
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 201);
	Assert.AreEqual(Mock.MockServerResponse.URL, "http://localhost:1080/mockserver/expectation");

EndProcedure


// Response Action Code Examples

// literal response with status code and reason phrase
// 
// @unit-test:integration
Procedure LiteralResponseWithStatusCodeAndReasonPhrase(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("localhost", "1080")
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
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 201);
	Assert.AreEqual(Mock.MockServerResponse.URL, "http://localhost:1080/mockserver/expectation");

EndProcedure

// Verifying Repeating Requests Code Examples

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
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 202);
	Assert.AreEqual(Mock.MockServerResponse.URL, "http://localhost:1080/mockserver/verify");

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
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 406);
	Assert.AreEqual(Mock.MockServerResponse.URL, "http://localhost:1080/mockserver/verify");

EndProcedure

#EndRegion