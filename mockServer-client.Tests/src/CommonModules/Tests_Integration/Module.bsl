#Region Internal

// @unit-test:inegration
Procedure MockServerDockerUp(Context) Export
	
	Raise "Fail";
	
EndProcedure

// @unit-test:dev
Procedure RespondResponse(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.URL = "http://localhost:1080";
	// when
	Mock.When( """method"":""GET""" ).Respond( """statusCode"": 404"  );
	// then
//	Assert.IsTrue(IsBlankString(Result.RequestJson));
//	Assert.IsInstanceOfType("Map", Result.Constructor["httpRequest"]);
//	Assert.AreCollectionEmpty(Result.Constructor["httpRequest"]);

EndProcedure

#EndRegion