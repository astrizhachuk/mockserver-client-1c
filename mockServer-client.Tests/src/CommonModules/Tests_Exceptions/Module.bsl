#Region Internal

// @unit-test
Procedure CurrentStageEmptySelfException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Try
		// when
		Result = Mock.WithMethod("GET");
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
		Assert.AreEqual(Mock.CurrentStage, "");
	EndTry;

EndProcedure

// @unit-test
Procedure RequestEmptyMapException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.CurrentStage = "foo";
	Mock.Constructor = New Map();
	Try
		// when
		Result = Mock.WithMethod("GET");
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
		Assert.AreEqual(Mock.CurrentStage, "foo");
	EndTry;
	
EndProcedure

// @unit-test
Procedure ResponseEmptyMapException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.CurrentStage = "foo";
	Mock.Constructor = New Map();
	Try
		// when
		Result = Mock.WithStatusCode(404);
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
		Assert.AreEqual(Mock.CurrentStage, "foo");
	EndTry;
	
EndProcedure

// @unit-test
Procedure RequestBlankException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", "");
	Try
		// when
		Result = Mock.WithMethod("GET");
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
	EndTry;	

EndProcedure

// @unit-test
Procedure ResponseBlankException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpResponse", "");
	Try
		// when
		Result = Mock.WithStatusCode(404);
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
	EndTry;	

EndProcedure

#EndRegion