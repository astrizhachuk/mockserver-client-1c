#Region Internal

// @unit-test
Procedure OpenAPIUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.OpenAPI();
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpRequest");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));	
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure OpenAPIStringJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.OpenAPI("""specUrlOrPayload"": ""http://..."", ""operationId"": ""operation_id""");
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpRequest");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsFalse(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsUndefined(Result.Constructor);
	
	Assert.AreEqual(Mock.HttpRequestNode, """specUrlOrPayload"": ""http://..."", ""operationId"": ""operation_id""");

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
	Assert.AreEqual(Mock.JSON, "{
								| ""httpRequest"": {
								|  ""specUrlOrPayload"": ""http://..."",
								|  ""operationId"": ""operation_id""
								| }
								|}");

	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));
	
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
	
	Assert.AreEqual(Mock.JSON, "{
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
	Assert.IsTrue(IsBlankString(Mock.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Mock.TimesNode));
	Assert.AreEqual(Mock.JSON, "{
							   | ""specUrlOrPayload"": ""http://..."",
							   | ""operationsAndResponses"": {
							   |  ""operation"": ""200""
							   | }
							   |}");

EndProcedure

#EndRegion
