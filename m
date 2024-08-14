Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC266951A02
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 13:36:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723635372;
	bh=czMyt+QEynCFnsobcbVsx2xvGFGxQJtCRETnMso46Mk=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=d+VVaJE7sEOpox5AjIx5CX5Ps60Te+2Tzgq/dTQ3CQgHbQsGhZ7XbGksIskwdt0W+
	 BMKBUeWpOgHzg3sf6YmoP1cpWi/Vr8NKYlJEsLiF6lnt4YppZf8sk/q5Mr0aS54BID
	 OfN+HYdxXYPJJBR7qtiMJYxXB88NbUmvV7XWfpZGJY1YUmvTJjxnqd5ADHBIuOgzd5
	 gLMkxAczvr8tGuURH9A4xuhUEM/rCFPHpcdR9vuRx+FwjgBscenXCjfgJZ4GefT8Qe
	 JFwm96a4UMlU1pdwqot++D+dzp9zFIHk5IELghuBSa/mxDbGGyoW+wHb2631ne6LQO
	 xK7g3oEg3/uMQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkR645c62z2yV8
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 21:36:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=LxCn6Qgq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::600; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::600])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkR5s2TRJz2yJL
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 21:35:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnqgLgF+2d55lPd2iRd4q58yGV4q31Nxw62W/P3OFTbYDRP1jzMV8chlibbPHtErSyPUgrAdc3/MHgx/eGMsiEhE6aOaJvIPCebi5MdY4w02ozJ4KaXQW7lgh+ShGVkLMR65c2naUQ5bBVHdDoNM4OZVNG46fbm4rqH9j66jffClrkANzk+3TLuD29pPCU8hyhxwqskyOFy+nwt1cRXsTpKA/XkckactOfrJZuRcCR57ctM4VwGPq2BY8Zz6MrZpmJqJsezj85uORGwxlyVN2/oFTep9wVYd8XtkruveGKNROxyRzELdgJ3fT8eso8lAHdlPRBX+AsqBa26Lbi76tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czMyt+QEynCFnsobcbVsx2xvGFGxQJtCRETnMso46Mk=;
 b=qya0MZDnLhbqsbwLGEtl9T8qFu2ZvbSWSO92miYaPUkTTjXm1eYrawuk7cVXh1uFIrlCDREkSYtDvewWWYtewj3C+ZTGo3otn46DEct9FVSFoJf+l19fzqPcTwu1UkEnugZ5veN0AndSHm4qXmWzyvDEPhxgB0fT0cabBoFL+Yfc84J3sfDVpjdAFFKX/eSVri0U+NCzP1vtHN5vPOd9L1oZGe+hwIBADnXS50bNZ5UZCBlZwro/ejHb+ECXhEiuuU+94AhZ4yTZhj3ksl/hyiHKbB4XEgjE2emCr4t516moKiV5gGUiDwNkYXg3N0GJ0fWzGuMUKJiZ0P4y6gjsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB7348.apcprd06.prod.outlook.com (2603:1096:101:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:35:32 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 11:35:32 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
Thread-Topic: [PATCH] erofs: allocate extra bvec pages from reserved buffer
 pool first by default
Thread-Index: AQHa7WlYD138MipB3kSR9SoEb+aiYrImCpAAgACWwIA=
Date: Wed, 14 Aug 2024 11:35:32 +0000
Message-ID: <52c4bcf8-dfb2-43ac-9b94-91b4bd7821ba@vivo.com>
References: <20240813102723.640311-1-guochunhai@vivo.com>
 <d6f177fe-0263-489b-968f-189a923e089b@linux.alibaba.com>
In-Reply-To: <d6f177fe-0263-489b-968f-189a923e089b@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|SEZPR06MB7348:EE_
x-ms-office365-filtering-correlation-id: a2454ec8-f525-4957-1cfc-08dcbc5534ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:  =?utf-8?B?ZlVsdTdXWmlXajNpSVJzcklSb0N4aHlUWmhzOW5Pakc4dmFBeVZNWnRXaklr?=
 =?utf-8?B?eXVzbmFrRmt6aSt6dUMyQ3JoQlZ2ZFNLcWVndGozWnllK2ZzQXh3d3VoeXFx?=
 =?utf-8?B?ckZXUHppYVFNaEMrcVpYT2hpcVV6NTZvdmlJa1pNTG8xYmxCcjkzbVQwOEhq?=
 =?utf-8?B?L0FHdUlTRWZuNUJuWWhuNmxFUCtRKzhEcWxacUl2amlwenQ3VG0wWm82MHh4?=
 =?utf-8?B?clo4MklKYnRnczhKcGgzQ0tiZHlxbjg0WkxvK1pkdjhJQWM4eHFRcUs0ZDVp?=
 =?utf-8?B?RjZ1cG1yWk01WUI4RC9RSXEweXpvZ25idXpiKzZ2TzhMZEZqZzFiQW1RdWZY?=
 =?utf-8?B?NUpHQ1NjWCtJYjBwYUdjTjUwK3ZTNGRSR2tpbFZKVVFvd2kvV0hRdGxaWTJv?=
 =?utf-8?B?VUhTL1pQS3JobFV1ci83SzV3eGIwaFNqQzNZVldObHdQNklWOHpWSXVWcWZZ?=
 =?utf-8?B?SjBNdzAvTWdJTWo5bUVOSUpSU2k4U2xPQWN0R0M0UnhENEIyc0pXVDZrekQy?=
 =?utf-8?B?L0hKM2VTTFhQZ2l3WUNHT251cFJza2JkRzlxWTRQSTVPNEY5ejBVNEdTSGZP?=
 =?utf-8?B?U3hXUjhnRXA2WjhzTnA5S2duSERzZmZoeGVCRE1FYzlPMmJKQ0tZd0JxSHpj?=
 =?utf-8?B?aTVWYXY5aThoVTAvdk9PenlRV2JzaTlJbnRwUkZwdzFJbmFudmsyek9Qbjhl?=
 =?utf-8?B?SmVPeHc2VHpVcTBMaXNaQUpEZ0UrYW9icXlpZ1BzWVFuNnZLRkZQaUNWcFJj?=
 =?utf-8?B?SU83WTErVGdFWVlOUUhHeWF5Wmg2dndpY1oyTGVDWDFQcE15MVdPc1dvcFNN?=
 =?utf-8?B?TzhBZmZDMXpZb09uZjhGT1VWSE5FU3U0bFhZZkRmYU5VUkx6Vi9sL25zYjVG?=
 =?utf-8?B?MFdFblBOcUowNXN5bDhGL003YWlrdktmVmQ0eWxiQm5vL0ttdDdOUDJ1VElW?=
 =?utf-8?B?c1NFTGlkUjBFVHlBTi9WZnQ3bzc3TmVFQ0lKNzdoWDJWM0JBNXFVclV4eURY?=
 =?utf-8?B?bGNSUFBMK0lEUndOdG1Dakd6MFExYkNxSGZNaFlaU1ZKam4wZERyeWNibGhv?=
 =?utf-8?B?MnV2YTlXSFlXSFFkYldFR2V0S0VsUG5ieXlsWjloTHdxZ0c5WmxlQUpGamVX?=
 =?utf-8?B?MWM0NHduNnVsNlp2YTM1M1RsakcvMXhwdkVjZUJjTlFHcm5QMTB6M093bE5k?=
 =?utf-8?B?a0pnWWNIZyt2YlB6azJNclRqdVY3U2tmdE5BNFhPZ2IxV1JZeGMvZldOUnpM?=
 =?utf-8?B?QVJWNU9qaVNxMkp4V1YvanBYSnV4SXk3bTREYkhEcVRaK013OWJlUmRkM25B?=
 =?utf-8?B?Z2xZL2o3a1Z6Q1NFMWxZOGRUanhpK3E0Q1NRS3dTajdoYUc5ZUx2QlhId3pD?=
 =?utf-8?B?bUdMMDBWU2xNVkkza1crNjNrQlMyTnZUOWdzekxsVkMzdnoxSkIrK2hrOW9T?=
 =?utf-8?B?NVRZR3IyTS9Ca1BwUnR3dS9ZS01qOGZvRm85NXljQy9qTlFDK1o5TmxmdnlM?=
 =?utf-8?B?MkRnZ3ZOTWR3OXAwcUZFVVlFLzQzdm4rQ0VEblgyZDNaUXdEeDYxL1UwVnF0?=
 =?utf-8?B?OGQxZzNZMFQ0OCt0NzdPTmJveHd3MFFlVUlWUHVLcEpobHQxMGJ1Q3ZCRXQ5?=
 =?utf-8?B?YU9lWmxEYzhwSEFJZGpUczBIWFd4alRTLzlpdi9vK29HM1BET0NTM3VCU0lT?=
 =?utf-8?B?Y0ZqS0ZpMHlzaVJJSDE5Rkk3U3M0SS9QSUVCdzAwR3ZNWDZ2d0x5RVdvSC9a?=
 =?utf-8?B?WmNrYjFpUlQyNHUzck1wQTVsUHk5V3BLYmZteHNzREtYc1dBUlZQK0dnb1NG?=
 =?utf-8?B?R2g2elFoZFpodFpHaE5kYjBHdVZoMU5QZzQzYWZRcE1LajljWlg3MXZmZ1p6?=
 =?utf-8?B?UG01dG5jczVJY2VtS1FLSGFLQk5KcG5raTA5anpqejRqL1E9PQ==?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YWtneGVrV0JjMWR0ZUhTbnZBMEE1MmE1bVdFTzNnK3B3SlRIK1hKbWJTdUtI?=
 =?utf-8?B?MU1NeFJCb09JMU5EcVZWTjJtQnhLR0dnSDBKRUJzRUtmd0RHOFIvQXZVT3V1?=
 =?utf-8?B?dU0wZ3JpaFZTMVB4MjVLTFJNLzVsUW96TEdlQXhic0l4Y2JPTU9LZlJ4QU1O?=
 =?utf-8?B?NXRZanp4K2FGaGFSdDV6WGN5OGMrZUdQSmlHd2x2c2xHbDl6WG1xcDMvWi9Y?=
 =?utf-8?B?alZXVzJCaEJqZm5hMWxIc1BLbUdnSW5hWUZ1NnpVZWJmN0VINllCZVZDWjNh?=
 =?utf-8?B?QnBZcWZCM0cvbFZZUWgrTkNEM1J5aWZEbUJtNXNmUCtnUmhPK3BvN3B5emZP?=
 =?utf-8?B?cVh2R3k3YzFTSmZCdnN4WVRES1RKaUlqR1JyTndtN0FzZyt3d0cxY2FPc280?=
 =?utf-8?B?TU5LWTJFZ2d1cUxoVTg1OXZjQnZYWFVMb3ZnQmU5QzNwa0FveXdlV3J2L3lB?=
 =?utf-8?B?Qml4ZmZiWXpVZDRJRWtLM0VhNnc0TndEVXFZeGtHSDZjcGVQaldXUjRCTU42?=
 =?utf-8?B?MkhycEsxUFpaeXROdnRoMGRlMlNlNzR5OWYyU0hmZjJUa2szSWZORU1HK2dq?=
 =?utf-8?B?WkNaT25CMEpWTzVPZzI4TEpibXFidmRPNmNaelBmRUNDNWRHc0Npa0pnUWps?=
 =?utf-8?B?bE1RWm5TV0NLN0tUZFhncUE3d3IyMXFWYlFEZTNWOWpIajd2N0pLbzFxcUE2?=
 =?utf-8?B?cFo2S3luZFdRQzE5dnh0ZUVMcWxwNzZldzJzZWxyaVBuK1l6Y1JBKzNuMGZj?=
 =?utf-8?B?b3ZXOHlKNWRuUDMyTXF2aG5EVEJXakdGSGc4SW9ZN3JBLzdsSDRUcjU3dXNI?=
 =?utf-8?B?NGdtYzVmcml1WUZKVTArMTVXVkRYcjdxbGhkNlJQTEhuaDN2aEtZc2IzTk5H?=
 =?utf-8?B?R0pvYWRoa09SZlBrOHpvNVBwaldmR2pxbVNidEJsSWZoU29jK0llWnlxQ0d3?=
 =?utf-8?B?Z3dZbUYwbW1YNlEzOVBUUWhMQllzWmI3SFQwZjY4ZmUxTzZYeTJjZm5jejdl?=
 =?utf-8?B?Rm85TktXVk5YYXpBeHB6T01iR2JwQ3lpRk5BaXZKK0hNek40SSsxa0ozbFpa?=
 =?utf-8?B?Q2x6SEY3L09ydDV0RjlKM0l0TkRReG5JT3l5WnlLZkV0dURDS0I2SExsZ0lT?=
 =?utf-8?B?VVNlSnZNYm9pYVJpUWovM3dRQUZOMjZUY3EwQnRjMDdIWXN4djJBd3dEUXdL?=
 =?utf-8?B?Y1VScncwUFhCYVY4SzlIVjI1U2llaXB2bElSZmxtNWczMmVFZE5ic05xUlJs?=
 =?utf-8?B?eGZDdDM0dTFGMm1ZdUdHSXVyZlkzaHZKRlMwSExua0RnYWttQ1FNRGlaUHF6?=
 =?utf-8?B?K2JOT29hYnJIZ0J5cUJPajZUQ2x2WE9yTWtnOHhKZE4yRytCbGxTS2hQSitM?=
 =?utf-8?B?cElxSjY2RVRFd3RuVmpvdlZuS3F6T01UOG1NcnNUZkthSlVtbVl6K3A1UnJI?=
 =?utf-8?B?ck1oaXFhVnRJa0Rmai9DdFFWZGFkRVZTcm8xWGQ3VU1RTXJNOFI4WjREM3h4?=
 =?utf-8?B?L2JQK3FMWEtPLzUvSUVUVUx2eHpydDNSRkc3Q0o2VUd5QmpWYTVENyt1WWt5?=
 =?utf-8?B?OSt5YVBnamJVS01uUTEwYUJDOTBjR2RzaGVHVDJOR0t1NW9vczRCa0kwVUI1?=
 =?utf-8?B?VzZQR3Roc2ZnSEI3SkthRWxoR1J1cWl2TUgzYjdNeGx4eEVvL013MmljMkkx?=
 =?utf-8?B?TUsvS3hYUTVUdG1vNTRoSW5pNWttaWQ3VlpabnZrenVhK1IvU1hmZHk0VTNu?=
 =?utf-8?B?VE9jZXdCQlVtVnh2QTVHS2xkRzBXeVZuYjBSYnZmWmFvMWFMaEkvTFhiTlVW?=
 =?utf-8?B?ZncrZG52YjIrUUZOVEhIVHhIdjZoVGdncTROWDZIR3ptS1h0dW1hY3A1MjhX?=
 =?utf-8?B?Zk4rT0tmQWRGUmhGY0dEL1FKd3V5UXlLVFVQYUwyMHg2OHZNbTQvbnRMeGRa?=
 =?utf-8?B?L2crbHhqcFpVc3U3ZE1pcjJ2SW52RDVJaHN2MGYzZVBGaVpEQmhGeEUzZVRI?=
 =?utf-8?B?TEJERHlPUDAzSlg4STVBU1ZIMXllek15R3NFN0VyU0xnMzU1cFZVQzFLR2Rl?=
 =?utf-8?B?T0YxNHFPaWhNSThoanZqMWlPZ2dUVmN4OWNUMDJOSzJuYjFWa01yMXIvdSs2?=
 =?utf-8?Q?X42c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FDE633940387447B4ED83A2B0F11C6D@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2454ec8-f525-4957-1cfc-08dcbc5534ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 11:35:32.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9rNYseKxRgxdgL0xhpF/jrXbS0+DJDXC01hHWU7C9IWHdT+cgdjqwXaHs/3Xu+oyQSLtMTiHVkLnNJNazTYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7348
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

5ZyoIDIwMjQvOC8xNCAxMDozNSwgR2FvIFhpYW5nIOWGmemBkzoNCj4gSGkgQ2h1bmhhaSwNCj4N
Cj4gT24gMjAyNC84LzEzIDE4OjI3LCBDaHVuaGFpIEd1byB3cm90ZToNCj4+IEFzIHRoZSBleHRy
YSBidmVjIHBhZ2VzIGFyZSBhbGxvY2F0ZWQgYW5kIGZyZWVkIGluIGEgc2hvcnQgdGltZSwgaXQg
Y2FuDQo+IEl0J2QgYmUgYmV0dGVyIHRvIGp1c3Qgc2ltcGxpZnkgdGhlIHN1YmplY3QNCj4gZXJv
ZnM6IGFsbG9jYXRlIGJ2cGFnZXMgZnJvbSByZXNlcnZlZCBidWZmZXIgcG9vbCBmaXJzdA0KR290
IGl0LiBJIHdpbGwgY2hhbmdlIGl0Lg0KDQo+PiByZWR1Y2UgdGhlIHBhZ2UgYWxsb2NhdGlvbiB0
aW1lIGJ5IGZpcnN0IGFsbG9jYXRpbmcgcGFnZXMgZnJvbSB0aGUNCj4+IHJlc2VydmVkIGJ1ZmZl
ciBwb29sIFsxXS4NCj4+DQo+PiBbMV0gVGhlIHJlc2VydmVkIGJ1ZmZlciBwb29sIGFuZCBpdHMg
YmVuZWZpdHMgYXJlIGRldGFpbGVkIGluDQo+IEFsdGhvdWdoIEkgY2FuIGltYWdpbmUgaXQgY291
bGQgaGF2ZSBzb21lIGJlbmVmaXRzLCBidXQgaWYgaXQncw0KPiBwb3NzaWJsZSwgY291bGQgeW91
IGdpdmUgc29tZSByZWFsIG51bWJlcnMgZm9yIHRoaXMgY29tbWl0IChhc3N1bWUNCj4gdGhhdCBp
dCdzIG5vdCBoYXJkKSBzbyB0aGF0IHdlIGNvdWxkIHJlY29yZCB0aGVtIGluIHRoZSBjb21taXQN
Cj4gbWVzc2FnZSBmb3Igb3RoZXIgcmVmZXJlbmNlPw0KSSBkbyBub3QgaGF2ZSBhIGdvb2QgbnVt
YmVyIGZvciBpdCBub3cuIFdoaWxlIHRoZSBtb2RpZmljYXRpb24gaXMgbWlub3IgDQphbmQgd2l0
aG91dCBhbnkgc2lkZSBlZmZlY3RzLiBJIHN1Z2dlc3QgdGhhdCB3ZSBtYWtlIHRoZSBjaGFuZ2Uu
DQoNClRoYW5rcywNCg0KPj4gY29tbWl0IDBmNjI3M2FiNDYzNyAoImVyb2ZzOiBhZGQgYSByZXNl
cnZlZCBidWZmZXIgcG9vbCBmb3IgbHo0DQo+PiBkZWNvbXByZXNzaW9uIikuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogQ2h1bmhhaSBHdW8gPGd1b2NodW5oYWlAdml2by5jb20+DQo+IFRoZSBwYXRj
aCBpdHNlbGYgbG9va3MgZ29vZCB0byBtZSB0aG8uDQo+DQo+IFRoYW5rcywNCj4gR2FvIFhpYW5n
DQo+DQo+PiAtLS0NCj4+ICAgIGZzL2Vyb2ZzL3pkYXRhLmMgfCAzICsrLQ0KPj4gICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9mcy9lcm9mcy96ZGF0YS5jIGIvZnMvZXJvZnMvemRhdGEuYw0KPj4gaW5kZXggYjk3OTUy
OWJlNWVkLi40MjhhYjYxN2UwZTQgMTAwNjQ0DQo+PiAtLS0gYS9mcy9lcm9mcy96ZGF0YS5jDQo+
PiArKysgYi9mcy9lcm9mcy96ZGF0YS5jDQo+PiBAQCAtMjMyLDcgKzIzMiw4IEBAIHN0YXRpYyBp
bnQgel9lcm9mc19idmVjX2VucXVldWUoc3RydWN0IHpfZXJvZnNfYnZlY19pdGVyICppdGVyLA0K
Pj4gICAgCQlzdHJ1Y3QgcGFnZSAqbmV4dHBhZ2UgPSAqY2FuZGlkYXRlX2J2cGFnZTsNCj4+ICAg
IA0KPj4gICAgCQlpZiAoIW5leHRwYWdlKSB7DQo+PiAtCQkJbmV4dHBhZ2UgPSBlcm9mc19hbGxv
Y3BhZ2UocGFnZXBvb2wsIEdGUF9LRVJORUwpOw0KPj4gKwkJCW5leHRwYWdlID0gX19lcm9mc19h
bGxvY3BhZ2UocGFnZXBvb2wsIEdGUF9LRVJORUwsDQo+PiArCQkJCQl0cnVlKTsNCj4+ICAgIAkJ
CWlmICghbmV4dHBhZ2UpDQo+PiAgICAJCQkJcmV0dXJuIC1FTk9NRU07DQo+PiAgICAJCQlzZXRf
cGFnZV9wcml2YXRlKG5leHRwYWdlLCBaX0VST0ZTX1NIT1JUTElWRURfUEFHRSk7DQoNCg0K
