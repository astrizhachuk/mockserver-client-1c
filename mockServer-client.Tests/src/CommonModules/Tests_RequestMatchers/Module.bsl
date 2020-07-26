#Region Internal

// @unit-test
Procedure PropertyByStage(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Метод("GET")).Respond(Mock.Response().Метод("GET"));
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"]["method"], "GET");
	Assert.AreEqual(Mock.Constructor["httpResponse"]["method"], "GET");

EndProcedure

// @unit-test:dev
Procedure HeadersWithoutParams(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Headers()).Respond();
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.AreEqual(Mock.Constructor["httpRequest"].Count(), 1);
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpRequest"]["headers"]);

EndProcedure

// @unit-test:dev
Procedure HeadersWithParams(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
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

// @unit-test:dev
Procedure HeadersByStage(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Headers()).Respond(Mock.Response().Headers());
	// then
	Assert.AreEqual(Mock.CurrentStage, "");
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpRequest"]["headers"]);
	Assert.IsInstanceOfType("Map", Mock.Constructor["httpResponse"]["headers"]);

EndProcedure

// @unit-test:dev
Procedure WithHeader(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key", "value")).Respond();
	// then
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

// @unit-test:dev
Procedure WithHeaderArrayValue(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Array = New Array();
	Array.Add("value1");
	Array.Add("value2");
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key", Array)).Respond();
	// then
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

// @unit-test:dev
Procedure WithHeaderWithoutHeaders(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().WithHeader("key", "value")).Respond();
	// then
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

// @unit-test:dev
Procedure WithHeaderTwoHeader(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.When(Mock.Request().Headers().WithHeader("key1", "value1").WithHeader("key2", "value2")).Respond();
	// then
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