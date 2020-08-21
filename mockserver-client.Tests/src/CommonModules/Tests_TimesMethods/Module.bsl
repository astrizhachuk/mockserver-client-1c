#Region Internal

// @unit-test
Procedure AtLeast(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times().AtLeast(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreEqual(Result.Constructor["times"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);

EndProcedure

// @unit-test
Procedure AtMost(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times().AtMost(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreEqual(Result.Constructor["times"].Count(), 1);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 2);

EndProcedure

// @unit-test
Procedure Exactly(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times().Exactly(2);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreEqual(Result.Constructor["times"].Count(), 2);
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 2);

EndProcedure

// @unit-test
Procedure Once(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times().Once();
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreEqual(Result.Constructor["times"].Count(), 2);
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 1);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 1);

EndProcedure

// @unit-test
Procedure Between(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Result = Mock.Times().Between(2, 3);
	// then
	Assert.AreEqual(Mock.CurrentStage, "times");
	Assert.IsTrue(IsBlankString(Result.JSON));
	Assert.IsTrue(IsBlankString(Result.HttpRequestNode));
	Assert.IsTrue(IsBlankString(Result.HttpResponseNode));
	Assert.IsTrue(IsBlankString(Result.TimesNode));
	Assert.IsInstanceOfType("Map", Result.Constructor);
	Assert.AreEqual(Result.Constructor.Count(), 1);
	Assert.IsInstanceOfType("Map", Result.Constructor["times"]);
	Assert.AreEqual(Result.Constructor["times"].Count(), 2);
	Assert.AreEqual(Mock.Constructor["times"]["atLeast"], 2);
	Assert.AreEqual(Mock.Constructor["times"]["atMost"], 3);

EndProcedure

#EndRegion