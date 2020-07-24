#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

#Region En
	
Function Server( Val Url ) Export
	
	ThisObject.URL = URL;
	Return ThisObject;
	
EndFunction

Function When( Request ) Export
	
	If ( TypeOf(Request) = Type("String") ) Then
		ThisObject.RequestJson = Request;
	EndIf;
	
	Return ThisObject;
	
EndFunction

Function Request() Export
	
	// TODO extract
	If ( ThisObject.Constructor = Undefined
		Or TypeOf(ThisObject.Constructor) <> Type("Map")) Then
			
			ThisObject.Constructor = New Map();
			
	EndIf;
	
	ThisObject.Constructor.Insert( "httpRequest", New Map() );
	
	Return ThisObject;
	
EndFunction

Function Response() Export
	// TODO extract
	If ( ThisObject.Constructor = Undefined
		Or TypeOf(ThisObject.Constructor) <> Type("Map")) Then
			
			ThisObject.Constructor = New Map();
			
	EndIf;
	
	ThisObject.Constructor.Insert( "httpResponse", New Map() );
	
	Return ThisObject;
	
EndFunction

#Region Terminal

Procedure Respond( Response ) Export
	
	If ( TypeOf(Response) = Type("String") ) Then
		ThisObject.ResponseJson = Response;
	EndIf;
//	
//	ЭтотОбъект.Ответ = Ответ;
//	
//	Заголовки = Новый Соответствие;
//	Заголовки.Вставить("Content-Type", "application/json; charset=utf-8");
//	ДополнительныеПараметры = Новый Структура("Заголовки", Заголовки);
//	ЭтотОбъект.MockServerResponse = КоннекторHTTP.Put(URL + "/mockserver/expectation", JSON(), ДополнительныеПараметры);
//	
//	Если НЕ КодОтветаHTTP.isCreated(ЭтотОбъект.MockServerResponse.КодСостояния) Тогда
//		
//		ВызватьИсключение "MockServer: can't create Expectation.";
//		
//	КонецЕсли;
//	
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

Function Сервер( Val Url ) Export
	
	Return Server( Url );
	
EndFunction

Function Когда( Запрос ) Export
	
	Return When( Запрос );
	
EndFunction

Function Запрос() Export
	
	Return Request();
	
EndFunction

Function Ответ() Export
	
	Return Response();
	
EndFunction

Function Метод( Val Метод = "" ) Export
	
	Return WithMethod( Метод );
	
EndFunction

Function Путь( Val Путь = "" ) Export
	
	Return WithPath( Путь );
	
EndFunction

#EndRegion

#EndRegion

#Region Private

Function RuntimeError( Message = "" )
    
    Return "[RuntimeError]" + Chars.LF + Message;
    
EndFunction

#EndRegion

#EndIf