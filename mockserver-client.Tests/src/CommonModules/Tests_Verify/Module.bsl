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
Procedure VerifyWhenFullJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");
		
EndProcedure

// @unit-test
Procedure VerifyWhenRequestJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request("""name"":""value""") ).Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |""name"":""value""
							   | }
							   |}");
	Assert.AreEqual(Mock.HttpRequestJson, """name"":""value""");
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

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
	Assert.AreEqual(Mock.Json, "{
								| ""httpRequest"": {
								|  ""method"": ""GET""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

EndProcedure

// @unit-test
Procedure VerifyWhenVerifyJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify("{""name"":""value""}");
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);

	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								|}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

EndProcedure

// @unit-test
Procedure VerifyWhenTimesJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Verify( Mock.Times("""atMost"": 2") );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
							   | ""times"": {
							   |""atMost"": 2
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.AreEqual(Mock.TimesJson, """atMost"": 2");

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
	Assert.AreEqual(Mock.Json, "{
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

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
Procedure VerifydWhenRequestInWhenAndTimesInVerify(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request().WithMethod("GET") ).Verify( Mock.Times().AtMost(3) );
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
Procedure VerifyWhenOpenAPIWithSource(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithSource("http...") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""specUrlOrPayload"": ""http...""
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
Procedure VerifyWhenOpenAPIWithOperationId(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithOperationId("operation") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""operationId"": ""operation""
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
Procedure VerifyWhenOpenAPI(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithSource("http...").WithOperationId("operation") ).Verify( Mock.Times().AtMost(3) );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""specUrlOrPayload"": ""http..."",
							   |  ""operationId"": ""operation""
							   | },
							   | ""times"": {
							   |  ""atMost"": 3
							   | }
							   |}");
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));

EndProcedure

#EndRegion