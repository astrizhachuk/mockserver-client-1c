#Region Internal

// @unit-test
Procedure WhenString(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When("{""sample"": ""any""}");
	// then
	Assert.IsUndefined(Result.Constructor);
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));
	Assert.AreEqual(Result.Json, "{""sample"": ""any""}");

EndProcedure

// @unit-test
Procedure WhenRequest(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( Mock.Request() );
	// then
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));
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
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));
	Assert.IsUndefined(Result.Constructor);

EndProcedure

// @unit-test
Procedure CallWhenRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Когда("{""sample"": ""any""}");
	// then
	Assert.IsUndefined(Result.Constructor);
	Assert.AreEqual(Result.Json, "{""sample"": ""any""}");
	Assert.IsTrue(IsBlankString(Result.RequestBodyJson));
	Assert.IsTrue(IsBlankString(Result.ResponseBodyJson));

EndProcedure

#EndRegion