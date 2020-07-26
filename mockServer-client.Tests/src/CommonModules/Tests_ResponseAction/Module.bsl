#Region Internal

// @unit-test
Procedure WithStatusCode(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond(Mock.Response().WithStatusCode(404));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 404);

EndProcedure

// @unit-test
Procedure WithStatusCodeRewrite(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond(Mock.Response().WithStatusCode(404));
	Mock.Respond(Mock.Response().WithStatusCode(400));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 400);	
	
EndProcedure	

// @unit-test
Procedure WithBody(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond(Mock.Response().WithBody("some body"));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["body"], "some body");

EndProcedure

#EndRegion