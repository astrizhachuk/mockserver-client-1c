// mockserver-client-1c - https://github.com/astrizhachuk/mockserver-client-1c
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// 
// Copyright © 2020 Alexander Strizhachuk
// version: 0.1.2

#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

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

// Prepares a set of request properties in "httpRequest" node.
// 
// Parameters:
// 	Request - String - a request properties in json-format string;
//          - Undefined - an empty collection will be added to the conditions collection for the 'httpRequest' node;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with a new collection of properties;
//
// Example:
//	Mock.When( Mock.Request().WithPath("/фуу/foo") ).Respond( Mock.Response().WithBody("some_response_body") );
//	Mock.When( Mock.Request("""method"": ""GET""") ).Respond( Mock.Response().WithBody("some_response_body") );
//
Function Request( Val Request = Undefined ) Export

	ThisObject.Json = "";
	ThisObject.CurrentStage = "httpRequest";
	
	FillConstructorRootPropertyByValueType( "httpRequest", Request );

	Return ThisObject;
	
EndFunction

// Prepares a set of response properties in "httpResponse" node.
// 
// Parameters:
// 	Response - String - a response properties in json-format string;
//           - Undefined - an empty collection will be added to the conditions collection for the 'httpResponse' node;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with a new collection of properties;
//
// Example:
//	Mock.When( Mock.Request().WithPath("/фуу/foo") ).Respond( Mock.Response().WithBody("some_response_body") );
//	Mock.When( Mock.Request().WithPath("/фуу/foo") ).Respond( Mock.Response("""statusCode"": 200 ") );
//
Function Response( Val Response = Undefined  ) Export
	
	ThisObject.Json = "";
	ThisObject.CurrentStage = "httpResponse";
	
	FillConstructorRootPropertyByValueType( "httpResponse", Response );
	
	Return ThisObject;
	
EndFunction

// Prepares a set of OpenAPI properties in "httpResponse" node.
// 
// Parameters:
// 	OpenAPI - String - OpenAPI properties in json-format string;
//           - Undefined - an empty collection will be added to the conditions collection for the 'httpResponse' node;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with a new collection of properties;
//
// Example:
//	Mock.When(
//			Mock.OpenAPI()
//				.WithSource("http://example.com/openapi_petstore_example.json")
//				.WithOperationId("some_id")
//		).Verify(
//			Mock.Times()
//				.Once()
//		);
//
Function OpenAPI( Val OpenAPI = Undefined ) Export
	
	Return Request( OpenAPI );
	
EndFunction

// Sets conditions that a requests has been received by MockServer a specific number of time.
// 
// Parameters:
// 	Condition - String - a conditions in json-format string;
//            - Undefined - an empty collection will be added to the conditions collection for the 'times' node;
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with a new collection of properties;
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

// Sets the expectations according to the OpenAPI specification (terminal operation).
// 
// Parameters:
// 	Source - String - the path to the OpenAPI document or the data itself in accordance with the OpenAPI specification;
// 	Operations - String - operation id and response status code for the selected operation as a json-format string;
//
// Example:
//  Mock.OpenAPIExpectation( "file:/Users/me/openapi.json" );
//  Mock.OpenAPIExpectation( "http://example.com/mock/openapi.json", """some_operation_id"": ""200""" );
//  Mock.OpenAPIExpectation( "---\n""
//        + """openapi: 3.0.0\n"""
//        + """info:\n"""
//		...
//        + """...OpenAPI specification here""" " );	
//
Procedure OpenAPIExpectation( Val Source, Val Operations = "" ) Export
	
	GenerateOpenApiJson( Source, Operations );
	
	Try
		
		DoAction( "openapi" );
		
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

#Region OpenAPI

Function WithSource( Val Source ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "specUrlOrPayload", Source );
	
	Return ThisObject;
	
EndFunction

Function WithOperationId( Val OperationId ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddConstructorStageProperty( "operationId", OperationId );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#Region Ru

#Region Промежуточные

Function Сервер( URL, Port = Undefined ) Export
	
	Return Server( URL, Port );
	
EndFunction

Function Когда( Запрос ) Export
	
	Return When( Запрос );
	
EndFunction

// Подготавливает коллекцию свойств запроса в узле "httpRequest".
// 
// Параметры:
// 	Запрос - Строка - свойства запроса в виде строки в формате json;
//          - Неопределено - в коллекцию условий для узла 'httpRequest' будет добавлена пустая коллекция;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с новой коллекцией условий;
//
// Пример:
//	Мок.Когда( Мок.Запрос().Путь("/фуу/foo") ).Ответить( Мок.Ответ().Тело("some_response_body") );
//	Мок.Когда( Мок.Запрос("""method"": ""GET""") ).Ответить( Мок.Ответ().Тело("some_response_body") );
//
Function Запрос( Запрос = Undefined ) Export
	
	Return Request( Запрос );
	
EndFunction


// Подготавливает коллекцию свойств ответа в узле "httpResponse".
// 
// Параметры:
// 	Ответ - Строка - свойства ответа в виде строки в формате json;
//          - Неопределено - в коллекцию условий для узла 'httpResponse' будет добавлена пустая коллекция;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с новой коллекцией условий;
//
// Пример:
//	Мок.Когда( Мок.Запрос().Путь("/фуу/foo") ).Ответить( Мок.Ответ().Тело("some_response_body") );
//	Мок.Когда( Мок.Запрос().Путь("/фуу/foo") ).Ответить( Мок.Ответ("""body"": ""some_response_body""") );
//
Function Ответ( Ответ = Undefined ) Export
	
	Return Response( Ответ );
	
EndFunction

// Устанавливает условия на проверку количества запросов к MockServer.
// 
// Параметры:
// 	Условие - Строка - условие проверки на количество запросов в виде строки в формате json;
//          - Неопределено - в коллекцию условий для узла 'times' будет добавлена пустая коллекция;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с новой коллекцией условий;
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

// Устанавливает ожидание в соответствии с OpenAPI спецификацией (терминальная операция). 
// 
// Параметры:
// 	Источник - Строка - путь к документу с описанием данных или сами данные в соответствии с OpenAPI спецификацией;
// 	Операции - Строка - id операции и код статуса ответа для выбранной операции в виде строки в формате json;
// 	
// Пример:
//  Мок.ОжидатьOpenAPI( "file:/Users/me/openapi.json" );
//  Мок.ОжидатьOpenAPI( "http://example.com/mock/openapi.json", """some_operation_id"": ""200""" );
//  Мок.ОжидатьOpenAPI( "---\n""
//        + """openapi: 3.0.0\n"""
//        + """info:\n"""
//		...
//        + """...OpenAPI specification here""" " );	
//
Procedure ОжидатьOpenAPI( Val Источник, Val Операции = "" ) Export

	OpenAPIExpectation( Источник, Операции );
	
EndProcedure

#EndRegion

// Возвращает результат выполнения PUT-метода для последней терминальной операции (действия).
// 
// Возвращаемое значение:
// 	Булево - Истина - операция выполнена успешно, иначе - Ложь;
//
Function Успешно() Export
	
	Return IsOk();
	
EndFunction

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

Procedure FillActionTemplate( Result, Val Key, Val Value )
	
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

Procedure GenerateOpenApiJson( Val Source, Val Condition = "" )
	
	Var Template;
	Var ConditionTemplate;
	
	Template = "{
		| ""specUrlOrPayload"": ""%1""%2
	    |}";
    
    If ( NOT IsBlankString(Condition) ) Then
    	
		ConditionTemplate = ",
			| ""operationsAndResponses"": {
			|  %1
			| }";
			
		Condition = StrTemplate( ConditionTemplate, Condition );
    	
    EndIf;
    
    ThisObject.Json = StrTemplate( Template, Source, Condition );

EndProcedure

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