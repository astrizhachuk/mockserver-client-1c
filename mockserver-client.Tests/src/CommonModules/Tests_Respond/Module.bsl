#Region Internal

// @unit-test
Procedure RespondURLException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test
Procedure RespondWhenFullJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));
	Assert.AreEqual(Mock.JSON, "{""name"":""value""}");
		
EndProcedure

// @unit-test
Procedure RespondWhenRequestJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request("""name"":""value""") ).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |""name"":""value""
							   | }
							   |}");
	Assert.AreEqual(Mock.HttpRequestNode, """name"":""value""");
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure RespondWhenRequestMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().WithMethod("GET") ).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsNotUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.JSON, "{
								| ""httpRequest"": {
								|  ""method"": ""GET""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure RespondWhenRespondJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond("{""name"":""value""}");
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);

	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.JSON, "{
								|}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure RespondWhenResponseJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond( Mock.Response("""statusCode"":404") );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpResponse"": {
							   |""statusCode"":404
							   | }
							   |}");
	Assert.AreEqual(Mock.HttpResponseNode, """statusCode"":404");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure RespondWhenResponseMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond( Mock.Response().WithStatusCode(404) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpResponse"": {
							   |  ""statusCode"": 404
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

#EndRegion