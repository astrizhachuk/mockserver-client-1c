#Region Internal

// @unit-test
Procedure ResponseUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Response();
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpResponse"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpResponse"]);

EndProcedure

// @unit-test
Procedure ResponseReInitWrongConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Array();
	// when
	Result = Mock.Response();
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpResponse"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpResponse"]);

EndProcedure

// @unit-test
Procedure ResponseRequestExists(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert( "httpRequest", New Map() );
	// when
	Result = Mock.Response();
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 2);
	Assert.IsNotUndefined(Result.Constructor["httpRequest"]);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpResponse"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpResponse"]);

EndProcedure

// @unit-test
Procedure ResponseStringJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Response("""statusCode"": 200 ");
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsFalse(IsBlankString(Result.HttpResponseJson));		
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure CallResponseRu(Context) Export
	
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

#EndRegion