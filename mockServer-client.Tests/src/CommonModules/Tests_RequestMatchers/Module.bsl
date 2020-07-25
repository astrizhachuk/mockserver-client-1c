#Region Internal

// @unit-test
Procedure WithMethodNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Mock.When(Mock.Request().WithMethod("GET")).Respond();
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");

EndProcedure

// @unit-test
Procedure WithMethodRewrite(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Mock.When(Mock.Request().WithMethod("GET")).Respond();
	Mock.When(Mock.Request().WithMethod("POST")).Respond();
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "POST");	
	
EndProcedure	

// @unit-test
Procedure CallMethodsRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Constructor = New Map();
	Mock.Constructor.Insert("httpRequest", New Map());
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond();
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");

EndProcedure

#EndRegion