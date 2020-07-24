#Region Internal

// @unit-test
Procedure WhenString(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When("""method"": ""GET""");
	// then
	Assert.IsUndefined(Result.Constructor);
	Assert.AreEqual(Result.RequestJson, """method"": ""GET""");

EndProcedure

// @unit-test
Procedure WhenRequest(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( Mock.Request() );
	// then
	Assert.IsTrue(IsBlankString(Result.RequestJson));
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure WhenWrongType(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( new Array() );
	// then
	Assert.IsTrue(IsBlankString(Result.RequestJson));
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure CallWhenRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Когда("""method"": ""GET""");
	// then
	Assert.IsUndefined(Result.Constructor);
	Assert.AreEqual(Result.RequestJson, """method"": ""GET""");

EndProcedure

#EndRegion