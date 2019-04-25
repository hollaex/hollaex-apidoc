---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='https://hollaex.com/account/developers'>Sign Up for a Developer Key</a>

includes:
  - errors

search: true
---

# Introduction

> All shell commands are CURL. You can read more about CURL [here](https://curl.haxx.se/).

HollaEx provides a complete RESTful API for developers which allows full access to all the functionalities on the exchange. HollaEx also support websocket for real-time updates.

These endpoints are categorized into public and private. Public endpoints allow you to access public information such as price ticker, orderbook etc while private endpoints require authentication and allow you to get your balance, active orders as well as placing orders.

We have language bindings in Shell with CURL and you can view code examples in the dark area on the right.

# Authentication

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request 
curl -X POST
  -H "Authorization: Bearer $ACCESS_TOKEN"
  "api_endpoint_here"
```

> Make sure to replace `$ACCESS_TOKEN` with your API key.

HollaEx uses API tokens to allow private access to the API for an authenticated user. You can register a new HollaEx API key in our [developer portal](https://hollaex.com/developers).

HollaEx expects the API key to be included in all Private API requests to the server in the request header with the following format:

`Authorization: Bearer <ACCESS_TOKEN>`

<aside class="notice">
You must replace <code>ACCESS_TOKEN</code> with your own API Token.
</aside>

# Public

## Ticker

> Request

```shell
curl -X GET "https://api.hollaex.com/v0/ticker?symbol=btc-eur"
```

> Response

```json
{
  "ticker": 50000000
}
```

This endpoint retrieves the last price traded.

### HTTP Request

`GET https://api.hollaex.com/v0/ticker`

### PARAMETERS

Parameter | Description
--------- | ------- 
symbol | the currency pair symbol (btc-eur, eth-eur)

## Orderbook

> Request

```shell
curl -X GET "https://api.hollaex.com/v0/orderbooks?symbol=btc-eur"
```

> Response

```json
{
  "timestamp":"2018-03-02T21:36:52.345Z",
  "btc":{
    "bids":[
      [52110000,0.0007],
      [51950000,0.0024],
      [51450000,0.03],
      [51020000,0.0805],
      [51010000,0.0606],
      [51005000,0.01],
      [51000000,0.0746],
      [50770000,0.0024],
      [50000000,0.0004],
      [49500000,0.01]
    ],
    "asks":[
      [52985000,0.0002],
      [52995000,0.0376],
      [53000000,0.11],
      [53190000,0.0051],
      [53400000,0.0006],
      [53700000,0.01],
      [53940000,0.0005],
      [53955000,0.0001],
      [54000000,0.2],
      [55000000,0.0948]
    ],
    "timestamp":"2018-03-02T21:36:29.395Z"
  }
}
```

This endpoint retrieves 10 leve bids and 10 level asks of the orderbook.

### HTTP Request

`GET https://api.hollaex.com/v0/orderbooks`

### PARAMETERS

Parameter | Default | Description
--------- | ----------- | -----------
Symbol | btc-eur | The currency pair symbol

## Trades

> Request

```shell
curl -X GET "https://api.hollaex.com/v0/trades?symbol=btc-eur"
```

> Response

```json
{
  "btc": [
    {
      "size": 0.0008,
      "price": 45500000,
      "side": "buy",
      "timestamp": "2018-03-23T04:00:20.744Z"
    },
    {
      "size": 0.0005,
      "price": 45500000,
      "side": "buy",
      "timestamp": "2018-03-23T03:32:38.927Z"
    },
    {
      "size": 0.0031,
      "price": 44490000,
      "side": "sell",
      "timestamp": "2018-03-23T03:13:42.361Z"
    }
  ]
}
```

This endpoint retrieves the last 30 trades.

### HTTP Request

`GET https://api.hollaex.com/v0/trades`

### PARAMETERS

Parameter | Description
--------- | ------- 
symbol | the currency pair symbol (btc-eur)

# Private

<aside class="notice">
You must replace <code>ACCESS_TOKEN</code> based on the docs on Authentication in the header of all private http requests.
</aside>

## Get User

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN"
  "https://api.hollaex.com/v0/user" 
```

> Response

```json
{
  "id": "integer",
  "email": "string",
  "full_name": "string",
  "gender": true,
  "nationality": "string",
  "dob": "2018-03-23T04:14:08.593Z",
  "address": {
    "country": "string",
    "address": "string",
    "postal_code": "string",
    "city": "string",
    "verified": true
  },
  "phone_number": "string",
  "id_data": {
    "type": "string",
    "number": "string",
    "issued_date": "string",
    "expiration_date": "string",
    "verified": true
  },
  "bank_account": {
    "bank_name": "string",
    "account_number": "string",
    "account_owner": "string",
    "shaba_number": "string",
    "card_number": "string",
    "verified": true
  },
  "crypto_wallet": {},
  "verification_level": 0,
  "access_token": "string",
  "balance": {
    "btc_balance": 0,
    "btc_available": 0,
    "btc_pending": 0,
    "fiat_balance": 0,
    "fiat_available": 0,
    "fiat_pending": 0,
    "updated_at": "2018-03-23T04:14:08.593Z"
  },
  "settings": {
    "language": "en"
  }
}
```

This endpoint gets user's information, crypto wallet address as well as his balance.

### HTTP Request

`GET https://api.hollaex.com/v0/user`

## Get Balance

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN"
  "https://api.hollaex.com/v0/user/balance" 
```

> Response

```json
{
  "btc_balance": 0,
  "btc_available": 0,
  "btc_pending": 0,
  "fiat_balance": 0,
  "fiat_available": 0,
  "fiat_pending": 0,
  "updated_at": "2018-03-23T04:14:08.705Z"
}
```

This endpoint gets user's balance

### HTTP Request

`GET https://api.hollaex.com/v0/user/balance`


## Get Deposits

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN" 
  "https://api.hollaex.com/v0/user/deposits
  ?currency=btc&limit=50&page=1&order=asc"
```

> Response

```json
{
  "count": 0,
  "data": [
    {
      "currency": "string",
      "transaction_id": "string",
      "amount": 0,
      "created_at": "2018-03-23T04:14:08.755Z",
      "type": "deposit",
      "fee": 0,
      "status": true,
      "dissmissed": true,
      "rejected": true,
      "description": "string"
    }
  ]
}
```

This endpoint displays user's deposits

### HTTP Request

`GET https://api.hollaex.com/v0/user/deposits`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The currency pair symbol (btc-eur)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
orderBy | Field to order data
order | asc or desc


## Get Withdrawals

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN" 
  "https://api.hollaex.com/v0/user/withdrawals
  ?currency=btc&limit=50&page=1&order=asc"
```

> Response

```json
{
  "count": 0,
  "data": [
    {
      "currency": "string",
      "transaction_id": "string",
      "amount": 0,
      "created_at": "2018-03-23T04:14:08.755Z",
      "type": "withdrawal",
      "fee": 0,
      "status": true,
      "dissmissed": true,
      "rejected": true,
      "description": "string"
    }
  ]
}
```

This endpoint displays user's withdrawals

### HTTP Request

`GET https://api.hollaex.com/v0/user/withdrawals`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The currency pair symbol (btc-eur)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
orderBy | Field to order data
order | asc or desc

## Get Withdrawal Fee

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN"
  "https://api.hollaex.com/v0/user/withdraw/$currency/fee"
```

> Response

```json
{
  "fee": 0.0005
}
```

This endpoint gets the withdrawal fee for a certain currency

### HTTP Request

`GET https://api.hollaex.com/v0/user/withdraw/{currency}/fee`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The desired currency e.g. btc

## Create Withdrawal Request

> Request

```shell
curl -X POST -H "Authorization: Bearer $ACCESS_TOKEN"
	-d '{"currency":$currency,"amount":$amount,"address":$address}'
	"https://api.hollaex.com/v0/user/request-withdrawal"
```

> Response

```json
{
  "message": "Success"
}
```

This endpoint creates a withdrawal request for the user

### HTTP Request

`POST https://api.hollaex.com/v0/user/request-withdrawal`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The desired currency e.g. btc
amount | The amount to withdrawal e.g. 0.0001
address | The recipient wallet's address

## Get Trades

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN" 
  "https://api.hollaex.com/v0/user/trades
  ?symbol=btc-eur&limit=50&page=1"
```

> Response

```json
{
  "count": 0,
  "data": [
    {
      "fee": 0,
      "side": "buy",
      "symbol": "string",
      "size": 0,
      "price": 0,
      "timestamp": "2018-03-23T04:14:08.663Z"
    }
  ]
}
```

This endpoint displays user's trades

### HTTP Request

`GET https://api.hollaex.com/v0/user/trades`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (btc-eur)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve


## Get All Orders

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN"
  "https://api.hollaex.com/v0/user/orders?symbol=$symbol" 
```

> Response

```json
[
  {
    "id": "string",
    "side": "buy",
    "symbol": "string",
    "size": 0,
    "filled": 0,
    "type": "market",
    "price": 0,
    "status": "string"
  }
]
```

This endpoint gets all active orders placed by the users

### HTTP Request

`GET https://api.hollaex.com/v0/user/orders`

### PARAMETERS

Parameter | Description
--------- | -----------
Symbol | The currency pair symbol (btc-eur)

## Get Order

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN"
  "https://api.hollaex.com/v0/user/orders/$orderId" 
```

> Response

```json

{
  "id": "string",
  "side": "buy",
  "symbol": "string",
  "size": 0,
  "filled": 0,
  "type": "market",
  "price": 0,
  "status": "string"
}

```

This endpoint gets an order by its id.

### HTTP Request

`GET https://api.hollaex.com/v0/user/orders/{orderId}`

### PARAMETERS

Parameter | Description
--------- | -----------
orderId | Order unique Id

## Create Order

> Request

```shell
curl -X POST -H "Authorization: Bearer $ACCESS_TOKEN"
  -d '{"symbol":$symbol,"side":$side,"size":$size,"type":$type,"price":$price}'
  "https://api.hollaex.com/v0/order" 
```

> Response

```json
{
  "id": "string",
  "side": "buy",
  "symbol": "string",
  "size": 0,
  "filled": 0,
  "type": "market",
  "price": 0,
  "status": "string"
}
```

This endpoint places an order for the user

### HTTP Request

`POST https://api.hollaex.com/v0/order`

### PARAMETERS

Parameter | Description
--------- | -----------
Symbol | The currency pair symbol (btc-eur)
side | buy or sell order
size | the amount of the order. For example in btc the unit is BTC
type | limit or market order type
price | Only should be used when type is limit. In case of market price should not be used


## Cancel All Orders

> Request

```shell
curl -X DELETE -H "Authorization: Bearer $ACCESS_TOKEN" 
  "https://api.hollaex.com/v0/user/orders?symbol=$symbol" 
```

> Response

```json

[
  {
    "id": "string",
    "side": "buy",
    "symbol": "string",
    "size": 0,
    "filled": 0,
    "type": "market",
    "price": 0,
    "status": "string"
  }
]

```

This endpoint cancels all orders placed by the user.

### HTTP Request

`DELETE https://api.hollaex.com/v0/user/orders`

### PARAMETERS

Parameter | Description
--------- | -----------
Symbol | The currency pair symbol (btc-eur)

## Cancel Order

> Request

```shell
curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN" 
  "https://api.hollaex.com/v0/user/orders/$orderId" 
```

> Response

```json

{
  "id": "string",
  "side": "buy",
  "symbol": "string",
  "size": 0,
  "filled": 0,
  "type": "market",
  "price": 0,
  "status": "string"
}

```

This endpoint cancels an order by getting its id

### HTTP Request

`DELETE https://api.hollaex.com/v0/user/orders/{orderId}`

### PARAMETERS

Parameter | Description
--------- | -----------
orderId | specific order unique Id


# Websocket

To connect to the websocket, you have to use the <a href="https://socket.io/">socket.io</a> client. Connection to public and private channels are available through two different path as follow.

## Public

For receiving real-time public data updates such as trades, orderbook etc you can connect to `realtime` path.

### Path

`https://api.hollaex.com/v0/realtime`

### PARAMETERS

Parameter | Description
--------- | -----------
query | You can provide the symbol to subscribe to a specific channel, or subscribe to all the channels (no providing the symbol)
symbol | The currency pair symbol (btc-eur)

### EVENTS
You have to subscribe to socket.io events as follows:

#### orderbook
Object with the symbols(currencies) and its top 10 orderbook. Same data as `GET /orderbook?symbol=btc-eur`. When the user connects, receives the complete object with the symbols' top 10 orderbooks. Also will receive the same type of object when an update happens.

#### trades

Object with the last trades of the symbol subscribed. Same data as `GET /trade?symbol=btc-eur`. When the user connects, will receive the last trades (Max number: 50).

## Private

Contact us at `support@bitholla.com` for more information about private websockets.