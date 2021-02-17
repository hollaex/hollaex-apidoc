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
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "api_endpoint_here"
```

> Make sure to replace `$API_KEY`, `$API_SIGNATURE`, and `$API_EXPIRES` with your own key, signature, and expires values.

HollaEx uses HMAC-SHA256 authentication for private user access to the API. HMAC-SHA256 takes a string and secret key (your `api-secret`) and outputs an encoded signature (your `api-signature`). The string being encoded should follow the format `${METHOD}${PATH}${api-expires}`, where `METHOD` is the HTTP method of the request, `PATH` is the path of the request, and `api-expires` is a unix timestamp indicating when the request expires. If the request includes a body, the JSON body object should be appended to the string being encoded e.g. `${METHOD}${PATH}${api-expires}${JSON_BODY}`. You can use an online [HMAC generator](https://www.freeformatter.com/hmac-generator.html) to generate the signature.


Examples of strings being encoded:

- `GET` request to `https://api.hollaex.com/v2/user/balance` that expires at `1575516146`
  - `GET/v2/user/balance1575516146`
- `POST` request to `https://api.hollaex.com/v2/order` that expires at `1575516146` with body `{"symbol":"btc-usdt","side":"buy","size":0.001,"type":"market"}`
  - `POST/v2/order1583284849{"symbol":"btc-usdt","side":"buy","size":0.001,"type":"market"}`

You can register for a new HollaEx `api-key` and `api-secret` in the [security section](https://pro.hollaex.com/security) of hollaex.com.

HollaEx expects `api-key`, `api-signature`, and `api-expires` to be included in all Private API requests to the server in the request header with the following format:

```
api-key: <API_KEY>
api-signature: <API_SIGNATURE>
api-expires: <API_EXPIRES>
```

<aside class="notice">
You must replace <code>API_KEY</code>, <code>API_SIGNATURE</code>, and <code>API_EXPIRES</code> with your own values.
</aside>

# API Client Libraries

Client libraries make it simple to utilize our API. Currently, there are two libraries for HollaEx that support three languages:

- [HollaEx Node Library](https://github.com/bitholla/hollaex-node-lib) - Our official library that supports Node.js. Connects to both our API and websocket.
- [CCXT](https://ccxt.trade) - An authorized library that supports Node.js, PHP, and Python. Connects to our API.

# Public

## Health

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/health"
```

> Response

```json
{
    "name": "HollaEx",
    "version": "2.0.0",
    "host": "api.hollaex.com",
    "basePath": "/v2"
}
```
This endpoint retrieves the exchange's basic information and checks its health.

### HTTP Request

`GET https://api.hollaex.com/v2/health`

## Constants

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/constants"
```

> Response

```json
{
    "coins": {
        "usdt": {
            "id": 6,
            "fullname": "USD Tether",
            "symbol": "usdt",
            "active": true,
            "verified": true,
            "allow_deposit": true,
            "allow_withdrawal": true,
            "withdrawal_fee": 0,
            "min": 0.0001,
            "max": 100000,
            "increment_unit": 0.0001,
            "created_at": "2020-02-03T10:19:10.857Z",
            "updated_at": "2020-02-03T10:19:10.857Z",
            "logo": null,
            "code": "usdt",
            "is_public": true,
            "meta": {},
            "estimated_price": null,
            "description": null,
            "type": "blockchain",
            "network": null,
            "standard": null
        },
        "xht": {
            "id": 1,
            "fullname": "HollaEx",
            "symbol": "xht",
            "active": true,
            "verified": true,
            "allow_deposit": true,
            "allow_withdrawal": true,
            "withdrawal_fee": 0,
            "min": 0.0001,
            "max": 100000,
            "increment_unit": 0.0001,
            "created_at": "2020-02-03T10:19:10.857Z",
            "updated_at": "2020-02-03T10:19:10.857Z",
            "logo": null,
            "code": "xht",
            "is_public": true,
            "meta": {},
            "estimated_price": null,
            "description": null,
            "type": "blockchain",
            "network": null,
            "standard": null
        },
		...
    },
    "pairs": {
        "xht-usdt": {
            "id": 1,
            "name": "xht-usdt",
            "pair_base": "xht",
            "pair_2": "usdt",
            "min_size": 0.1,
            "max_size": 100000,
            "min_price": 0.001,
            "max_price": 1000000,
            "increment_size": 0.001,
            "increment_price": 0.01,
            "active": true,
            "verified": true,
            "code": "xht-usdt",
            "is_public": true,
            "estimated_price": null,
            "created_at": "2020-02-03T10:19:10.846Z",
            "updated_at": "2020-02-03T10:19:10.846Z"
        },
        ...
    }
}
```
This endpoint retrieves system information for coins and pairs.

### HTTP Request

`GET https://api.hollaex.com/v2/constants`

## Kit

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/kit"
```

> Response

```json
{
    "meta": {...},
    "color": {...},
    "icons": {...},
    "links": {...},
    "title": "HollaEx",
    "captcha": {
        "site_key": ""
    },
    "strings": {...},
    "api_name": "HollaEx",
    "defaults": {
        "theme": "dark",
        "language": "en"
    },
    "features": {...},
    "interface": {
        "type": "full"
    },
    "logo_image": "https://bitholla-sandbox.s3.ap-northeast-2.amazonaws.com/exchange/Sandbox_HollaEx/EXCHANGE_LOGO__dark.png",
    "description": "This exchange is the first exchange to be customized on the fly, ever. 2020-Nov-9th",
    "native_currency": "xht",
    "setup_completed": true,
    "valid_languages": "en,fa,ko,ar,pt,ja,ru",
    "new_user_is_activated": true,
	"email_verification_required": true,
    "info": {
        "name": "HollaEx",
        "active": true,
        "url": "https://api.hollaex.com",
        "is_trial": false,
        "created_at": "2020-10-05T06:46:27.272Z",
        "expiry": "2021-02-04T06:46:27.000Z",
        "collateral_level": "member",
        "status": true,
        "initialized": true
    }
}
```
This endpoint retrieves system kit configurations for the client.

### HTTP Request

`GET https://api.hollaex.com/v2/kit`

## Tiers

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/tiers"
```

> Response

```json
{
    "1": {
        "id": 1,
        "name": "Base Trader",
        "icon": "",
        "description": "basic tier",
        "deposit_limit": 0,
        "withdrawal_limit": 0,
        "fees": {
            "maker": {
                "xht-usdt": 0.2,
                "xmr-usdt": 0.2,
                "eth-usdt": 0.2,
                "btc-usdt": 0.2,
                "eth-btc": 0.2
            },
            "taker": {
                "xht-usdt": 0.2,
                "xmr-usdt": 0.2,
                "eth-usdt": 0.2,
                "btc-usdt": 0.2,
                "eth-btc": 0.2
            }
        },
        "note": "",
        "created_at": "2020-10-28T02:00:57.128Z",
        "updated_at": "2021-01-13T15:42:30.615Z"
    },
    "2": {
        "id": 2,
        "name": "VIP Trader",
        "icon": "",
        "description": "vip tier",
        "deposit_limit": 0,
        "withdrawal_limit": 0,
        "fees": {
            "maker": {
                "xht-usdt": 0,
                "xmr-usdt": 0,
                "eth-usdt": 0,
                "btc-usdt": 0,
                "eth-btc": 0
            },
            "taker": {
                "xht-usdt": 0,
                "xmr-usdt": 0,
                "eth-usdt": 0,
                "btc-usdt": 0,
                "eth-btc": 0
            }
        },
        "note": "",
        "created_at": "2020-10-28T02:01:12.299Z",
        "updated_at": "2021-01-07T08:21:15.300Z"
    },
	...
}
```
This endpoint retrieves system tier levels for users.

### HTTP Request

`GET https://api.hollaex.com/v2/tiers`

## Ticker

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/ticker?symbol=xht-usdt"
```

> Response

```json
{
    "open": 0.54,
    "close": 0.54,
    "high": 0.54,
    "low": 0.54,
    "last": 0.54,
    "volume": 0
}
```

This endpoint retrieves ticker information for a pair.

### HTTP Request

`GET https://api.hollaex.com/v2/ticker`

### PARAMETERS

Parameter | Description
--------- | -------
symbol | The currency pair symbol (xht-usdt)

## Tickers

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/tickers"
```

> Response

```json
{
    "xht-usdt": {
        "open": 0.54,
        "close": 0.54,
        "high": 0.54,
        "low": 0.54,
        "last": 0.54,
        "volume": 0
    },
    ...
}
```

This endpoint retrieves ticker information for all pairs.

### HTTP Request

`GET https://api.hollaex.com/v2/tickers`

## Orderbook

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/orderbook?symbol=xht-usdt"
```

> Response

```json
{
	"xht-usdt": {
		"bids": [
			[0.212,8],
			[0.21,5],
			[0.208,15],
			[0.206,583],
			[0.205,1000],
			[0.204,1000],
			[0.203,1000],
			[0.202,1000],
			[0.201,1000],
			[0.2,1000]
		],
		"asks": [
			[0.23,45],
			[0.24,824],
			[0.248,10]
		],
		"timestamp": "2018-03-02T21:36:29.395Z"
	}
}
```

This endpoint retrieves 10 level bids and 10 level asks of the orderbook for a symbol.

### HTTP Request

`GET https://api.hollaex.com/v2/orderbook`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (xht-usdt, etc.)

## Orderbooks

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/orderbooks"
```

> Response

```json
{
	"xht-usdt": {
		"bids": [...],
		"asks": [...],
		"timestamp": "2018-03-02T21:36:29.395Z"
	},
	"btc-usdt": {
		"bids": [...],
		"asks": [...],
		"timestamp": "2018-03-02T21:36:29.395Z"
	},
	...
}
```

This endpoint retrieves 10 level bids and 10 level asks of the orderbook for all symbols.

### HTTP Request

`GET https://api.hollaex.com/v2/orderbooks`

## Trades

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/trades?symbol=xht-usdt"
```

> Response

```json
{
  "xht-usdt": [
    {
      "size": 10,
      "price": 0.2,
      "side": "buy",
      "timestamp": "2018-03-23T04:00:20.744Z"
    },
    {
      "size": 5,
      "price": 0.21,
      "side": "buy",
      "timestamp": "2018-03-23T03:32:38.927Z"
    },
    {
      "size": 5,
      "price": 0.23,
      "side": "sell",
      "timestamp": "2018-03-23T03:13:42.361Z"
    }
  ]
}
```

This endpoint retrieves the last 30 trades.

### HTTP Request

`GET https://api.hollaex.com/v2/trades`

### PARAMETERS

Parameter | Description
--------- | -------
symbol | The currency pair symbol (xht-usdt, etc.)

## Chart

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/chart?symbol=xht-usdt&resolution=1D&from=1551663947&to=1582768007"
```

> Response

```json
[
	{
		"time": "2020-01-01T00:00:00.000Z",
		"close": 0.2,
		"high": 0.23,
		"low": 0.2,
		"open": 0.23,
		"symbol": "xht-usdt",
		"volume": 13538
	},
	{
		"time": "2020-01-02T00:00:00.000Z",
		"close": 0.2,
		"high": 0.2,
		"low": 0.2,
		"open": 0.2,
		"symbol": "xht-usdt",
		"volume": 54
	},
  	{
		"time": "2020-01-03T00:00:00.000Z",
		"close": 0.2,
		"high": 0.201,
		"low": 0.2,
		"open": 0.2,
		"symbol": "xht-usdt",
		"volume": 25982
	}
	...
]
```

This endpoint retrieves a trading pair's trade history HOLCV.

### HTTP Request

`GET https://api.hollaex.com/v2/chart`

## Charts

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/charts?resolution=1D&from=1551663947&to=1582768007"
```

> Response

```json
{
    "xht-usdt": [
        {
			"time": "2020-01-01T00:00:00.000Z",
			"close": 0.2,
			"high": 0.23,
			"low": 0.2,
			"open": 0.23,
			"symbol": "xht-usdt",
			"volume": 13538
		},
		{
			"time": "2020-01-02T00:00:00.000Z",
			"close": 0.2,
			"high": 0.2,
			"low": 0.2,
			"open": 0.2,
			"symbol": "xht-usdt",
			"volume": 54
		},
		{
			"time": "2020-01-03T00:00:00.000Z",
			"close": 0.2,
			"high": 0.201,
			"low": 0.2,
			"open": 0.2,
			"symbol": "xht-usdt",
			"volume": 25982
		},
		...
    ],
    "btc-usdt": [...],
	...
}
```

This endpoint retrieves trade history HOLCV for all pairs.

### HTTP Request

`GET https://api.hollaex.com/v2/charts`

### PARAMETERS

Parameter | Description
--------- | -------
resolution | Time interval resolution (1D, 60, etc.)
from | Beginning UNIX timestamp
to | Ending UNIX timestamp

# Private

<aside class="notice">
You must replace <code>API_KEY</code>, <code>API_SIGNATURE</code>, and <code>API_EXPIRES</code> with your own values in the header of all private http requests. Refer to the <a href='#authentication'>authentication section</a> above to learn more.
</aside>

## Get User

> Request

```shell
curl -X GET 
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user"
```

> Response

```json
{
  "id": "integer",
  "email": "string",
  "full_name": "string",
  "name_verified": true,
  "gender": true,
  "nationality": "string",
  "dob": "2018-03-23T04:14:08.593Z",
  "phone_number": "string",
  "address": {
    "country": "string",
    "address": "string",
    "postal_code": "string",
    "city": "string",
    "verified": true
  },
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
  "otp_enabled": false,
  "activated": true,
  "note": "",
  "username": "string",
  "affiliation_code": "string",
  "balance": {
    "xht_balance": 0,
    "xht_available": 0,
    "xht_pending": 0,
    "usdt_balance": 0,
    "usdt_available": 0,
    "usdt_pending": 0,
    "updated_at": "2018-03-23T04:14:08.593Z"
  },
  "settings": {
    "language": "en"
  },
  "flagged": false,
  "created_at": "2018-03-23T04:14:08.593Z",
  "updated_at": "2018-03-23T04:14:08.593Z",
  "images": [],
  "fees": {
	  "xht-usdt": {
		  "maker_fee": 0,
		  "taker_fee": 0
	  }
  }
}
```

This endpoint gets user's information, crypto wallet address as well as his balance.

### HTTP Request

`GET https://api.hollaex.com/v2/user`

## Get Balance

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/balance" 
```

> Response

```json
{
  "xht_balance": 0,
  "xht_available": 0,
  "xht_pending": 0,
  "usdt_balance": 0,
  "usdt_available": 0,
  "usdt_pending": 0,
  "updated_at": "2018-03-23T04:14:08.705Z"
}
```

This endpoint gets user's balance

### HTTP Request

`GET https://api.hollaex.com/v2/user/balance`


## Get Deposits

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/deposits
  ?currency=xht&limit=50&page=1&order=asc"
```

> Response

```json
{
  "count": 1,
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

`GET https://api.hollaex.com/v2/user/deposits`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The currency pair symbol (xht-usdt)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data


## Get Withdrawals

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/withdrawals
  ?currency=xht&limit=50&page=1&order=asc"
```

> Response

```json
{
  "count": 1,
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

`GET https://api.hollaex.com/v2/user/withdrawals`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The currency pair symbol (xht-usdt)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data

## Get Withdrawal Fee

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/withdraw/$currency/fee"
```

> Response

```json
{
  "fee": 0.0005
}
```

This endpoint gets the withdrawal fee for a certain currency

### HTTP Request

`GET https://api.hollaex.com/v2/user/withdraw/{currency}/fee`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The desired currency e.g. xht

## Create Withdrawal Request

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"currency":$currency,"amount":$amount,"address":$address}'
  "https://api.hollaex.com/v2/user/request-withdrawal"
```

> Response

```json
{
  "message": "Success"
}
```

This endpoint creates a withdrawal request for the user

### HTTP Request

`POST https://api.hollaex.com/v2/user/request-withdrawal`

### PARAMETERS

Parameter | Description
--------- | -----------
currency | The desired currency e.g. xht
amount | The amount to withdrawal e.g. 5
address | The recipient wallet's address

## Get Trades

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/trades
  ?symbol=xht-usdt&limit=50&page=1"
```

> Response

```json
{
  "count": 1,
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

`GET https://api.hollaex.com/v2/user/trades`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (xht-usdt)
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data



## Get All Orders

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/orders?symbol=$symbol" 
```

> Response

```json
[
  {
    "created_at": "2018-03-23T04:14:08.663Z",
	"title": "string",
	"side": "sell",
	"type": "limit",
	"price": 0,
	"size": 0,
	"symbol": "xht-usdt",
	"id": "string",
	"created_by": 1,
	"filled": 0
  }
]
```

This endpoint gets all active orders placed by the user

### HTTP Request

`GET https://api.hollaex.com/v2/user/orders`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (xht-usdt)

## Get Order

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/orders/$order_id" 
```

> Response

```json

{
    "created_at": "2018-03-23T04:14:08.663Z",
	"title": "string",
	"side": "sell",
	"type": "limit",
	"price": 0,
	"size": 0,
	"symbol": "xht-usdt",
	"id": "string",
	"created_by": 1,
	"filled": 0
}

```

This endpoint gets an order by its id.

### HTTP Request

`GET https://api.hollaex.com/v2/user/orders/{order_id}`

### PARAMETERS

Parameter | Description
--------- | -----------
order_id | Order unique Id

## Create Order

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"symbol":$symbol,"side":$side,"size":$size,"type":$type,"price":$price}'
  "https://api.hollaex.com/v2/order" 
```

> Response

```json
{
    "symbol": "xht-usdt",
    "side": "sell",
    "size": 1,
    "type": "limit",
    "price": 0.1,
    "id": "string",
    "created_by": 34,
    "filled": 0,
    "status": "pending"
}
```

This endpoint places an order for the user

### HTTP Request

`POST https://api.hollaex.com/v2/order`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (xht-usdt)
side | buy or sell order
size | The amount of the order
type | limit or market order type
price | Only should be used when type is limit. In case of market price should not be used


## Cancel All Orders

> Request

```shell
curl -X DELETE
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/orders?symbol=$symbol" 
```

> Response

```json

[
  	{
		"title": "string",
		"symbol": "xht-usdt",
		"side": "sell",
		"size": 1,
		"type": "limit",
		"price": 0.1,
		"id": "string",
		"created_by": 34,
		"filled": 0
	}
]

```

This endpoint cancels all orders placed by the user.

### HTTP Request

`DELETE https://api.hollaex.com/v2/user/orders`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol (xht-usdt)

## Cancel Order

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/orders/$order_id" 
```

> Response

```json

{
    "title": "string",
    "symbol": "xht-usdt",
    "side": "sell",
    "size": 1,
    "type": "limit",
    "price": 0.1,
    "id": "string",
    "created_by": 34,
    "filled": 0
}
```

This endpoint cancels an order by getting its id

### HTTP Request

`DELETE https://api.hollaex.com/v2/user/orders/{order_id}`

### PARAMETERS

Parameter | Description
--------- | -----------
order_id | Specific order unique Id

# TradingView

HollaEx fully supports the TradingView UDF API.

## Config

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/udf/config"
```

> Response

```json
{
    "supported_resolutions": [
        "60",
        "1D"
    ],
    "supports_group_request": false,
    "supports_marks": false,
    "supports_search": true,
    "supports_timescale_marks": false
}
```
This endpoint retrieves the TradingView UDF config.

### HTTP Request

`GET https://api.hollaex.com/v2/udf/config`

## History

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/udf/history?symbol=xht-usdt&resolution=1D&from=1551663947&to=1582768007"
```

> Response

```json
{
    "c": [...],
    "h": [...],
    "l": [...],
    "o": [...],
    "v": [...],
    "s": "ok"
}
```
This endpoint retrieves the TradigView UDF history HOLCV.

### HTTP Request

`GET https://api.hollaex.com/v2/udf/history`

Parameter | Description
--------- | -------
symbol | The currency pair symbol (xht-usdt, etc.)
resolution | Time interval resolution (1D, 60, etc.)
from | Beginning UNIX timestamp
to | Ending UNIX timestamp

## Symbols

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/udf/symbols?symbol=xht-usdt"
```

> Response

```json
{
    "name": "bitHolla",
    "ticker": "xht-usdt",
    "exchange": "HollaEx",
    "has_intraday": true,
    "has_daily": true,
    "has_weekly_and_monthly": true,
    "session": "24x7",
    "regular_session": "24x7",
    "pricescale": 1,
    "volume_precision": 2,
    "has_empty_bars": true
}
```
This endpoint retrieves system a TradingView UDF symbol.

### HTTP Request

`GET https://api.hollaex.com/v2/udf/symbols`

Parameter | Description
--------- | -------
symbol | The currency pair symbol (xht-usdt, etc.)

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
symbol | The currency pair symbol (xht-usdt)

### EVENTS

The public socket.io events you can subscribe to are:

Event | Description
--------- | -----------
orderbook | Object with the symbols(currencies) and its top 10 orderbook. Same data as `GET /orderbook?symbol=xht-usdt`. When the user connects, receives the complete object with the symbols' top 10 orderbooks. Also will receive the same type of object when an update on the orderbook happens.
trades | Object with the last trades of the symbol subscribed. Same data as `GET /trade?symbol=xht-usdt`. When the user connects, will receive the last trades (Max number: 50). Also will receive the same type of object when a trade happens.

## Private

> Connection

```javascript

  const io = require('socket.io-client');

  const socket = io('https://api.hollaex.com/user', {
    query: {
		api-key: `${API_KEY}`,
		api-signature: `${API_SIGNATURE}`,
		api-expires: `${API_EXPIRES}`
	}
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
query | You must provide a HollaEx `api-key`, `api-signature`, and `api-expires`
api-key | Your API key.
api-signature | HMAC-SHA256 signature using API secret. The `METHOD` is `CONNECT` and the `PATH` is `/socket`.
api-expires | UNIX timestamp of when the request expires.

<aside class="notice">
You must replace <code>API_KEY</code>, <code>API_SIGNATURE</code>, and <code>API_EXPIRES</code> with your own values. Refer to the <a href='#authentication'>authentication section</a> above to learn more.
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
		"price": 0.23,
		"size": 2,
		"symbol": "xht-usdt",
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
		"filled": 0.1,
		"created_by": 79,
		"side": "sell",
		"type": "limit",
		"size": 5,
		"price": 0.32,
		"symbol": "xht-usdt"
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
		"price": 0.23,
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
      "symbol": "xht-usdt",
      "size": 5,
      "price": 0.32,
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
		"currency": "usdt",
		"status": false
	},
	"balance": {
		"usdt_balance": 0,
		"xht_balance": 300000,
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
		"currency": "xht",
		"status": true
	},
	"balance": {
		"usdt_balance": 0,
		"xht_balance": 300000,
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