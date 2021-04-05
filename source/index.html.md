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

### PARAMETERS

Parameter | Description
--------- | -------
symbol | Symbol to get
resolution | Time interval resolution (1D, 60, etc.)
from | Beginning UNIX timestamp
to | Ending UNIX timestamp

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
    "id": 1,
    "email": "fight@club.com",
    "full_name": "Tyler Durden",
    "gender": true,
    "nationality": "USA",
    "dob": "2017-07-21T17:32:28.000Z",
    "phone_number": "",
    "address": {
        "city": "Bradford",
        "address": "537 Paper Street",
        "country": "USA",
        "postal_code": "19808"
    },
    "id_data": {
        "type": "passport",
        "number": "999",
        "issued_date": "2017-07-21T17:32:28.000Z",
        "expiration_date": "2017-07-21T17:32:28.000Z"
    },
    "bank_account": [],
    "crypto_wallet": {
        "xht": "string",
        "usdt": "string",
		...
    },
    "verification_level": 2,
    "email_verified": true,
    "otp_enabled": false,
    "activated": true,
    "username": "narrator",
    "affiliation_code": "STRING",
    "settings": {
        "chat": {
            "set_username": true
        },
        "risk": {
            "popup_warning": true,
            "order_portfolio_percentage": 90
        },
        "audio": {
            "all": true,
            "order_placed": true,
            "public_trade": true,
            "click_amounts": true,
            "order_canceled": true,
            "order_completed": true,
            "quick_trade_success": true,
            "quick_trade_timeout": true,
            "get_quote_quick_trade": true,
            "order_partially_completed": true
        },
        "language": "en",
        "interface": {
            "theme": "dark",
            "order_book_levels": 20
        },
        "notification": {
            "popup_order_completed": false,
            "popup_order_confirmation": false,
            "popup_order_partially_filled": false
        }
    },
    "affiliation_rate": 0,
    "network_id": 90,
    "created_at": "2020-10-06T11:01:46.715Z",
    "updated_at": "2021-02-16T07:48:03.108Z",
    "balance": {
        "usdt_balance": 0,
        "usdt_available": 0,
        "xht_balance": 0,
        "xht_available": 0,
		...,
        "updated_at": "2021-02-16T05:48:28.014Z"
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
	"usdt_balance": 0,
	"usdt_available": 0,
	...
	"updated_at": "2018-03-23T04:14:08.705Z"
}
```

This endpoint gets a user's balance.

### HTTP Request

`GET https://api.hollaex.com/v2/user/balance`


## Get Deposits

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/deposits"
```

> Response

```json
{
	"count": 1,
	"data": [
		{
            "id": 229,
            "amount": 1,
            "fee": 0,
            "address": "string",
            "transaction_id": "string",
            "status": true,
            "dismissed": false,
            "rejected": false,
            "processing": false,
            "waiting": false,
            "description": "",
            "type": "deposit",
            "currency": "usdt",
            "created_at": "2021-02-16T05:48:28.011Z",
            "updated_at": "2021-02-16T05:48:28.011Z",
            "user_id": 90
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
currency | The currency pair symbol
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data
format | Pass value csv to download csv file

## Get Withdrawals

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/withdrawals"
```

> Response

```json
{
	"count": 1,
	"data": [
		{
            "id": 224,
            "amount": 1,
            "fee": 0,
            "address": "string",
            "transaction_id": "string",
            "status": true,
            "dismissed": false,
            "rejected": false,
            "processing": false,
            "waiting": false,
            "description": "",
            "type": "withdrawal",
            "currency": "usdt",
            "created_at": "2021-02-15T02:36:47.167Z",
            "updated_at": "2021-02-15T02:36:47.167Z",
            "user_id": 90
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
format | Pass value csv to download csv file

## Get Withdrawal Fee

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/user/withdrawal/fee?symbol=$symbol"
```

> Response

```json
{
	"fee": 0.001
}
```

This endpoint gets the withdrawal fee for a certain currency

### HTTP Request

`GET https://api.hollaex.com/v2/user/withdrawal/fee`

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
  "https://api.hollaex.com/v2/user/trades"
```

> Response

```json
{
	"count": 1,
	"data": [
		{
            "side": "sell",
            "symbol": "xht-usdt",
            "size": 0.1,
            "price": 0.15,
            "timestamp": "2021-02-15T07:34:34.203Z",
            "order_id": "string",
            "fee": 0.2,
            "fee_coin": "usdt"
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
symbol | The currency pair symbol
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data
format | Pass value csv to download csv file

## Get All Orders

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/orders"
```

> Response

```json
{
    "count": 1,
    "data": [
        {
            "id": "string",
            "side": "sell",
            "symbol": "xht-usdt",
            "size": 0.1,
            "filled": 0,
            "stop": null,
            "fee": 0,
            "fee_coin": "usdt",
            "type": "limit",
            "price": 1.09,
            "status": "new",
            "created_by": 116,
            "created_at": "2021-02-17T02:32:38.910Z",
            "updated_at": "2021-02-17T02:32:38.910Z",
            "User": {
                "id": 116,
                "email": "fight@club.com",
                "username": "narrator",
                "exchange_id": 176
            }
        }
	]
}
```

This endpoint gets all active orders placed by the user

### HTTP Request

`GET https://api.hollaex.com/v2/orders`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol
side | Side of orders to query (buy, sell)
status | Status of order (filled, pfilled, canceled, new)
open | Open status of order
limit | Number of elements to return. Default: 50. Maximun: 100
page | Page of data to retrieve
order_by | Field to order data
order | asc or desc
start_date | Starting date of queried data
end_date | Ending date of queried data

## Get Order

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/order?$order_id"
```

> Response

```json
{
	"id": "string",
	"side": "sell",
	"symbol": "xht-usdt",
	"size": 0.1,
	"filled": 0,
	"stop": null,
	"fee": 0,
	"fee_coin": "usdt",
	"type": "limit",
	"price": 1.09,
	"status": "new",
	"created_by": 116,
	"created_at": "2021-02-17T02:32:38.910Z",
	"updated_at": "2021-02-17T02:32:38.910Z",
	"User": {
		"id": 116,
		"email": "fight@club.com",
		"username": "narrator",
		"exchange_id": 176
	}
}
```

This endpoint gets an order by its id.

### HTTP Request

`GET https://api.hollaex.com/v2/order?order_id`

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
    "fee": 0,
    "meta": {},
    "symbol": "xht-usdt",
    "side": "sell",
    "size": 0.1,
    "type": "limit",
    "price": 1,
    "fee_structure": {
        "maker": 0.2,
        "taker": 0.2
    },
    "fee_coin": "usdt",
    "id": "string",
    "created_by": 116,
    "filled": 0,
    "status": "new",
    "updated_at": "2021-02-17T03:03:19.231Z",
    "created_at": "2021-02-17T03:03:19.231Z",
    "stop": null
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
stop | Stop price of order
meta | Object with other options such as post_only


## Cancel All Orders

> Request

```shell
curl -X DELETE
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/order/all"
```

> Response

```json
[
    {
        "created_by": 116,
        "side": "sell",
        "type": "limit",
        "size": 0.1,
        "price": 1,
        "created_at": "2021-02-17T03:04:59.607Z",
        "updated_at": "2021-02-17T03:05:02.945Z",
        "symbol": "xht-usdt",
        "filled": 0,
        "stop": null,
        "status": "canceled",
        "fee": 0,
        "fee_coin": "usdt",
        "meta": {},
        "id": "string",
        "fee_structure": {
            "maker": 0.2,
            "taker": 0.2
        }
    },
    ...
]
```

This endpoint cancels all orders placed by the user.

### HTTP Request

`DELETE https://api.hollaex.com/v2/order/all`

### PARAMETERS

Parameter | Description
--------- | -----------
symbol | The currency pair symbol

## Cancel Order

> Request

```shell
curl -X GET
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/order?order_id=$order_id"
```

> Response

```json
{
    "created_by": 116,
    "side": "buy",
    "type": "limit",
    "size": 2,
    "price": 1,
    "created_at": "2021-02-17T03:07:36.244Z",
    "updated_at": "2021-02-17T03:07:52.683Z",
    "symbol": "xht-usdt",
    "filled": 0,
    "stop": null,
    "status": "canceled",
    "fee": 0,
    "fee_coin": "xht",
    "meta": {},
    "id": "string",
    "fee_structure": {
        "maker": 0.2,
        "taker": 0.2
    }
}
```

This endpoint cancels an order by getting its id

### HTTP Request

`DELETE https://api.hollaex.com/v2/order`

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

Connection to public and private channels are available through the path `https://api.hollaex.com/stream`. HollaEx Exchanges can be connected to using any websocket libraries. For this documentation, we will use the library [`ws`]('https://github.com/websockets/ws').

## Connecting

> Connection

```javascript

	const WebSocket = require('ws');

	// Public
	const client = new WebSocket('https://api.hollaex.com/stream');

	// Private Bearer
	const client = new WebSocket(`https://api.hollaex.com/stream?authorization=Bearer%20${TOKEN}`);

	// Private HMAC
	const client = new WebSocket(`https://api.hollaex.com/stream?api-key=${API-KEY}&api-signature=${API-SIGNATURE}&api-expires=${API-EXPIRES}`);

	client.on('open', () => {
		// Ping message to keep connection alive
		setInterval(() => {
			client.send(
				JSON.stringify({
					op: 'ping'
				})
			)
		})
	}, 30000);

```

Connection for public events does not require authentication while private events do. Users can use Bearer or HMAC authentication.
For HMAC, the method is `CONNECT` and the path is `/stream`. Refer to the [Authentication]('#Authentication') section for more information on HMAC-SHA256.

Websocket connections will disconnect if a message is not sent within one minute. To keep a connection alive, you can sent a `ping` message every ~30 seconds.

### PATH

`https://api.hollaex.com/stream`

### PARAMETERS

Parameter | Description
--------- | -----------
authorization (*Bearer*) | A bearer token required to subscribe to private events.
api-key (*HMAC*) | Your exchange api-key
api-signature (*HMAC*) | An api-signature created using HMAC SHA256
api-expires (*HMAC*) | Expiry time of request

## Sending/Receiving Messages

> Connection

```javascript

	client.send(
		JSON.stringify({
			op: OPERATION,
			args: [EVENTS]
		})
	);

	client.on('message', (data) => {
		data = JSON.parse(data);
		console.log(data);
	})

```

### Operations

Operation | Description
--------- | -----------
subscribe | Subscribe to events.
unsubscribe | Unsubscribe to events.
ping | Ping-pong message for keeping connections alive.

### Events

Events | Description
--------- | -----------
orderbook | Public event for orderbook updates.
trades | Public event for trade updates.
order | Private event for user order updates.
wallet | Private even for wallet balance updates.

## Public Events

> Connection

```javascript

	client.on('open', () => {

		// Subscribe
		client.send(
			JSON.stringify({
				op: 'subscribe',
				args: ['orderbook', 'trades']
			})
		);

		// On message
		client.on('message', (data) => {
			console.log(JSON.parse(data));
		});

		// Unsubscribe
		client.send(
			JSON.stringify({
				op: 'unsubscribe',
				args: ['orderbook', 'trades']
			})
		);
	})

```

### EVENTS

The public events you can subscribe to are:

Event | Description
--------- | -----------
orderbook | Notification with orderbook symbol and data update. To subscribe to a specific pair, you can pass the pair after a colon. Ex: `orderbook:xht-usdt`.
trades | Notification with trade data. To subscribe to a specific pair, you can pass the pair after a colon. Ex: `trades:xht-usdt`.

## Public Updates

> orderbook

```json

{
	"topic": "orderbook",
	"action": "partial",
	"symbol": "xht-usdt",
	"data": {
		"bids": [
			[0.1, 0.1],
			...
		],
		"asks": [
			[1, 1],
			...
		],
		"timestamp": "2020-12-15T06:45:27.766Z"
	},
	"time": 1608015328
}

```

> trades

```json

{
	"topic": "trade",
	"action": "partial",
	"symbol": "xht-usdt",
	"data": [
		{
			"size": 0.012,
			"price": 300,
			"side": "buy",
			"timestamp": "2020-12-15T07:25:28.887Z"
		},
		...
	],
	"time": 1608015328
}

```

## Private Events

> Connection

```javascript

	client.on('open', () => {

		// Subscribe
		client.send(
			JSON.stringify({
				op: 'subscribe',
				args: ['order', 'wallet']
			})
		);

		// On message
		client.on('message', (data) => {
			console.log(JSON.parse(data));
		});

		// Unsubscribe
		client.send(
			JSON.stringify({
				op: 'unsubscribe',
				args: ['order', 'wallet']
			})
		);
	})

```

### EVENTS

The private events you can subscribe to are:

Event | Description
--------- | -----------
order | Notifications for newly created orders and order updates.
wallet | Notifications for balance updates.

## Private Updates

> order

```json

{
	"topic": "order",
	"action": "partial",
	"user_id": 1,
	"data": [
		{
			"id": "7d3d9545-b7e6-4e7f-84a0-a39efa4cb173",
			"side": "buy",
			"symbol": "xht-usdt",
			"type": "limit",
			"size": 0.1,
			"filled": 0,
			"price": 1,
			"stop": null,
			"status": "new",
			"fee": 0,
			"fee_coin": "xht",
			"meta": {},
			"fee_structure": {
				"maker": 0.1,
				"taker": 0.1
			},
			"created_at": "2020-11-30T07:45:43.819Z",
			"created_by": 1
		},
		...
	],
	"time": 1608022610
}

{
	"topic": "order",
	"action": "insert",
	"user_id": 1,
	"symbol": "xht-usdt",
	"data": [
		{
			"id": "7d3d9545-b7e6-4e7f-84a0-a39efa4cb173",
			"side": "buy",
			"symbol": "xht-usdt",
			"type": "limit",
			"size": 0.1,
			"filled": 0,
			"price": 1,
			"stop": null,
			"status": "new",
			"fee": 0,
			"fee_coin": "xht",
			"meta": {},
			"fee_structure": {
				"maker": 0.1,
				"taker": 0.1
			},
			"created_at": "2020-11-30T07:45:43.819Z",
			"updated_at": "2020-12-15T08:56:45.066Z",
			"created_by": 1
		},
		...
	],
	"time": 1608022610
}

{
	"topic": "order",
	"action": "insert",
	"user_id": 1,
	"symbol": "xht-usdt",
	"data": [
		{
			"id": "7d3d9545-b7e6-4e7f-84a0-a39efa4cb173",
			"side": "buy",
			"symbol": "xht-usdt",
			"type": "limit",
			"size": 0.1,
			"filled": 0,
			"price": 1,
			"stop": null,
			"status": "new",
			"fee": 0,
			"fee_coin": "xht",
			"meta": {},
			"fee_structure": {
				"maker": 0.1,
				"taker": 0.1
			},
			"created_at": "2020-11-30T07:45:43.819Z",
			"updated_at": "2020-12-15T08:56:45.066Z",
			"created_by": 1
		},
		...
	],
	"time": 1608022610
}

```

### Order status and action

The `status` of the order can be `new`, `pfilled`, `filled`, and `canceled`.

The `action` of the data determines what caused it to happen. All three are explained below:

Action | Description
--------- | -----------
partial | All previous and current orders. Is the first order data received when connecting. Max: 50. Descending order.
insert | When user's order is added. The status of the order can be either new, pfilled, or filled.
update | When user's order status is updated. Status can be pfilled, filled, and canceled.

> wallet

```json

{
	"topic": "wallet",
	"action": "partial",
	"user_id": 1,
	"data": {
		"usdt_balance": 1,
		"usdt_available": 1,
		"xht_balance": 1,
		"xht_available": 1,
		"xmr_balance": 1,
		"xmr_available": 1,
		"btc_balance": 1,
		"btc_available": 1,
		"eth_balance": 1,
		"eth_available": 1,
		...,
		"updated_at": "2020-12-15T08:41:24.048Z"
	},
	"time": 1608021684
}

```