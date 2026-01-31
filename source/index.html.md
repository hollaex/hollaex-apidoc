---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='https://pro.hollaex.com/security?apiKeys'>Sign Up for a Developer Key</a>

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
- `DELETE` request to `https://api.hollaex.com/v2/order?order_id=23a75975-3ad9-448c-8f3e-836c1f61f248` that expires at `1697543568`
  - `DELETE/v2/order?order_id=23a75975-3ad9-448c-8f3e-836c1f61f248`

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

- [HollaEx Node Library](https://github.com/hollaex/hollaex-node-lib) - Our official library that supports Node.js. Connects to both our API and websocket.
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
    "version": "2.1.0",
    "host": "https://api.hollaex.com",
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
        "xht": {
            "id": 1,
            "fullname": "HollaEx Token",
            "symbol": "xht",
            "active": true,
            "verified": true,
            "allow_deposit": true,
            "allow_withdrawal": true,
            "withdrawal_fee": 20,
            "min": 1,
            "max": 1000000,
            "increment_unit": 1,
            "created_at": "2019-08-09T10:45:43.367Z",
            "updated_at": "2019-10-31T05:08:18.907Z",
            "logo": "",
            "code": "xht",
            "is_public": true,
            "meta": {},
            "estimated_price": null,
            "description": null,
            "type": "blockchain",
            "network": "eth",
            "standard": "erc-20",
            "issuer": "HollaEx",
            "withdrawal_fees": {
                "eth": 20,
                "trx": 1
            },
            "created_by": 1
        },
        "usdt": {
            "id": 6,
            "fullname": "USD Tether",
            "symbol": "usdt",
            "active": true,
            "verified": true,
            "allow_deposit": true,
            "allow_withdrawal": true,
            "withdrawal_fee": 20,
            "min": 0.1,
            "max": 10000000,
            "increment_unit": 0.1,
            "created_at": "2019-08-09T10:45:43.367Z",
            "updated_at": "2021-04-20T03:02:48.635Z",
            "logo": "",
            "code": "usdt",
            "is_public": true,
            "meta": {},
            "estimated_price": 1,
            "description": null,
            "type": "blockchain",
            "network": "eth,trx",
            "standard": "erc-20",
            "issuer": "HollaEx",
            "withdrawal_fees": null,
            "created_by": 1
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
            "max_size": 10000000,
            "min_price": 0.01,
            "max_price": 10000,
            "increment_size": 0.1,
            "increment_price": 0.0001,
            "active": true,
            "verified": true,
            "code": "xht-usdt",
            "is_public": true,
            "estimated_price": 0.1,
            "created_at": "2019-08-09T10:45:43.353Z",
            "updated_at": "2019-08-09T10:45:43.353Z",
            "created_by": 1
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
    "user_meta": {...},
    "logo_image": "",
    "description": "HollaEx is a crypto exchange whitelabel",
    "injected_html": {...},
    "injected_values": [...],
    "native_currency": "usdt",
    "setup_completed": true,
    "valid_languages": "en,ko,ar,pt,ja,ru,fr",
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
        "type": "Cloud",
        "plan": "crypto",
        "period": "year",
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
    "volume": 18653.3,
    "timestamp": "2021-04-28T03:05:24.996Z"
}
```

This endpoint retrieves ticker information for a pair.

### HTTP Request

`GET https://api.hollaex.com/v2/ticker?symbol=${symbol}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol (xht-usdt)

## Tickers

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/tickers"
```

> Response

```json
{
    "xht-usdt": {
        "time": "2021-04-27T03:05:41.012Z",
        "open": 0.54,
        "close": 0.54,
        "high": 0.54,
        "low": 0.54,
        "last": 0.54,
        "volume": 18653.3,
        "symbol": "xht-usdt"
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

`GET https://api.hollaex.com/v2/orderbook?symbol=${symbol}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol (xht-usdt, etc.)

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
    ],
    ...
}
```

This endpoint retrieves the last 30 trades.

### HTTP Request

`GET https://api.hollaex.com/v2/trades`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Optional | The currency pair symbol (xht-usdt, etc.)

## Chart

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/chart?symbol=xht-usdt&resolution=1D&from=1616987453&to=1619579513"
```

> Response

```json
[
	{
        "time": "2021-04-14T00:00:00.000Z",
        "close": 0.25,
        "high": 0.21,
        "low": 0.25,
        "open": 0.21,
        "symbol": "xht-usdt",
        "volume": 204.2
    },
    {
        "time": "2021-04-19T00:00:00.000Z",
        "close": 0.25,
        "high": 0.25,
        "low": 0.25,
        "open": 0.25,
        "symbol": "xht-usdt",
        "volume": 437.8
    },
	...
]
```

This endpoint retrieves a trading pair's trade history HOLCV.

### HTTP Request

`GET https://api.hollaex.com/v2/chart?symbol=${symbol}&resolution=${resolution}&from=${from}&to=${to}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | Symbol to get
resolution | string | Required | Time interval resolution (15, 60, 240, 1D, 1W)
from | string | Required | Beginning UNIX timestamp
to | string | Required | Ending UNIX timestamp

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

`GET https://api.hollaex.com/v2/charts?resolution=${resolution}&from=${from}&to=${to}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
resolution | string | Required | Time interval resolution (15, 60, 240, 1D, 1W)
from | string | Required | Beginning UNIX timestamp
to | string | Required | Ending UNIX timestamp



## MiniCharts

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/minicharts?assets=btc,xht&quote=xht"
```

> Response

```json
{
    "btc": [
        {
            "time": "2023-09-12T11:59:00.548Z",
            "price": "25000.00",
            "symbol": "btc",
            "quote": "usdt"
        },
      ...
    ],
    "xht": [
        {
            "time": "2023-09-12T11:59:00.548Z",
            "price": "0.18",
            "symbol": "xht",
            "quote": "usdt"
        },
       ...
    ]
}
```
Get trade history HOLCV for all pairs

### HTTP Request

`GET https://api.hollaex.com/v2/minicharts`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
assets | array | Required | The list of assets to get the mini charts for
from | string | Optional | Beginning UNIX timestamp
to | string | Optional | Ending UNIX timestamp
quote | string | Optional | Quote asset to receive prices based on


## Oracle Prices

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/oracle/prices?&assets=xht&quote=usdt&amount=1"
```

> Response

```json
{ "xht": 0.19 }
```
Retrieve price conversion

### HTTP Request

`GET https://api.hollaex.com/v2/oracle/prices`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
assets | array | Required | Assets to convert in array
quote | string | Optional | Quote coin to convert to
amount | number | Optional |  Amount to convert


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
    "bank_account": [...],
    "crypto_wallet": {},
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
    },
    "wallet": [
        {
            "currency": "xht",
            "address": "0xb9b424250b1d5025f69d5c099b7a90f0a0a9c275",
            "network": "eth",
            "standard": null,
            "is_valid": true,
            "created_at": "2021-04-07T07:23:33.212Z"
        },
        {
            "currency": "usdt",
            "address": "0xb9b424250b1d5025f69d5c099b7a90f0a0a9c275",
            "network": "eth",
            "standard": null,
            "is_valid": true,
            "created_at": "2021-04-22T13:46:54.014Z"
        },
        ...
    ]
}
```

This endpoint gets user's information, wallet address as well as his balance.

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
            "network": "eth",
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

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
currency | string | Optional | The currency pair symbol
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
transaction_id | string | Optional | Get deposits with this transaction ID
address | string | Optional | Get deposits made to this address
status | boolean | Optional | Completed status of deposits to get
dismissed | boolean | Optional | Dismissed status of deposits to get
rejected | boolean | Optional | Rejected status of deposits to get
processing | boolean | Optional | Processing status of deposits to get
waiting | boolean | Optional | Waiting status of deposits to get
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data in ISO 8601 format
format | string | Optional | Pass value csv to download csv file

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
            "network": "eth",
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

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
currency | string | Optional | The currency pair symbol (xht-usdt)
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
transaction_id | string | Optional | Get withdrawals with this transaction ID
address | string | Optional | Get withdrawals made to this address
status | boolean | Optional | Completed status of withdrawals to get
dismissed | boolean | Optional | Dismissed status of withdrawals to get
rejected | boolean | Optional | Rejected status of withdrawals to get
processing | boolean | Optional | Processing status of withdrawals to get
waiting | boolean | Optional | Waiting status of withdrawals to get
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data i ISO 8601 format
format | string | Optional | Pass value csv to download csv file

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

`GET https://api.hollaex.com/v2/user/withdrawal/fee?currency=${currency}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
currency | string | Required | The desired currency e.g. xht

## Withdrawal

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"currency":$currency,"amount":$amount,"address":$address}'
  "https://api.hollaex.com/v2/user/withdrawal"
```

> Response

```json
{
    "message": "Withdrawal request is in the queue and will be processed.",
    "id": 1000,
    "transaction_id": "d696dd5d-3226-4662-8d86-3da3d8eb68ff",
    "amount": 1,
    "currency": "xht",
    "fee": 20,
    "fee_coin": "xht"
}
```

This endpoint directly creates a withdrawal for the user, only available via
HMAC tokens with the withdrawal permission.

### HTTP Request

`POST https://api.hollaex.com/v2/user/withdrawal`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
currency | string | Required | The desired currency e.g. xht
amount | number | Required | The amount to withdrawal e.g. 5
address | string | Required | The recipient wallet's address
network | string | Optional | Network of currency being withdrawn if there are multiple networks for currency

## Transfer Between Accounts

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"subaccount_id":$subaccount_id,"currency":$currency,"amount":$amount,"direction":$direction}'
  "https://api.hollaex.com/v2/subaccount/transfer"
```

> Response

```json
{
   "message": "Success"
}
```

Transfer an asset to or from a subaccount. Only master users can initiate, and the subaccount must belong to the master. This endpoint is only available via HMAC tokens with the withdrawal permission.

### HTTP Request

`POST https://api.hollaex.com/v2/subaccount/transfer`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
subaccount_id | number | Required | The user id of the subaccount
currency | string | Required | The currency to transfer
amount | number | Required | The amount to transfer
direction | string | Required | Transfer direction. Enum: ['to_sub', 'to_master']

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

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Optional | The currency pair symbol
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data in ISO 8601 format
format | string | Optional | Pass value csv to download csv file

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

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Optional | The currency pair symbol
side | string | Optional | Side of orders to query (buy, sell)
open | boolean | Optional | Open status of order
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data in ISO 8601 format

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
	"updated_at": "2021-02-17T02:32:38.910Z"
}
```

This endpoint gets an order by its id.

### HTTP Request

`GET https://api.hollaex.com/v2/order?order_id=${order_id}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
order_id | string | Required | Order unique Id

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

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol (xht-usdt)
side | string | Required | buy or sell order
size | number | Required | The amount of the order
type | string | Required | limit or market order type
price | number | Required if limit order | Only should be used when type is limit
stop | number | Optional | Stop price of order
meta | object | Optional | Object with other options
meta.post_only | boolean | Optional | Set to true if order should only be made if market maker
meta.note | string | Optional | Additional note to add to order data


## Cancel All Orders

> Request

```shell
curl -X DELETE
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  "https://api.hollaex.com/v2/order/all?symbol=xht-usdt"
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

This endpoint cancels all orders of the same currency pair symbol, placed by the user.

### HTTP Request

`DELETE https://api.hollaex.com/v2/order/all`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol

## Cancel Order

> Request

```shell
curl -X DELETE
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

`DELETE https://api.hollaex.com/v2/order?order_id=${order_id}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
order_id | string | Required | Specific order unique Id

## Convert Quote

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/quick-trade?&spending_currency=btc&receiving_currency=usdt&spending_amount=0.0001"
```

> Response

```json
{
  "spending_currency": "btc",
  "receiving_currency": "usdt",
  "spending_amount": 0.0001,
  "type": "market",
  "receiving_amount": 3.45,
  "token": "wTqpH3aXjfPTnZbK4P94vUbwg7HGk05i",
  "expiry": "2023-11-09T20:47:21.323Z"
}
```
Get a quote for a conversion between two assets that can be used in quick trade (convert) page

### HTTP Request

`GET https://api.hollaex.com/v2/quick-trade`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
spending_currency | string | Required | Currency symbol of the spending currency
receiving_currency | string | Required | Currency symbol of the receiving currency
spending_amount | string | Optional | Spending amount
receiving_amount | string | Optional | Receiving amount


## Convert Execute

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"token":$token}'
  "https://api.hollaex.com/v2/order/execute"
```

> Response

```json
{
  "symbol": "btc-usdt",
  "side": "sell",
  "size": 0.0001,
  "type": "market",
  "price": 0,
  "fee_structure": { "maker": 0.2, "taker": 0.2 },
  "fee_coin": "usdt",
  "id": "6a70663f-8948-4d08-b1b7-6c81a7b13c16",
  "created_by": 10792,
  "filled": 0.0001,
  "method": "market",
  "created_at": "2023-11-09T21:09:36.060Z",
  "updated_at": "2023-11-09T21:09:36.060Z",
  "average": 34500,
  "status": "filled"
}
```

This endpoint executes a quote received from the previous endpoint before the quote is expired.

### HTTP Request

`POST https://api.hollaex.com/v2/order/execute`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
token | string | Required | token


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

`GET https://api.hollaex.com/v2/udf/history?symbol=${symbol}&resolution=${resolution}&from=${from}&to=${to}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol (xht-usdt, etc.)
resolution | string | Required | Time interval resolution (1D, 60, etc.)
from | string | Required | Beginning UNIX timestamp
to | string | Required | Ending UNIX timestamp

## Symbols

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/udf/symbols?symbol=xht-usdt"
```

> Response

```json
{
    "name": "HollaEx",
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

`GET https://api.hollaex.com/v2/udf/symbols?symbol=${symbol}`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
symbol | string | Required | The currency pair symbol (xht-usdt, etc.)


# Admin API

Endpoints only accessible to Admins of Hollaex Kit


## Exchange Info

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/exchange"
```

> Response

```json
{
   "id": 781,
    "name": "testexchange429",
    "expiry": "2022-03-30T13:19:06.283Z",
    "url": "localhost",
    "active": true,
    "is_trial": false,
    "created_at": "2022-03-28T13:19:06.284Z",
    "coins": [
        "btc",
        "usdt",
        "eth",
        "xht"
    ],
    "pairs": [
        "btc-usdt",
        "eth-usdt",
        "xht-usdt"
        "eth-btc"
    ],
    "plan": null,
    "period": null
}
```
Get general exchange information such as coins & pairs
### HTTP Request

`GET https://api.hollaex.com/v2/admin/exchange`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by


## Create User

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/user"
```

> Response

```json
{
   "message": "Success"
}
```
Create a new user on the exchange

### HTTP Request

`POST https://api.hollaex.com/v2/admin/user`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
email | string | Required | The mail address for the user
password | string | Required | The password for the user
referral | string | Optional | The referral code for the user


## Exchange Users List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/users"
```

> Response

```json
{
   "count": 1,
    "data": [
        {
            "id": 346,
            "email": "23423f4@gmail.com",
            "full_name": "",
            "gender": false,
            "nationality": "",
            "dob": null,
            "phone_number": "",
            "address": {
                "city": "",
                "address": "",
                "country": "",
                "postal_code": ""
            },
            "id_data": {
                "note": "",
                "type": "",
                "number": "",
                "status": 0,
                "issued_date": "",
                "expiration_date": ""
            },
            "bank_account": [],
            "crypto_wallet": {},
            "verification_level": 1,
            "email_verified": true,
            "otp_enabled": false,
            "activated": true,
            "note": "",
            "username": "23423f4",
            "affiliation_code": "1RSWRK",
            "settings": {
                "chat": {
                    "set_username": false
                },
                "risk": {
                    "order_portfolio_percentage": 90
                },
                "audio": {
                    "public_trade": false,
                    "order_completed": true,
                    "order_partially_completed": true
                },
                "language": "en",
                "interface": {
                    "theme": "dark",
                    "order_book_levels": 10
                },
                "notification": {
                    "popup_order_completed": true,
                    "popup_order_confirmation": true,
                    "popup_order_partially_filled": true
                }
            },
            "flagged": false,
            "affiliation_rate": 0,
            "network_id": 11262,
            "discount": 0,
            "meta": {},
            "created_at": "2023-04-10T20:44:34.717Z",
            "updated_at": "2023-04-10T20:44:35.799Z"
        },
    ]
}
```
Retrieve a list of users by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/users`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
id | number | Optional | The identifier of the user to filter by
user_id | number | Optional | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
page | number | Optional | Page of referral data. Default: 1
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.
search | string | Optional | The search text to filter by, pass undefined to receive data on all fields
pending | boolean | Optional | The pending field to filter by, pass undefined to receive all data
pending_type | string | Optional | The pending type info to filter by, pass undefined to receive data
format | string | Optional | Custom format of data set. Enum: ['all', 'csv']



## User Referrer

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/user/referer"
```

> Response

```json
{
    "email": {
        "created_at": "2020-01-18T18:35:02.418Z",
        "updated_at": "2020-01-18T18:35:02.418Z",
        "referer": {
            "id": 1,
            "email": "test@mail.com"
        }
    }
}
```
Retrieve a user's referer info by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/user/referer`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by


## User Referrals

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/user/affiliation"
```

> Response

```json
{
    "count": 1,
    "data": [
        {
            "referrer_id": 1,
            "user": {
                "id": 10,
                "email": "test@mail.com"
            }
        },
    ]
}
```
Retrieve a user's referrals list by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/user/affiliation`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
page | number | Optional | Page of referral data. Default: 1
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.


## Activate User

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/user/activate"
```

> Response

```json
{
   "message": "Success"
}
```
Activate a frozen user account by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/user/activate`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
activated | boolean | Requred | The option to activate or deactivate


## Deactive OTP

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/deactivate-otp"
```

> Response

```json
{
    "message": "Success"
}
```
Deactivate user's otp by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/deactivate-otp`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by


## User Logins List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/logins"
```

> Response

```json
{
    "count": 1,
    "data": [
        {
            "ip": "172.19.0.1",
            "device": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36",
            "domain": "http://localhost:3000",
            "timestamp": "2023-04-16T11:24:22.197Z",
            "user_id": 1,
            "UserId": 1
        },
    ]
}
```
Retrieve user's login info by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/logins`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
page | number | Optional | Page of referral data. Default: 1
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.


## Create User Bank

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/user/bank"
```

> Response

```json
{
   "message": "Success"
}
```
Create a bank or payment account for a user by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/user/bank`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
bank_account | object | Required |  Array of objects with bank account info


## User Balance

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/user/balance"
```

> Response

```json
{
    "user_id": 1,
    "btc_balance": 0.4972535,
    "btc_available": 0.4972535,
    "usdt_balance": 38860.29955,
    "usdt_available": 38857.29955,
    "eth_balance": 0,
    "eth_available": 0,
    "xht_balance": 877.046264
}
```
Retrieve a user's balance by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/user/balance`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by

## Users Balances

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/balances"
```

> Response

```json
{
   "count": 356,
   "data": [
    {
      "balance": "2.0010000000000000",
      "available": "2.0010000000000000",
      "symbol": "xht",
      "updated_at": "2022-02-17T08:27:10.637Z",
      "user_id": 150,
      "network_id": 582
    },
    {
      "balance": "2.0110000000000000",
      "available": "2.0110000000000000",
      "symbol": "xht",
      "updated_at": "2022-02-17T09:07:46.303Z",
      "user_id": 33,
      "network_id": 324
    },
    {
      "balance": "49108.1478000000000000",
      "available": "49108.1478000000000000",
      "symbol": "xht",
      "updated_at": "2023-02-21T18:37:58.966Z",
      "user_id": 8,
      "network_id": 138
    },
    {
      "balance": "2.1000000000000000",
      "available": "2.1000000000000000",
      "symbol": "xht",
      "updated_at": "2023-05-22T12:07:39.124Z",
      "user_id": 11,
      "network_id": 188
    },
    {
      "balance": "5.0000000000000000",
      "available": "5.0000000000000000",
      "symbol": "xht",
      "updated_at": "2023-07-03T14:22:28.277Z",
      "user_id": 1664,
      "network_id": 12392
    },
    {
      "balance": "1.0000000000000000",
      "available": "1.0000000000000000",
      "symbol": "xht",
      "updated_at": "2022-02-17T08:25:37.498Z",
      "user_id": 136,
      "network_id": 568
    },

    ...
   ]
}
```
Retrieve a list of balances from multiple users by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/balances`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user
currency | string | Optional | The currency pair symbol (xht-usdt, etc.)
format | string | Optional | Pass value 'all' to download csv file


## Exchange Total Balance

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/balance"
```

> Response

```json
{
    "btc_balance": 0.50727102,
    "btc_available": 0.50727102,
    "usdt_balance": 40030.93636929621,
    "usdt_available": 40026.73636929621,
    "eth_balance": 0.0001996,
    "eth_available": 0.0001996,
    "xht_balance": 1166.2836345,
    "xht_available": 1166.2836345,
    "try_balance": 0,
    "try_available": 0
}
```
Retrieve the total balance of all users on the exchange

### HTTP Request

`GET https://api.hollaex.com/v2/admin/balance`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------


## Create User Wallet

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/user/wallet"
```

> Response

```json
{
   "message": "Success"
}
```
Create a wallet for a user on the exchange

### HTTP Request

`POST https://api.hollaex.com/v2/admin/user/wallet`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
crypto | number | Required | The coin for the wallet e.g btc, eth
network | number | Optional | The network info


## Wallets List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/user/wallet"
```

> Response

```json
{
    "count": 1,
    "data": [
        {
            "currency": "btc",
            "address": "31j36fxNCt51mtMd15DMF9UyEb5YmGx3bZ",
            "network": "btc",
            "standard": null,
            "is_valid": true,
            "created_at": "2023-03-31T01:08:40.987Z",
            "updated_at": "2023-03-31T01:08:40.987Z",
            "User": {
                "email": "testmail12@gmail.com",
                "exchange_id": 781
            },
            "network_id": 10509
        },
    ]
}
```
Retrieve users' wallets information by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/user/wallet`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
page | number | Optional | Page of referral data. Default: 1
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.
address | string | Optional | Address of crypto
is_valid | boolean | Optional | Specify whether or not wallet is valid
network | string | Optional | Crypto network of currency
format | string | Optional | Custom format of data set. Enum: ['all', 'csv']


## Update User role

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/user/role"
```

> Response

```json
{
   "message": "Success"
}
```
Update exchange user role

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/user/role`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
role | string | Required |The role of the user

## Update User meta

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/user/meta"
```

> Response

```json
{
   "message": "Success"
}
```
Update exchange user meta

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/user/meta`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
meta | object | Required |The meta object of the user
overwrite | boolean | Optional | The overwrite field


## Update User discount

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/user/discount"
```

> Response

```json
{
   "message": "Success"
}
```
Update exchange user discount fee reduction

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/user/discount`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
discount | number | Required |The discount number of the user


## Update User note

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/user/note"
```

> Response

```json
{
   "message": "Success"
}
```
Update exchange user note which is used to store additional information about the user

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/user/note`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
note | string | Required |The note text of the user


## Update User tier

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/upgrade-user"
```

> Response

```json
{
   "message": "Success"
}
```
Update exchange user tier (verification level)

### HTTP Request

`POST https://api.hollaex.com/v2/admin/upgrade-user`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
verification_level | number | Required |The verification_level of the user

## Delete User

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/user"
```

> Response

```json
{
   "message": "Success"
}
```
Create exchange user

### HTTP Request

`DELETE https://api.hollaex.com/v2/admin/user`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The id for the user


## Create User Order

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/order"
```

> Response

```json
{
  "fee": 0,
  "meta": {},
  "symbol": "xht-usdt",
  "side": "buy",
  "size": 1,
  "type": "limit",
  "price": 0.1,
  "fee_structure": { "maker": 0.186, "taker": 0.186 },
  "fee_coin": "xht",
  "id": "a80b5c7f-be88-4d24-b134-cfb7b31b6d7d",
  "created_by": 10792,
  "filled": 0,
  "filled": 0,
  "average": 0.1,
  "status": "new",
  "updated_at": "2023-12-12T23:51:22.239Z",
  "created_at": "2023-12-12T23:51:22.239Z",
  "stop": null
}
```
Create am order on behalf of a user

### HTTP Request

`POST https://api.hollaex.com/v2/admin/order`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | User id for the order
symbol | string | Required | Currency symbol of the order e.g. xht-usdt
size  number | Required | Amount of the order
price | number | Required | Order Price
side | string | Required | Order Side, buy or sell
type | string | Required | Order Type, limit or market


## Cancel User Order

> Request

```shell
curl -X DELETE "https://api.hollaex.com/v2/admin/order"
```

> Response

```json
{
   "message": "Success"
}
```
Cancel a user's order by order id

### HTTP Request

`DELETE https://api.hollaex.com/v2/admin/order`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by

## Orders List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/orders"
```

> Response

```json
{
   "count": 1,
    "data": [
        {
            "id": "21c2be80-a2d8-4797-9ed9-caf83c631586",
            "side": "buy",
            "symbol": "xht-usdt",
            "size": 10,
            "filled": 0,
            "stop": null,
            "fee": 0,
            "fee_coin": "xht",
            "type": "limit",
            "price": 0.3,
            "status": "new",
            "created_by": 1,
            "created_at": "2023-04-10T21:48:13.691Z",
            "updated_at": "2023-04-10T21:48:13.691Z",
            "meta": {},
            "average": 0.3,
            "User": {
                "id": 1,
                "email": "test15@mail.com_m3cc4",
                "username": "test15",
                "exchange_id": 781
            },
            "network_id": 10792
        },
    ]
}
```
Retrieve user's orders list by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/orders`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
side | string | Optional | The order side (buy or side)
status | string | Optional | The order's status e.g open, filled, canceled etc
open | boolean | Optional | The info on whether the order is active or not
page | number | Optional | Page of referral data. Default: 1
bank_key | string | Optional | Bank query key to fetch specific bank
bank_value | string | Optional | Bank query value to fetch specific bank
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.
format | string | Optional | Custom format of data set. Enum: ['all', 'csv']


## Create Trade

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/trade"
```

> Response

```json
{
{
    "side": "buy",
    "symbol": "xrp-usdt",
    "size": 10,
    "price": 0.6,
    "maker_order_id": "05018676-d8f0-420d-abc0-3c199fb84f4c",
    "taker_order_id": "4d62d466-fbdb-4819-b60a-8aba3ad1c3e9",
    "timestamp": "2024-02-27T04:43:57.183Z",
    "maker_fee": 0.003,
    "taker_fee": 0.05,
    "maker_fee_coin": "usdt",
    "taker_fee_coin": "xrp",
    "quick": false,
    "maker_id": 1436,
    "taker_id": 1,
    "maker_network_id": 11186,
    "taker_network_id": 90
}
}
```
Create a trade between two users at a specific price

### HTTP Request

`POST https://api.hollaex.com/v2/admin/trade`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
maker_id | number | Required | User id for the maker
taker_id | number | Required | User id for the taker
maker_fee | number | Required | fee in percentage for the maker
taker_fee | number | Required | fee in percentage for the taker
symbol | string | Required | Currency symbol of the order e.g. xht-usdt
size  number | Required | Amount of the order
price | number | Required | Order Price
side | string | Required | Order Side, buy or sell


## Trades List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/trades"
```

> Response

```json
{
   "count": 1,
    "data": [
        {
            "side": "buy",
            "symbol": "xht-usdt",
            "size": 1,
            "price": 0.35,
            "maker_order_id": null,
            "taker_order_id": "c3a29aa8-0e8a-40f7-9057-a873dba65402",
            "timestamp": "2023-03-09T20:09:33.379Z",
            "maker_fee": null,
            "taker_fee": 0.002,
            "maker_fee_coin": null,
            "taker_fee_coin": "xht",
            "quick": false,
            "maker_id": null,
            "taker_id": 1,
            "taker_network_id": 10792
        },
    ]
}
```
Retrieve user's trades list by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/trades`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by
limit | number | Optional | Amount of referrals per page. Maximum: 50. Default: 50
side | string | Optional | The order side (buy or side)
symbol | string | Optional | The symbol-pair to filter by, pass undefined to receive data on all currencies
page | number | Optional | Page of referral data. Default: 1
order_by | string | Optional | The field to order data by e.g. amount, id.
order | string | Optional | Ascending (asc) or descending (desc).
start_date | date | Optional | Start date of query in ISO8601 format.
end_date | date | Optional | End date of query in ISO8601 format.
format | string | Optional | Custom format of data set. Enum: ['all', 'csv']


## Transfer Assets

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/transfer"
```

> Response

```json
{
   "message": "Success"
}
```
Transfer an asset between two users by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/transfer`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
sender_id | number | Required | The identifier of the sender
receiver_id | number | Required | The identifier of the receiver
currency | string | Required | The currency to specify
amount | number | Required | The amount to specify
description | string | Optional | The description field
email | boolean | Optional | The email field

## Crypto Withdrawal

> Request

```shell
curl -X POST
  -H "api-key: $API_KEY"
  -H "api-signature: $API_SIGNATURE"
  -H "api-expires: $API_EXPIRES"
  -H "Content-Type: application/json"
  -d '{"user_id":$user_id,"currency":$currency,"amount":$amount,"address":$address}'
  "https://api.hollaex.com/v2/admin/withdrawal"
```

> Response

```json
{
    "message": "Withdrawal request is in the queue and will be processed.",
    "id": 1000,
    "transaction_id": "d696dd5d-3226-4662-8d86-3da3d8eb68ff",
    "amount": 1,
    "currency": "xht",
    "fee": 20,
    "fee_coin": "xht"
}
```

This endpoint directly creates a withdrawal on behalf of a user, only available via
HMAC tokens with the withdrawal permission.

### HTTP Request

`POST https://api.hollaex.com/v2/admin/withdrawal`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | user id for the withdrawal process
currency | string | Required | The desired currency e.g. xht
amount | number | Required | The amount to withdrawal e.g. 5
address | string | Required | The recipient wallet's address
network | string | Optional | Network of currency being withdrawn if there are multiple networks for currency



## Check Deposit status

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/check-transaction"
```

> Response

```json
{

}
```
Check the status of a transaction on the blockchain. This is useful for when a deposit is missing or its left as pending on the blockchain

### HTTP Request

`GET https://api.hollaex.com/v2/admin/check-transaction`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
currency | string | Required | The currency to filter by, pass undefined to receive data on all currencies
transaction_id | string | Required | Deposits with specific transaction ID.
address | string | Required | Deposits with specific address.
network | string | Required | The network info
is_testnet | boolean | Optional | The info on whether it's a testnet or not


## Create Manual Deposit

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/mint"
```

> Response

```json
{
   "message": "Success"
}
```
Create a manual deposit for a user by admin. This is called minting assets and can only be done for fiat assets and assets you have created in the system.

### HTTP Request

`POST https://api.hollaex.com/v2/admin/mint`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
currency | string | Required | The currency to specify
amount | number | Required | The amount to specify
transaction_id | string | Optional | Withdrawal with specific transaction ID.
status | boolean | Optional | The status field to confirm the withdrawal
email | boolean | Optional | The email field
fee | number | Optional | The fee to specify



## Update Deposit

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/mint"
```

> Response

```json
{
   "message": "Success"
}
```
Update the status of a manually created deposit on the exchange

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/mint`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
transaction_id | string | Required | Withdrawals with specific transaction ID.
updated_transactionId | string | Optional | Withdrawals with updated transaction id
updated_address | string | Optional | Withdrawals with updated address
status | boolean | Optional | Confirmed status of the withdrawals to set.
dismissed | boolean | Optional | Dismissed status of the withdrawals to set.
rejected | boolean | Optional | Rejected status of the withdrawals to set.
processing | boolean | Optional | Processing status of the withdrawals to set.
waiting | boolean | Optional | Waiting status of the withdrawals to set.
email | boolean | Optional | Email
description | string | Optional | The description field


## Create Manual Withdrawal

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/burn"
```

> Response

```json
{
   "message": "Success"
}
```
Create a manual withdrawal for a user by admin. This is called burning assets and can only be done for fiat assets and assets you have created in the system.

### HTTP Request

`POST https://api.hollaex.com/v2/admin/burn`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user to filter by
currency | string | Required | The currency to specify
amount | number | Required | The amount to specify
transaction_id | string | Optional | Withdrawal with specific transaction ID.
status | boolean | Optional | The status field to confirm the withdrawal
email | boolean | Optional | The email field
fee | number | Optional | The fee to specify


## Update Withdrawal

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/burn"
```

> Response

```json
{
   "message": "Success"
}
```
Update the status of a manually created withdrawal on the exchange

### HTTP Request

`PUT https://api.hollaex.com/v2/admin/burn`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
transaction_id | string | Required | Withdrawals with specific transaction ID.
updated_transactionId | string | Optional | Withdrawals with updated transaction id
updated_address | string | Optional | Withdrawals with updated address
status | boolean | Optional | Confirmed status of the withdrawals to set.
dismissed | boolean | Optional | Dismissed status of the withdrawals to set.
rejected | boolean | Optional | Rejected status of the withdrawals to set.
processing | boolean | Optional | Processing status of the withdrawals to set.
waiting | boolean | Optional | Waiting status of the withdrawals to set.
email | boolean | Optional | Email
description | string | Optional | The description field


## Deposits List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/deposits"
```

> Response

```json
{

   {
    "count": 1,
    "data": [
        {
            "id": 11104,
            "amount": 5,
            "fee": 0,
            "address": "transfer",
            "transaction_id": "0200a457-1965-45de-ac08-03699d44c7f6",
            "status": true,
            "dismissed": false,
            "rejected": false,
            "processing": false,
            "waiting": false,
            "description": "Admin Transfer",
            "type": "deposit",
            "currency": "usdt",
            "network": null,
            "fee_coin": "usdt",
            "created_at": "2023-04-16T20:49:01.228Z",
            "updated_at": "2023-04-16T20:49:01.228Z",
            "user_id": 10,
            "User": {
                "email": "test_auth9126@mail.com_vow05",
                "exchange_id": 781,
                "Exchange": {
                    "id": 781,
                    "name": "testexchange429",
                    "display_name": "test-exchange429"
                },
                "id": 10
            },
            "network_id": 10871
        },
    ]
   }
}
```
Retrieve a list of the user's deposits by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/deposits`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by
currency | string | Optional | The currency pair symbol
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
transaction_id | string | Optional | Get deposits with this transaction ID
address | string | Optional | Get deposits made to this address
status | boolean | Optional | Completed status of deposits to get
dismissed | boolean | Optional | Dismissed status of deposits to get
rejected | boolean | Optional | Rejected status of deposits to get
processing | boolean | Optional | Processing status of deposits to get
waiting | boolean | Optional | Waiting status of deposits to get
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data in ISO 8601 format
format | string | Optional | Pass value csv to download csv file


## Withdrawals List

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/withdrawals"
```

> Response

```json
{
   "count": 1,
    "data": [
        {
            "id": 11103,
            "amount": 5,
            "fee": 0,
            "address": "transfer",
            "transaction_id": "0200a457-1965-45de-ac08-03699d44c7f6",
            "status": true,
            "dismissed": false,
            "rejected": false,
            "processing": false,
            "waiting": false,
            "description": "Admin Transfer",
            "type": "withdrawal",
            "currency": "usdt",
            "network": null,
            "fee_coin": "usdt",
            "created_at": "2023-04-16T20:49:01.228Z",
            "updated_at": "2023-04-16T20:49:01.228Z",
            "user_id": 1,
            "User": {
                "email": "test15@mail.com_m3cc4",
                "exchange_id": 781,
                "Exchange": {
                    "id": 781,
                    "name": "testexchange429",
                    "display_name": "test-exchange429"
                },
                "id": 1
            },
            "network_id": 10792
        },
    ]
}
```
Retrieve a list of the user's withdrawals by admin

### HTTP Request

`GET https://api.hollaex.com/v2/admin/withdrawals`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by
currency | string | Optional | The currency pair symbol
limit | number | Optional | Number of elements to return. Default: 50. Maximun: 100
page | number | Optional | Page of data to retrieve
order_by | string | Optional | Field to order data
order | string | Optional | asc or desc
transaction_id | string | Optional | Get deposits with this transaction ID
address | string | Optional | Get deposits made to this address
status | boolean | Optional | Completed status of deposits to get
dismissed | boolean | Optional | Dismissed status of deposits to get
rejected | boolean | Optional | Rejected status of deposits to get
processing | boolean | Optional | Processing status of deposits to get
waiting | boolean | Optional | Waiting status of deposits to get
start_date | date-time | Optional | Starting date of queried data in ISO 8601 format
end_date | date-time | Optional | Ending date of queried data in ISO 8601 format
format | string | Optional | Pass value csv to download csv file


## Send Email to User

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/send-email"
```

> Response

```json
{
   "message": "Success"
}
```
Send an email to a user account by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/send-email`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Required | The identifier of the user
mail_type | string | Required | The mail type for the email payload
data | object | Required | The content of the mail


## Send Raw Email

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/send-email/raw"
```

> Response

```json
{
   "message": "Success"
}
```
Send an email to users with a custom html by admin

### HTTP Request

`POST https://api.hollaex.com/v2/admin/send-email/raw`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
receivers | array | Required | The array of emails to send mail
html | string | Required | The stringified html content
title | string | Optional | The title of the mail
text | string | Optional | The text of the mail


## Settle Fees

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/fees/settle"
```

> Response

```json
{
    "message": "Success"
}
```
Settle the exchange fees by admin to a specific user account

### HTTP Request

`GET https://api.hollaex.com/v2/admin/fees/settle`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
user_id | number | Optional | The identifier of the user to filter by

## Create Exchange Stakes

> Request

```shell
curl -X POST "https://api.hollaex.com/v2/admin/stake" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "MATURE USDT",
    "user_id": 1,
    "currency": "usdt",
    "account_id": 228,
    "apy": 10,
    "min_amount": 1,
    "max_amount": 100,
    "early_unstake": false,
    "status": "active"
  }'
```

> Response

```json
{
  "message": "Success"
}
```
Create new exchange stakes
### HTTP Request

`POST https://api.hollaex.com/v2/admin/stake`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
name | string | Required | Name of the stake pool (max 256 chars)
user_id | number | Required | User ID associated with stake pool
currency | string | Required | Currency of the stake pool
account_id | number | Required | Account ID
apy | number | Required | Annual Percentage Yield
min_amount | number | Required | Minimum stake amount
max_amount | number | Required | Maximum stake amount
early_unstake | boolean | Required | Whether early unstake is allowed
status | string | Required | Pool status (uninitialized/active/paused/terminated)
reward_currency | string | Optional | Currency for rewards
duration | number | Optional | Duration in days
slashing | boolean | Optional | Whether slashing is enabled
slashing_earning_percentage | number | Optional | Slashing percentage for earnings
slashing_principle_percentage | number | Optional | Slashing percentage for principle
onboarding | boolean | Optional | Whether pool is for onboarding
disclaimer | string | Optional | Disclaimer text

## Update Exchange Stakes

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/stake" \
  -H "Content-Type: application/json" \
  -d '{
    "id": 43,
    "apy": 12,
    "status": "paused"
  }'
```

> Response

```json
{
  "message": "Success"
}
```
Update exchange stakes
### HTTP Request

`PUT https://api.hollaex.com/v2/admin/stake`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
id | number | Required | ID of the stake pool to update
name | string | Optional | Name of the stake pool
user_id | number | Optional | User ID associated with stake pool
currency | string | Optional | Currency of the stake pool
account_id | number | Optional | Account ID
apy | number | Optional | Annual Percentage Yield
min_amount | number | Optional | Minimum stake amount
max_amount | number | Optional | Maximum stake amount
early_unstake | boolean | Optional | Whether early unstake is allowed
status | string | Optional | Pool status (uninitialized/active/paused/terminated)


## Delete Exchange Stakes

> Request

```shell
curl -X DELETE "https://api.hollaex.com/v2/admin/stake" \
  -H "Content-Type: application/json" \
  -d '{
    "id": 43
  }'
```

> Response

```json
{
  "message": "Success"
}
```
Delete exchange stakes
### HTTP Request

`DELETE https://api.hollaex.com/v2/admin/stake`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
id | number | Required | ID of the stake pool to delete


## Get Exchange Stakers

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/stakers"
```

> Response

```json
{
  "count": 14,
  "data": [
    {
      "id": 142,
      "user_id": 1,
      "stake_id": 43,
      "amount": 10,
      "currency": "usdt",
      "reward_currency": "usdt",
      "reward": 0.00277777777777778,
      "slashed": 0,
      "status": "closed",
      "closing": "2024-10-23T18:20:46.498Z",
      "unstaked_date": "2024-10-28T00:00:00.033Z",
      "created_at": "2024-10-08T18:20:47.571Z",
      "updated_at": "2024-11-10T00:00:01.903Z"
    }
  ]
}
```
Get exchange stakers information
### HTTP Request

`GET https://api.hollaex.com/v2/admin/stakers`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
opts.id | number | Optional | Unique identifier for the staker entry
opts.user_id | number | Optional | The ID of the user who staked
opts.stake_id | number | Optional | The ID of the stake pool
opts.currency | string | Optional | The currency in which the user staked
opts.limit | number | Optional | Number of elements to return. Default: 50. Maximum: 100
opts.page | number | Optional | Page of data to retrieve
opts.order_by | string | Optional | Field to order data
opts.order | string | Optional | Direction to order (asc/desc)
opts.start_date | string | Optional | Starting date in ISO8601 format
opts.end_date | string | Optional | Ending date in ISO8601 format
opts.format | string | Optional | Data format (csv/all)



## Update Exchange Staker

> Request

```shell
curl -X PUT "https://api.hollaex.com/v2/admin/staker" \
  -H "Content-Type: application/json" \
  -d '{
    "id": 142,
    "nav": 10,
    "reward": 0.0028,
    "status": "staking"
  }'
```

> Response

```json
{
  "message": "Success"
}
```
Update exchange staker values for admin
### HTTP Request

`PUT https://api.hollaex.com/v2/admin/staker`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
id | number | Required | Unique identifier for the staker entry
nav | number | Optional | Net asset value of the staker entry
reward | number | Optional | Reward value of the staker entry
status | string | Optional | Staker status (staking/unstaking/closed)


## Get Stake Analytics

> Request

```shell
curl -X GET "https://api.hollaex.com/v2/admin/stake/analytics"
```

> Response

```json
{
  "stakingAmount": [
    {
      "currency": "usdt",
      "total_amount": 317.25
    }
  ],
  "unstakingAmount": [
    {
      "currency": "usdt",
      "total_amount": 8.5
    }
  ]
}
```
Get staking and unstaking analytics
### HTTP Request

`GET https://api.hollaex.com/v2/admin/stake/analytics`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------



# Websocket

Connection to public and private channels are available through the path `https://api.hollaex.com/stream`. HollaEx Exchanges can be connected to using any websocket libraries. For this documentation, we will use the library [`ws`]('https://github.com/websockets/ws').

## Connecting

> Connection

```javascript

	const WebSocket = require('ws');

	// Public
	const client = new WebSocket('wss://api.hollaex.com/stream');

	// Private HMAC
	const client = new WebSocket(`wss://api.hollaex.com/stream?api-key=${API-KEY}&api-signature=${API-SIGNATURE}&api-expires=${API-EXPIRES}`);

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

`wss://api.hollaex.com/stream`

### PARAMETERS

Parameter | Type | Required/Optional | Description
--------- | ------- | ------- | -------
api-key (*HMAC*) | string | Optional | Your exchange api-key
api-signature (*HMAC*) | string | Optional | An api-signature created using HMAC SHA256
api-expires (*HMAC*) | string | Optional | Expiry time of request

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
trade | Public event for trade updates.
price | Public event for price updates.
order | Private event for user order updates.
usertrade | Private event for user trades.
wallet | Private even for wallet balance updates.
stake | Private event for user stake updates.
deposit | Private event for user deposits.
withdrawal | Private event for user withdrawals.


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
				args: ['orderbook', 'trade']
			})
		);
	})

```

### EVENTS

The public events you can subscribe to are:

Event | Description
--------- | -----------
orderbook | Notification with orderbook symbol and data update. To subscribe to a specific pair, you can pass the pair after a colon. Ex: `orderbook:xht-usdt`.
trade | Notification with trade data. To subscribe to a specific pair, you can pass the pair after a colon. Ex: `trade:xht-usdt`.
price | Notification with the latest prices (quoted in USDT) per currency and live price updates.

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

> price

```json

{
	"topic": "price",
	"action": "partial",
	"data": {
		"usdt": {
			"price": 1.0007337033020485,
			"lastUpdate": "2025-12-02T20:39:36.106Z"
		},
		"btc": {
			"price": 88894.87428027151,
			"lastUpdate": "2026-01-21T01:30:02.528Z"
		},
		"eth": {
			"price": 4000,
			"lastUpdate": "2026-01-21T01:40:47.510Z"
		},
		...
	},
	"time": 1768960063
}

{
	"topic": "price",
	"action": "update",
	"symbol": "eth",
	"data": {
		"price": 4000,
		"lastUpdate": "2026-01-21T01:50:19.501Z"
	},
	"time": 1768960220
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
usertrade | Notifications for user trades (recent trades snapshot and updates).
deposit | Notifications for deposits updates.
withdrawal | Notifications for withdrawals updates.
stake | Notifications for stake updates (create/delete).
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

> usertrade

```json

{
	"topic": "usertrade",
	"action": "partial",
	"user_id": 2876,
	"data": [
		{
			"side": "buy",
			"symbol": "btc-usdt",
			"size": 0.001,
			"price": 60000,
			"timestamp": "2026-01-19T02:54:35.636Z",
			"order_id": "cc5ebec3-6e3f-4cb5-b5f9-49dd01843a08",
			"fee": 0.0000005,
			"fee_coin": "btc"
		},
		{
			"side": "buy",
			"symbol": "btc-usdt",
			"size": 0.03074,
			"price": 61200,
			"timestamp": "2026-01-19T02:46:15.235Z",
			"order_id": "0814a018-3e74-4330-9649-b06dc5107e27",
			"fee": 0.00001537,
			"fee_coin": "btc"
		}
	],
	"time": 1768959647
}

{
	"topic": "usertrade",
	"action": "insert",
	"user_id": 2876,
	"symbol": "eth-usdt",
	"data": [
		{
			"size": "0.001",
			"side": "sell",
			"price": 4000,
			"symbol": "eth-usdt",
			"timestamp": "2026-01-21T01:40:47.471Z",
			"order_id": "1df5b4b4-3274-4183-8c52-282afb4dc1df",
			"fee": "0.004",
			"fee_coin": "usdt"
		}
	],
	"time": 1768959647
}

```

> stake

```json

{
	"topic": "stake",
	"action": "insert",
	"user_id": 2976,
	"user_network_id": 15334,
	"data": {
		"reward": 0,
		"slashed": 0,
		"id": 28,
		"user_id": 2976,
		"stake_id": 7,
		"amount": 0.5,
		"nav": 0.5,
		"currency": "eth",
		"reward_currency": "eth",
		"status": "staking",
		"updated_at": "2026-01-21T01:26:31.449Z",
		"created_at": "2026-01-21T01:26:31.449Z",
		"closing": null,
		"unstaked_date": null
	},
	"time": 1768958791
}

{
	"topic": "stake",
	"action": "delete",
	"user_id": 2976,
	"user_network_id": 15334,
	"data": {
		"id": 28,
		"user_id": 2976,
		"stake_id": 7,
		"amount": 0.5,
		"nav": 0.5,
		"currency": "eth",
		"reward_currency": "eth",
		"reward": 0,
		"slashed": 0,
		"status": "unstaking",
		"closing": null,
		"unstaked_date": "2026-01-21T01:31:18.866Z",
		"created_at": "2026-01-21T01:26:31.449Z",
		"updated_at": "2026-01-21T01:31:18.867Z"
	},
	"time": 1768959078
}

```

> deposit

```json

{
	"topic": "deposit",
	"action": "insert",
	"user_id": 1,
	"data": {
		"amount": 1,
		"currency": "xht",
		"status": "COMPLETED",
		"transaction_id": "123",
		...
	},
	"time": 1608021684
}

```

> withdrawal

```json

{
	"topic": "withdrawal",
	"action": "insert",
	"user_id": 1,
	"data": {
		"amount": 1,
		"currency": "xht",
		"status": "COMPLETED",
		"transaction_id": "123",
		...
	},
	"time": 1608021684
}

```

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

## Admin Events

Admin websocket subscriptions can be used by **exchange admins** to receive **deposit**, **withdrawal**, and **stake** updates for **all users** automatically.

> Connection

```javascript

	client.on('open', () => {
		client.send(
			JSON.stringify({
				op: 'subscribe',
				args: ['admin']
			})
		);
	})

```

When subscribed to `admin`, the server will send deposit/withdrawal/stake messages in the same payload format as the private user events shown above, but covering all users.
