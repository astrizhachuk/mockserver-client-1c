#Region Internal

// @unit-test
Procedure CreateNewClientsWithoutServer(Context) Export
	
	// given
	Mock_1 = DataProcessors.MockServerClient.Create();
	Mock_2 = DataProcessors.MockServerClient.Create();
	// when
	// then
	Assert.AreEqual(Mock_1.URL, "localhost:1080");
	Assert.AreEqual(Mock_2.URL, "localhost:1080");
	
EndProcedure

// @unit-test
Procedure CreateNewClientsWithServer(Context) Export
	
	// given
	Mock_1 = DataProcessors.MockServerClient.Create();
	Mock_2 = DataProcessors.MockServerClient.Create();
	// when
	Result_1 = Mock_1.Server("http://localhost:1080");
	Result_2 = Mock_2.Server("http://localhost:1090");
	// then
	Assert.AreEqual(Result_1.URL, "http://localhost:1080");
	Assert.AreEqual(Result_2.URL, "http://localhost:1090");
	
EndProcedure

// @unit-test
Procedure CreateClientNotDefaultURL(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Server("http://example.org");
	// then	
	Assert.AreEqual(Result.URL, "http://example.org");
	Assert.IsUndefined(Result.MockServerResponse);
		
EndProcedure

// @unit-test
Procedure CreateClientOnlyServerName(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Server("example.org");
	// then	
	Assert.AreEqual(Result.URL, "example.org");
	Assert.IsUndefined(Result.MockServerResponse);
		
EndProcedure

// @unit-test
Procedure CreateClientServerNameAndPort(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Server("example.org", "1090");
	// then	
	Assert.AreEqual(Result.URL, "example.org:1090");
	Assert.IsUndefined(Result.MockServerResponse);
		
EndProcedure

// @unit-test
Procedure CreateClientAndResetAfter(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Server("this.is.error.url", "1080", true);
	// then	
	Assert.AreEqual(Result.URL, "this.is.error.url:1080");
	Assert.AreEqual(Result.MockServerResponse.КодСостояния, 500);
		
EndProcedure

// @unit-test
Procedure CreateFluence(Context) Export
	
	// when
	Result = DataProcessors.MockServerClient.Create().Server("this.is.error.url", "1080", true);
	// then	
	Assert.AreEqual(Result.URL, "this.is.error.url:1080");
	Assert.AreEqual(Result.MockServerResponse.КодСостояния, 500);
		
EndProcedure

#EndRegion