#Region Internal

// @unit-test
Procedure PropertyByStage(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond(Mock.Response().Метод("POST"));
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["method"], "POST");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | },
							   | ""httpResponse"": {
							   |  ""method"": ""POST""
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure HeadersWithoutParams(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Headers()).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpRequest"]["headers"]);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {}
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure HeadersWithParams(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");	

	Value1 = New Array();
	Value1.Add("array1_1");
	Value1.Add("array1_2");
	Value2 = New Array();
	Value2.Add("array2_1");
	Value2.Add("array2_2");
	Headers = New Map();
	Headers.Insert("header1", Value1);
	Headers.Insert("header2", Value2);
	// when
	Mock.When(Mock.Request().Headers(Headers)).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"].Count(), 2);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["header1"].Count(), 2);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["header1"][0], "array1_1");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""header1"": [
							   |    ""array1_1"",
							   |    ""array1_2""
							   |   ],
							   |   ""header2"": [
							   |    ""array2_1"",
							   |    ""array2_2""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure HeadersByStage(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Headers()).Respond(Mock.Response().Headers());
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpRequest"]["headers"]);
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpResponse"]["headers"]);
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {}
							   | },
							   | ""httpResponse"": {
							   |  ""headers"": {}
							   | }
							   |}");

EndProcedure

// @unit-test
Procedure WithHeader(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key", "value")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["key"][0], "value");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""key"": [
							   |    ""value""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure WithHeaderArrayValue(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	Array = New Array();
	Array.Add("value1");
	Array.Add("value2");
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key", Array)).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["key"][0], "value1");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""key"": [
							   |    ""value1"",
							   |    ""value2""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure WithHeaderWithoutHeaders(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().WithHeader("key", "value")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);	
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["key"][0], "value");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""key"": [
							   |    ""value""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure WithHeaderTwoHeader(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key1", "value1").WithHeader("key2", "value2")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["headers"]["key1"][0], "value1");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""headers"": {
							   |   ""key1"": [
							   |    ""value1""
							   |   ],
							   |   ""key2"": [
							   |    ""value2""
							   |   ]
							   |  }
							   | }
							   |}" );

EndProcedure

// @unit-test
Procedure WithMethodNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().WithMethod("GET")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""method"": ""GET""
							   | }
							   |}");

EndProcedure

// @unit-test:dev
Procedure WithMethodRewrite(Context) Export

	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().WithMethod("GET")).Respond();
	Mock.When(Mock.Request().WithMethod("POST")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "POST");	
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""method"": ""POST""
							   | }
							   |}");
	
EndProcedure

// @unit-test
Procedure WithPathNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().WithPath("/фуу/foo")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["path"], "/фуу/foo");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""path"": ""/фуу/foo""
							   | }
							   |}");
							   
EndProcedure

// @unit-test:dev
Procedure WithQueryStringParametersNotEmpty(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.When(Mock.Request().WithQueryStringParameters("cartId", "[A-Z0-9\\-]+")).Respond();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["queryStringParameters"]["cartId"][0], "[A-Z0-9\\-]+");
	Assert.AreEqual(Mock.Json, "{
							   | ""httpRequest"": {
							   |  ""queryStringParameters"": {
            				   |   ""cartId"": [
            				   |    ""[A-Z0-9\\\\-]+""
            				   |   ]
        					   |  }
							   | }
							   |}");
							   
EndProcedure

#EndRegion