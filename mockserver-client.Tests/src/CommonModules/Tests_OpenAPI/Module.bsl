#Region Internal

// @unit-test
Procedure OpenAPIUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.OpenAPI();
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpRequest");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));	
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure OpenAPIStringJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.OpenAPI("""specUrlOrPayload"": ""http://..."", ""operationId"": ""operation_id""");
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpRequest");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsFalse(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));
	Assert.IsUndefined(Result.Constructor);
	
	Assert.AreEqual(Mock.HttpRequestJson, """specUrlOrPayload"": ""http://..."", ""operationId"": ""operation_id""");

EndProcedure

// @unit-test
Procedure OpenAPIWhenOpenAPIMap(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.OpenAPI().WithSource("http://...").WithOperationId("operation_id") ).Verify();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsNotUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
								| ""httpRequest"": {
								|  ""specUrlOrPayload"": ""http://..."",
								|  ""operationId"": ""operation_id""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));
	
EndProcedure

// @unit-test
Procedure OpenAPIExpectationOnlySource(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.OpenAPIExpectation( "http://..." );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
	
	Assert.AreEqual(Mock.Json, "{
							   | ""specUrlOrPayload"": ""http://...""
							   |}");
		
EndProcedure

// @unit-test
Procedure OpenAPIExpectationSourceAndOperations(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.OpenAPIExpectation( "http://...", """operation"": ""200""" );
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Mock.TimesJson));
	Assert.AreEqual(Mock.Json, "{
							   | ""specUrlOrPayload"": ""http://..."",
							   | ""operationsAndResponses"": {
							   |  ""operation"": ""200""
							   | }
							   |}");

EndProcedure

#EndRegion
