#Region Internal

// @unit-test
Procedure Server(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Сервер("example.org", "1090", Ложь);
	// then	
	Assert.AreEqual(Result.URL, "example.org:1090");

EndProcedure

// @unit-test
Procedure Reset(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Сбросить();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
	
EndProcedure

// @unit-test
Procedure When(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Когда("{""sample"": ""any""}");
	// then
	Assert.IsUndefined(Result.Constructor);
	Assert.AreEqual(Result.Json, "{""sample"": ""any""}");
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));		

EndProcedure

// @unit-test
Procedure Request(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Запрос("""method"": ""GET""");
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsFalse(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));		
	Assert.IsTrue(IsBlankString(Result.TimesJson));		
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure Headers(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Заголовки()).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpRequest"]["headers"]);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {}
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure WithHeader(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Headers().Заголовок("key", "value")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["key"][0], "value");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""key"": [
							   |    ""value""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure WithMethod(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure WithPath(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Путь("/фуу/foo")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["path"], "/фуу/foo");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""path"": ""/фуу/foo""
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure Response(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Ответ("""statusCode"": 200 ");
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsFalse(IsBlankString(Result.HttpResponseJson));		
	Assert.IsTrue(IsBlankString(Result.TimesJson));
	Assert.IsUndefined(Result.Constructor);
	
EndProcedure

// @unit-test
Procedure WithStatusCode(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().КодОтвета(404));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 404);
	Assert.AreEqual(Mock.Json, "{
								| ""httpResponse"": {
								|  ""statusCode"": 404
								| }
								|}");

EndProcedure

// @unit-test
Procedure WithReasonPhrase(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().Причина("I'm a teapot"));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["reasonPhrase"], "I'm a teapot");
	Assert.AreEqual(Mock.Json, "{
								| ""httpResponse"": {
								|  ""reasonPhrase"": ""I'm a teapot""
								| }
								|}");

EndProcedure

// @unit-test
Procedure Respond(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Ответить();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");

EndProcedure

// @unit-test
Procedure Times(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreCollectionEmpty(Result.Constructor["times"]);

EndProcedure

// @unit-test
Procedure AtLeast(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений().НеМенее(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);

EndProcedure

// @unit-test
Procedure AtMost(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений().НеБолее(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 2);

EndProcedure

// @unit-test
Procedure Exactly(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений().Точно(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 2);

EndProcedure

// @unit-test
Procedure Once(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений().Однократно();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 1);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 1);

EndProcedure

// @unit-test
Procedure Between(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Повторений().Между(2, 3);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 3);

EndProcedure

// @unit-test
Procedure Verify(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().Метод("GET") ).Проверить( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

EndProcedure

// @unit-test
Procedure WithSource(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().Источник("http://...") ).Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsNotUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								| ""httpRequest"": {
								|  ""specUrlOrPayload"": ""http://...""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));
	
EndProcedure

// @unit-test
Procedure WithOperationId(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().Операция("operation_id") ).Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsNotUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								| ""httpRequest"": {
								|  ""operationId"": ""operation_id""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));
	
EndProcedure

// @unit-test
Procedure OpenAPIExpectation(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.ОжидатьOpenAPI( "http://..." );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
	
	Assert.AreEqual(Mock.Json, "{
							   | ""specUrlOrPayload"": ""http://...""
							   |}");
		
EndProcedure

#EndRegion