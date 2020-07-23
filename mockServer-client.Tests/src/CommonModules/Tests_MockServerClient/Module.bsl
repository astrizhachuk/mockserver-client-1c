#Region Internal

// @unit-test:fast
Procedure MockServerDockerUp(Context) Export
	
	Raise "Fail";
	
EndProcedure

// @unit-test
Procedure InitServer(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("http://localhost:1080");
	// then
	Assert.AreEqual(Mock.URL, "http://localhost:1080");
	
	// given
	MockRu = DataProcessors.MockServerClient.Create();
	// when
	MockRu.Server("http://localhost:1090");
	// then
	Assert.AreEqual(MockRu.URL, "http://localhost:1090");
	Assert.AreNotEqual(Mock.URL, MockRu.URL);
	
EndProcedure

#EndRegion