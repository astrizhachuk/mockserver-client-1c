#Region Internal

// @unit-test
Procedure TimesUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
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
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
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
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 2);
	Assert.IsNotUndefined(Result.Constructor["httpRequest"]);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreCollectionEmpty(Result.Constructor["times"]);

EndProcedure

// @unit-test
Procedure TimesStringJSON(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times("""atLeast"": 2, ""atMost"": 2");
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsFalse(IsBlankString(Result.TimesNode));			
	Assert.IsUndefined(Result.Constructor);

EndProcedure

#EndRegion