#Region Internal

// @unit-test
Procedure VerifyUrlException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test
Procedure VerifyWhenFullJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Verify();
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
Procedure VerifyWhenRequestJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request("""name"":""value""") ).Verify();
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
Procedure VerifyWhenRequestMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().WithMethod("GET") ).Verify();
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
Procedure VerifyWhenVerifyJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify("{""name"":""value""}");
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
Procedure VerifyWhenTimesNode(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify( Mock.Times("""atMost"": 2") );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.JSON, "{
							   | ""times"": {
							   |""atMost"": 2
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.AreEqual(Mock.TimesNode, """atMost"": 2");

EndProcedure

// @unit-test
Procedure VerifydWhenTimesMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure VerifydWhenRequestAndTimes(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify( Mock.Request().WithMethod("GET").Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure VerifydWhenRequestInWhenAndTimesInVerify(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().WithMethod("GET") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure VerifyWhenOpenAPIWithSource(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithSource("http...") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |  ""specUrlOrPayload"": ""http...""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure VerifyWhenOpenAPIWithOperationId(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithOperationId("operation") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |  ""operationId"": ""operation""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

// @unit-test
Procedure VerifyWhenOpenAPI(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithSource("http...").WithOperationId("operation") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.JSON, "{
							   | ""httpRequest"": {
							   |  ""specUrlOrPayload"": ""http..."",
							   |  ""operationId"": ""operation""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));

EndProcedure

#EndRegion