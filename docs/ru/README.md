# MockServer клиент для 1C:Предприятие 8

[![Quality Gate Status](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)
[![Maintainability Rating](https://sonar.openbsl.ru/api/project_badges/measure?project=mockserver-client-1c&metric=sqale_rating)](https://sonar.openbsl.ru/dashboard?id=mockserver-client-1c)

[english](https://github.com/astrizhachuk/mockserver-client-1c/blob/master/README.md)

*[MockServer](https://www.mock-server.com/#what-is-mockserver)-client-1c* создан для [управления](https://www.mock-server.com/mock_server/mockserver_clients.html) MoskServer с помощью 1C:Предприятие 8. *Клиент* поставляется в виде расширения конфигурации и реализован в виде обработки, взаимодействующей с MockServer через [REST API](https://app.swaggerhub.com/apis/jamesdbloom/mock-server-openapi/5.11.x). MockServer поддерживает OpenAPI v3 спецификацию как в JSON, так и в YAML форматах.

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

```text
// @unit-test
Процедура Пример(Фреймворк) Экспорт
  // given
  Мок = Обработки.MockServerClient.Создать();
  Мок.Сервер( "localhost", "1080", Истина );
  HTTPConnector.Get( "http://localhost:1080/some/path" );
  HTTPConnector.Get( "http://localhost:1080/some/path" );
  // when
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .НеМенее(2)
    );
  // then
  Проверка.ЭтоИстина(Мок.Успешно());
КонецПроцедуры
```

Протестировано!

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

## Начало работы

[Руководство пользователя (англ.)](https://www.mock-server.com/mock_server/getting_started.html)

Обычная последовательность действий при работе с MockServer:

* [Запустить MockServer](#StartMockServer)
* [Создать экземпляр клиента](#CreateInstance)
* [Установить ожидаемое поведение](#SetupExpectations)
* Запустить тестовые сценарии
* Проверить запросы

### Запуск MockServer<a name="StartMockServer"></a>

[Документация по запуску MockServer](https://www.mock-server.com/mock_server/running_mock_server.html)

Пример запуска docker-контейнера с MockServer:

```text
docker run -d --rm -p 1080:1080 --name mockserver-1c-integration mockserver/mockserver -logLevel DEBUG -serverPort 1080
```

Или запуск docker-compose.yml из корня текущего проекта:

```text
docker-compose -f "docker-compose.yml" up -d --build
```

### Создание экземпляра клиента<a name="CreateInstance"></a>

Подключение к серверу по умолчанию:

```text
Мок = Обработки.MockServerClient.Создать();
```

Подключение к серверу с некоторым адресом и портом подключения:

```text
Мок = Обработки.MockServerClient.Создать();
Мок = Мок.Server( "http://server" );
# или
Мок = Обработки.MockServerClient.Создать();
Мок = Мок.Сервер( "http://server", "1099" );
```

Подключение к серверу с некоторым адресом и портом подключения с предварительной [очисткой](https://www.mock-server.com/mock_server/clearing_and_resetting.html) MockServer:

```text
Мок = Обработки.MockServerClient.Создать();
Мок = Мок.Сервер( "http://server", "1099", Истина );
```

### Установка ожидания поведения<a name="SetupExpectations"></a>

Установка ожидания поведения (и проверка запросов) состоит из двух стадий: подготовка условий (в формате json) и выполнение действия для этих условий (отправка json на сервер).

Для клиента доступны два вида методов: **промежуточные** (возвращающие ссылки на объект клиента) и **терминальные** (выполняющие некоторое действие). Некоторые методы принимать в качестве параметров как ссылки на объекты с установленными предварительными условиями, так и строки в формате json. Перед отправкой сообщения на сервер будет автоматически сгенерирован необходимый json в зависимости от выбранной терминальной операции и предварительных условий.

Текущая реализация клиента позволяет использовать вызовы методов в виде цепочки действий, завершающихся терминальной операцией (fluent interface):

```text
  # передача готового json без автоматической генерации
  Мок.Сервер( "localhost", "1080" )
    .Когда( "{""name"":""value""}" )
    .Ответить();

  # передача свойства httpRequest в json-формате
  Мок.Server( "localhost", "1080" )
    .Когда(
      Мок.Запрос( """name"":""value""" )
    )
    .Ответить();

  # комбинированный вариант
  Мок.Сервер( "localhost", "1080" )
    .Когда(
      Мок.Запрос()
        .Метод( "GET" )
        .Путь( "some/path" )
    )
    .Ответить(
        Мок.Ответ( """statusCode"": 404" )
    );

```

## Примеры

### Проверка повторений запросов

#### проверить, что запросы получены не менее двух раз

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .НеМенее(2)
    );
```

#### проверить, что запросы получены не более двух раз

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .НеБолее(2)
    );
```

#### проверить, что запросы получены точно два раза

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .Точно(2)
    );
```

#### проверить, что запросы получены не менее двух раз в соответствии с OpenAPI

```text
  Мок.Когда(
      Мок.OpenAPI()
        .Источник("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
    ).Проверить(
      Мок.Повторений()
        .НеМенее(2)
    );
```

#### проверить, что запрос получен только один раз в соответствии с OpenAPI для некоторой операции

```text
  Мок.When(
      Мок.OpenAPI()
        .Источник("https://raw.githubusercontent.com/mock-server/mockserver/master/mockserver-integration-testing/src/main/resources/org/mockserver/mock/openapi_petstore_example.json")
        .Операция("listPets")
    ).Проверить(
      Мок.Повторений()
        .Однократно()
    );
```

#### проверить, что запрос получен только один раз

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .Однократно()
    );
```

#### проверить, что запросы получены в диапазоне между n и m раз

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .Между(2, 3)
    );
```

#### проверить, что запросов не было

```text
  Мок.Когда(
      Мок.Запрос()
        .Путь("/some/path")
    ).Проверить(
      Мок.Повторений()
        .Точно(0)
    );
```
