#Region Internal

// @unit-test:dev
Procedure PropertyByStage(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond(Mock.Response().Метод("GET"));
	// then
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["method"], "GET");

EndProcedure

// @unit-test
Procedure WithMethodNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
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
	// when
	Mock.When(Mock.Request().WithMethod("GET")).Respond();
	Mock.When(Mock.Request().WithMethod("POST")).Respond();
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "POST");	
	
EndProcedure

// @unit-test
Procedure WithPathNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().WithPath("/фуу/foo")).Respond();
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["path"], "/фуу/foo");

EndProcedure	

#EndRegion