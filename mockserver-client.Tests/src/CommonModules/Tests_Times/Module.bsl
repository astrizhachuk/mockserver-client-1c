#Region Internal

// @unit-test
Procedure TimesUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreCollectionEmpty(Result.Constructor["times"]);

EndProcedure

// @unit-test
Procedure TimesReInitWrongConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Array();
	// when
	Result = Mock.Times();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreCollectionEmpty(Result.Constructor["times"]);

EndProcedure

// @unit-test
Procedure TimesRequestExists(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert( "httpRequest", New Map() );
	// when
	Result = Mock.Times();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsTrue(IsBlankString(Result.TimesJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 2);
	Assert.IsNotUndefined(Result.Constructor["httpRequest"]);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreCollectionEmpty(Result.Constructor["times"]);

EndProcedure

// @unit-test
Procedure TimesStringJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times("""atLeast"": 2, ""atMost"": 2");
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsFalse(IsBlankString(Result.TimesJson));			
	Assert.IsUndefined(Result.Constructor);

EndProcedure

#EndRegion