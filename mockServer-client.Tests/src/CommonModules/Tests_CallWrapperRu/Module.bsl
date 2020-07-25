#Region Internal

// @unit-test
Procedure Server(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Сервер("example.org", "1090");
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
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure WithMethod(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond();
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");

EndProcedure

// @unit-test
Procedure WithPath(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Путь("/фуу/foo")).Respond();
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["path"], "/фуу/foo");

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
	Assert.IsUndefined(Result.Constructor);
	
EndProcedure

// @unit-test
Procedure WithStatusCode(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond(Mock.Response().КодОтвета(404));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 404);

EndProcedure

// @unit-test:dev
Procedure Respond(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Ответить();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");

EndProcedure

#EndRegion