#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

#Region Ru

#Region Промежуточные

Function Сервер( URL, Port = Undefined ) Export
	
	Return Server( URL, Port );
	
EndFunction

Function Когда( Запрос ) Export
	
	Return When( Запрос );
	
EndFunction

Function Запрос( ЗапросJson = Undefined ) Export
	
	Return Request( ЗапросJson );
	
EndFunction

Function Ответ( ОтветJson = Undefined ) Export
	
	Return Response( ОтветJson );
	
EndFunction

// Устанавливает условия на проверку количества запросов к MockServer.
// 
// Параметры:
// 	Условие - Строка - (необязательно) условие проверки на количество запросов в виде строки json-формата,
// 						если параметр не указан, то в условия для свойства 'times' добавляется пустая коллекция;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
// 	
// Пример:
//	Мок.Когда( Мок.Запрос().Метод("GET") ).Проверить( Мок.Повторений().НеБолее(3) );
//  Результат = Мок.Проверить().НеМенее(3).НеБолее(3);
//  Результат = Мок.Проверить( """atLeast"": 3, ""atMost"": 3" );
//
Function Повторений( Условие = Undefined ) Export
	
	Return Times( Условие );
	
EndFunction

#Region Повторения

// Добавляет условие, что количество запросов к MockServer было не менее n раз.
// 
// Параметры:
// 	Повторений - Число - количество повторений запросов;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
Function НеМенее( Val Повторений ) Export
	
	Return AtLeast( Повторений );
	
EndFunction

// Добавляет условие, что количество запросов к MockServer было не более n раз.
// 
// Параметры:
// 	Повторений - Число - количество повторений запросов;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
Function НеБолее( Val Повторений ) Export
	
	Return AtMost( Повторений );
	
EndFunction

// Добавляет условие, что количество запросов к MockServer было ровно n раз.
// 
// Параметры:
// 	Повторений - Число - количество повторений запросов;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
Function Точно( Val Повторений ) Export
	
	Return Exactly( Повторений );
	
EndFunction

// Добавляет условие, что запрос к MockServer был только один раз.
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
Function Однократно() Export
	
	Return Once();
	
EndFunction

// Добавляет условие, что количество запросов к MockServer было от n до m раз.
// 
// Параметры:
// 	От - Число - не менее n раз;
// 	До - Число - не более m раз;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
Function Между( Val От, Val До ) Export
	
	Return Between( От, До );
	
EndFunction

#EndRegion

#EndRegion

#Region Терминальные

Procedure Сбросить() Export
	
	Reset();
	
EndProcedure

Procedure Ответить( Объект = Undefined ) Export
	
	Respond( Объект );
	
EndProcedure

// Проверяет наличие отправленного на сервер запроса (терминальная операция).
// 
// Параметры:
// 	Объект - ОбработкаОбъект.MockServerClient - объект с предварительно установленными условиями; 
//
// Пример:
//	Мок.Когда( Мок.Запрос().Метод("GET") ).Проверить( Мок.Повторений().НеБолее(3) );
//	Мок.Проверить( Мок.Повторений().НеБолее(3) );
//	Мок.Проверить( Мок.Повторений("""atMost"": 3") );
//
Procedure Проверить( Объект = Undefined ) Export
	
	Verify( Объект );
	
EndProcedure

#Region Условия

Function Заголовки( Заголовки = Undefined ) Export
	
	Return Headers( Заголовки );
	
EndFunction

Function Заголовок( Ключ, Значение ) Export
	
	Return WithHeader( Ключ, Значение );
	
EndFunction

Function Метод( Метод ) Export
	
	Return WithMethod( Метод );
	
EndFunction

Function Путь( Путь ) Export
	
	Return WithPath( Путь );
	
EndFunction

#EndRegion

// Возвращает результат выполнения PUT-метода для последней терминальной операции (действия).
// 
// Возвращаемое значение:
// 	Булево - Истина - операция выполнена успешно, иначе - Ложь;
//
Function Успешно() Export
	
	Return IsOk();
	
EndFunction

#Region Действия

Function Тело( Тело ) Export
	
	Return WithBody( Тело );
	
EndFunction

Function КодОтвета( КодОтвета ) Export
	
	Return WithStatusCode( КодОтвета );
	
EndFunction

Function Причина( Причина ) Export
	
	Return WithReasonPhrase( Причина );
	
EndFunction

#EndRegion

#EndRegion

#EndRegion

#Region En
	
#Region Intermediate

// Defines and returns the client communicating to a MockServer at the specified host and port.
//
// Parameters:
// 	URL - String - URL;
// 	Port - String - port;
// 	Reset - Boolean - true - reset MockServer, otherwise - false (default false);
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
// 	
// Example:
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server");
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server", "1090");
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server", "1090", true);
//
Function Server( Val URL, Val Port = Undefined, Val Reset = False ) Export
	
	If ( Port <> Undefined ) Then

		URL = URL + ":" + Port;
		
	EndIf;
	
	ThisObject.URL = URL;
	
	If ( Reset ) Then
		
		Reset();
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function When( Val What ) Export

	ThisObject.Json = "";	
	ThisObject.CurrentStage = "";
	
	If ( TypeOf(What) = Type("String") ) Then
		
		ThisObject.Json = What;
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function Request( Val Self = Undefined ) Export

	ThisObject.Json = "";
	ThisObject.CurrentStage = "httpRequest";
	
	FillConstructorRootPropertyByValueType( "httpRequest", Self );

	Return ThisObject;
	
EndFunction

Function Response( Val Self = Undefined  ) Export
	
	ThisObject.Json = "";
	ThisObject.CurrentStage = "httpResponse";
	
	FillConstructorRootPropertyByValueType( "httpResponse", Self );
	
	Return ThisObject;
	
EndFunction

// Sets condition that a request has been received by MockServer a specific number of time.
// 
// Parameters:
// 	Condition - String - a conditions in json-format string;
// 						an empty collection for 'times'-property is added to the conditions collection,
// 						if the parameter is not specified
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
// 	
// Example:
//	Mock.When( Mock.Request().WithMethod("GET") ).Verify( Mock.Times().AtMost(3) );
//  Result = Mock.Times().AtMost(3).AtLeast(3);
//  Result = Mock.Times("""atLeast"": 3, ""atMost"": 3");
//
Function Times( Val Condition = Undefined  ) Export
	
	ThisObject.Json = "";
	ThisObject.CurrentStage = "times";
	
	FillConstructorRootPropertyByValueType( "times", Condition );
	
	Return ThisObject;
	
EndFunction

#Region Times

// Add condition that a request has been received by MockServer at least n-times.
// 
// Parameters:
// 	Count - Number - n-times;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function AtLeast( Val Count ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "atLeast", Count );
	
	Return ThisObject;
	
EndFunction

// Add condition that a request has been received by MockServer at most n-times.
// 
// Parameters:
// 	Count - Number - number of times;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function AtMost( Val Count ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "atMost", Count );
	
	Return ThisObject;
	
EndFunction

// Add condition that a request has been received by MockServer exactly n-times.
// 
// Parameters:
// 	Count - Number - number of times;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function Exactly( Val Count ) Export
	
	CheckObjectPropertiesForMethod();

	AddConstructorStageProperty( "atLeast", Count );	
	AddConstructorStageProperty( "atMost", Count );
	
	Return ThisObject;
	
EndFunction

// Add condition that a request has been received by MockServer only once.
// 
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function Once() Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "atLeast", 1 );
	AddConstructorStageProperty( "atMost", 1 );
	
	Return ThisObject;
	
EndFunction

// Add condition that a request has been received by MockServer between n and m times.
// 
// Parameters:
// 	AtLeast - Number - at least n-times;
// 	AtMost - Number - at most m-times;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function Between( Val AtLeast, Val AtMost ) Export
	
	CheckObjectPropertiesForMethod();

	AddConstructorStageProperty( "atLeast", AtLeast );	
	AddConstructorStageProperty( "atMost", AtMost );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#Region Terminal

Procedure Reset() Export
	
	ThisObject.Json = "";
	
	Try
		
		DoAction( "reset" );
		
		If ( HTTPStatusCodesClientServerCached.IsOk(ThisObject.MockServerResponse.КодСостояния) ) Then
			
			ThisObject.IsActionOk = True;
			ThisObject.MockServerResponse = Undefined;
		
		Else
			
			ThisObject.MockServerResponse = MockServerClientError( ThisObject.MockServerResponse.КодСостояния );

		EndIf;
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;
	
EndProcedure

Procedure Respond( Val Self = Undefined ) Export
	
	GenerateJson();
	
	Try
		
		DoAction( "expectation" );
		
		If ( HTTPStatusCodesClientServerCached.IsCreated(ThisObject.MockServerResponse.КодСостояния) ) Then
			
			ThisObject.IsActionOk = True;
			ThisObject.MockServerResponse = Undefined;
		
		Else
			
			ThisObject.MockServerResponse = MockServerClientError( ThisObject.MockServerResponse.КодСостояния );

		EndIf;
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;
	
EndProcedure

// Verify a request has been sent (terminal operation).
// 
// Parameters:
// 	Self - DataProcessorObject.MockServerClient - a reference to object with preparing conditions; 
//
// Example:
//	Mock.When( Mock.Request().WithMethod("GET") ).Verify( Mock.Times().AtMost(3) );
//	Mock.Verify( Mock.Times().AtMost(3) );
//	Mock.Verify( Mock.Times("""atMost"": 3") );
//
Procedure Verify( Val Self = Undefined ) Export
	
	GenerateJson();
	
	Try
		
		DoAction( "verify" );
		
		If ( HTTPStatusCodesClientServerCached.IsAccepted(ThisObject.MockServerResponse.КодСостояния) ) Then
			
			ThisObject.IsActionOk = True;
			ThisObject.MockServerResponse = Undefined;
		
		Else
			
			ThisObject.MockServerResponse = MockServerClientError( ThisObject.MockServerResponse.КодСостояния );

		EndIf;
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;
	
EndProcedure

#EndRegion

// Returns the result of executing the PUT method for the last action.
// 
// Returns:
// 	Boolean - true - operation was successful, otherwise - false;
//
Function IsOk() Export
	
	Return ThisObject.IsActionOk;
	
EndFunction

#Region RequestMatchers

Function WithMethod( Val Method ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "method", Method );
	
	Return ThisObject;
	
EndFunction

Function WithPath( Val Path ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "path", Path );
	
	Return ThisObject;
	
EndFunction

Function WithQueryStringParameters( Val Key, Val Value ) Export
	
	Var NewQueryParameters;
	
	CheckObjectPropertiesForMethod();
	
	NewQueryParameters = MapStringValueToArray( Key, Value );
	InsertConstructorStageProperty( "queryStringParameters", NewQueryParameters );

	Return ThisObject;

EndFunction

Function Headers( Val Headers = Undefined ) Export
	
	CheckObjectPropertiesForMethod();
	
	Headers = ?( (Headers = Undefined), New Map(), Headers );
	
	FillConstructorRootPropertyByValueType( "headers", Headers, ThisObject.CurrentStage );

	Return ThisObject;
	
EndFunction

Function WithHeader( Val Key, Val Value ) Export

	Var NewHeader;
	
	CheckObjectPropertiesForMethod();
	
	NewHeader = MapStringValueToArray( Key, Value );
	InsertConstructorStageProperty( "headers", NewHeader );

	Return ThisObject;
	
EndFunction

#EndRegion

#Region ResponseAction

Function WithBody( Val Body ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "body", Body );

	Return ThisObject;
	
EndFunction

Function WithStatusCode( Val StatusCode ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "statusCode", StatusCode );

	Return ThisObject;
	
EndFunction

Function WithReasonPhrase( Val ReasonPhrase ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "reasonPhrase", ReasonPhrase );

	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#EndRegion

#Region Private

Процедура CheckObjectPropertiesForMethod()
	
	RaiseIfCurrentStageEmpty();
	RaiseIfConstructorUndefined();
	
КонецПроцедуры

Procedure InitMapValue( Value )
	
	If ( (Value = Undefined) OR (TypeOf(Value) <> Type("Map")) ) Then
			
			Value = New Map();
			
	EndIf;
	
EndProcedure

Procedure InitConstructor()
	
	InitMapValue( ThisObject.Constructor );
	
EndProcedure

Function ConstructorRootProperty( Val Key )

	Var Message;
	
	Result = ThisObject.Constructor.Get( Key );

	Message = NStr( "en = 'Constructor does not contain action scope.';
		            |ru = 'Конструктор не содержит область применения метода.'" );
	
	If ( TypeOf(Result) <> Type("Map") ) Then

		Raise RuntimeError( Message );
		
	EndIf;
	
	Return Result;
	
EndFunction

Procedure AddConstructorStageProperty( Val Key, Val Value )
	
	Var ConstructorRootProperty;
	
	ConstructorRootProperty = ConstructorRootProperty( ThisObject.CurrentStage );
	ConstructorRootProperty.Insert( Key, Value );
	
EndProcedure

Процедура InsertConstructorStageProperty( Val Key, Val Value )
	
	Var Result;
	
	Result = ConstructorStagePropertyOrInitMapIfAbsent( ThisObject.CurrentStage, Key );

	For Each KeyValue In Value Do
		
		Result.Insert( KeyValue.Key, KeyValue.Value );
		
	EndDo;
	
КонецПроцедуры

Procedure FillConstructorRootPropertyByValueType( Key, Value, Stage = "" )
	
	If ( TypeOf(Value) = Type("String") ) Then
		
		ThisObject[ Key + "Json" ] = Value;
		
	Else

		InitConstructor();
		
		If ( IsBlankString(Stage) ) Then
			
			ThisObject.Constructor.Insert( Key, New Map() );
			
		Else
			
			ConstructorRootProperty( Stage ).Insert( Key, Value );
			
		EndIf;
		
	EndIf;
	
EndProcedure

Function ConstructorStagePropertyOrInitMapIfAbsent( Val Stage, Val Key )
	
	Var StageProperty;
	Var Result;
	
	StageProperty = ConstructorRootProperty( Stage );

	Result = StageProperty.Get( Key );
	
	If ( Result = Undefined ) Then
		
		StageProperty.Insert( Key, New Map() );
		Result = StageProperty.Get( Key );
		
	EndIf;
	
	Return Result;

EndFunction

Function MapStringValueToArray( Val Key, Val Value )
	
	Var Result;
	
	Result = New Map();
	
	If ( TypeOf(Value) = Type("String") ) Then
		
		NewValue = New Array();
		NewValue.Add( Value );
	
	Else
		
		NewValue = Value;
	
	EndIf;
	
	Result.Insert( Key, NewValue );
	
	Return Result;
	
EndFunction

Procedure FillActionTemplate( Result,  Val Key, Val Value )
	
	If ( TypeOf(Key) = Тип("String") AND NOT IsBlankString(Value) ) Then
		
		Result = Result + StrTemplate(
	        " ""%1"": {
	        |%2
	        | },", Key, Value );
		
	EndIf;
	
EndProcedure

Function JoinJsonParts()
	
	Var Result;

	Result = "{" + Chars.LF;
	
	FillActionTemplate( Result, "httpRequest", HttpRequestJson);
	FillActionTemplate( Result, "httpResponse", HttpResponseJson);
	FillActionTemplate( Result, "times", TimesJson);

	Result = Left( Result, StrLen(Result) - 1 );
	
	Result = Result + Chars.LF + "}";
	
	Возврат Result;
	
EndFunction

Procedure GenerateJson()
	
	If (Not IsBlankString(ThisObject.Json)) Then
		
		Return;
		
	EndIf;
	
	If ( ThisObject.Constructor = Undefined ) Then
		
		ThisObject.Json = JoinJsonParts();

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

Процедура DoAction( Val Action )
	
	Var PutJson;
	Var PutHeaders;
	
	ThisObject.CurrentStage = "";
	ThisObject.IsActionOk = False;

	If ( IsBlankString(ThisObject.Json) ) Then
		
		PutJson = Undefined;
		PutHeaders = Undefined;

	Else
		
		PutJson = ThisObject.Json;
		PutHeaders = ContentTypeJsonHeaders();
	
	EndIf;
	
	ThisObject.MockServerResponse = HTTPConnector.Put( ThisObject.Url + "/mockserver/" + Action,
															PutJson,
															PutHeaders );
														
	If ( HTTPStatusCodesClientServerCached.IsServerError(ThisObject.MockServerResponse.КодСостояния) ) Then
		
		Raise HTTPConnector.КакТекст( ThisObject.MockServerResponse );
		
	EndIf;
		
КонецПроцедуры

#Region Errors

Procedure RaiseIfCurrentStageEmpty()

	Var Message;

	Message = NStr( "en = 'The action needs to be initialized first.';
		            |ru = 'Сначала необходимо инициализировать действие.'" );
	
	If ( IsBlankString(ThisObject.CurrentStage) ) Then
		Raise RuntimeError( Message );
	EndIf;
	
EndProcedure

Procedure RaiseIfConstructorUndefined()

	Var Message;

	Message = NStr( "en = 'Constructor not initialized.';
		            |ru = 'Конструктор не был инициализирован.'" );
	
	If ( ThisObject.Constructor = Undefined ) Then

		Raise RuntimeError( Message );

	EndIf;
	
EndProcedure

Function RuntimeError( Val Message = "" )
    
    Return "[RuntimeError]" + Chars.LF + Message;
    
EndFunction

Function MockServerClientError( StatusCode )
	
	Var Result;
	Var ErrorId;
	
	Result = New Structure();
	Result.Insert( "КодСостояния", StatusCode );
	ErrorId = HTTPStatusCodesClientServerCached.FindIdByCode( StatusCode );
	Result.Insert( "ТекстОшибки", HTTPStatusCodesClientServerCached.FindReasonPhraseById(ErrorId) );
	
	Return Result;
	
EndFunction

Function MockServerError( DetailErrorDescription )
	
	Var Result;
	
	Result = New Structure();
	Result.Insert( "КодСостояния", HTTPStatusCodesClientServerCached.FindCodeById("INTERNAL_SERVER_ERROR") );
	Result.Insert( "ТекстОшибки", DetailErrorDescription );
	
	Return Result;
	
EndFunction

#EndRegion

#EndRegion

#Region Initialize

ThisObject.URL = "localhost:1080";

#EndRegion

#EndIf