#Region Internal

// @unit-test
Procedure RespondString(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Respond("""statusCode"": 404");
	// then
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.ResponseJson, """statusCode"": 404");

EndProcedure


//
//// @unit-test
//Procedure WhenWrongType(Context) Export
//	
//	// given
//	Mock = DataProcessors.MockServerClient.Create();
//	// when
//	Result = Mock.When( new Array() );
//	// then
//	Assert.IsTrue(IsBlankString(Result.RequestJson));
//	Assert.IsUndefined(Result.Constructor);
//
//EndProcedure
//
//// @unit-test
//Procedure CallWhenRu(Context) Export
//	
//	// given
//	Mock = DataProcessors.MockServerClient.Create();
//	// when
//	Result = Mock.Когда("""method"": ""GET""");
//	// then
//	Assert.IsUndefined(Result.Constructor);
//	Assert.AreEqual(Result.RequestJson, """method"": ""GET""");
//
//EndProcedure

#EndRegion