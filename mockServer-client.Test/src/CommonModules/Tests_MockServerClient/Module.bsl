#Region Internal

// @unit-test:fast
// Parameters:
// 	Context - ФреймворкТестирования - Context
//
Procedure MockServerDockerUp(Context) Export
	
	Raise "Fail";
	
EndProcedure

// @unit-test
// Parameters:
// 	Context - ФреймворкТестирования - Context
//
Procedure InitServer(Context) Export
	
	//given
	Mock = DataProcessors.MockServerClient.Create();
	//when
	Mock.Server("http://host.docker.internal:1080");
	//then
	Context.AssertEqual(Mock.URL, "http://host.docker.internal:1080");
	
	//given
	MockRu = DataProcessors.MockServerClient.Create();
	//when
	MockRu.Server("http://host.docker.internal:1090");
	//then
	Context.AssertEqual(MockRu.URL, "http://host.docker.internal:1090");
	Context.AssertNotEqual(Mock.URL, MockRu.URL);
	
EndProcedure

#EndRegion