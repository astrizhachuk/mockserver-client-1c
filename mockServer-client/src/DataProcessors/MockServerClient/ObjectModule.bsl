#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

#Region Ru

Function Сервер( URL, Port = Undefined ) Export
	
	Return Server( URL, Port );
	
EndFunction

Procedure Сбросить() Export
	
	Reset();
	
EndProcedure

Procedure Ответить( Ожидание = Undefined ) Export
	
	Respond( Ожидание );
	
EndProcedure

Function Когда( Запрос ) Export
	
	Return When( Запрос );
	
EndFunction

Function Запрос( ЗапросJson = Undefined ) Export
	
	Return Request( ЗапросJson );
	
EndFunction

Function Ответ( ОтветJson = Undefined ) Export
	
	Return Response( ОтветJson );
	
EndFunction

Function Заголовки( Заголовки = Undefined ) Export
	
	Return Headers( Заголовки );
	
EndFunction

Function Метод( Метод ) Export
	
	Return WithMethod( Метод );
	
EndFunction

Function Путь( Путь ) Export
	
	Return WithPath( Путь );
	
EndFunction

Function Тело( Тело ) Export
	
	Return WithBody( Тело );
	
EndFunction

Function КодОтвета( КодОтвета ) Export
	
	Return WithStatusCode( КодОтвета );
	
EndFunction

#EndRegion

#Region En
	
#Region Intermediate

Function Server( Val URL, Val Port = Undefined, Val Reset = false ) Export
	
	If ( Port <> Undefined ) Then

		URL = URL + ":" + Port;
		
	EndIf;
	
	ThisObject.URL = URL;
	
	If ( Reset ) Then
		
		Reset();
		
		If ( HTTPStatusCode.isOk(ThisObject.MockServerResponse.КодСостояния) ) Then
			
			ThisObject.MockServerResponse = Undefined;
			
		EndIf;
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function When( Val What ) Export
	
	ThisObject.CurrentStage = "";
	
	If ( TypeOf(What) = Type("String") ) Then
		
		ThisObject.Json = What;
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function Request( Val HttpRequestJson = Undefined ) Export
	
	ThisObject.CurrentStage = "httpRequest";
	FillPropertyByValue( "httpRequest", HttpRequestJson );

	Return ThisObject;
	
EndFunction

Function Response( Val HttpResponseJson = Undefined  ) Export
	
	ThisObject.CurrentStage = "httpResponse";
	FillPropertyByValue( "httpResponse", HttpResponseJson );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#Region Terminal

Procedure Reset() Export
	
	ThisObject.CurrentStage = "";
	
	Try

		ThisObject.MockServerResponse = HTTPConnector.Put( ThisObject.URL + "/mockserver/reset" );
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;
	
EndProcedure

Procedure Respond( Val Object = Undefined ) Export
	
	ThisObject.CurrentStage = "";
	
	// TODO add Action (time, httpOverrideForwardedRequest, httpForward, errors etc)
	
	Try

		GenerateJson();
		
		ThisObject.MockServerResponse = HTTPConnector.Put( ThisObject.Url + "/mockserver/expectation",
															ThisObject.Json,
															ContentTypeJsonHeaders() );
		
		If ( NOT HTTPStatusCode.isCreated(ThisObject.MockServerResponse.КодСостояния) ) Then
		
			Raise HTTPConnector.КакТекст( ThisObject.MockServerResponse );		
		
		EndIf;
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;		

EndProcedure

#EndRegion

#Region RequestMatchers

Function WithMethod( Val Method ) Export
	
	Var ConstructorProperty;
	
	CheckObjectPropertiesForMethod();
	
	ConstructorProperty = ConstructorPropertyByStage( ThisObject.CurrentStage );
	ConstructorProperty.Insert( "method", Method );
	
	Return ThisObject;
	
EndFunction

Function WithPath( Val Path ) Export
	
	Var ConstructorProperty;
	
	CheckObjectPropertiesForMethod();
	
	ConstructorProperty = ConstructorPropertyByStage( ThisObject.CurrentStage );
	ConstructorProperty.Insert( "path", Path );
	
	Return ThisObject;
	
EndFunction

Function Headers( Val Headers = Undefined ) Export
	
	CheckObjectPropertiesForMethod();
	
	If ( Headers = Undefined ) Then
		
		Headers = New Map();
		
	EndIf;
	
	FillPropertyByValue( "headers", Headers, ThisObject.CurrentStage );

	Return ThisObject;
	
EndFunction
	
#EndRegion

#Region Actions

#Region ResponseAction

Function WithBody( Val Body ) Export
	
	Var ConstructorProperty;

	CheckObjectPropertiesForMethod();

	ConstructorProperty = ConstructorPropertyByStage( ThisObject.CurrentStage );
	ConstructorProperty.Insert( "body", Body );
	
	Return ThisObject;
	
EndFunction

Function WithStatusCode( Val StatusCode ) Export
	
	Var ConstructorProperty;

	CheckObjectPropertiesForMethod();

	ConstructorProperty = ConstructorPropertyByStage( ThisObject.CurrentStage );
	ConstructorProperty.Insert( "statusCode", StatusCode );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#EndRegion

#EndRegion

#Region Private

Процедура CheckObjectPropertiesForMethod()
	
	RaiseIfCurrentStageEmpty();
	RaiseIfConstructorUndefined();
	
КонецПроцедуры

Procedure RaiseIfCurrentStageEmpty()
	
	If ( IsBlankString(ThisObject.CurrentStage) ) Then
		Raise RuntimeError(
		    NStr("en = 'The action needs to be initialized first.';
		         |ru = 'Сначала необходимо инициализировать действие.'")
		);
	EndIf;
	
EndProcedure

Procedure RaiseIfConstructorUndefined()
	
	If ( ThisObject.Constructor = Undefined ) Then
		Raise RuntimeError(
		    NStr("en = 'Constructor not initialized.';
		         |ru = 'Конструктор не был инициализирован.'")
		);
	EndIf;
	
EndProcedure

Procedure InitConstructor()
	
	If ( ThisObject.Constructor = Undefined
		Or TypeOf(ThisObject.Constructor) <> Type("Map")) Then
			
			ThisObject.Constructor = New Map();
			
	EndIf;
	
EndProcedure

Function ConstructorPropertyByStage( Val Stage )
	
	Result = ThisObject.Constructor.Get( Stage );
	
	If ( TypeOf(Result) <> Type("Map") ) Then
		Raise RuntimeError(
		    NStr("en = 'Constructor does not contain action scope.';
		         |ru = 'Конструктор не содержит область применения метода.'")
		);
	EndIf;
	
	Return Result;
	
EndFunction

Procedure FillPropertyByValue( Property, Value, Stage = "" )
	
	If ( TypeOf(Value) = Type("String") ) Then
		
		ThisObject[ Property + "Json" ] = Value;
		
	Else

		InitConstructor();
		
		If ( IsBlankString(Stage) ) Then
			
			ThisObject.Constructor.Insert( Property, New Map() );
			
		Else
			
			ConstructorProperty = ConstructorPropertyByStage( Stage );
			ConstructorProperty.Insert( Property, Value );
			
		EndIf;
		
	EndIf;
	
EndProcedure

Функция JoinJsonProperties()
	
	Перем JSON;

	JSON = "{" + Chars.LF;
	
	Если ( ТипЗнч(HttpRequestJson) = Тип("String") И НЕ ПустаяСтрока(HttpRequestJson) ) Тогда
		
		Если HttpResponseJson = Неопределено Тогда
			JSON = JSON + StrTemplate(
		        " ""httpRequest"": {
		        |%1
		        | }",
		        HttpRequestJson
	    	);
		Иначе
			JSON = JSON + StrTemplate(
		        " ""httpRequest"": {
		        |%1
		        | },",
		        HttpRequestJson
	    	);		
		КонецЕсли;
		
	КонецЕсли;
	
	Если ( ТипЗнч(HttpResponseJson) = Тип("String") И НЕ ПустаяСтрока(HttpResponseJson) ) Тогда
		
			JSON = JSON + StrTemplate(
		        " ""httpResponse"": {
		        |%1
		        | }",
		        HttpResponseJson
	    	);

	КонецЕсли;
	
	JSON = JSON + Chars.LF + "}";
	
	Возврат JSON;
	
КонецФункции

Procedure GenerateJson()
	
	If (Not IsBlankString(ThisObject.Json)) Then
		
		Return;
		
	EndIf;
	
	If ( ThisObject.Constructor = Undefined ) Then
		
		ThisObject.Json = JoinJsonProperties();

	Else
		
		JsonWriterOptions = New Structure();
		JsonWriterOptions.Insert( "ПереносСтрок", JsonLineBreak.Unix );
		JsonWriterOptions.Insert( "СимволыОтступа", " " );
		
		ThisObject.Json = HTTPConnector.ОбъектВJson( ThisObject.Constructor, , JsonWriterOptions );
		
	Endif;
	
EndProcedure

Function ContentTypeJsonHeaders()
	
	Var Headers;
	
	Headers = New Map();
	Headers.Insert( "Content-Type", "application/json; charset=utf-8" );
	
	Return New Structure( "Заголовки", Headers );
	
EndFunction

Function MockServerError( DetailErrorDescription )
	
	Var Result;
	
	Result = New Structure();
	Result.Insert( "КодСостояния", HTTPStatusCode.НайтиКодПоИдентификатору("INTERNAL_SERVER_ERROR") );
	Result.Insert( "ТекстОшибки", DetailErrorDescription );
	
	Return Result;
	
EndFunction

Function RuntimeError( Message = "" )
    
    Return "[RuntimeError]" + Chars.LF + Message;
    
EndFunction

#EndRegion

#Region Init

ThisObject.URL = "localhost:1080";

#EndRegion

#EndIf