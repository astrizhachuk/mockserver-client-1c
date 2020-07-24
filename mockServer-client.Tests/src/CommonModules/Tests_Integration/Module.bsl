#Region Internal

// @unit-test:inegration
Procedure MockServerDockerUp(Context) Export
	
	Raise "Fail";
	
EndProcedure

// @unit-test:dev
Procedure Reset(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Reset();
	// then
		
EndProcedure

// @unit-test:dev
Procedure RespondResponse(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.URL = "localhost:1080";
	// when
	Mock.When( Mock.Request("""method"":""GET""") ).Respond( Mock.Response("""statusCode"": 404") );
	// then

EndProcedure



#EndRegion