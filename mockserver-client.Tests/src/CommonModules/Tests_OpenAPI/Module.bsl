#Region Internal

// @unit-test
Procedure OpenAPIOnlySource(Context) Export
	
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
Procedure OpenAPISourceAndOperations(Context) Export
	
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
