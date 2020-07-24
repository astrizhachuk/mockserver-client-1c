#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

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
	
	If ( TypeOf(What) = Type("String") ) Then
		
		ThisObject.Json = What;
		
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function Request( Val HttpRequestJson = Undefined ) Export
	
	FillPropertyByValue( "httpRequest", HttpRequestJson );

	Return ThisObject;
	
EndFunction

Function Response( Val HttpResponseJson = Undefined  ) Export
	
	FillPropertyByValue( "httpResponse", HttpResponseJson );
	
	Return ThisObject;
	
EndFunction

#EndRegion

#Region Terminal

Procedure Reset() Export
	
	Try

		ThisObject.MockServerResponse = HTTPConnector.Put( ThisObject.URL + "/mockserver/reset" );
		
	Except
		
		ThisObject.MockServerResponse = MockServerError( DetailErrorDescription(ErrorInfo()) );
		
	EndTry;
	
КонецПроцедуры

Procedure Respond( Val Response = Undefined ) Export
	
	If ThisObject.Constructor = Undefined Then
		JSON = JSON();
	Else
		JSON = HTTPConnector.ОбъектВJson(ThisObject.Constructor);
	Endif;
	
	Headers = New Map();
	Headers.Insert( "Content-Type", "application/json; charset=utf-8" );
	Params = New Structure( "Заголовки", Headers );
	Action = URL + "/mockserver/expectation";
	ThisObject.MockServerResponse = HTTPConnector.Put(Action, JSON, Params);

	If Not HTTPStatusCode.isCreated(ThisObject.MockServerResponse.КодСостояния) Then
		
		Message = NStr("en = '[MockServer]: can't create Action (Expectation).';
		         |ru = '[MockServer]: не могу создать Expectation.'");
		
		If (HTTPStatusCode.isBadRequest(ThisObject.MockServerResponse.КодСостояния)) Then
			Message = Message + Chars.LF + HTTPConnector.КакТекст(ThisObject.MockServerResponse);
		EndIf;
		
		Raise RuntimeError( Message );		
		
	EndIf;

EndProcedure

#EndRegion

#Region RequestMatchers

Function WithMethod( Val Method = "" ) Export
	
	Var Result;
	
	// TODO extract
	If ( ThisObject.Constructor = Undefined ) Then
		Raise RuntimeError(
		    NStr("en = 'Constructor not initialized.';
		         |ru = 'Конструктор не был инициализирован.'")
		);
	EndIf;
	// TODO extract from extract?
	Result = ThisObject.Constructor.Get("httpRequest");
	If ( TypeOf(Result) <> Type("Map") ) Then
		Raise RuntimeError(
		    NStr("en = 'Request constructor is not correct.';
		         |ru = 'Некорректный конструктор запроса.'")
		);
	EndIf;
	//
	
	Result.Insert( "method", Method );
	
	Return ThisObject;
	
EndFunction

Function WithPath( Val Path = "" ) Export
	
	Var Result;
	
	Result = ThisObject.Constructor[ "httpRequest" ];
	Result.Insert( "path", Path );
	
	Return ThisObject;
	
EndFunction
	
#EndRegion


/////////////////////


//Функция Ответ() Экспорт
//
//	Если ЭтотОбъект.Конструктор = Неопределено Тогда
//		ЭтотОбъект.Конструктор = Новый Соответствие();
//	КонецЕсли;
//	ЭтотОбъект.Конструктор.Вставить("httpResponse", Новый Соответствие());
//	
//	Возврат ЭтотОбъект;
//	
//КонецФункции
///////////////////////////

#EndRegion

#Region Ru

Function Сервер( URL, Port = Undefined ) Export
	
	Return Server( URL, Port );
	
EndFunction

Procedure Сбросить() Export
	
	Reset();
	
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

Function Метод( Метод = "" ) Export
	
	Return WithMethod( Метод );
	
EndFunction

Function Путь( Путь = "" ) Export
	
	Return WithPath( Путь );
	
EndFunction

#EndRegion

#EndRegion

#Region Private

Procedure InitConstructor()
	
	If ( ThisObject.Constructor = Undefined
		Or TypeOf(ThisObject.Constructor) <> Type("Map")) Then
			
			ThisObject.Constructor = New Map();
			
	EndIf;
	
EndProcedure

Procedure FillPropertyByValue( JsonProperty, Value )
	
	If ( TypeOf(Value) = Type("String") ) Then
		ThisObject[ JsonProperty + "Json" ] = Value;
	Else

		InitConstructor();
		ThisObject.Constructor.Insert( JsonProperty, New Map() );
		
	EndIf;
	
EndProcedure

Функция JSON()
	
	Перем JSON;
	
	JSON = "{";
	
	Если ( ТипЗнч(HttpRequestJson) = Тип("String") И НЕ ПустаяСтрока(HttpRequestJson) ) Тогда
		
		JSON = JSON + "
			|    ""httpRequest"": {";
		JSON = JSON + HttpRequestJson;
		Если HttpResponseJson = Неопределено Тогда
			JSON = JSON + "
				|    }";
		Иначе
			JSON = JSON + "
				|    },";			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ( ТипЗнч(HttpResponseJson) = Тип("String") И НЕ ПустаяСтрока(HttpResponseJson) ) Тогда
		
		JSON = JSON + "
			|    ""httpResponse"": {";
		JSON = JSON + HttpResponseJson;
		JSON = JSON + "
			|    }";

	КонецЕсли;
	
	JSON = JSON + "
			|}";
	
	Возврат JSON;
	
КонецФункции

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