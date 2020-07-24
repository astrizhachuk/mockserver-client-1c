#Region Internal

// @unit-test
Procedure ResetIntermediateException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	// when
	Mock.Server("this.is.error.url", "1080", true);
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test
Procedure ResetTerminalException(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Reset();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
		
EndProcedure

// @unit-test
Procedure CallResetRu(Context) Export
	
	// given
	Mock = DataProcessors.MockServerClient.Create();
	Mock.Server("this.is.error.url", "1080");
	// when
	Mock.Сбросить();
	// then
	Assert.AreEqual(Mock.MockServerResponse.КодСостояния, 500);
	Assert.IsFalse(IsBlankString(Mock.MockServerResponse.ТекстОшибки));
	
EndProcedure

#EndRegion