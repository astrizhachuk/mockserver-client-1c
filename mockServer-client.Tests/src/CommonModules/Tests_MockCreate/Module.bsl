#Region Internal

// @unit-test:dev
Procedure CreateNewObjectsWithoutServer(Context) Export
	
	// given
	Mock_1 = DataProcessors.MockServerClient.Create();
	Mock_2 = DataProcessors.MockServerClient.Create();
	// when
	// then
	Assert.AreEqual(Mock_1.URL, "http://localhost:1080");
	Assert.AreEqual(Mock_2.URL, "http://localhost:1080");
	
EndProcedure

// @unit-test:dev
Procedure CreateNewObjectsWithServer(Context) Export
	
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

#EndRegion