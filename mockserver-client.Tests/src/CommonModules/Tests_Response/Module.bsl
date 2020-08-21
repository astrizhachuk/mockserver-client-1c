#Region Internal

// @unit-test
Procedure ResponseUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Response();
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpResponse");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
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
	Assert.AreEqual(Mock.CurrentStage, "httpResponse");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
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
	Assert.AreEqual(Mock.CurrentStage, "httpResponse");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 2);
	Assert.IsNotUndefined(Result.Constructor["httpRequest"]);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpResponse"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpResponse"]);

EndProcedure

// @unit-test
Procedure ResponseStringJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Response("""statusCode"": 200 ");
	// then
	Assert.AreEqual(Mock.CurrentStage, "httpResponse");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsFalse(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));		
	Assert.IsUndefined(Result.Constructor);

EndProcedure

#EndRegion