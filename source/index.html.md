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

This endpoint gets all active orders placed by the user

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

For receiving real-time public data updates such as trades, orderbook etc you can connect to the `realtime` path. For real-time private data, connect to the `user` path. 

## Public

> Connection

```javascript

  const io = require('socket.io-client');

  const socket = io('https://api.hollaex.com/realtime', {
    query: { symbol }
  });

  socket.on('orderbook', (data) => { ... }) // orderbook event

  socket.on('trades', (data) => { ... }) // trades event

```

### PATH

`https://api.hollaex.com/realtime`

### PARAMETERS

Parameter | Description
--------- | -----------
query (*optional*) | You can provide the symbol to subscribe to a specific channel, or subscribe to all the channels (no providing the symbol)
symbol | The currency pair symbol (btc-eur)

### EVENTS

The public socket.io events you can subscribe to are:

Event | Description
--------- | -----------
orderbook | Object with the symbols(currencies) and its top 10 orderbook. Same data as `GET /orderbook?symbol=btc-eur`. When the user connects, receives the complete object with the symbols' top 10 orderbooks. Also will receive the same type of object when an update on the orderbook happens.
trades | Object with the last trades of the symbol subscribed. Same data as `GET /trade?symbol=btc-eur`. When the user connects, will receive the last trades (Max number: 50). Also will receive the same type of object when a trade happens.

## Private

> Connection

```javascript

  const io = require('socket.io-client');

  const socket = io('https://api.hollaex.com/user', {
    query: { token: `Bearer ${ACCESS_TOKEN}` }
  });

  socket.on('userInfo', (data) => { ... }) // userInfo event

  socket.on('userOrder', (data) => { ... }) // userOrder event

  socket.on('userTrades', (data) => { ... }) // userTrades event

  socket.on('userWallet', (data) => { ... }) // userWallet event

  socket.on('userUpdate', (data) => { ... }) // userUpdate event

```
### PATH

`https://api.hollaex.com/user`


### PARAMETERS

Parameter | Description
--------- | -----------
query | You must provide your HollaEx API token (`token`)
token | Preceded by `Bearer` e.g.  `` `Bearer ${ACCESS_TOKEN}` ``

<aside class="notice">
You must replace <code>ACCESS_TOKEN</code> with your own API Token.
</aside>

### EVENTS

The private socket.io events you can subscribe to are:

Event | Description
--------- | -----------
userInfo | Object with user's id, email, name, balance, etc. Same data as `GET /user`. When the user connects, the socket will send the current user's information. Will not send any other information.
userOrder | Object with the user's active orders. Same data as `GET /user/orders`. When the user connects, the socket will send all the user's active orders. Will not send any other information.
userTrades | Object with the user's last trades (Max number: 50). Same data as `GET /user/trades`. When the user connects, the socket will immediately send the user's last trades (Max number: 50). Will no send any other information.
userWallet | Object with the user's balance. Same data as `GET /user/balance`. When the user connects, the socket will not send any information immediately. Instead, it will wait for any updates to the user's balance and send them in real-time.
userUpdate | The socket will listen for any updates related to the user's private information and send them in real-time.

<aside class="notice">
<code>userInfo</code> , <code>userOrder</code>, <code>userTrade</code>, are similar to GET requests and you should not expect any updates after you receive the first set of data. However, <code>userWallet</code> and <code>userUpdate</code> send all real-time updates.
</aside>

## Private Updates

> order_queued

```json

{
	"action": "update",
	"type": "order_queued",
	"data": {
		"side": "sell",
		"type": "limit",
		"price": 1001,
		"size": 2,
		"symbol": "bch-btc",
		"id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd",
		"created_by": 79,
		"filled": 0
	}
}

```

> order_processed

```json

{
	"action": "update",
	"type": "order_processed",
	"data": { "id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd" }
}

```

> order_canceled

```json

{
	"action": "update",
	"type": "order_canceled",
	"data": {
		"id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd",
		"message": "Insufficient balance to perform the order."
	}
}

```

> order_added

```json

{
	"action": "update",
	"type": "order_added",
	"data": {
		"side": "sell",
		"type": "limit",
		"price": 1001,
		"size": 2,
		"symbol": "bch-btc",
		"id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd",
		"created_by": 79,
		"filled": 0
	}
}

```

> order_partialy_filled

```json

{
	"action": "update",
	"type": "order_partialy_filled",
	"data": {
		"id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd",
		"filled": 0.0001,
		"created_by": 79,
		"side": "sell",
		"type": "limit",
		"size": 2,
		"price": 1001,
		"symbol": "bch-btc"
	}
}

```
>order_filled

```json

{
  "action": "update",
  "type": "order_filled",
  "data": [
    {
      "id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd"
    },
    {
      "id": "bc7717d4-04e9-4430-a21b-08d32b2c34cd"
    },
    ...
  ]
}

```

> order_updated

```json

{
  "action": "update",
	"type": "order_updated",
	"data": {
		"id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd",
		"created_by": 79,
		"price": 1001,
		"side": "sell",
		"size": 2,
		"type": "limit"
	}
}

```

> order_removed

```json

{
  "action": "update",
  "type": "order_removed",
  "data": [
    {
      "id": "ac7717d4-04e9-4430-a21b-08d32b2c34cd"
    },
    {
      "id": "bc7717d4-04e9-4430-a21b-08d32b2c34cd"
    },
    ...
  ]
}

```

> trade

```json

{
  "action": "update",
  "type": "trade",
  "data": [
    {
      "id": "1efd30b6-fcb5-44da-82c1-82d9def2ddbd",
      "side": "sell",
      "symbol": "bch-btc",
      "size": 0.2,
      "price": 999,
      "timestamp": "2017-07-26T13:20:40.464Z",
      "fee": 0,
    },
    ...
  ]
}

```

> deposit

```json

{
	"action": "update",
	"type": "deposit",
	"data": {
		"amount": 3000,
		"currency": "fiat",
		"status": false
	},
	"balance": {
		"fiat_balance": 0,
		"btc_balance": 300000,
		"updated_at": "2017-07-26T13:20:40.464Z"
	}
}

```

> withdrawal

```json

{
	"action": "update",
	"type": "withdrawal",
	"data": {
		"amount": 5000,
		"currency": "btc",
		"status": true
	},
	"balance": {
		"fiat_balance": 0,
		"btc_balance": 300000,
		"updated_at": "2017-07-26T13:20:40.464Z"
	}
}

```

The types of updates from the event `userUpdate` are as follows:

Update | Description
--------- | -----------
order_queued | When a user's order is added to the queue.
order_processed | When a user's order has been processed in the queue.
order_canceled | When a user's order has been canceled while in the queue.
order_added | When a user's order has been added to the orderbook.
order_partialy_filled | When a user's order has been partially filled.
order_filled | When a user's order has been completely filled.
order_updated | When a user's order has been updated.
order_removed | When a user's order in the orderbook has been removed/canceled.
trade | When a user's trade happened.
deposit | When a user's account gets a deposit. *Status = pending or completed*
withdrawal | When a user performs a withdrawal from the account. *Status = pending or completed*