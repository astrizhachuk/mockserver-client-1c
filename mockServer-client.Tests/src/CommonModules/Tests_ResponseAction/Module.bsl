#Region Internal

// @unit-test:dev
Procedure WithStatusCodeNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond(Mock.Response().WithStatusCode(404));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 404);

EndProcedure

// @unit-test:dev
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

#EndRegion