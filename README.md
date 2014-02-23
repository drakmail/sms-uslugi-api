[![Build Status](https://travis-ci.org/drakmail/sms-uslugi-api.png?branch=master)](https://travis-ci.org/drakmail/sms-uslugi-api)
[![Coverage Status](https://coveralls.io/repos/drakmail/sms-uslugi-api/badge.png)](https://coveralls.io/r/drakmail/sms-uslugi-api)

# sms-uslugi-api

Gem для взаимодействия с API сервиса sms-uslugi.

## Установка

Запустить

```bash
gem install sms-uslugi-api
```

или добавить в Gemfile:

```ruby
gem 'sms-uslugi-api'
```

## Использование

```ruby
sms = SmsUslugiApi.new 'login', 'password' # инициализация API
sms.info # получение информации об аккаунте, https://lcab.sms-uslugi.ru/send/smsApi#main/lcabApi/orgInfo
sms.get_phone_info '79000000000' # получение информации о номере, https://lcab.sms-uslugi.ru/send/smsApi#main/lcabApi/getPhoneInfo
sms.send 'message in utf8', '81112223333' # отправка SMS получателю, https://lcab.sms-uslugi.ru/send/smsApi#main/lcabApi/send
```

## Методы

### info

Возвращает хеш с информацией об аккаунте:

```ruby
{
  code: 1,
  descr: "Операция завершена успешно",
  account: "583.12",
  ocode: "80009999999",
  tarif: "Аванс::50",
  price: "0.50",
  source: ["systemTest", "Ded Moroz"],
  receive_numbers: [
    "79029999999",
    "79028888888"
  ]
}
```

### send(txt, to, idGroup = nil, source = nil, flash = 0, dateTimeSend = nil, onlydelivery = 0, use_alfasource = nil, discountID = nil)

Отправляет SMS с текстом `txt` (должен быть в кодировке utf8) на номер `to`. Остальные параметры идентичны аналогичным из официальной документации: https://lcab.sms-uslugi.ru/send/smsApi#main/lcabApi/send

Возвращает хеш с информацией об отправке:

```ruby
{
  code: 1,
  descr: "Успешно обработано",
  colsmsOfSending: 1,
  priceOfSending: '0.50'
}
```

## Тестирование

Для запуска тестов необходимо запустить команду `rspec` в директории с проектом. После выполнения тестов будет сохранен отчёт о проценте покрытия кода тестами в директории `coverage`.

## Разработка

Pull-реквесты приветствуются. Чтобы добавить новую функциональность или изменить текущую, требуется:

1. Форкнуть и склонировать репозиторий
2. Написать тесты и код
3. Проверить работоспособность
4. Проверить покрытие кода тестами
5. Закомитить и создать pull-реквест

### Примечание

Так как сервис не поддерживает тестовый режим, а также для того, чтобы не оставлять реальных данных аккаунта, для написания тестов с использованием VCR необходимо сначала указать при инициализации `SmsUslugiApi` в блоке `before` реальные данные, а затем поправить руками в `./fixtures/vcr_cassettes/*.yml` URL запроса, чтобы он содержал в качестве логина и пароля `demo:demo`, а также все необходимые данные.

PS. При смене информации для авторизации все старые тесты не пройдут, это нормальное поведение. После замены логина и пароля обратно на `demo:demo` всё станет нормально.

## Copyright

Copyright (c) 2014 Alexander Maslov. See LICENSE.txt for further details.
