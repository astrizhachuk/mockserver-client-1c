#If Server Or ThickClientOrdinaryApplication Or ExternalConnection Then

#Region Public

#Region En
	
Function Server( Val Url ) Export
	
	ThisObject.URL = URL;
	Return ThisObject;
	
EndFunction

#EndRegion

#Region Ru

Function Сервер( Val Url ) Export
	
	Return Server( Url );
	
EndFunction

#EndRegion

#EndRegion

#EndIf