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
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.AreEqual(Result.JSON, "{""sample"": ""any""}");

EndProcedure

// @unit-test
Procedure WhenParamsRequestAction(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.When( Mock.Request() );
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
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
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsUndefined(Result.Constructor);

EndProcedure

#EndRegion