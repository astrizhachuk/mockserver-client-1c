#Region Internal

// @unit-test
Procedure WithBody(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().WithBody("some body"));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["body"], "some body");
	Assert.AreEqual(Mock.JSON, "{
								| ""httpResponse"": {
								|  ""body"": ""some body""
								| }
								|}");

EndProcedure

// @unit-test
Procedure WithStatusCode(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().WithStatusCode(404));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 404);
	Assert.AreEqual(Mock.JSON, "{
								| ""httpResponse"": {
								|  ""statusCode"": 404
								| }
								|}");

EndProcedure

// @unit-test:dev
Procedure WithStatusCodeRewrite(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().WithStatusCode(404));
	Mock.Respond(Mock.Response().WithStatusCode(400));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpResponse"]["statusCode"], 400);
	Assert.AreEqual(Mock.JSON, "{
								| ""httpResponse"": {
								|  ""statusCode"": 400
								| }
								|}");
	
EndProcedure	

// @unit-test
Procedure WithReasonPhrase(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond(Mock.Response().WithReasonPhrase("I'm a teapot"));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["reasonPhrase"], "I'm a teapot");
	Assert.AreEqual(Mock.JSON, "{
								| ""httpResponse"": {
								|  ""reasonPhrase"": ""I'm a teapot""
								| }
								|}");

EndProcedure

#EndRegion