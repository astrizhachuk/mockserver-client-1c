#Region Internal

// @unit-test:dev
Procedure RespondUrlException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test:dev
Procedure RespondWhenFullJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.IsTrue(IsBlankString(Mock.HttpRequestJson));
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");
		
EndProcedure

// @unit-test:dev
Procedure RespondWhenRequestJson(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When( Mock.Request("""name"":""value""") ).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	
	Assert.IsUndefined(Mock.Constructor);
	Assert.AreEqual(Mock.Json, "{
							   |    ""httpRequest"": {""name"":""value""
							   |    }
							   |}");
	Assert.AreEqual(Mock.HttpRequestJson, """name"":""value""");
	Assert.IsTrue(IsBlankString(Mock.HttpResponseJson));

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

// @unit-test:dev
Procedure CallRespondRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When("{""name"":""value""}").Ответить();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.Json, "{""name"":""value""}");

EndProcedure

#EndRegion