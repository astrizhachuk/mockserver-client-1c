#Region Internal

// @unit-test
Procedure WhenParamsString(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When("{""sample"": ""any""}");
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsUndefined(Result.Constructor);
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.AreEqual(Result.Json, "{""sample"": ""any""}");

EndProcedure

// @unit-test
Procedure WhenParamsRequestAction(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( Mock.Request() );
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

// @unit-test
Procedure WhenWrongParams(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( new Array() );
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsTrue(IsBlankString(Result.Json));
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));
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
	Assert.IsTrue(IsBlankString(Result.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Result.HttpResponseJson));

EndProcedure

#EndRegion