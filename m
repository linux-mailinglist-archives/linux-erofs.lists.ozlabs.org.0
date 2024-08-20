Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77595821D
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 11:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724145967;
	bh=NCYevGB2ivwU9XAHzMUFDMP3+joZfaXaQxUcHZWP/jw=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jenjDeE2hLOVFc6d38v5c82MazJqzq4B7cPnKaHMl1WM1cgk8/Rj2Kg4CLRDbeLMd
	 E1PlbM9hzI+weyRLDEP9o39BPNwhXXOkVtn4MLTlB4wHkuDjR+qzNKfffUjnPLX9Xi
	 HxX5gGp5vdBwknrHhZNXJg11ss9GfPXmzpsPzlhCMqSA+J0B17mNMfyKxy4B4B801J
	 NUvwzW6UpHskCJ/iPqfsCcNAKuJWy8Vc/rH2Ep98otl6Jv/OFuwG1Yv859Pg7nGNIA
	 tbO9ismwOZBXLCpvhYxNfSlxnEejuc+S6O6N7XawkffGDqdnYLf4tsA8unp3SH7CHK
	 wzPotcgWQ6fug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp3xC36J8z2yF0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 19:26:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::62d" arc.chain=microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=oVgGkPf6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::62d; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::62d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp3x33k2pz2y1l
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 19:25:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbhO1hWJWEVDLDjkMZRLe6zjzO8BnAdALBdBvIBUxyEE4YzT7MZ8FEgIDVbhSDpkh2JjvFFDJlU0CE1RDRZsrHwtG5iGFaExtz0udOZIxg904TmCpyQA5iYppZbPi8W17f2vc3zyZ0pO655H3Kfwo//aoA+7aCytVIW3hcsMxUA+zYOJVOfbQ0EgeEaZ0dgDywLATol6tdhbuSJkwmr73RLkMJvczzBZCC7za3isX/kJtkx0PoTDRJC1gZkhd6PSNGSsutm42sGxRzzONA469lqIfRGg+9+fmbkNu3frJ7JEl1V8rGfO+k0PimoeagbsxKbSCeXy7xFxZbEv9GzOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCYevGB2ivwU9XAHzMUFDMP3+joZfaXaQxUcHZWP/jw=;
 b=Mf/lWWwCH3DOP6fgBC9AzgSM3km76hhcR2HBbF7Kdo5rsGqgYWP2XVPqfx3HqA5HFIoCe9kg0pTHR/0cy6U5gQ5IvtSu08MlEGqJ58o+pE15482Kb5b/g2NM52cjQjOsbJvVwfPM+J4aXrx5hxRODmrB8rGzSLF1CLQIr3heNGvqwaAZeXBnYPiO0FZzcPZvkgNfEhW7NRz1ah5I4qH7tA0akMbFRsX4/ngfCUNlUUV0B2yme3jg9Do4e/znb9BU21HqWnbD9v3Z7bQ5654vWnIuzzZ/LTQReT28uPQl120hA1Ajs+qNFkBXI0/kF7FZYWFFD5HpatGRz6RhejXANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCYevGB2ivwU9XAHzMUFDMP3+joZfaXaQxUcHZWP/jw=;
 b=oVgGkPf6l6rpSbv4AErv0n9ruKvhBFvzqSD0xZsPdxqCPsUmARXi0lO/pUgwQHzs8oj9l6/9ar31vqw2AIa/9K0uRfSjitZmALdOJFcMpQSPMJLZDNDJUzvM399bgHf3r1Vwe3G25tfpbIsPhWSJA8kTvam+vQz536Kql5afutYXrQmSEUurYVYo2/NoaUcG7rCrFLAinKf0KMrp6q/lNiDBo6BwMsMHT433AH7MRrM5ivUoDRczUJES5qpYMwRIumKypWPgIRBaDtEE2dUPLqIesElv3X8Gvv8Y5fcAXfqEr2t5BKvHlV9qUebsMViJ6TPDzCa8AY8w22rSv6nb+Q==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYSPR06MB7164.apcprd06.prod.outlook.com (2603:1096:405:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 09:25:31 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:25:31 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
Thread-Topic: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
Thread-Index: AQHa8tz08HbfeeaA0U6v+SOJ6gjPXLIv4BIA
Date: Tue, 20 Aug 2024 09:25:30 +0000
Message-ID: <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
References: <000000000000f7b96e062018c6e3@google.com>
 <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|TYSPR06MB7164:EE_
x-ms-office365-filtering-correlation-id: 9054e4d6-5b6e-46bf-9c9f-08dcc0fa0943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:  =?utf-8?B?ZWorOFZCaWRDTXZwM2xkeFEvMzR6ZFFRNnIvR2wrZzJXa0JhTUFYWDVPUDc1?=
 =?utf-8?B?WkZaL2VNY2lPVDlUTzdQTW91UktweGxrTTlSS0N2cTNQa0ZyMGttSE9DMnBB?=
 =?utf-8?B?WllHdkhSdHZGbjdzNmNhcEVyY2ppMUFLaWtjTzNQM3J2R3ZCVU1KWk5mbk1t?=
 =?utf-8?B?ZHdOZ1hQZkp5SXNkOWFyNmRoNHhLUE1qN1VNZUJrRUNuREFmS2hQb2FFQ0tF?=
 =?utf-8?B?RFBPNnBVVmpwems3bHdpYVdJRlNYMkt3bHVaRGR6YXFWVzJCcTExVTdmS1Yv?=
 =?utf-8?B?RG5rL2VxSW5GcXJJUUl4R002RTZxQU9ocUFkZm9HNytqMTJOQUtTUWVaUVB4?=
 =?utf-8?B?Z2FNUFhxbkRqV3JjRjFrR25xcTUvbExIdDZtODMvMUlsSktUYnB6dmQ3bzVa?=
 =?utf-8?B?NHRVWDJDR0IzM2hIcXRLYW5tOGNYNjV4Qm1XNDRRa0x0ZDNXNmNoNVMvN0FP?=
 =?utf-8?B?SVBZTVZVNy8xWTEyRG94NmlDQjM0VlY3R211QjFWYVRKSHFFQW80NWlmeEVk?=
 =?utf-8?B?eVdDcHY4MnRVNDg4dFVpams1aHkyeDVSOHIyaU1FajRiNzUxVzkyWThDNGFR?=
 =?utf-8?B?N09UMkRKMXF1NzRSQTVDcjMwQlFDNUR6Q1FOczZuRnJSU2M3Z3pvbWFOcEtr?=
 =?utf-8?B?RnY1SUhvOGZjTEZLTGo5ZzZBNDIxa2VKUXBIc3NtR3c2M2s4dU9IRjYzcTQy?=
 =?utf-8?B?V3NJUklXR0g4KzJib0YzcVU0dXlEZi9mVlZ3eG5BQ2NQRE4yTmtsTGRWcENV?=
 =?utf-8?B?TjQ3cFlTKytTOFpzRUJ3N2hLNzB5a05oWklEUEpNQXUrckdRME1ubFhZSjdC?=
 =?utf-8?B?cENuWGc4Slc2RTVUK3d2T090U0xvSlZOT2NROGZqQ3NRLy9HTWtOOHovQ1ZK?=
 =?utf-8?B?K1hxaGJ0cHBpM05jS3N0WEVxZWMxdVo0QmJBbGh0REZZM2g2VDJuVUFEaWw2?=
 =?utf-8?B?eFBiYmpVTHVkNFQ0WmdTaHE2ZDFaMTJINDI1eFFuU1NUd3hWUlFlZ2EzYW54?=
 =?utf-8?B?dXc0TjJ6K1BmNUY3ays5TWRTeDk4andCOCtWSUlKSnl4TmxNK0dROGJ4dUdU?=
 =?utf-8?B?TUlDUzVxcy9LZ2Q0b1JLVVFFeG1GQ3BrYU9QZnVEMWgyZ0FPbmdOU05WTzZS?=
 =?utf-8?B?V3BxSWNhYzFYZlRXVktqZlVmaWdUR3c1UU9GS0UvYW9HUHZVZFVCaWNDVE9J?=
 =?utf-8?B?SWVZVWlSSlVHMG5OMmZYVTEycUFrR3dCRHRaTnMyQnM5V0l0TjVKT2NBWmRO?=
 =?utf-8?B?REQwTEJsMVY5UktocUo1Yml2UVRkWU14NjQzZTRFNC8wV3RGR2kzWnhSZlNy?=
 =?utf-8?B?VHYxWXNPRWhSZDlrVGZUdjlETk43N0hlbzN1dXBFZXgxKzhVWWN0Mlk3dk9V?=
 =?utf-8?B?R1pzQ1p1Y2R2OG5qQkZpYXFGYzlRSlFHdlQ0Q0lkSW1xVlRLbldFdnh1S1l6?=
 =?utf-8?B?cFdLd2x2S2IyZEpMMjNOSVFBbFhHWSt3c0tMZlF0OWwva2RkS09rTVZxZ3Js?=
 =?utf-8?B?dTlCTXlCaEp3VXpydUVncUYxNnJ0dFJxY29zbXRsZ1R6ZWNqQzR3bEFpeVpQ?=
 =?utf-8?B?OHp5eFdLK3hMM0pRbGc5T0RsLzVpREtPN3hRU1hRTjZvVzJLaEt4SVExM3I1?=
 =?utf-8?B?dDVBSnJhMzA3MnorU2E1UHFQRTRlcTdLQzZXTy9RM014ZXI2Q3UwcEZLVVph?=
 =?utf-8?B?UC9TZjFVQzdSanBQdmhHZmdnSzgvY0preXAwajRMQXZmNTIwRU03V0RINnNq?=
 =?utf-8?B?cTBMOENjMWN0MTc2SVlYZnNBdzRNWERjeTlYenF5WEpoejBKVm16YzVoa3Jr?=
 =?utf-8?B?anN3KzlmbWJmTXZZOXNmNEpMSHoyckFCT0RYclFraGJvalJESVFMU2lKb0or?=
 =?utf-8?B?SE96c2lnQ1doZmluKy9ZYmttOGxjYVkyaHdKeUFrRTU2Mnc9PQ==?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Qk5GbXpUTFlESTJlOWR6NG1HVlVlL09nQlA0YTdtVG5TTkF3cDJ0aU15Wmxv?=
 =?utf-8?B?aXQ2T2hzTzJhYzFIVXJuSFRZR2Uwd2ZTVStybFBoaGtGRVkvSW5FYzYyL0ZE?=
 =?utf-8?B?YnlyNVhDK05PVUhJUUo1NHVETngvV1k4NmtLcWZCSWpTT2t3Tk1WWmpaMjkr?=
 =?utf-8?B?cytlSndtOGtEZ0lWdnlTcE5NblNCclpvMGVTWGZYSlY5SUVBQ241S2xKbjll?=
 =?utf-8?B?b3U2SHpCT0g4UDU2dW9OVysrQ2R3aFJuek1jdFQ1ZjBlWnNOdWVlREptT29W?=
 =?utf-8?B?V2gzM2lJMC9aMHNMVE9rZk5uUTM3VHFlbmV0L2FwTE02a3l3ZHB1RTVGakJM?=
 =?utf-8?B?ODBXYjZITEJCZ0Q0eGlocXBxSVdWeEVzVGo5ZFdPQjd4emcyRXpSTkVZd3Jh?=
 =?utf-8?B?TC8ybStHemcyemJaOC8vdlF6T050VmZSSEp3c2Y0Nm9PMkhXd281b1ZQUTZu?=
 =?utf-8?B?b2c2U21pY3Y4UmpSZW5Bd0JRNjRiSW82SXJsTlRLdGlxRW4yYlJBRGZtbnNC?=
 =?utf-8?B?c282TnllTXBqSUE4WWxnQWpsWFR3RWhscUVCUm5BYWtIMVI2Um84ZE8wSG4r?=
 =?utf-8?B?Mkc4YUROczNXUnl3MzBLazdQKzVvcHJ3blFQcllRNDJqNXJwNVVMVW5jUTFW?=
 =?utf-8?B?UjI2bmJWaE1DMnFlbXg3OHc2R0hCWm5Tb0Q5ZUtyeFhVOVk0ZlJsV2VmMHFq?=
 =?utf-8?B?L21wWFFDNGJMbzBoL001ekQ5ZGdrSnZWaWZCeFBvZ3dRakp1TTNNSU1GSnlU?=
 =?utf-8?B?MElheDBGS2w5UUg1RUpHVUpZWnlWRnIybzhYUkZueUFXRG0xS1lDK05xYmhC?=
 =?utf-8?B?Nkx4SXJacWlPb2hiemdXdGVHcVp3Z2tRZjR1eFlwK05lMlZaWWtkcEZvMFhS?=
 =?utf-8?B?L0w4aTUwRDYvOWVMZUhBMWdSYTdTT0k5S1IveWVkWXZvU2xaOHFVTkZGTWRy?=
 =?utf-8?B?cDhwM1Ywb0lRbWZSbGFpSE15Y2p5dDR1eEJXWWx6SlliR1R5YjE2OGNwQnVw?=
 =?utf-8?B?ZzFCaXMzWXZpWmhYcUVGQ3Y2cFU5WWhaYm1GZUo3dGgvT05MdWw2SXNKNzlR?=
 =?utf-8?B?QzNTeVp3dVE3ZkZVRklaM3krbkhRT3g2NVl3YTZFdXVpaFNzSkxxb01Xc0wr?=
 =?utf-8?B?TURYMkhEMzN3TUhnb29yaWFjNk5mRDdZNGVWTFRhaWQxRFhQL01wcHBxVS9o?=
 =?utf-8?B?RkszWDRMUkVZMHFISUZ3YkNBbjlXbkg5emR6Rk5UR2tOb3B5Q1B2bThKNUZo?=
 =?utf-8?B?K0NoTlpLMDRXQU1SQSt6MDVKUWVEcVRwVlEycmhXMFNNNjU4UjIxdlVxcFpi?=
 =?utf-8?B?dGk0bUZHUjhSKzNubUM5UlBJQVQ4WXlNNWxPRnp6bTUrejhUWjBoU2lCUTRu?=
 =?utf-8?B?d3BZUE9mbXB3YVFqUStpbkQvZCtZdmE2bi9mK0poUkxtbjAyUG1QU1NIN0ZS?=
 =?utf-8?B?UHJvZ2NYd1VmTjNEbHFWaE5ybzIzNkMrZVUrYVM4bWozMitud3JMNmxINUVX?=
 =?utf-8?B?TzgzV2RJYU1NMEwxUExtK2dNV1k1NnY0b0R5L0w3OStJSDNqZnFsVjJ3T2RX?=
 =?utf-8?B?eHBid0tIQXA4Sk1yenFvVWQyTWxVTlNlMlg3aVZhOEZQVzA4aHB5YUpPNTF4?=
 =?utf-8?B?SUlmbHg3b2FMVWZjU0FGZEEzdDJlZXFJckFYWjN0MTh3YXJlQnUraGFyQzB2?=
 =?utf-8?B?eU0xQXlPODNSalE3SXFLQUo3Q21Zb1hrUzNRUGhBM0d1bzNza3dmc2FEWkNT?=
 =?utf-8?B?cHdEYXozT2txaVRlRGRZQzVYV0hhdmtkZVpOU2dpZ1U3Z1llN0hyR1VqMnZh?=
 =?utf-8?B?UitDV2sxMFMwNER3dGFnMjQ4V1o5a0ovVHVCSWE4N3V6SWdQUXdWYUlHQ21K?=
 =?utf-8?B?S3ZieHZPUjI3VHJyZ2gyS1pRRGhlM2ZLeHBLelp2M2lYb1VWUkxzSjhQb0lw?=
 =?utf-8?B?MEhFWnNCU3JTaHkyV3hRaVFZT3QxYWkyNHA1TVBGcmlZeU1BeTd5YXlaNHVZ?=
 =?utf-8?B?UDlpenFXL2JIRk1hcmV1ZmtQc0dXbnNiQ1Zya09lRWdxUkRsVHlWYWpFQW13?=
 =?utf-8?B?Z25hVGpnVkVjL0luaHptbWRiY2RmS3VFenY4Nk84ZGNUL21DNzZ6MzF5TGQ3?=
 =?utf-8?Q?t6w4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33496F8D84742F4BB2B25D04752E9710@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9054e4d6-5b6e-46bf-9c9f-08dcc0fa0943
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:25:30.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+1kVDgdea9/wONQbQG77sVvwp7kz7P2ZHQP0qDMYgs4+5sm/jSXcwN404u4B+jTcuCgPXMbuqkBNuJhAPrkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7164
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

5ZyoIDIwMjQvOC8yMCAxNjo0MiwgR2FvIFhpYW5nIOWGmemBkzoNCj4gSWYgel9lcm9mc19nYnVm
X2dyb3dzaXplKCkgcGFydGlhbGx5IGZhaWxzIG9uIGEgZ2xvYmFsIGJ1ZmZlciBkdWUgdG8NCj4g
bWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZSBvciBmYXVsdCBpbmplY3Rpb24gKGFzIHJlcG9ydGVk
IGJ5IHN5emJvdCBbMV0pLA0KPiBuZXcgcGFnZXMgbmVlZCB0byBiZSBmcmVlZCBieSBjb21wYXJp
bmcgdG8gdGhlIGV4aXN0aW5nIHBhZ2VzIHRvIGF2b2lkDQo+IG1lbW9yeSBsZWFrcy4NCj4NCj4g
SG93ZXZlciwgdGhlIG9sZCBnYnVmLT5wYWdlc1tdIGFycmF5IG1heSBub3QgYmUgbGFyZ2UgZW5v
dWdoLCB3aGljaCBjYW4NCj4gbGVhZCB0byBudWxsLXB0ci1kZXJlZiBvciBvdXQtb2YtYm91bmQg
YWNjZXNzLg0KPg0KPiBGaXggdGhpcyBieSBjaGVja2luZyBhZ2FpbnN0IGdidWYtPm5ycGFnZXMg
aW4gYWR2YW5jZS4NCj4NCj4gRml4ZXM6IGQ2ZGI0N2U1NzFkYyAoImVyb2ZzOiBkbyBub3QgdXNl
IHBhZ2Vwb29sIGluIHpfZXJvZnNfZ2J1Zl9ncm93c2l6ZSgpIikNCj4gQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPiAjIDYuMTArDQo+IENjOiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2aXZv
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFi
YS5jb20+DQo+DQpSZXZpZXdlZC1ieTogQ2h1bmhhaSBHdW8gPGd1b2NodW5oYWlAdml2by5jb20+
DQoNClRoYW5rcywNCg0KQ2h1bmhhaSBHdW8NCg0K
