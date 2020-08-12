
// BSLLS-off

// HTTPStatusCodes - https://github.com/astrizhachuk/HTTPStatusCodes
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
// version: 2.0.2
//
//	Status Codes (RFC 2068, 2518, 3229, 4918, 5842, 6585, 7231-7233):
//		100, "CONTINUE", "Continue"
// 		101, "SWITCHING_PROTOCOLS", "Switching Protocols"
//      102, "PROCESSING", "Processing"
//      103, "CHECKPOINT", "Checkpoint"
//
//		200, "OK", "OK"
//		201, "CREATED", "Created"
//		202, "ACCEPTED", "Accepted"
//		203, "NON_AUTHORITATIVE_INFORMATION", "Non-Authoritative Information"
//		204, "NO_CONTENT", "No Content"
//		205, "RESET_CONTENT", "Reset Content"
//		206, "PARTIAL_CONTENT", "Partial Content"
//		207, "MULTI_STATUS", "Multi-Status"
//		208, "ALREADY_REPORTED", "Already Reported"
//		226, "IM_USED", "IM Used"
//
//		300, "MULTIPLE_CHOICES", "Multiple сhoices"
//		301, "MOVED_PERMANENTLY", "Moved Permanently"
//		302, "FOUND", "Found"
//		303, "SEE_OTHER", "See Other"
//		304, "NOT_MODIFIED", "Not Modified"
//		305, "USE_PROXY", "Use Proxy"
//		307, "TEMPORARY_REDIRECT", "Temporary Redirect"
//		308, "PERMANENT_REDIRECT", "Permanent Redirect"
//
//		400, "BAD_REQUEST", "Bad Request"
//		401, "UNAUTHORIZED", "Unauthorized"
//		402, "PAYMENT_REQUIRED", "Payment Required"
//		403, "FORBIDDEN", "Forbidden"
//		404, "NOT_FOUND", "Not Found"
//		405, "METHOD_NOT_ALLOWED", "Method Not Allowed"
//		406, "NOT_ACCEPTABLE", "Not Acceptable"
//		407, "PROXY_AUTHENTICATION_REQUIRED", "Proxy Authentication Required"
//		408, "REQUEST_TIMEOUT", "Request Timeout"
//		409, "CONFLICT", "Conflict"
//		410, "GONE", "Gone"
//		411, "LENGTH_REQUIRED", "Length Required"
//		412, "PRECONDITION_FAILED", "Precondition Failed"
//		413, "PAYLOAD_TOO_LARGE", "Payload Too Large"
//		414, "URI_TOO_LONG", "URI Too Long"
//		415, "UNSUPPORTED_MEDIA_TYPE", "Unsupported Media Type"
//		416, "REQUESTED_RANGE_NOT_SATISFIABLE", "Requested range not satisfiable"
//		417, "EXPECTATION_FAILED", "Expectation Failed"
//		418, "I_AM_A_TEAPOT", "I'm a teapot"
//		421, "DESTINATION_LOCKED", "Destination Locked"
//		422, "UNPROCESSABLE_ENTITY", "Unprocessable Entity"
//		423, "LOCKED", "Locked"
//		424, "FAILED_DEPENDENCY", "Failed Dependency"
//		426, "UPGRADE_REQUIRED", "Upgrade Required"
//		428, "PRECONDITION_REQUIRED", "Precondition Required"
//		429, "TOO_MANY_REQUESTS", "Too Many Requests"
//		431, "REQUEST_HEADER_FIELDS_TOO_LARGE", "Request Header Fields Too Large"
//		451, "UNAVAILABLE_FOR_LEGAL_REASONS", "Unavailable For Legal Reasons"
//
//		500, "INTERNAL_SERVER_ERROR", "Internal Server Error"
//		501, "NOT_IMPLEMENTED", "Not Implemented"
//		502, "BAD_GATEWAY", "Bad Gateway"
//		503, "SERVICE_UNAVAILABLE", "Service Unavailable"
//		504, "GATEWAY_TIMEOUT", "Gateway Timeout"
//		505, "HTTP_VERSION_NOT_SUPPORTED", "HTTP Version not supported"
//		506, "VARIANT_ALSO_NEGOTIATES", "Variant Also Negotiates"
//		507, "INSUFFICIENT_STORAGE", "Insufficient Storage"
//		508, "LOOP_DETECTED", "Loop Detected"
//		509, "BANDWIDTH_LIMIT_EXCEEDED", "Bandwidth Limit Exceeded"
//		510, "NOT_EXTENDED", "Not Extended"
//		511, "NETWORK_AUTHENTICATION_REQUIRED", "Network Authentication Required"

// BSLLS:CachedPublic-off
// BSLLS:Typo-off
#Region Public

// Returns a three-digit numeric HTTP status code by its identifier.
//
// Parameters:
//  Id - String - HTTP status code identifier;
// 
// Returns:
//	- Undefined - code not found;
//	- Number - three-digit numeric HTTP status code;
//
Function FindCodeById( Val Id ) Export
	
	Var StatusCodes;
	Var Result;

	StatusCodes = HTTPStatusCodesClientServerCached.StatusCodesCached();
	
	Result = Undefined;
	
	Try
		
		Result = StatusCodes[ Upper(Id) ];
	
	Except
		
		Result = Undefined;
	
	EndTry;

	Return Result;
 
EndFunction

// Returns the HTTP status code identifier by its three-digit numeric.
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//	- Undefined - identifier not found;
//	- String - HTTP status code identifier;
//
Function FindIdByCode( Val Code ) Export
	
	Var StatusCodesId;
	
	StatusCodesId = HTTPStatusCodesClientServerCached.StatusCodesIdCached();

	Return StatusCodesId.Get( Code );

EndFunction

// Returns the HTTP status code identifier by its three-digit numeric.
//
// Parameters:
//  Id - String - HTTP status code identifier;
// 
// Returns:
//	- Undefined - identifier not found;
//	- String - HTTP status code identifier;
//
Function FindReasonPhraseById( Val Id ) Export
	
	Var StatusCodesDescription;
	
	StatusCodesDescription = HTTPStatusCodesClientServerCached.StatusCodesReasonPhrasesCached();
	
	Return StatusCodesDescription.Get( Upper(Id) );

EndFunction

// Returns a string representation of the HTTP status code class by its three-digit numeric code.
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//	- Undefined - class not found;
//  - String - possible values: "Informational", "Success", "Redirection", "ClientError", "ServerError";
//
Function StatusCodesClass( Val Code ) Export
	
	Var GroupNumber;
	Var Result;

	COUNT_CODES_IN_CLASS = 100;
	FIRST_CLASS = 1;
	LAST_CLASS = 5;
	
	Result = Undefined;
	
	If ( FindIdByCode( Code ) = Undefined ) Then
		
		Return Result;
		
	EndIf;

	GroupNumber = Int( Code / COUNT_CODES_IN_CLASS );
	
	If ( GroupNumber < FIRST_CLASS И GroupNumber > LAST_CLASS ) Then
		
		Return Result;
		
	EndIf;
	
	Return StatusCodesClasses()[ GroupNumber - 1 ];
	
EndFunction

// Determines whether the HTTP status code is "Informational".
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the status code belongs to the class "Informational", otherwise it's false;
//
Function IsInformational( Val Code ) Export
	
	Return ( StatusCodesClass( Code ) = "Informational" );
	
EndFunction

// Determines whether the HTTP status code is "Success".
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the status code belongs to the class "Success", otherwise it's false;
//
Function IsSuccess( Val Code ) Export
	
	Return ( StatusCodesClass( Code ) = "Success" );
	
EndFunction

// Determines whether the HTTP status code is "Redirection".
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the status code belongs to the class "Redirection", otherwise it's false;
//
Function IsRedirection( Val Code ) Export
	
	Return ( StatusCodesClass( Code ) = "Redirection" );
	
EndFunction

// Determines whether the HTTP status code is "ClientError".
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the status code belongs to the class "ClientError", otherwise it's false;
//
Function IsClientError( Val Code ) Export
	
	Return ( StatusCodesClass( Code ) = "ClientError" );
	
EndFunction

// Determines whether the HTTP status code is "ServerError".
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the status code belongs to the class "ServerError", otherwise it's false;
//
Function IsServerError( Val Code ) Export
	
	Return ( StatusCodesClass( Code ) = "ServerError" );
	
EndFunction

#Region Informational_1xx

// Determines whether the value belongs to the code 100, "CONTINUE", "Continue".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsContinue( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["CONTINUE"] );
	
EndFunction

// Determines whether the value belongs to the code 101, "SWITCHING_PROTOCOLS", "Switching Protocols".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsSwitchingProtocols( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["SWITCHING_PROTOCOLS"] );
	
EndFunction

// Determines whether the value belongs to the code 102, "PROCESSING", "Processing".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsProcessing( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PROCESSING"] );
	
EndFunction

// Determines whether the value belongs to the code 103, "CHECKPOINT", "Checkpoint".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsCheckpoint( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["CHECKPOINT"] );
	
EndFunction

#EndRegion

#Region Success_2xx

// Determines whether the value belongs to the code 200, "OK", "OK".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsOk( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["OK"] );

EndFunction

// Determines whether the value belongs to the code 201, "CREATED", "Created".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsCreated( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["CREATED"] );

EndFunction

// Determines whether the value belongs to the code 202, "ACCEPTED", "Accepted".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsAccepted( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["ACCEPTED"] );

EndFunction

// Determines whether the value belongs to the code
// 203, "NON_AUTHORITATIVE_INFORMATION", "Non-Authoritative Information".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNonAuthoritative( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NON_AUTHORITATIVE_INFORMATION"] );

EndFunction

// Determines whether the value belongs to the code 204, "NO_CONTENT", "No Content".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNoContent( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NO_CONTENT"] );

EndFunction

// Determines whether the value belongs to the code 205, "RESET_CONTENT", "Reset Content".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsResetContent( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["RESET_CONTENT"] );

EndFunction

// Determines whether the value belongs to the code 206, "PARTIAL_CONTENT", "Partial Content".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPartialContent( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PARTIAL_CONTENT"] );

EndFunction

// Determines whether the value belongs to the code 207, "MULTI_STATUS", "Multi-Status".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsMultiStatus( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["MULTI_STATUS"] );

EndFunction

// Determines whether the value belongs to the code 208, "ALREADY_REPORTED", "Already Reported".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsAlreadyReported( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["ALREADY_REPORTED"] );

EndFunction

// Determines whether the value belongs to the code 226, "IM_USED", "IM Used".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsIMUsed( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["IM_USED"] );

EndFunction

#EndRegion

#Region Redirection_3xx

// Determines whether the value belongs to the code 300, "MULTIPLE_CHOICES", "Multiple сhoices".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsMultipleChoices( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["MULTIPLE_CHOICES"] );

EndFunction

// Determines whether the value belongs to the code 301, "MOVED_PERMANENTLY", "Moved Permanently".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsMovedPermanently( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["MOVED_PERMANENTLY"] );

EndFunction

// Determines whether the value belongs to the code 302, "FOUND", "Found".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsFound( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["FOUND"] );

EndFunction

// Determines whether the value belongs to the code 303, "SEE_OTHER", "See Other".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsSeeOther( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["SEE_OTHER"] );

EndFunction

// Determines whether the value belongs to the code 304, "NOT_MODIFIED", "Not Modified".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNotModified( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NOT_MODIFIED"] );

EndFunction

// Determines whether the value belongs to the code 305, "USE_PROXY", "Use Proxy".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUseProxy( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["USE_PROXY"] );

EndFunction

// Determines whether the value belongs to the code 307, "TEMPORARY_REDIRECT", "Temporary Redirect".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsTemporaryRedirect( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["TEMPORARY_REDIRECT"] );

EndFunction

// Determines whether the value belongs to the code 308, "PERMANENT_REDIRECT", "Permanent Redirect".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPermanentRedirect( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PERMANENT_REDIRECT"] );

EndFunction

#EndRegion

#Region ClientError_4xx

// Determines whether the value belongs to the code 400, "BAD_REQUEST", "Bad Request".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsBadRequest( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["BAD_REQUEST"] );

EndFunction

// Determines whether the value belongs to the code 401, "UNAUTHORIZED", "Unauthorized".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUnauthorized( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["UNAUTHORIZED"] );

EndFunction

// Determines whether the value belongs to the code 402, "PAYMENT_REQUIRED", "Payment Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPaymentRequired( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PAYMENT_REQUIRED"] );

EndFunction

// Determines whether the value belongs to the code 403, "FORBIDDEN", "Forbidden".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsForbidden( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["FORBIDDEN"] );

EndFunction

// Determines whether the value belongs to the code 404, "NOT_FOUND", "Not Found".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNotFound( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NOT_FOUND"] );

EndFunction

// Determines whether the value belongs to the code 405, "METHOD_NOT_ALLOWED", "Method Not Allowed".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsMethodNotAllowed( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["METHOD_NOT_ALLOWED"] );

EndFunction

// Determines whether the value belongs to the code 406, "NOT_ACCEPTABLE", "Not Acceptable".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNotAcceptable( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NOT_ACCEPTABLE"] );

EndFunction

// Determines whether the value belongs to the code
// 407, "PROXY_AUTHENTICATION_REQUIRED", "Proxy Authentication Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsProxyAuthentication( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PROXY_AUTHENTICATION_REQUIRED"] );

EndFunction

// Determines whether the value belongs to the code 408, "REQUEST_TIMEOUT", "Request Timeout".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsRequestTimeout( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["REQUEST_TIMEOUT"] );

EndFunction

// Determines whether the value belongs to the code 409, "CONFLICT", "Conflict".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsConflict( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["CONFLICT"] );

EndFunction

// Determines whether the value belongs to the code 410, "GONE", "Gone".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsGone( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["GONE"] );

EndFunction

// Determines whether the value belongs to the code 411, "LENGTH_REQUIRED", "Length Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsLengthRequired( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["LENGTH_REQUIRED"] );

EndFunction

// Determines whether the value belongs to the code 412, "PRECONDITION_FAILED", "Precondition Failed".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPreconditionFailed( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PRECONDITION_FAILED"] );

EndFunction

// Determines whether the value belongs to the code 413, "PAYLOAD_TOO_LARGE", "Payload Too Large".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPayloadTooLarge( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PAYLOAD_TOO_LARGE"] );

EndFunction

// Determines whether the value belongs to the code 414, "URI_TOO_LONG", "URI Too Long".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsURITooLong( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["URI_TOO_LONG"] );

EndFunction

// Determines whether the value belongs to the code 415, "UNSUPPORTED_MEDIA_TYPE", "Unsupported Media Type".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUnsupportedMedia( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["UNSUPPORTED_MEDIA_TYPE"] );

EndFunction

// Determines whether the value belongs to the code
// 416, "REQUESTED_RANGE_NOT_SATISFIABLE", "Requested range not satisfiable".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsRequestedRangeNotSatisfiable( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["REQUESTED_RANGE_NOT_SATISFIABLE"] );

EndFunction

// Determines whether the value belongs to the code 417, "EXPECTATION_FAILED", "Expectation Failed".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsExpectationFailed( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["EXPECTATION_FAILED"] );

EndFunction

// Determines whether the value belongs to the code 418, "I_AM_A_TEAPOT", "I'm a teapot".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsImATeapot( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["I_AM_A_TEAPOT"] );

EndFunction

// Determines whether the value belongs to the code 421, "DESTINATION_LOCKED", "Destination Locked".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsDestinationLocked( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["DESTINATION_LOCKED"] );

EndFunction

// Determines whether the value belongs to the code 422, "UNPROCESSABLE_ENTITY", "Unprocessable Entity".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUnprocessableEntity( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["UNPROCESSABLE_ENTITY"] );

EndFunction

// Determines whether the value belongs to the code 423, "LOCKED", "Locked".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsLocked( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["LOCKED"] );

EndFunction

// Determines whether the value belongs to the code 424, "FAILED_DEPENDENCY", "Failed Dependency".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsFailedDependency( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["FAILED_DEPENDENCY"] );

EndFunction

// Determines whether the value belongs to the code 426, "UPGRADE_REQUIRED", "Upgrade Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUpgradeRequired( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["UPGRADE_REQUIRED"] );

EndFunction

// Determines whether the value belongs to the code 428, "PRECONDITION_REQUIRED", "Precondition Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsPreconditionRequired( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["PRECONDITION_REQUIRED"] );

EndFunction

// Determines whether the value belongs to the code 429, "TOO_MANY_REQUESTS", "Too Many Requests".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsTooManyRequests( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["TOO_MANY_REQUESTS"] );

EndFunction

// Determines whether the value belongs to the code
// 431, "REQUEST_HEADER_FIELDS_TOO_LARGE", "Request Header Fields Too Large".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsRequestHeaderTooLarge( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["REQUEST_HEADER_FIELDS_TOO_LARGE"] );

EndFunction

// Determines whether the value belongs to the code
// 451, "UNAVAILABLE_FOR_LEGAL_REASONS", "Unavailable For Legal Reasons".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsUnavailableReasons( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["UNAVAILABLE_FOR_LEGAL_REASONS"] );

EndFunction

#EndRegion

#Region ServerError_5xx

// Determines whether the value belongs to the code 500, "INTERNAL_SERVER_ERROR", "Internal Server Error".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsInternalServerError( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["INTERNAL_SERVER_ERROR"] );

EndFunction

// Determines whether the value belongs to the code 501, "NOT_IMPLEMENTED", "Not Implemented".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNotImplemented( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NOT_IMPLEMENTED"] );

EndFunction

// Determines whether the value belongs to the code 502, "BAD_GATEWAY", "Bad Gateway".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsBadGateway( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["BAD_GATEWAY"] );

EndFunction

// Determines whether the value belongs to the code 503, "SERVICE_UNAVAILABLE", "Service Unavailable".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsServiceUnavailable( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["SERVICE_UNAVAILABLE"] );

EndFunction

// Determines whether the value belongs to the code 504, "GATEWAY_TIMEOUT", "Gateway Timeout".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsGatewayTimeout( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["GATEWAY_TIMEOUT"] );

EndFunction

// Determines whether the value belongs to the code 505, "HTTP_VERSION_NOT_SUPPORTED", "HTTP Version not supported".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsHTTPVersionNotSupported( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["HTTP_VERSION_NOT_SUPPORTED"] );

EndFunction

// Determines whether the value belongs to the code 506, "VARIANT_ALSO_NEGOTIATES", "Variant Also Negotiates".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsVariantAlsoNegotiates( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["VARIANT_ALSO_NEGOTIATES"] );

EndFunction

// Determines whether the value belongs to the code 507, "INSUFFICIENT_STORAGE", "Insufficient Storage".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsInsufficientStorage( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["INSUFFICIENT_STORAGE"] );

EndFunction

// Determines whether the value belongs to the code 508, "LOOP_DETECTED", "Loop Detected".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsLoopDetected( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["LOOP_DETECTED"] );

EndFunction

// Determines whether the value belongs to the code 509, "BANDWIDTH_LIMIT_EXCEEDED", "Bandwidth Limit Exceeded".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsBandwidthLimitExceeded( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["BANDWIDTH_LIMIT_EXCEEDED"] );

EndFunction

// Determines whether the value belongs to the code 510, "NOT_EXTENDED", "Not Extended".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNotExtended( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NOT_EXTENDED"] );

EndFunction

// Determines whether the value belongs to the code
// 511, "NETWORK_AUTHENTICATION_REQUIRED", "Network Authentication Required".
// 
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//   - Boolean - true, the value belongs to this HTTP status code, otherwise it's false;
//
Function IsNetworkAuthentication( Val Code ) Export
	
	Return ( Code = StatusCodesCached()["NETWORK_AUTHENTICATION_REQUIRED"] );

EndFunction

#EndRegion

#EndRegion

#Region Internal

Function StatusCodesCached() Export
	
	Var StatusCodes;
	Var Result;
	
	StatusCodes = StatusCodes();
	
	Result = New Map();
	
	For Each Description In StatusCodes Do
		
		Result.Insert( Description.Value.Id, Description.Value.Code );
		
	EndDo;
	
	Return ( New FixedMap(Result) );
	
EndFunction

Function StatusCodesIdCached() Export
	
	Var StatusCodes;
	Var Result;
	
	StatusCodes = StatusCodes();
	
	Result = New Map();
	
	For Each Description In StatusCodes Do
		
		Result.Insert( Description.Value.Code, Description.Value.Id );
		
	EndDo;
	
	Return ( New FixedMap(Result) );
	
EndFunction

Function StatusCodesReasonPhrasesCached() Export
	
	Var StatusCodes;
	Var Result;
	
	StatusCodes = StatusCodes();
	
	Result = New Map();
	
	For Each Description In StatusCodes Do
		
		Result.Insert( Description.Value.Id, Description.Value.ReasonPhrase );
		
	EndDo;
	
	Return ( New FixedMap(Result) );
	
EndFunction

#EndRegion

#Region Private

Function StatusCodesClasses()
	
	Var Result;
	
	Result = New Array();
	Result.Add( "Informational" );
	Result.Add( "Success" );
	Result.Add( "Redirection" );
	Result.Add( "ClientError" );
	Result.Add( "ServerError" );
	
	Return Result;

EndFunction

Function StatusCodes()
	
	Var Result;
	
	Result = New Map();
	
	AddStatusCode( Result, 100, "CONTINUE", "Continue");
	AddStatusCode( Result, 101, "SWITCHING_PROTOCOLS", "Switching Protocols");
	AddStatusCode( Result, 102, "PROCESSING", "Processing");
	AddStatusCode( Result, 103, "CHECKPOINT", "Checkpoint");
	
	AddStatusCode( Result, 200, "OK", "OK" );
	AddStatusCode( Result, 201, "CREATED", "Created" );
	AddStatusCode( Result, 202, "ACCEPTED", "Accepted" );
	AddStatusCode( Result, 203, "NON_AUTHORITATIVE_INFORMATION", "Non-Authoritative Information" );
	AddStatusCode( Result, 204, "NO_CONTENT", "No Content" );
	AddStatusCode( Result, 205, "RESET_CONTENT", "Reset Content" );
	AddStatusCode( Result, 206, "PARTIAL_CONTENT", "Partial Content" );
	AddStatusCode( Result, 207, "MULTI_STATUS", "Multi-Status" );
	AddStatusCode( Result, 208, "ALREADY_REPORTED", "Already Reported" );
	AddStatusCode( Result, 226, "IM_USED", "IM Used" );
	
	AddStatusCode( Result, 300, "MULTIPLE_CHOICES", "Multiple сhoices" );
	AddStatusCode( Result, 301, "MOVED_PERMANENTLY", "Moved Permanently" );
	AddStatusCode( Result, 302, "FOUND", "Found" );
	AddStatusCode( Result, 303, "SEE_OTHER", "See Other" );
	AddStatusCode( Result, 304, "NOT_MODIFIED", "Not Modified" );
	AddStatusCode( Result, 305, "USE_PROXY", "Use Proxy" );
	AddStatusCode( Result, 307, "TEMPORARY_REDIRECT", "Temporary Redirect" );
	AddStatusCode( Result, 308, "PERMANENT_REDIRECT", "Permanent Redirect" );
	
	AddStatusCode( Result, 400, "BAD_REQUEST", "Bad Request" );
	AddStatusCode( Result, 401, "UNAUTHORIZED", "Unauthorized" );
	AddStatusCode( Result, 402, "PAYMENT_REQUIRED", "Payment Required" );
	AddStatusCode( Result, 403, "FORBIDDEN", "Forbidden" );
	AddStatusCode( Result, 404, "NOT_FOUND", "Not Found" );
	AddStatusCode( Result, 405, "METHOD_NOT_ALLOWED", "Method Not Allowed" );
	AddStatusCode( Result, 406, "NOT_ACCEPTABLE", "Not Acceptable" );
	AddStatusCode( Result, 407, "PROXY_AUTHENTICATION_REQUIRED", "Proxy Authentication Required" );
	AddStatusCode( Result, 408, "REQUEST_TIMEOUT", "Request Timeout" );
	AddStatusCode( Result, 409, "CONFLICT", "Conflict" );
	AddStatusCode( Result, 410, "GONE", "Gone" );
	AddStatusCode( Result, 411, "LENGTH_REQUIRED", "Length Required" );
	AddStatusCode( Result, 412, "PRECONDITION_FAILED", "Precondition Failed" );
	AddStatusCode( Result, 413, "PAYLOAD_TOO_LARGE", "Payload Too Large" );
	AddStatusCode( Result, 414, "URI_TOO_LONG", "URI Too Long" );
	AddStatusCode( Result, 415, "UNSUPPORTED_MEDIA_TYPE", "Unsupported Media Type" );
	AddStatusCode( Result, 416, "REQUESTED_RANGE_NOT_SATISFIABLE", "Requested range not satisfiable" );
	AddStatusCode( Result, 417, "EXPECTATION_FAILED", "Expectation Failed" );
	AddStatusCode( Result, 418, "I_AM_A_TEAPOT", "I'm a teapot" );
	AddStatusCode( Result, 421, "DESTINATION_LOCKED", "Destination Locked" );
	AddStatusCode( Result, 422, "UNPROCESSABLE_ENTITY", "Unprocessable Entity" );
	AddStatusCode( Result, 423, "LOCKED", "Locked" );
	AddStatusCode( Result, 424, "FAILED_DEPENDENCY", "Failed Dependency" );
	AddStatusCode( Result, 426, "UPGRADE_REQUIRED", "Upgrade Required" );
	AddStatusCode( Result, 428, "PRECONDITION_REQUIRED", "Precondition Required" );
	AddStatusCode( Result, 429, "TOO_MANY_REQUESTS", "Too Many Requests" );
	AddStatusCode( Result, 431, "REQUEST_HEADER_FIELDS_TOO_LARGE", "Request Header Fields Too Large" );
	AddStatusCode( Result, 451, "UNAVAILABLE_FOR_LEGAL_REASONS", "Unavailable For Legal Reasons" );

	AddStatusCode( Result, 500, "INTERNAL_SERVER_ERROR", "Internal Server Error" );
	AddStatusCode( Result, 501, "NOT_IMPLEMENTED", "Not Implemented" );
	AddStatusCode( Result, 502, "BAD_GATEWAY", "Bad Gateway" );
	AddStatusCode( Result, 503, "SERVICE_UNAVAILABLE", "Service Unavailable" );
	AddStatusCode( Result, 504, "GATEWAY_TIMEOUT", "Gateway Timeout" );
	AddStatusCode( Result, 505, "HTTP_VERSION_NOT_SUPPORTED", "HTTP Version not supported" );
	AddStatusCode( Result, 506, "VARIANT_ALSO_NEGOTIATES", "Variant Also Negotiates" );
	AddStatusCode( Result, 507, "INSUFFICIENT_STORAGE", "Insufficient Storage" );
	AddStatusCode( Result, 508, "LOOP_DETECTED", "Loop Detected" );
	AddStatusCode( Result, 509, "BANDWIDTH_LIMIT_EXCEEDED", "Bandwidth Limit Exceeded" );
	AddStatusCode( Result, 510, "NOT_EXTENDED", "Not Extended" );
	AddStatusCode( Result, 511, "NETWORK_AUTHENTICATION_REQUIRED", "Network Authentication Required" );

	Return Result;
	
EndFunction

Procedure AddStatusCode( Result, Val Code, Val Id, Val ReasonPhrase )
	
	Var Description;
	
	Description = New Structure();
	Description.Insert( "Code", Code );
	Description.Insert( "Id", Id );
	Description.Insert( "ReasonPhrase", ReasonPhrase );

	Result.Insert( Code, Description );

EndProcedure

#EndRegion
