#Region Internal

// @unit-test:dev
Procedure RespondUrlException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test:dev
Procedure RespondWhenFullJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");
		
EndProcedure

// @unit-test:dev
Procedure RespondWhenRequestJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request("""name"":""value""") ).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |""name"":""value""
							   | }
							   |}");
	Assert.AreEqual(Mock.HttpRequestJson, """name"":""value""");
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));

EndProcedure

// @unit-test:dev
Procedure RespondWhenRequestMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().WithMethod("GET") ).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsNotUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								| ""httpRequest"": {
								|  ""method"": ""GET""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));

EndProcedure

// @unit-test:dev
Procedure RespondWhenRespondJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond("{""name"":""value""}");
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								|
								|}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));

EndProcedure

// @unit-test:dev
Procedure RespondWhenResponseJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond( Mock.Response("""statusCode"":404") );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpResponse"": {
							   |""statusCode"":404
							   | }
							   |}");
	Assert.AreEqual(Mock.HttpResponseJson, """statusCode"":404");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));

EndProcedure

//// @unit-test:dev
//Procedure RespondWhenResponseMap(Context) Export
//	
//	// given
//	Mock = DataProcessors.MockServerClient.Create();
//	Mock.Server("this.is.error.url", "1080");
//	// when
//	Mock.Respond( Mock.Response().StatusCode() );
//	// then
//	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
//	
//	Assert.IsUndefined(Mock.Constructor);
//	Assert.AreEqual(Mock.Json, "{
//							   | ""httpResponse"": {
//							   |""statusCode"":404
//							   | }
//							   |}");
//	Assert.AreEqual(Mock.HttpResponseJson, """statusCode"":404");
//	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
//
//EndProcedure

// @unit-test:dev
Procedure CallRespondRu(Context) Export
	
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