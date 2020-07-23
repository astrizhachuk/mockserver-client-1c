#Region Internal

// @unit-test
Procedure WithMethodUndefinedConstructorException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Try
		// when
		Result = Mock.WithMethod();
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
	EndTry;

EndProcedure
	
// @unit-test
Procedure WithMethodEmptyMapException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Try
		// when
		Result = Mock.WithMethod();
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
	EndTry;
	
EndProcedure

// @unit-test
Procedure WithMethodEmptyRequestException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", "");
	Try
		// when
		Result = Mock.WithMethod();
	Except
		// then
		Assert.IsLegalException("[RuntimeError]", ErrorInfo());
	EndTry;	

EndProcedure

// @unit-test
Procedure WithMethodEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Result = Mock.WithMethod();
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "");
	
EndProcedure
	
// @unit-test
Procedure WithMethodNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Result = Mock.WithMethod("GET");
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");

EndProcedure

// @unit-test
Procedure WithMethodRewrite(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Result = Mock.WithMethod("");
	Result = Mock.WithMethod("GET");
	Result = Mock.WithMethod("POST");
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "POST");	
	
EndProcedure	

// @unit-test
Procedure RuCallMethods(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Result = Mock.Метод();
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "");

EndProcedure

#EndRegion