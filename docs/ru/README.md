# MockServer клиент для 1C:Предприятие 8

[![Quality Gate Status](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)
[![Maintainability Rating](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=sqale_rating)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)

[english](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/README.md)

*[MockServer](https://www.mock-server.com/#what-is-mockserver)-client-1c* создан для [управления](https://www.mock-server.com/mock_server/mockserver_clients.html) MoskServer при помощи 1C:Предприятие 8. *Клиент* поставляется в виде расширения конфигурации, однако, технически, поставку можно осуществлять и в виде внешней обработки.

## Как это работает

```text
 Мок = Обработки.MockServerClient.Создать();
 Мок.Сервер("localhost", "1080")
  .Когда(
   Мок.Запрос()
    .Метод("GET")
    .Путь("/some/path")
    .Заголовки()
      .Заголовок("foo", "boo")
  ).Ответить(
   Мок.Ответ()
    .КодОтвета(200)
  );
```

Вот и все! Мок создан!

## Guidelines

[Getting Started](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/docs/ru/GettingStarted.md)

## Зависимости

Проект создан с помощью:

1. [1C:Enterprise](https://1c-dn.com) 8.3.16.1502+ (8.3.16 compatibility mode)
2. [1C:Enterprise Development Tools](https://edt.1c.ru) 2020.4 RC1
3. [1Unit](https://github.com/DoublesunRUS/ru.capralow.dt.unit.launcher) 0.4.0+
4. [vanessa-automation](https://github.com/Pr-Mex/vanessa-automation)
5. [dt.bslls.validator](https://github.com/DoublesunRUS/ru.capralow.dt.bslls.validator)
6. [BSL Language Server](https://github.com/1c-syntax/bsl-language-server)

Работа с HTTP реализована с помощью следующих библиотек:

* [HTTPConnector](https://github.com/vbondarevsky/Connector)
* [HTTPStatusCodes](https://github.com/astrizhachuk/HTTPStatusCodes)
