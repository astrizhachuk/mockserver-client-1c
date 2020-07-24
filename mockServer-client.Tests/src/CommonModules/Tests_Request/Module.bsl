#Region Internal

// @unit-test
Procedure RequestUndefinedConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Request();
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure RequestReInitWrongConstructor(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Array();
	// when
	Result = Mock.Request();
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure RequestStringJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Request("""method"": ""GET""");
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsFalse(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));		
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure CallRequestRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Запрос("""method"": ""GET""");
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsFalse(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));		
	Assert.IsUndefined(Result.Constructor);

EndProcedure

#EndRegion