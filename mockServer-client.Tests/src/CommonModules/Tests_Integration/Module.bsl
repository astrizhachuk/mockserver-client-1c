#Region Internal

// @unit-test:integration
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

//// @unit-test:dev
//Procedure RespondResponse(Context) Export
//	
//	// given
//	Mock = DataProcessors.MockServerClient.Create();
//	Mock.URL = "localhost:1080";
//	// when
//	Mock.When( Mock.Request("""method"":""GET""") ).Respond( Mock.Response("""statusCode"": 404") );
//	// then
//
//EndProcedure

Procedure TODO(Context) Export

	// given
	Мок = DataProcessors.MockServerClient.Create();
	// when
	Мок.Сервер("localhost", "1080")
		.Когда(
			Мок.Запрос()
				.Метод("GET")
				.Путь("/%D1%84%D1%8D%D0%B9%D0%BA.epf")
				.Заголовок("PRIVATE-TOKEN", "-U2ssrBsM4rmx85HXzZ1")
		).Ответить(
			Мок.Ответ()
				.КодОтвета(404)
		);
	// then
	Assert.AreEqual(Мок.MockServerResponse.КодСостояния, 201);
	Assert.AreEqual(Мок.MockServerResponse.URL, "http://localhost:1080/mockserver/expectation");

EndProcedure

#EndRegion