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
// version: 1.0.0

#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

#Region En
	
#Region Intermediate

// Initializes the client to communicate with the MockServer on the specified host and port.
//
// Parameters:
// 	URL - String - URL;
// 	Port - String - port;
// 	Reset - Boolean - True - reset MockServer, otherwise - False (default);
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
// Example:
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server");
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server", "1090");
//  Mock = DataProcessors.MockServerClient.Create().Server("http://server", "1090", True);
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

// Presets any conditions or accepts fully prepared JSON for subsequent sending data to MockServer.
// 
// Parameters:
// 	What - DataProcessorObject.MockServerClient - instance of mock-object with a predefined conditions;
//       - String - JSON to send to MockServer;   
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
// 	
// Example:
//  Mock.When( Mock.WithPath("/фуу/foo") ).Respond();
// 	Mock.When("{""sample"": ""any""}").Respond();
//
Function When( Val What ) Export

	ThisObject.JSON = "";	
	ThisObject.CurrentStage = "";
	
	If ( TypeOf(What) = Type("String") ) Then
		
		ThisObject.JSON = What;
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

// Prepares a set of request properties in "httpRequest" node.
//
// Parameters:
// 	Request - String - a request properties in JSON-format;
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

	ThisObject.JSON = "";
	ThisObject.CurrentStage = "httpRequest";
	
	FillConstructorRootPropertyByValueType( "httpRequest", Request );

	Return ThisObject;
	
EndFunction

// Prepares a set of response properties in "httpResponse" node.
//
// Parameters:
// 	Response - String - a response properties in JSON-format;
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
	
	ThisObject.JSON = "";
	ThisObject.CurrentStage = "httpResponse";
	
	FillConstructorRootPropertyByValueType( "httpResponse", Response );
	
	Return ThisObject;
	
EndFunction

// Prepares a set of OpenAPI properties in "httpResponse" node.
//
// Parameters:
// 	OpenAPI - String - OpenAPI properties in JSON-format;
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
// 	Condition - String - a conditions in JSON-format string;
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
	
	ThisObject.JSON = "";
	ThisObject.CurrentStage = "times";
	
	FillConstructorRootPropertyByValueType( "times", Condition );
	
	Return ThisObject;
	
EndFunction

#Region Times

// Adds  condition that a request has been received by MockServer at least n-times.
//
// Parameters:
// 	Count - Number - n-times;
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function AtLeast( Val Count ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "atLeast", Count );
	
	Return ThisObject;
	
EndFunction

// Adds condition that a request has been received by MockServer at most n-times.
//
// Parameters:
// 	Count - Number - number of times;
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function AtMost( Val Count ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "atMost", Count );
	
	Return ThisObject;
	
EndFunction

// Adds condition that a request has been received by MockServer exactly n-times.
//
// Parameters:
// 	Count - Number - number of times;
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function Exactly( Val Count ) Export
	
	CheckObjectPropertiesForMethod();

	AddPropertyToConstructorByCurrentStage( "atLeast", Count );
	AddPropertyToConstructorByCurrentStage( "atMost", Count );
	
	Return ThisObject;
	
EndFunction

// Adds condition that a request has been received by MockServer only once.
// 
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object;
//
Function Once() Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "atLeast", 1 );
	AddPropertyToConstructorByCurrentStage( "atMost", 1 );
	
	Return ThisObject;
	
EndFunction

// Adds condition that a request has been received by MockServer between n and m times.
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

	AddPropertyToConstructorByCurrentStage( "atLeast", AtLeast );
	AddPropertyToConstructorByCurrentStage( "atMost", AtMost );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#Region Terminal

// Resets the MockServer completely (terminal operation).
// 
Procedure Reset() Export
	
	ThisObject.JSON = "";
	
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

// Sets requests expectation (terminal operation).
// 
// Parameters:
// 	Self - DataProcessorObject.MockServerClient - a reference to object with preparing conditions; 
//
// Example:
//	Mock.When( Mock.Request().WithMethod("GET") ).Respond( Mock.Response().WithBody("some_response_body") );
//	Mock.Respond( Mock.Response().WithBody("some_response_body") );
//	Mock.Respond( Mock.Response("""statusCode"": 404") );
//
Procedure Respond( Val Self = Undefined ) Export
	
	GenerateJSON();
	
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

// Verifies a request has been sent (terminal operation).
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
	
	GenerateJSON();
	
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
// 	Operations - String - operation id and response status code for the selected operation as a JSON-format string;
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
	
	GenerateOpenApiJSON( Source, Operations );
	
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

#Region Properties

// Adds the "method" property.
// See also: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Parameters:
// 	Method - String - property matcher;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//	Mock.When(
//		Mock.Request()
//			.WithMethod("!GET")
//	).Respond(
//		Mock.Response()
//			.WithBody("some_response_body")
//	);
//
Function WithMethod( Val Method ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "method", Method );
	
	Return ThisObject;
	
EndFunction

// Adds the "path" property.
// See also: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Parameters:
// 	Path - String - property matcher;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//	Mock.When(
//		Mock.Request()
//			.WithMethod("!GET")
//	).Respond(
//		Mock.Response()
//			.WithBody("some_response_body")
//	);
//
Function WithPath( Val Path ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "path", Path );
	
	Return ThisObject;
	
EndFunction

// Adds the "queryStringParameters" property.
// See also: https://www.mock-server.com/mock_server/getting_started.html#request_key_to_multivalue_matchers
// 
// Parameters:
// 	Key - String - key of query parameter;
// 	Value - String - value of query parameter;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//  Mock.When(
//      Mock.Request()
//        .WithPath("/some/path")
//        .WithQueryStringParameter("cartId", "[A-Z0-9\\-]+")
//        .WithQueryStringParameter("anotherId", "[A-Z0-9\\-]+")
//    ).Respond(
//      Mock.Response()
//        .WithBody("some_response_body")
//    );
//
Function WithQueryStringParameter( Val Key, Val Value ) Export
	
	Var NewQueryParameters;
	
	CheckObjectPropertiesForMethod();
	
	NewQueryParameters = MapStringValueToArray( Key, Value );
	AddMultipleValuesPropertyToConstructorByCurrentStage( "queryStringParameters", NewQueryParameters );

	Return ThisObject;

EndFunction

// Prepares a set of headers properties in "headers" node.
//
// Parameters:
// 	Headers - Map - a headers (key = header, value = array of strings);
//          - Undefined - an empty collection will be added to the 'header' node;
//
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
// 
// 	1:
// 	
//  Mock.When(
//      Mock.Request()
//        .WithMethod("GET")
//        .WithPath("/some/path")
//        .Headers()
//          .WithHeader("Accept", "application/json")
//          .WithHeader("Accept-Encoding", "gzip, deflate, br")
//    ).Respond(
//      Mock.Response()
//        .WithBody("some_response_body")
//    );
//
//	2:
//	
//	Header_1 = New Array();
//	Header_1.Add("11");
//	Header_1.Add("12");
//	Header_2 = New Array();
//	Header_2.Add("21");
//	Header_2.Add("22");
//	Headers = New Map();
//	Headers.Insert("Header_1", Header_1);
//	Headers.Insert("Header_2", Header_2);
//	
//	Mock.When( Mock.Request().Headers(Headers) ).Respond();
//
Function Headers( Val Headers = Undefined ) Export
	
	CheckObjectPropertiesForMethod();
	
	Headers = ?( (Headers = Undefined), New Map(), Headers );
	
	FillConstructorRootPropertyByValueType( "headers", Headers, ThisObject.CurrentStage );

	Return ThisObject;
	
EndFunction

// Adds the "header" property to the "headers" node.
// See also: https://www.mock-server.com/mock_server/getting_started.html#request_key_to_multivalue_matchers
// 
// Parameters:
// 	Key - String - key of header;
// 	Value - String - value of header;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
// 
//  Mock.When(
//      Mock.Request()
//        .WithMethod("GET")
//        .WithPath("/some/path")
//        .Headers()
//          .WithHeader("Accept", "application/json")
//          .WithHeader("Accept-Encoding", "gzip, deflate, br")
//    ).Respond(
//      Mock.Response()
//        .WithBody("some_response_body")
//    );
//
Function WithHeader( Val Key, Val Value ) Export

	Var NewHeader;
	
	CheckObjectPropertiesForMethod();
	
	NewHeader = MapStringValueToArray( Key, Value );
	AddMultipleValuesPropertyToConstructorByCurrentStage( "headers", NewHeader );

	Return ThisObject;
	
EndFunction

// Adds the "body" property.
// See also: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Parameters:
// 	Body - String - property matcher;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//	Mock.When(
//		Mock.Request()
//			.WithMethod("!GET")
//	).Respond(
//		Mock.Response()
//			.WithBody("some_response_body")
//	);
//
Function WithBody( Val Body ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "body", Body );

	Return ThisObject;
	
EndFunction

// Adds the "statusCode" property.
// See also: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Parameters:
// 	StatusCode - Numeric - numeric status code;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//  Mock.When(
//      Mock.Request()
//        .WithMethod("GET")
//        .WithPath("/some/path")
//    ).Respond(
//      Mock.Response()
//        .WithStatusCode(418)
//        .WithReasonPhrase("I'm a teapot")
//    );
//
Function WithStatusCode( Val StatusCode ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "statusCode", StatusCode );

	Return ThisObject;
	
EndFunction

// Adds the "reasonPhrase" property.
// See also: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Parameters:
// 	ReasonPhrase - String - reason phrase;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
//  Mock.When(
//      Mock.Request()
//        .WithMethod("GET")
//        .WithPath("/some/path")
//    ).Respond(
//      Mock.Response()
//        .WithStatusCode(418)
//        .WithReasonPhrase("I'm a teapot")
//    );
//
Function WithReasonPhrase( Val ReasonPhrase ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "reasonPhrase", ReasonPhrase );

	Return ThisObject;
	
EndFunction

#Region OpenAPI

// Adds the "specUrlOrPayload" property describing the data source or the data itself in OpenAPI format.
// 
// Parameters:
// 	Source - String - the path to the OpenAPI document or the data itself in accordance with the OpenAPI specification;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
// 	Mock.When(
//		Mock.OpenAPI()
//			.WithSource("https://example.com/openapi.json")
//	).Verify(
//		Mock.Times()
//			.AtLeast(2)
//	);
//
//  Result = Mock.OpenAPI().WithSource( "file:/Users/me/openapi.json" );
//
Function WithSource( Val Source ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "specUrlOrPayload", Source );
	
	Return ThisObject;
	
EndFunction

// Adds the "operationId" property that specifies which operations of OpenAPI are included.
// 
// Parameters:
// 	OperationId - String - the operation in the OpenAPI specification;
// 	
// Returns:
// 	DataProcessorObject.MockServerClient - instance of mock-object with added property;
//
// Example:
//  
// 	Mock.When(
//		Mock.OpenAPI()
//			.WithSource("https://example.com/openapi.json")
//			.WithOperationId("listPets")
//	).Verify(
//		Mock.Times()
//			.AtLeast(2)
//	);
//
//  Result = Mock.OpenAPI().WithSource( "file:/Users/me/openapi.json" ).WithOperationId("listPets");
//
Function WithOperationId( Val OperationId ) Export
	
	CheckObjectPropertiesForMethod();
	
	AddPropertyToConstructorByCurrentStage( "operationId", OperationId );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#EndRegion

#EndRegion

#Region Ru

#Region Промежуточные

// Инициализирует клиента для связи с MockServer на указанном хосте и порту.
//
// Параметры:
// 	URL - Строка - URL;
// 	Порт - Строка - порт;
// 	Сбросить - Булево - Истина - предварительно сбросить сервер MockServer, иначе - Ложь (по умолчанию);
//
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
//
// Пример:
//  Мок = Обработки.MockServerClient.Создать().Сервер("http://server");
//  Мок = Обработки.MockServerClient.Создать().Сервер("http://server", "1090");
//  Мок = Обработки.MockServerClient.Создать().Сервер("http://server", "1090", Истина);
//
Function Сервер( URL, Порт = Undefined, Сбросить = Undefined ) Export
	
	Return Server( URL, Порт, Сбросить );
	
EndFunction

// Предварительно устанавливает любые условия или принимает полностью готовый JSON
// для последующей отправки данных на MockServer.
// 
// Параметры:
// 	Запрос - ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с предустановленными условиями;
//       - Строка - JSON для отправки на MockServer;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта;
// 	
// Пример:
//  Мок.Когда( Мок.Путь("/фуу/foo") ).Ответить();
// 	Мок.Когда("{""sample"": ""any""}").Ответить();
//
Function Когда( Запрос ) Export
	
	Return When( Запрос );
	
EndFunction

// Подготавливает коллекцию свойств запроса в узле "httpRequest".
// 
// Параметры:
// 	Запрос - Строка - свойства запроса в виде строки в формате JSON;
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
// 	Ответ - Строка - свойства ответа в виде строки в формате JSON;
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
// 	Условие - Строка - условие проверки на количество запросов в виде строки в формате JSON;
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

// Полностью сбрасывает MockServer (терминальная операция).
// 
Procedure Сбросить() Export
	
	Reset();
	
EndProcedure

// Устанавливает ожидание запроса (терминальная операция).
// 
// Пример:
// 	Объект - ОбработкаОбъект.MockServerClient - объект с предварительно установленными условиями; 
//
// Example:
//	Мок.Когда( Мок.Запрос().Метод("GET") ).Ответить( Мок.Ответ().Тело("some_response_body") );
//	Мок.Ответить( Мок.Ответ().Тело("some_response_body") );
//	Мок.Ответить( Мок.Ответ("""statusCode"": 404") );
//
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
// 	Операции - Строка - id операции и код статуса ответа для выбранной операции в виде строки в формате JSON;
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

#Region Свойства

// Добавляет свойство "method".
// См. также: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers 
// 
// Параметры:
// 	Метод - Строка - имя метода;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Когда(
//      Мок.Запрос()
//        .Метод("!GET")
//    ).Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
Function Метод( Метод ) Export
	
	Return WithMethod( Метод );
	
EndFunction

// Добавляет свойство "path".
// См. также: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Параметры:
// 	Путь - Строка - относительный путь;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Когда(
//      Мок.Запрос()
//        .Путь("/some/path")
//    ).Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
Function Путь( Путь ) Export
	
	Return WithPath( Путь );
	
EndFunction

// Добавляет свойство "queryStringParameters".
// См. также: https://www.mock-server.com/mock_server/getting_started.html#request_key_to_multivalue_matchers
// 
// Параметры:
// 	Ключ - Строка - ключ параметра строки запроса;
// 	Значение - Строка - значение параметра строки запроса;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Когда(
//      Мок.Запрос()
//        .Путь("/some/path")
//        .ПараметрСтрокиЗапроса("cartId", "[A-Z0-9\\-]+")
//        .ПараметрСтрокиЗапроса("anotherId", "[A-Z0-9\\-]+")
//    ).Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
Function ПараметрСтрокиЗапроса( Ключ, Значение ) Export
	
	Return WithQueryStringParameter( Ключ, Значение );
	
EndFunction

// Добавляет коллекцию свойств в узле "headers" или создает пустую коллекцию.
//
// Параметры:
// 	Заголовки - Соответствие - коллекция заголовков (Ключ = имя заголовка, Значение = массив строк);
//          - Неопределено - в коллекцию условий для узла 'headers' будет добавлена пустая коллекция;
//
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
// 
// 	Вариант 1:
// 	
//  Мок.Когда(
//      Мок.Запрос()
//        .Метод("GET")
//        .Путь("/some/path")
//        .Заголовки()
//          .Заголовок("Accept", "application/json")
//          .Заголовок("Accept-Encoding", "gzip, deflate, br")
//    ).Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
//	Вариант 2:
//	
//	Заголовок_1 = Новый Массив();
//	Заголовок_1.Добавить("11");
//	Заголовок_1.Добавить("12");
//	Заголовок_2 = Новый Массив();
//	Заголовок_2.Добавить("21");
//	Заголовок_2.Добавить("22");
//	Заголовки = Новый Соответствие();
//	Заголовки.Вставить("Заголовок_1", Заголовок_1);
//	Заголовки.Вставить("Заголовок_2", Заголовок_2);
//	
//	Мок.Когда( Мок.Запрос().Заголовки(Заголовки) ).Ответить();
//
Function Заголовки( Заголовки = Undefined ) Export
	
	Return Headers( Заголовки );
	
EndFunction

// Добавляет свойство "header" в коллекцию свойств "headers".
// См. также: https://www.mock-server.com/mock_server/getting_started.html#request_key_to_multivalue_matchers
// 
// Параметры:
// 	Ключ - Строка - ключ заголовка;
// 	Значение - Строка - значение заголовка;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
// 
//  Мок.Когда(
//      Мок.Запрос()
//        .Метод("GET")
//        .Путь("/some/path")
//        .Заголовки()
//          .Заголовок("Accept", "application/json")
//          .Заголовок("Accept-Encoding", "gzip, deflate, br")
//    ).Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
Function Заголовок( Ключ, Значение ) Export
	
	Return WithHeader( Ключ, Значение );
	
EndFunction

// Добавляет свойство "body".
// См. также: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Параметры:
// 	Тело - Строка - строковое значение тела;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Ответить(
//      Мок.Ответ()
//        .Тело("some_response_body")
//    );
//
Function Тело( Тело ) Export
	
	Return WithBody( Тело );
	
EndFunction

// Добавляет свойство "statusCode".
// См. также: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Параметры:
// 	КодОтвета - Число - числовой код статуса ответа;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Когда(
//      Мок.Запрос()
//        .Метод("GET")
//        .Путь("/some/path")
//    ).Ответить(
//      Мок.Ответ()
//        .КодОтвета(418)
//        .Причина("I'm a teapot")
//    );
//
Function КодОтвета( КодОтвета ) Export
	
	Return WithStatusCode( КодОтвета );
	
EndFunction

// Добавляет свойство "reasonPhrase".
// См. также: https://www.mock-server.com/mock_server/creating_expectations.html#request_property_matchers
// 
// Параметры:
// 	Причина - Строка - причина;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
//  Мок.Когда(
//      Мок.Запрос()
//        .Метод("GET")
//        .Путь("/some/path")
//    ).Ответить(
//      Мок.Ответ()
//        .КодОтвета(418)
//        .Причина("I'm a teapot")
//    );
//
Function Причина( Причина ) Export
	
	Return WithReasonPhrase( Причина );
	
EndFunction

#Region OpenAPI

// Добавляет свойство "specUrlOrPayload", которое описывает источник данных или сами данные в формате OpenAPI.
// 
// Параметры:
// 	Источник - Строка - путь к документу с описанием данных или сами данные в соответствии с OpenAPI спецификацией;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
// 	Мок.Когда(
//		Мок.OpenAPI()
//			.Источник("https://example.com/openapi.json")
//	).Проверить(
//		Мок.Повторений()
//			.НеМенее(2)
//	);
//
//  Результат = Мок.OpenAPI().Источник( "file:/Users/me/openapi.json" );
//
Function Источник( Источник ) Export
	
	Return WithSource( Источник );
	
EndFunction

// Добавляет свойство "operationId", указывающее на операцию из спецификации документа OpenAPI;
// 
// Параметры:
// 	Операция - Строка - операция из документа OpenAPI;
// 	
// Возвращаемое значение:
// 	ОбработкаОбъект.MockServerClient - текущий экземпляр мок-объекта с добавленным свойством;
//
// Пример:
//  
// 	Мок.Когда(
//		Мок.OpenAPI()
//			.Источник("https://example.com/openapi.json")
//			.Операция("listPets")
//	).Проверить(
//		Мок.Повторений()
//			.НеМенее(2)
//	);
//
//  Результат = Мок.OpenAPI().Источник( "file:/Users/me/openapi.json" ).Операция("listPets");
//
Function Операция( Операция ) Export
	
	Return WithOperationId( Операция );
	
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

Procedure AddPropertyToConstructorByCurrentStage( Val Key, Val Value )
	
	Var ConstructorRootProperty;
	
	ConstructorRootProperty = ConstructorRootProperty( ThisObject.CurrentStage );
	ConstructorRootProperty.Insert( Key, Value );
	
EndProcedure

Процедура AddMultipleValuesPropertyToConstructorByCurrentStage( Val Key, Val Value )
	
	Var Result;
	
	Result = ConstructorStagePropertyOrInitMapIfAbsent( ThisObject.CurrentStage, Key );

	For Each KeyValue In Value Do
		
		Result.Insert( KeyValue.Key, KeyValue.Value );
		
	EndDo;
	
КонецПроцедуры

Procedure FillConstructorRootPropertyByValueType( Key, Value, Stage = "" )
	
	If ( TypeOf(Value) = Type("String") ) Then
		
		ThisObject[ Key + "Node" ] = Value;
		
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

Function JoinJSONParts()
	
	Var Result;

	Result = "{" + Chars.LF;
	
	FillActionTemplate( Result, "httpRequest", HttpRequestNode);
	FillActionTemplate( Result, "httpResponse", HttpResponseNode);
	FillActionTemplate( Result, "times", TimesNode);
	
	Result = Left( Result, StrLen(Result) - 1 );
	Result = Result + Chars.LF + "}";
	
	Возврат Result;
	
EndFunction

Procedure GenerateOpenApiJSON( Val Source, Val Condition = "" )
	
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
    
    ThisObject.JSON = StrTemplate( Template, Source, Condition );

EndProcedure

Procedure GenerateJSON()
	
	If (Not IsBlankString(ThisObject.JSON)) Then
		
		Return;
		
	EndIf;
	
	If ( ThisObject.Constructor = Undefined ) Then
		
		ThisObject.JSON = JoinJSONParts();

	Else
		
		JSONWriterOptions = New Structure();
		JSONWriterOptions.Insert( "ПереносСтрок", JSONLineBreak.Unix );
		JSONWriterOptions.Insert( "СимволыОтступа", " " );
		
		ThisObject.JSON = HTTPConnector.ОбъектВJson( ThisObject.Constructor, , JSONWriterOptions );
		
	EndIf;
	
EndProcedure

Function ContentTypeJSONHeaders()
	
	Var Headers;
	
	Headers = New Map();
	Headers.Insert( "Content-Type", "application/json; charset=utf-8" );
	
	Return New Structure( "Заголовки", Headers );
	
EndFunction

Процедура DoAction( Val Action )
	
	Var PutJSON;
	Var PutHeaders;
	
	ThisObject.CurrentStage = "";
	ThisObject.IsActionOk = False;

	If ( IsBlankString(ThisObject.JSON) ) Then
		
		PutJSON = Undefined;
		PutHeaders = Undefined;

	Else
		
		PutJSON = ThisObject.JSON;
		PutHeaders = ContentTypeJSONHeaders();
	
	EndIf;
	
	ThisObject.MockServerResponse = HTTPConnector.Put( ThisObject.URL + "/mockserver/" + Action,
															PutJSON,
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