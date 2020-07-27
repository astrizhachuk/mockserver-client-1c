// КодОтветаHTTP: Работа с кодами ответов HTTP для 1С:Предприятие 8
//
// Copyright 2019 Alexander Strizhachuk
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
//
// URL:    https://github.com/astrizhachuk/CodeStatusHTTP
// e-mail: strizhhh@mail.ru
// Версия: 1.0.0

#Область СлужебныйПрограммныйИнтерфейс

Функция КодыОтветаHTTP() Экспорт
	
	Перем ТаблицаКодовОтвета;
	Перем Результат;
	
	Результат = Новый Структура();
	
	ТаблицаКодовОтвета = ТаблицаКодовОтвета();
	
	Для каждого СтрокаТаблицыЗначений Из ТаблицаКодовОтвета Цикл
		
	 	Результат.Вставить( СтрокаТаблицыЗначений.Имя, СтрокаТаблицыЗначений.Код );
		
	КонецЦикла;
	
	Возврат ( Новый ФиксированнаяСтруктура(Результат) );
	
КонецФункции

Функция ИдентификаторыКодовОтветаHTTP() Экспорт
	
	Перем ТаблицаКодовОтвета;
	Перем Результат;
	
	ТаблицаКодовОтвета = ТаблицаКодовОтвета();
	
	Результат = Новый Соответствие();
	
	Для каждого СтрокаТаблицыЗначений Из ТаблицаКодовОтвета Цикл
		
	 	Результат.Вставить( СтрокаТаблицыЗначений.Код, СтрокаТаблицыЗначений.Имя );
		
	КонецЦикла;
	
	Возврат ( Новый ФиксированноеСоответствие(Результат) );
	
КонецФункции

Функция ОписанияКодовОтветаHTTP() Экспорт
	
	Перем ТаблицаКодовОтвета;
	Перем Результат;
	
	Результат = Новый Соответствие();
	
	ТаблицаКодовОтвета = ТаблицаКодовОтвета();
	
	Для каждого СтрокаТаблицыЗначений Из ТаблицаКодовОтвета Цикл
		
	 	Результат.Вставить( СтрокаТаблицыЗначений.Имя, СтрокаТаблицыЗначений.ПолноеИмя );
		
	КонецЦикла;
	
	Возврат ( Новый ФиксированноеСоответствие(Результат) );
	
КонецФункции

#КонецОбласти
 
#Область СлужебныеПроцедурыИФункции

Функция ТаблицаКодовОтвета()
	
	Перем Результат;
	
	Результат = ОписаниеТаблицыКодовОтвета();
	
	ОписаниеКодаОтвета( Результат, 100, "CONTINUE", "Continue");
	ОписаниеКодаОтвета( Результат, 101, "SWITCHING_PROTOCOLS", "Switching Protocols");
	ОписаниеКодаОтвета( Результат, 102, "PROCESSING", "Processing");
	ОписаниеКодаОтвета( Результат, 103, "CHECKPOINT", "Checkpoint");
	
	ОписаниеКодаОтвета( Результат, 200, "OK", "OK" );
	ОписаниеКодаОтвета( Результат, 201, "CREATED", "Created" );
	ОписаниеКодаОтвета( Результат, 202, "ACCEPTED", "Accepted" );
	ОписаниеКодаОтвета( Результат, 203, "NON_AUTHORITATIVE_INFORMATION", "Non-Authoritative Information" );
	ОписаниеКодаОтвета( Результат, 204, "NO_CONTENT", "No Content" );
	ОписаниеКодаОтвета( Результат, 205, "RESET_CONTENT", "Reset Content" );
	ОписаниеКодаОтвета( Результат, 206, "PARTIAL_CONTENT", "Partial Content" );
	ОписаниеКодаОтвета( Результат, 207, "MULTI_STATUS", "Multi-Status" );
	ОписаниеКодаОтвета( Результат, 208, "ALREADY_REPORTED", "Already Reported" );
	ОписаниеКодаОтвета( Результат, 226, "IM_USED", "IM Used" );
	
	ОписаниеКодаОтвета( Результат, 300, "MULTIPLE_CHOICES", "Multiple сhoices" );
	ОписаниеКодаОтвета( Результат, 301, "MOVED_PERMANENTLY", "Moved Permanently" );
	ОписаниеКодаОтвета( Результат, 302, "FOUND", "Found" );
	ОписаниеКодаОтвета( Результат, 303, "SEE_OTHER", "See Other" );
	ОписаниеКодаОтвета( Результат, 304, "NOT_MODIFIED", "Not Modified" );
	ОписаниеКодаОтвета( Результат, 305, "USE_PROXY", "Use Proxy" );
	ОписаниеКодаОтвета( Результат, 307, "TEMPORARY_REDIRECT", "Temporary Redirect" );
	ОписаниеКодаОтвета( Результат, 308, "PERMANENT_REDIRECT", "Permanent Redirect" );
	
	ОписаниеКодаОтвета( Результат, 400, "BAD_REQUEST", "Bad Request" );
	ОписаниеКодаОтвета( Результат, 401, "UNAUTHORIZED", "Unauthorized" );
	ОписаниеКодаОтвета( Результат, 402, "PAYMENT_REQUIRED", "Payment Required" );
	ОписаниеКодаОтвета( Результат, 403, "FORBIDDEN", "Forbidden" );
	ОписаниеКодаОтвета( Результат, 404, "NOT_FOUND", "Not Found" );
	ОписаниеКодаОтвета( Результат, 405, "METHOD_NOT_ALLOWED", "Method Not Allowed" );
	ОписаниеКодаОтвета( Результат, 406, "NOT_ACCEPTABLE", "Not Acceptable" );
	ОписаниеКодаОтвета( Результат, 407, "PROXY_AUTHENTICATION_REQUIRED", "Proxy Authentication Required" );
	ОписаниеКодаОтвета( Результат, 408, "REQUEST_TIMEOUT", "Request Timeout" );
	ОписаниеКодаОтвета( Результат, 409, "CONFLICT", "Conflict" );
	ОписаниеКодаОтвета( Результат, 410, "GONE", "Gone" );
	ОписаниеКодаОтвета( Результат, 411, "LENGTH_REQUIRED", "Length Required" );
	ОписаниеКодаОтвета( Результат, 412, "PRECONDITION_FAILED", "Precondition Failed" );
	ОписаниеКодаОтвета( Результат, 413, "PAYLOAD_TOO_LARGE", "Payload Too Large" );
	ОписаниеКодаОтвета( Результат, 414, "URI_TOO_LONG", "URI Too Long" );
	ОписаниеКодаОтвета( Результат, 415, "UNSUPPORTED_MEDIA_TYPE", "Unsupported Media Type" );
	ОписаниеКодаОтвета( Результат, 416, "REQUESTED_RANGE_NOT_SATISFIABLE", "Requested range not satisfiable" );
	ОписаниеКодаОтвета( Результат, 417, "EXPECTATION_FAILED", "Expectation Failed" );
	ОписаниеКодаОтвета( Результат, 418, "I_AM_A_TEAPOT", "I'm a teapot" );
	ОписаниеКодаОтвета( Результат, 421, "DESTINATION_LOCKED", "Destination Locked" );
	ОписаниеКодаОтвета( Результат, 422, "UNPROCESSABLE_ENTITY", "Unprocessable Entity" );
	ОписаниеКодаОтвета( Результат, 423, "LOCKED", "Locked" );
	ОписаниеКодаОтвета( Результат, 424, "FAILED_DEPENDENCY", "Failed Dependency" );
	ОписаниеКодаОтвета( Результат, 426, "UPGRADE_REQUIRED", "Upgrade Required" );
	ОписаниеКодаОтвета( Результат, 428, "PRECONDITION_REQUIRED", "Precondition Required" );
	ОписаниеКодаОтвета( Результат, 429, "TOO_MANY_REQUESTS", "Too Many Requests" );
	ОписаниеКодаОтвета( Результат, 431, "REQUEST_HEADER_FIELDS_TOO_LARGE", "Request Header Fields Too Large" );
	ОписаниеКодаОтвета( Результат, 451, "UNAVAILABLE_FOR_LEGAL_REASONS", "Unavailable For Legal Reasons" );

	ОписаниеКодаОтвета( Результат, 500, "INTERNAL_SERVER_ERROR", "Internal Server Error" );
	ОписаниеКодаОтвета( Результат, 501, "NOT_IMPLEMENTED", "Not Implemented" );
	ОписаниеКодаОтвета( Результат, 502, "BAD_GATEWAY", "Bad Gateway" );
	ОписаниеКодаОтвета( Результат, 503, "SERVICE_UNAVAILABLE", "Service Unavailable" );
	ОписаниеКодаОтвета( Результат, 504, "GATEWAY_TIMEOUT", "Gateway Timeout" );
	ОписаниеКодаОтвета( Результат, 505, "HTTP_VERSION_NOT_SUPPORTED", "HTTP Version not supported" );
	ОписаниеКодаОтвета( Результат, 506, "VARIANT_ALSO_NEGOTIATES", "Variant Also Negotiates" );
	ОписаниеКодаОтвета( Результат, 507, "INSUFFICIENT_STORAGE", "Insufficient Storage" );
	ОписаниеКодаОтвета( Результат, 508, "LOOP_DETECTED", "Loop Detected" );
	ОписаниеКодаОтвета( Результат, 509, "BANDWIDTH_LIMIT_EXCEEDED", "Bandwidth Limit Exceeded" );
	ОписаниеКодаОтвета( Результат, 510, "NOT_EXTENDED", "Not Extended" );
	ОписаниеКодаОтвета( Результат, 511, "NETWORK_AUTHENTICATION_REQUIRED", "Network Authentication Required" );

	Возврат Результат;
	
КонецФункции

Функция ОписаниеТаблицыКодовОтвета()
	
	Перем Результат;
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить( "Код", Новый ОписаниеТипов("Число") );
	Результат.Колонки.Добавить( "Имя", Новый ОписаниеТипов("Строка") );
	Результат.Колонки.Добавить( "ПолноеИмя", Новый ОписаниеТипов("Строка") );

	Возврат Результат;
	
КонецФункции

Процедура ОписаниеКодаОтвета( ТаблицаКодов, Знач Код, Знач Имя, Знач ПолноеИмя )
	
	Перем ОписаниеКодаОтвета;

	ОписаниеКодаОтвета = ТаблицаКодов.Добавить();
	ОписаниеКодаОтвета.Код = Код;
	ОписаниеКодаОтвета.Имя = Имя;
	ОписаниеКодаОтвета.ПолноеИмя = ПолноеИмя;

КонецПроцедуры

#КонецОбласти