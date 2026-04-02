Return-Path: <linux-erofs+bounces-3178-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB2pBNMQzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3178-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:46:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79A384A8C
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:46:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXSv5PzYz2yZc;
	Thu, 02 Apr 2026 17:46:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775112399;
	cv=pass; b=VK1QboCyz8QCU7bgnAGS+C35JKhfrafj5ykRrxvS6NWiud17PFyc4232iFIsfLUd2SO7zZm90ZAUTycbBclWNrV7Fm8hLEMyuOvgVihJ7VcskaI1+zqogcPyHvyCotznGYAZrnK1rmJAyS+K5Vg1aTkrFiP7UozJdoaDBVYXrILCqR+xhfNfb18KH9di4JgHCbfQuxNVsPRQ0Ee6QZW7mnN00rG0u53NqNICuV2NQpRv4QY8EHP5sbTIvOJcIae4wPL5JHP9A1qDzFFtlifokU+z5KVqa3rEo1aaJmakKJQGZB37zIlIB5KMPvZDYrBV7RZmxT0+HFj1npHrt0dqZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775112399; c=relaxed/relaxed;
	bh=XElomJs7ph3/iL/V5vXauPZsFy/9YeUJL8qtnsgF8oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktoRp0vB0IY6pJ2wxg8xdbPmPKINtJKywrQX0Okzta787tXPpALuPu9mIJ7Y8MU/cJzcuD3YzCib9tpG1ZtvOT3GSEjNI5awksq2++rDxcAe2T3TT9bjvkkFYpjh/YziiS//GgTo0tnqQOFExGV+PhcvijS/szFfEd2NGSYhEHLJxQ3DrkHKPwT++2MJpH/smvUrFE37qo7k0JPK5lj6vtl4qobIEGOWCpnsHUy6gHaCALGsBH564yke6O2wIRRIeFFPTwYDc/6L+vjsEjmEfrVxBSEq2DeUkbXS5qdcXSQ7K2gPDXcOwPc5pnsnZn5JGKhfUg4BQGJBOz2GiAHHSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=qXkk7VK7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=qXkk7VK7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXSv12Gdz2xln
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:46:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTIBwoFLklpuoYqmJ+luaHqRTKuYxmFP7L/Cu66NHnRsHbPhVusbN3BEFordUPfb2kJqLqI6WXYi4dy16htKuX/6Xo6ycg8AfLmHvFLKCdvFDu0UdgwUX+oSsUnLp8bdEie7MnQyV7FmnjxELrM27Ttkh2X9WccEkeOi2GB0i/jH0xFLBqChyLrDo/OruSO6ID5gqGOfU21pZCdK9tAi1v1Q3XhBb8oJz6NjSLcdPbVTu2xO8VYYgffm1uKmO7mHcEUoRJbpkM4kLXbYDWXHz90Cs2CCstuch8mh1KIbDbKlKTP6BMqnW2PJ1/SIsNN7teLLz9a6ZlOR7+PwlbmPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XElomJs7ph3/iL/V5vXauPZsFy/9YeUJL8qtnsgF8oc=;
 b=CIaW6iTBfGWt4fqQfumIR7NiYcXa6oT8HC61tkeRcYLwOwKcfznVJMIPJPWtciGtHJ28lMZ8DxpohWd9dRDj1wVsy/M5gd48XG04jVkSuucZy18pgJnnBxGp1LwcZxiRiyqV4GvpC8to8ppMBAXtZoE8RWMGTW6odA1RT9c11YqtemjgVvU/O0ZrARlVakq0z2oWBCN/bw2P17jRKxCuOaemC2Pm1K9IYLzl8S0lg8UpWlF7ZFsZnmTQg3Kpukew8D0ks/UTFXxQqSIKvjlV4GxSQjta6LioLVaWHYcLEK0wZGdytwUhAo12fxoYQOOO/GcEbDI0Hc3w9wOufGHU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XElomJs7ph3/iL/V5vXauPZsFy/9YeUJL8qtnsgF8oc=;
 b=qXkk7VK7mX2rf0YZr7y+EMc4Umoim1wqjTztDrKXIq9OhFXhfFrPZCdzfNLLmbzxiRW6gn/LnhoIc6OUTUEkwh2+9qHmf0DR7r9AEm8ViyUP+mw0PHNRH0TO62c3uJYmW4uatZ0onsOrHDIwwLFjXx9uRrFmq2gHAjMVuiffjhduRblSOXVpmSp4OV7w32/iCQC5f3t9nQ37ujLmTlPRiXsXVqzfS4XLPZujOWEznLmzmhmwiG36HfJwrBwsA1GPZfflVX8D40SpYvdQPtcccM2DM1FJpTz1WDiUGWZr7+FteHuG4TQko38U89FNNfBXtudmPO4oMdjcJD8tnbHu3w==
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com (2603:1096:101:2ee::17)
 by TY0PR06MB5596.apcprd06.prod.outlook.com (2603:1096:400:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 06:46:09 +0000
Received: from SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93]) by SE3PR06MB8257.apcprd06.prod.outlook.com
 ([fe80::881c:180e:661d:eb93%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 06:46:07 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
CC: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] [PATCH v3] erofs: ensure all folios are managed in
 erofs_try_to_free_all_cached_folios()
Thread-Topic: [PATCH] [PATCH v3] erofs: ensure all folios are managed in
 erofs_try_to_free_all_cached_folios()
Thread-Index: AQHcwMurGa0F2OyvFEKcH8pwkOP6U7XLVyqA
Date: Thu, 2 Apr 2026 06:46:07 +0000
Message-ID: <16a3510e-4768-44a8-9e09-cf3a118f6ade@vivo.com>
References: <1828ed19-e9d0-4908-926a-0e0a9c3d04af@linux.alibaba.com>
 <20260331050249.23662-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260331050249.23662-1-zhanxusheng@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8257:EE_|TY0PR06MB5596:EE_
x-ms-office365-filtering-correlation-id: b68e3de0-f83b-49de-f7ac-08de908384f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 sp67KcIesMiUGJI19WQiemsBa6yF91/SEprNzJLqOnW3Nckezvxd3TIZ0K2H7Cuj2wMrjUI7xGCgYnI5lafjQUQFcBRiViTL4fl6QxrdlOebVzCHt90ESZ+TcsqNUL/DGH0wvR5AC4pUlJB7UZwhpZ4c2z8NrC5t4lr3ChrPDUcYBDByC2+FGA+8HF8hj5KO7rxnmzB5VJWRGoN6bm49lf2zBWqvJ8Pf06r8jq3s8UQylPGCG+NTA24lckDePZM9imdF5wFm5EMBMmvLXo7ZN2LQGo7m6H/flsvtBdqPb6HkiBoMlIMlijA/LoE6ICh2C4i/3LIumE+5hrKz1bqGStjolWGcee7Q2GCqbjqjrdmnQgir7NqbQgtv8730mFYB0bTb+ZGAeHsIoX4Ln1CdryDahbgvfFVaSYpxSfASbbQyzAIrIt5ojSqeENs1fJZRmYmW8LPWcfIZYMShkqUAUJa1o5Ny8RSID1bDT4XTADHGUTmuYoGPE+dd42zC9+z4SBlwWiqwDOkHm2VCqgmf4OKjOB9zNLtHpRB8XDQcNJdlKtfXe6e96gAra6UKWIqxNXO/2xFqTyN4D+FRh3GgmCADWcMezewD6damQGCivk56Tvt5ep8erVNtA+VLkzVYR5TqBtcjENU08lqrb1jpTdt6OegRNoUjPBKht7B4KI7wRvcqPERcht1V90f0iqIC8lz82GBSlKTItUe3X2Mb4vE5YJ66eTtpdoHLtQhsHDY9S0pVtXh76INXJxJhRzPB1dxTTfaRxF0VuxRaFVW0+hT+kP2yEGcq8LCNnnJi6gY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR06MB8257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnFxeXN0eGF0cXpoUVhUdHZFUDBIZTFoSHVCRW9URFZPcjhaTUk5dzh2WXdn?=
 =?utf-8?B?eW1jQUJRdDhoOEM4N1Q0YWdLZUxySHJobkdISDRqSElGRlptUGxFUWc3ZDJl?=
 =?utf-8?B?eDRyZnJ0bGNOT1ZEVGszQnNUbzhJTVplZnBGUWhjeFVIM2xwblkvQURWYWxj?=
 =?utf-8?B?NU9ZSU84VHVtT05MSmx5OUxjZzNaL0pab3hMSFZsNmo2MkZld1o4TGViNTdV?=
 =?utf-8?B?d1VxZzV0ZzRINWRXY09hcmpzZHd5OFVXdGNaYmFnUkRmR0tTZWY5d1lOUTZG?=
 =?utf-8?B?ZUpKYUFuZ1cvdVAvVktkdVlhQlpZd24yWnJSZnpUdEVqMU13NnZZQ0NWUHJ6?=
 =?utf-8?B?UnhKVU44YlRVaEFOeU5CRmxHdFJPY0xrSEp2SXRWTTFqaFhrcGNFUUVHYVJE?=
 =?utf-8?B?OUVJMkM1SFJDcmxiOGREY3V0VGdSRTVmVVRRMFA5TVNJM1lRZ1FIM2hWZEZK?=
 =?utf-8?B?Z3VFOTRweE1FbktLZG0xOE9PYlA2bHhMckJ6VGw2NVpSSWdFeW5wanJSMEdx?=
 =?utf-8?B?cG9TRHhWUWdrRjRtKy9pM0dIRFI3NFNZb2piZEdXQkNXTVFaMmhTdGZUZzF5?=
 =?utf-8?B?ZU1LejA0UXJDd3hFaGkrQzg5bHN2YkVQV0ZJbzlWUVNJUk5Fbkt5cjF4OS9p?=
 =?utf-8?B?SERZNnY0V3hkTlRWbGtySkNMUmsyUXVVN0QwNmFrMnFCSUtObUdnTFZNTDF0?=
 =?utf-8?B?ZVNQcjdNMXUyV0lYQUFhMzlySldUQXJpTTJ6SE9ybkRibDR6WXF2dWhHNU1B?=
 =?utf-8?B?Z1FZT3VRZitnb2dUQW03ZHdNRU5RWnUvM2VqZmZTNGRyTzNpdEpTVkMrZzhx?=
 =?utf-8?B?QUhibTVUWTFQeWRrWWJiYkRFOW5xWGFnSS82TWl1YUhDNVZ0ZEV1UVFHWVhi?=
 =?utf-8?B?alRMd1E5c1NQazVCbFF6d2E1MFBNN2tCVFFBbUFObUtnaU9nREdXNERLcktn?=
 =?utf-8?B?R2xuOGdkeXNPTUIyQ2VRUHdZSnJFTTI3R2RLQUNqK050QzN3RjcreVhIMHpv?=
 =?utf-8?B?K1E0Z2FyaUdzQXRta1ViVFpYY09pVm9GVmRiRWZETjVObDVSdlh1cWFvRUVV?=
 =?utf-8?B?Vnl2cW9FSCtWYTA1eXEraklXekdnSEFPUUdhOGwxRFRnOWNjZGZ3MDdPc3hh?=
 =?utf-8?B?b2w4REVlaW83QkZpQmJSS0Z3UFJ6Q1Evamt5MExIU0REWEl2UjVPSmNRVnZE?=
 =?utf-8?B?NTVOeVhFTnY1dDRONUtSTWcybDNPUGR5c2dtRmN6MVB4MHBlcVNZMVN1OUdM?=
 =?utf-8?B?UmZtNThHSENNdXN3N1dlY29xTjZPV3FLWjVSdEJCM3lEd1NYanZ0QTR1eUNI?=
 =?utf-8?B?ZzN6RzgvSDQ3WW5BZnB5dHY3TmxUaHJ1TElBSTczYk9kRkRPNmRKZjVMZDdx?=
 =?utf-8?B?TmlLZEgwSVlWN2lrM0trY1FBYVhXRlViWGROcXBFYjZqclhpQVFOZmJPTEE5?=
 =?utf-8?B?YjM3ZC9WTklSU25DNEl0bDJobnZIOG9ObnZMV1UvUTlIZ2o0aTlrUTRHQnZs?=
 =?utf-8?B?cHJ5ekc5TS9sUTJpOFVuWWEvZ0wwcitpVTVNQXArc0tPcWdWdHljYjlQdkdp?=
 =?utf-8?B?RUFPUzFQR2NhQ0FHZUl1aDlqbzh3OXlaTktqMUh5a1pzbmxodGNKOFVxTjFO?=
 =?utf-8?B?QkljNjdPZUNNMVgxTC9PQnlEZVowSVVhelpHV00veTd2Z3N4dnl0cXVPRUtx?=
 =?utf-8?B?MmpWVUQwcng5Nk5PempxTW9MMDNzT0U2c1hRbUh5elMxanJ4UGV6UVZkVytj?=
 =?utf-8?B?U3hkSXlKT1NHSlVnSzZBVEtUbGtwbm5ManVlOXJZbHN3T21zRU1oUTV4TERk?=
 =?utf-8?B?dWdqdEJsRXdDU2FaSWU4OVZYMTVBTEUwMkw2bGExTTVzZTZHSWRmd1dSbmpX?=
 =?utf-8?B?VnlyMFo5U2JzdmxSRnZURzFobWJidnBlc3dTT3lrWGpXNGllK1VWQitvbmJt?=
 =?utf-8?B?U2tYajMreFpEVTk4U1FwaFU3ekpQcXc1ekg5SWgyVG5ETWVHZmhwOG5Wbk8w?=
 =?utf-8?B?WjRvNTVXUEJuRDUyNkpDQk05Y2RBZ0NTaVBxRDA0RE9OTEc4dnU3WTJVdm93?=
 =?utf-8?B?eUdRK0lsYngzaVpLYjI4M2VGU1ZyR1RvZG9oRXhnTC9LOE10dlVNbFJpSTU5?=
 =?utf-8?B?N1ZtLzhPNW4zcy9MMS9tcmwyb082OG9MWWJIZHNYZ2tKYnpmNkZBdjBERkpD?=
 =?utf-8?B?ekdzYllnVkxtdEdIR2hMdElEaldYZjB0dlBMbEVFVzdGS3VxVm5QaVR2ek93?=
 =?utf-8?B?R3dBOXpqQ01HYjlHNDE1Y0d0eFNyM2E0NEc5OUV0UjdlMWc0NzdvOUU5V1dY?=
 =?utf-8?Q?ENOTeMbIxfvzFvguYC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A3DB2130040046AB5C89FF732A197A@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8257.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e3de0-f83b-49de-f7ac-08de908384f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:46:07.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXKimzCpPbVndgN6M/VjYGA2YTofdgrgJ5fUCLRMmz9pkCi4c30SU3ENrxRcllGPrlPP4whl/b9e3wQyM/iA/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5596
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guochunhai@vivo.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3178-lists,linux-erofs=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:dkim,vivo.com:email,vivo.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 4E79A384A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMy8zMS8yMDI2IDE6MDIgUE0sIFpoYW4gWHVzaGVuZyB3cm90ZToNCj4gZm9saW9fdHJ5bG9j
aygpIGluIGVyb2ZzX3RyeV90b19mcmVlX2FsbF9jYWNoZWRfZm9saW9zKCkgbWF5DQo+IHN1Y2Nl
c3NmdWxseSBhY3F1aXJlIHRoZSBmb2xpbyBsb2NrLCBidXQgdGhlIHN1YnNlcXVlbnQgY2hlY2sN
Cj4gZm9yIGVyb2ZzX2ZvbGlvX2lzX21hbmFnZWQoKSBjYW4gc2tpcCB1bmxvY2tpbmcgd2hlbiB0
aGUgZm9saW8NCj4gaXMgbm90IG1hbmFnZWQgYnkgRVJPRlMuDQo+DQo+IEFzIEdhbyBYaWFuZyBw
b2ludGVkIG91dCwgdGhpcyBjb25kaXRpb24gc2hvdWxkIG5vdCBoYXBwZW4gaW4NCj4gcHJhY3Rp
Y2UgYmVjYXVzZSBjb21wcmVzc2VkX2J2ZWNzW10gb25seSBob2xkcyB2YWxpZCBjYWNoZWQgZm9s
aW9zDQo+IGF0IHRoaXMgcG9pbnQg4oCUIGFueSBub24tbWFuYWdlZCBmb2xpbyB3b3VsZCBoYXZl
IGFscmVhZHkgYmVlbg0KPiBkZXRhY2hlZCBieSB6X2Vyb2ZzX2NhY2hlX3JlbGVhc2VfZm9saW8o
KSB1bmRlciBmb2xpbyBsb2NrLg0KPg0KPiBGaXggdGhpcyBieSBhZGRpbmcgREJHX0JVR09OKCkg
dG8gY2F0Y2ggdW5leHBlY3RlZCBmb2xpb3MNCj4gYW5kIGVuc3VyZSBmb2xpb191bmxvY2soKSBp
cyBhbHdheXMgY2FsbGVkLg0KPg0KPiBTdWdnZXN0ZWQtYnk6IEdhbyBYaWFuZyA8aHNpYW5na2Fv
QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFuIFh1c2hlbmcgPHpoYW54
dXNoZW5nQHhpYW9taS5jb20+DQoNClJldmlld2VkLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhh
aUB2aXZvLmNvbT4NCg0KDQpUaGFua3MsDQoNCg==

