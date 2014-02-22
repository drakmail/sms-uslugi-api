# sms-uslugi-api

Gem для взаимодействия с API сервиса sms-uslugi.

## Использование

```ruby
sms = SmsUslugiApi.new 'login', 'password' # инициализация API
sms.info # получение информации об аккаунте, https://lcab.sms-uslugi.ru/send/smsApi#main/lcabApi/orgInfo
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

## Copyright

Copyright (c) 2014 Alexander Maslov. See LICENSE.txt for further details.

