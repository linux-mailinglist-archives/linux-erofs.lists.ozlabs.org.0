Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC346821794
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 07:09:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704175773;
	bh=/vO3f7v+5bxGuuYyP6MNlrQtsP8VQpvE8NHutoaBMSg=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UNM3c3zM7j0bVxheZc8ZhnIh8HlzOrJlEmmpoYr4DcWPssT1auJ6y5aNFbm3d5oGu
	 Cj3JrQW0giyLAEMnBBs8YTrODpf4B2BIPFr4PH+9OqOAeeu+wFuWKMGhfrzLFvkcDl
	 ztEdpZ2IHxUC7lFJ5aL98lCJJfgBULKsDwXgVJK0aQH66zKAlCwLWmf9SbfI1iHJ2Z
	 BfV0b/H1ArMWq06WnGdT3ay1KaYJthrSTeeiZNu/hpaFbvpC5p1ZNrwcA+S2FHvqP0
	 /4q/s89RPDppkasOkbw4qC0fzaXxwZWQjgR5zatiQb/cqEOeEEWCrFviXS8dpKOTIa
	 LwLJeUJa9ko5Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T42W142jgz30gM
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 17:09:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=VPoyymOF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::710; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20710.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::710])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T42Vp5r2xz2xTP
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jan 2024 17:09:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij1pvbK/QRNAepcQcd9OjLSIjq4CpIlAI1D+gNJfMZkKr3ZCEWFI+SQGtZ556LgdF8AI2+hzYbixXL6vfdcTaAHf22XWbpX4vIgR51VAJX53IZXEMfvAbPhssB4VdhTlqCbhnggNsRWuIUavPSAcKg+AmXjoQfKrMu1kSof283oaQkSMkjNHlhLH449baPdvJzcbCNDDdXF/OWGri+6FjnNjpMm2vFTcZ9enq7fgDQIv5hnmNpCi57nz76DJBNyReR4YNCITNas47/vqPep/9W5lHLmhpmF3AKT/ZVuPlnunAxAj+71IDxnRLJiKqeTf2svAy4uoKGB/A7XVOM2Q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vO3f7v+5bxGuuYyP6MNlrQtsP8VQpvE8NHutoaBMSg=;
 b=ZkDyKhsEP57W0RwJIqmyeJYtIjpeAihfR6SRqvsf9KxcV6f6wpnD6kdVi+kXDcAgipFOW+V/rH/rtKPYST08P+lHgRewK6utVk41UHq593vyrgZCyoszdIGKmyiLJPQdLzls1lvsecSU4VkYdrRAyHNe6Ki+imB3HC2NQHiJKh7DMrw48AJG5YOgY30/DhDQ0layxwuAeEA9a2x+TwYW740FyLlI8MDxTVzVmrG2SwCyg7ccQNDJ0bk6J7TKIyrc/D/4cRQTrW/ZDtj/CPDVBNXekdx+A3tYX+ul4pWWCg8Hh1PVvJ5Gnnapda3Vj2Qd6J4K4ACKpGTRJpy6/GlmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB7611.apcprd06.prod.outlook.com (2603:1096:405:e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:08:56 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 06:08:56 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chunhai Guo
	<guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH] erofs: add a global page pool for lz4 decompression
Thread-Topic: [PATCH] erofs: add a global page pool for lz4 decompression
Thread-Index: AQHaOYx+qitU2c/r4Uu/EPUCb2da77C+2jYAgADXPoCAAudkgIAD3aSA
Date: Tue, 2 Jan 2024 06:08:56 +0000
Message-ID:  <TY2PR06MB33423281620002D2FCA6FF7CBE61A@TY2PR06MB3342.apcprd06.prod.outlook.com>
References: <96632ab5-3748-4512-aeae-2e931ff14674@linux.alibaba.com>
 <20231229044833.2026565-1-guochunhai@vivo.com>
 <d40f429a-0e8e-4e03-97c7-b260bf827530@linux.alibaba.com>
In-Reply-To: <d40f429a-0e8e-4e03-97c7-b260bf827530@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: TYSPR06MB7163.apcprd06.prod.outlook.com
 (15.20.7159.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3342:EE_|TYZPR06MB7611:EE_
x-ms-office365-filtering-correlation-id: 2b4e797a-9c88-4d17-0fbb-08dc0b594db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8kG4DTuSTzyosE+MvNVS+MAJ2HfWVdQPALYY6oWG0oAQdS+OKzmfr2D5o7H2XZJCYWzA3WxFfYYqIRqkW6HCDwp4R2KWM/14ZOQrqDBUWCiZ0F4K3n5rNgz4CcEqhpKJuFaehVQ9lbsU5YP1l9QawoXK4eoIiK5PgVO7ZZwzU4xnzp80FdAUjp/WIjPxCC+tAL6jTtfqWX6eU6TEg+6dTlwRKyjFzC7Lb9j9IbYgMz5o7DjaV29xoGeNCn8N4Ru3814VdoR6XQEqyCzpVTOmTfyhwSc2+acuW8JdAcYw5n7GpW8qmVXkKUkMis23AjmjMNUOWuoGGlsIKOHx7pMmW+Pk4ijRrA69WhIB+feiH6upf+Bgp4+02Jl0/Z6qsl5n9bxArWQ7EvpL1YcbjJ0ykrtr0twjfDIvXDNrVSEtU+TBii91Y+ZlOnWpEskfn2SBlpSdm7JkjvnB0Z9oBK4pDMWPW/4gAnHu/kbM56drmAPNkETFUhHArThmbt0k+HdeyY5cFzTCD1S2OlaB3yNLRqB8OgqaS4jG22bVPcwyeaMiky/Dtzzy7Vu0kE4Eb9cOME5Y0xMkrYN/EeyiSjXYVLxR8cmqnikQjVk+pCA0ygCDtIenOd5DuGRzjw4EDGMBdBN8u4lrAmEKOQOQ7v6wZw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(38100700002)(122000001)(8676002)(5660300002)(8936002)(52536014)(316002)(110136005)(54906003)(4326008)(2906002)(41300700001)(71200400001)(966005)(53546011)(6506007)(9686003)(64756008)(7696005)(66476007)(66946007)(66446008)(76116006)(478600001)(66556008)(38070700009)(33656002)(55016003)(81742002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a25QUDY2NTVSWlNRWHFWbGRjNjBMdHBQK3NaM3JMTUVmTC9KUzVCRFNscXpw?=
 =?utf-8?B?ZS9FSUF1WC95QnJvMnFIWm10Y3RKZEJwWGt1SFpGbnZQMjZtWGx6VktSV0lh?=
 =?utf-8?B?SHZoKzNHRldtZUc4b3NyTjhod0V0SHVrZ2VwMlBPK0hiYjMwQlo4N2sxSkxq?=
 =?utf-8?B?a3lYVi9sMVFjN0U1cFpKSDlNSUhvUVJ5Qk42TzZucmdZWTA4QzZMS2lncFZB?=
 =?utf-8?B?Rm1QcGlhRGE1STdDYVRuOWVERHp1T0hqS1R4YVZBVzFQc3BRUjB0L3VrWm9w?=
 =?utf-8?B?UGpiQ3BpZUhpOFNISkltZDRDeTZTbE14dk80TW9ORGFmYS9hd29zMDAzMWxw?=
 =?utf-8?B?REg0MVQ2cVgzd1hhVEtyM2NyY2ZKVG9aK3k0S3JhUWJQam4yUGFUdWJucE1l?=
 =?utf-8?B?OWg5YmJDYlRrOEJwY0NTVk43S2tvWjJhUU9PY2dwTGw4RzdLdWVmYlJLYnc3?=
 =?utf-8?B?OEpnTUVndkdBOEJHT09pU3dyL1daN004NldXaUY5MTU5Vm11c0dlVDV2SzNI?=
 =?utf-8?B?RWlXWXJIWUFDZTEzVjNxcGh5R3ZtQjcyWkd3V0xzTEtkK3lZVTNjbnltWDNH?=
 =?utf-8?B?aGRJLzBHMWUrUmJRQ0h2bENIbVlHM1JsbFh1aFpyZ29NTHdUVEovOGhRU05B?=
 =?utf-8?B?RDQ2dmp3S3p1N3VpL2hCeUs1Q2N5bkt0dkhJUzJ4SVVTT1hab2VvWDZvdXJN?=
 =?utf-8?B?bC9XbnZSN29XMUtucWpMTmJvTUltZlVSUjk4NEszelBLK0g2QWFKOHp1OXlo?=
 =?utf-8?B?UysyaVgvaitndGFZc3JSWHZMaXVYV1JCNmUyNW5ZakJXYzZoOWlMT04zTjBW?=
 =?utf-8?B?Zm5ORC94a3dSY2RPL0JHb1J0aGVvaDNIajhudlJxdGVDQ1N0UlJKMngrZThn?=
 =?utf-8?B?ajhDQmEyY2FaRmpZTUFNQW9CaEhkd09wUkRkbllxblkwZE9VR3lvNG45Mjdu?=
 =?utf-8?B?bE5WZ3plRHEyUDVvbGo5WlRFYmFaakh5QVE4LytJdjhwTzgySnZhK2pCQU9s?=
 =?utf-8?B?NlkxeS9WWHBhcGZQWmxDdWNrbENKWlVqSCthdUNUay9FdTNDdDBCbnBwSTkx?=
 =?utf-8?B?ZFE5NDJXUzJjd0hXNzFWbHVGa241Y05zOHIzcmJsSVFhSVN6Y1E4eDFsdFdH?=
 =?utf-8?B?SkNDTk1KVEdkaEJFekVLTE9MbHFmbElnUWFsOWJiVkwzTjRDU2FYYmZJb1p1?=
 =?utf-8?B?QUYyUVRvWHRSVGdqeGd3R09UV1BFVFJqQlNJSGRYOVJ6allvTit1VlJRV1lF?=
 =?utf-8?B?aTNQR0lCRzZaNFpWWHM2NExGR29SNGlaT3ZjWUtVMEVwVXFSa0tPajVtb2Fs?=
 =?utf-8?B?VnJTTmFTMElVM0kyMGpnZHV3MFQ5L2M5encvYjIrWUNZYVpQZDVFR0x6WHlt?=
 =?utf-8?B?SEpJcFRZMWk2K2UxK2xvRGxmNFErb3pNZUlhcGN4THM4bEZtSlZhbDJla0Nv?=
 =?utf-8?B?d1lqc1hzaXdoM1pDYlpGSDhBUHN2L2xaR2k2N1VGQ21lanVlT2g4eUV0bmNT?=
 =?utf-8?B?SnA4VEV4bjZ1YTgxaGtvZWlyUkF4VThoRU8zWitTZEViU21mTkZkNFRtWWRz?=
 =?utf-8?B?cjBtdzFzenBxSGNGYWtuUG42QUs4V0I4ODMzUFI4N1hOVlNkUGVZVHZpRElC?=
 =?utf-8?B?by9DVCtvZnh2U293K3pIcHFRR1hxRFY5NHdxdG1NbDFOWUs1THRkS3NrQzlD?=
 =?utf-8?B?U2FQNDFsWW1BZlprZURBLy9FTnk0Ync3RlBuYVNpakFmcDBDVXZXTFZHbTJn?=
 =?utf-8?B?ZG5rRktoeElOVGl4MzNubW9kSnJhbTh1TUNCdnNEWnB3S2QzNm85TEdWK1Np?=
 =?utf-8?B?RG0rTXVhUGkwZ2poWmR2aDZDeWU0Zk5wanoreXB5cmpFWmNBNGlldDZiblRQ?=
 =?utf-8?B?ZkJ4b2tTSUJQWC9vcEgxRUUrT25yUStNRXB5L0lhdENLdGVyTW5jT2ErWmdH?=
 =?utf-8?B?bWhZZXhlek8xa2w3ZGhWWU1peGp4MytsN1ZHcWRXNXpIdHoyVVhlRnBlVEwz?=
 =?utf-8?B?dmJ6S21LUUJieWcwU2dCS3Jobnl2TmRXanVJUWRjMlVJbllzY0ZDdFJIZEF3?=
 =?utf-8?B?WDIzTkY0dUl3VGJrVjZ3WlBnYkxJb3doOUR6eXFPa3Q5dUFoOTR1UlBrUVFT?=
 =?utf-8?Q?HXuA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <503B669A2D391347A7660E673805D69B@vivo0.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e797a-9c88-4d17-0fbb-08dc0b594db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 06:08:56.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0CnGqK/y3xF/FvzSkikagEWOrV2ds1wFqv0cSYLJhCQ+uE48sOGws3rtfKvOSZ3yrcoqakB2DUg6PoVz1AhE9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7611
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

DQpPbiAyMDIzLzEyLzMxIDk6MDksIEdhbyBYaWFuZyB3cm90ZToNCj4gW+S9oOmAmuW4uOS4jeS8
muaUtuWIsOadpeiHqiBoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20g55qE55S15a2Q6YKu5Lu2
44CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
bu+8jOS7peS6huino+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeimgV0NCj4NCj4gT24gMjAyMy8x
Mi8yOSAxMjo0OCwgQ2h1bmhhaSBHdW8gd3JvdGU6DQo+Pj4gSGkgQ2h1bmhhaSwNCj4+Pg0KPj4+
IE9uIDIwMjMvMTIvMjggMjE6MDAsIENodW5oYWkgR3VvIHdyb3RlOg0KPj4+PiBVc2luZyBhIGds
b2JhbCBwYWdlIHBvb2wgZm9yIExaNCBkZWNvbXByZXNzaW9uIHNpZ25pZmljYW50bHkgcmVkdWNl
cw0KPj4+PiB0aGUgdGltZSBzcGVudCBvbiBwYWdlIGFsbG9jYXRpb24gaW4gbG93IG1lbW9yeSBz
Y2VuYXJpb3MuDQo+Pj4+DQo+Pj4+IFRoZSB0YWJsZSBiZWxvdyBzaG93cyB0aGUgcmVkdWN0aW9u
IGluIHRpbWUgc3BlbnQgb24gcGFnZSBhbGxvY2F0aW9uDQo+Pj4+IGZvcg0KPj4+PiBMWjQgZGVj
b21wcmVzc2lvbiB3aGVuIHVzaW5nIGEgZ2xvYmFsIHBhZ2UgcG9vbC4NCj4+Pj4gVGhlIHJlc3Vs
dHMgd2VyZSBvYnRhaW5lZCBmcm9tIG11bHRpLWFwcCBsYXVuY2ggYmVuY2htYXJrcyBvbiBBUk02
NA0KPj4+PiBBbmRyb2lkIGRldmljZXMgcnVubmluZyB0aGUgNS4xNSBrZXJuZWwuDQo+Pj4+ICst
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tKw0K
Pj4+PiB8ICAgICAgICAgICAgICB8IHcvbyBwYWdlIHBvb2wgfCB3LyBwYWdlIHBvb2wgfCAgZGlm
ZiAgIHwNCj4+Pj4gKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LSstLS0tLS0tLS0rDQo+Pj4+IHwgQXZlcmFnZSAobXMpIHwgICAgIDM0MzQgICAgICB8ICAgICAg
MjEgICAgICB8IC05OS4zOCUgfA0KPj4+PiArLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLSsNCj4+Pj4NCj4+Pj4gQmFzZWQgb24gdGhlIGJlbmNo
bWFyayBsb2dzLCBpdCBhcHBlYXJzIHRoYXQgMjU2IHBhZ2VzIGFyZSBzdWZmaWNpZW50DQo+Pj4+
IGZvciBtb3N0IGNhc2VzLCBidXQgdGhpcyBjYW4gYmUgYWRqdXN0ZWQgYXMgbmVlZGVkLiBBZGRp
dGlvbmFsbHksDQo+Pj4+IHR1cm5pbmcgb24gQ09ORklHX0VST0ZTX0ZTX0RFQlVHIHdpbGwgc2lt
cGxpZnkgdGhlIHR1bmluZyBwcm9jZXNzLg0KPj4+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLiBJIGhh
dmUgc29tZSBxdWVzdGlvbnM6DQo+Pj4gICAgIC0gd2hhdCBwY2x1c3RlciBzaXplcyBhcmUgeW91
IHVzaW5nPyA0ayBvciBtb3JlPw0KPj4gV2UgY3VycmVudGx5IHVzZSBhIDRrIHBjbHVzdGVyIHNp
emUuDQo+Pg0KPj4+ICAgICAtIHdoYXQgdGhlIGRldGFpbGVkIGNvbmZpZ3VyYXRpb24gYXJlIHlv
dSB1c2luZyBmb3IgdGhlIG11bHRpLWFwcA0KPj4+ICAgICAgIGxhdW5jaCB3b3JrbG9hZD8gU3Vj
aCBhcyBDUFUgLyBNZW1vcnkgLyB0aGUgbnVtYmVyIG9mIGFwcHMuDQo+PiBXZSByYW4gdGhlIGJl
bmNobWFyayBvbiBBbmRyb2lkIGRldmljZXMgd2l0aCB0aGUgZm9sbG93aW5nIGNvbmZpZ3VyYXRp
b24uDQo+PiBJbiB0aGUgYmVuY2htYXJrLCB3ZSBsYXVuY2hlZCAxNiBmcmVxdWVudGx5LXVzZWQg
YXBwcywgYW5kIHRoZSBjYW1lcmEgYXBwDQo+PiB3YXMgdGhlIGxhc3Qgb25lIGluIGVhY2ggcm91
bmQuIFRoZSByZXN1bHRzIGluIHRoZSB0YWJsZSBhYm92ZSB3ZXJlDQo+PiBvYnRhaW5lZCBmcm9t
IHRoZSBsYXVuY2hpbmcgcHJvY2VzcyBvZiB0aGUgY2FtZXJhIGFwcC4NCj4+ICAgICAgICBDUFU6
IDggY29yZXMNCj4+ICAgICAgICBNZW1vcnk6IDhHQg0KPiBJdCdzIHRoZSBhY2N1bXVsYXRlZCB0
aW1lIG9mIGNhbWVyYSBhcHAgZm9yIGFsbCByb3VuZHMgb3IgdGhlIGF2ZXJhZ2UNCj4gdGltZSBv
ZiBjYW1lcmEgYXBwIGZvciBlYWNoIHJvdW5kPw0KDQpJdCdzIHRoZSB0aGUgYXZlcmFnZSB0aW1l
IG9mIGNhbWVyYSBhcHAgZm9yIGVhY2ggcm91bmQuDQoNCj4+Pj4gVGhpcyBwYXRjaCBjdXJyZW50
bHkgb25seSBzdXBwb3J0cyB0aGUgTFo0IGRlY29tcHJlc3Nvciwgb3RoZXINCj4+Pj4gZGVjb21w
cmVzc29ycyB3aWxsIGJlIHN1cHBvcnRlZCBpbiB0aGUgbmV4dCBzdGVwLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2aXZvLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICAgICBmcy9lcm9mcy9jb21wcmVzcy5oICAgICB8ICAgMSArDQo+Pj4+ICAgICBmcy9l
cm9mcy9kZWNvbXByZXNzb3IuYyB8ICA0MiArKysrKysrKysrKystLQ0KPj4+PiAgICAgZnMvZXJv
ZnMvaW50ZXJuYWwuaCAgICAgfCAgIDUgKysNCj4+Pj4gICAgIGZzL2Vyb2ZzL3N1cGVyLmMgICAg
ICAgIHwgICAxICsNCj4+Pj4gICAgIGZzL2Vyb2ZzL3V0aWxzLmMgICAgICAgIHwgMTIxICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgIDUgZmlsZXMgY2hh
bmdlZCwgMTY1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYg
LS1naXQgYS9mcy9lcm9mcy9jb21wcmVzcy5oIGIvZnMvZXJvZnMvY29tcHJlc3MuaCBpbmRleA0K
Pj4+PiAyNzk5MzNlMDA3ZDIuLjY3MjAyYjk3ZDQ3YiAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvZXJv
ZnMvY29tcHJlc3MuaA0KPj4+PiArKysgYi9mcy9lcm9mcy9jb21wcmVzcy5oDQo+Pj4+IEBAIC0z
MSw2ICszMSw3IEBAIHN0cnVjdCB6X2Vyb2ZzX2RlY29tcHJlc3NvciB7DQo+Pj4+ICAgICAvKiBz
b21lIHNwZWNpYWwgcGFnZS0+cHJpdmF0ZSAodW5zaWduZWQgbG9uZywgc2VlIGJlbG93KSAqLw0K
Pj4+PiAgICAgI2RlZmluZSBaX0VST0ZTX1NIT1JUTElWRURfUEFHRSAgICAgICAgICAgICAoLTFV
TCA8PCAyKQ0KPj4+PiAgICAgI2RlZmluZSBaX0VST0ZTX1BSRUFMTE9DQVRFRF9QQUdFICAgKC0y
VUwgPDwgMikNCj4+Pj4gKyNkZWZpbmUgWl9FUk9GU19QT09MX1BBR0UgICAgICAgICAgICAoLTNV
TCA8PCAyKQ0KPj4+Pg0KPj4+PiAgICAgLyoNCj4+Pj4gICAgICAqIEZvciBhbGwgcGFnZXMgaW4g
YSBwY2x1c3RlciwgcGFnZS0+cHJpdmF0ZSBzaG91bGQgYmUgb25lIG9mIGRpZmYNCj4+Pj4gLS1n
aXQgYS9mcy9lcm9mcy9kZWNvbXByZXNzb3IuYyBiL2ZzL2Vyb2ZzL2RlY29tcHJlc3Nvci5jIGlu
ZGV4DQo+Pj4+IGQwOGE2ZWUyM2FjNS4uNDFiMzRmMDE0MTZmIDEwMDY0NA0KPj4+PiAtLS0gYS9m
cy9lcm9mcy9kZWNvbXByZXNzb3IuYw0KPj4+PiArKysgYi9mcy9lcm9mcy9kZWNvbXByZXNzb3Iu
Yw0KPj4+PiBAQCAtNTQsNiArNTQsNyBAQCBzdGF0aWMgaW50IHpfZXJvZnNfbG9hZF9sejRfY29u
ZmlnKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+Pj4+ICAgICAgICAgc2JpLT5sejQubWF4X2Rp
c3RhbmNlX3BhZ2VzID0gZGlzdGFuY2UgPw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRElWX1JPVU5EX1VQKGRpc3RhbmNlLCBQQUdFX1NJWkUpICsgMSA6DQo+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBMWjRfTUFYX0RJU1RB
TkNFX1BBR0VTOw0KPj4+PiArICAgICBlcm9mc19nbG9iYWxfcGFnZV9wb29sX2luaXQoKTsNCj4+
Pj4gICAgICAgICByZXR1cm4gZXJvZnNfcGNwdWJ1Zl9ncm93c2l6ZShzYmktPmx6NC5tYXhfcGNs
dXN0ZXJibGtzKTsNCj4+Pj4gICAgIH0NCj4+Pj4NCj4+Pj4gQEAgLTExMSwxNSArMTEyLDQyIEBA
IHN0YXRpYyBpbnQgel9lcm9mc19sejRfcHJlcGFyZV9kc3RwYWdlcyhzdHJ1Y3Qgel9lcm9mc19s
ejRfZGVjb21wcmVzc19jdHggKmN0eCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgdmlj
dGltID0gYXZhaWxhYmxlc1stLXRvcF07DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGdl
dF9wYWdlKHZpY3RpbSk7DQo+Pj4+ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4+PiAtICAg
ICAgICAgICAgICAgICAgICAgdmljdGltID0gZXJvZnNfYWxsb2NwYWdlKHBhZ2Vwb29sLA0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgdmljdGltID0gZXJvZnNfYWxsb2NwYWdlX2Zvcl9kZWNt
cHIocGFnZXBvb2wsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBHRlBfS0VSTkVMIHwNCj4+Pj4gX19HRlBfTk9GQUlMKTsNCj4+PiBGb3IgZWFj
aCByZWFkIHJlcXVlc3QsIHRoZSBleHRyZW1lIGNhc2UgaGVyZSB3aWxsIGJlIDE1IHBhZ2VzIGZv
ciA2NGsgTFo0IHNsaWRpbmcgd2luZG93ICg2MGsgPSA2NGstNGspLiBZb3UgY291bGQgcmVkdWNl
DQo+Pj4gTFo0IHNsaWRpbmcgd2luZG93IHRvIHNhdmUgbW9yZSBwYWdlcyB3aXRoIHNsaWdodCBj
b21wcmVzc2lvbiByYXRpbyBsb3NzLg0KPj4gT0ssIHdlIHdpbGwgZG8gdGhlIHRlc3Qgb24gdGhp
cy4gSG93ZXZlciwgYmFzZWQgb24gdGhlIGRhdGEgd2UgaGF2ZSwgOTclIG9mDQo+PiB0aGUgY29t
cHJlc3NlZCBwYWdlcyB0aGF0IGhhdmUgYmVlbiByZWFkIGNhbiBiZSBkZWNvbXByZXNzZWQgdG8g
bGVzcyB0aGFuIDQNCj4+IHBhZ2VzLiBUaGVyZWZvcmUsIHdlIG1heSBub3QgcHV0IHRvbyBtdWNo
IGhvcGUgb24gdGhpcy4NCj4gWWVzLCBidXQgSSdtIG5vdCBzdXJlIGlmIGp1c3QgMyUgb2YgY29t
cHJlc3NlZCBkYXRhIGRlbm9kZXMgdGhlIG1ham9yaXR5IG9mDQo+IGxhdGVuY2llcy4gIEl0J2Qg
YmUgYmV0dGVyIHRvIHRyeSBpdCBvdXQgYW55d2F5Lg0KDQpPSywgd2Ugd2lsbCBkbyB0aGUgdGVz
dCBvbiB0aGlzLg0KDQo+DQo+Pj4gT3IsIGhlcmUgX19HRlBfTk9GQUlMIGlzIGFjdHVhbGx5IHVu
bmVjZXNzYXJ5IHNpbmNlIHdlIGNvdWxkIGJhaWwgb3V0IHRoaXMgaWYgYWxsb2NhdGlvbiBmYWls
ZWQgZm9yIGFsbCByZWFkYWhlYWQgcmVxdWVzdHMNCj4+PiBhbmQgb25seSBhZGRyZXNzIF9fcmVh
ZCByZXF1ZXN0c19fLiAgIEkgaGF2ZSBzb21lIHBsYW4gdG8gZG8NCj4+PiB0aGlzIGJ1dCBpdCdz
IHRvbyBjbG9zZSB0byB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuICBTbyBJIHdhcyBvbmNlIHRvIHdv
cmsgdGhpcyBvdXQgZm9yIExpbnV4IDYuOS4NCj4+IFRoaXMgc291bmRzIGdyZWF0LiBJdCBpcyBt
b3JlIGxpa2VseSBhbm90aGVyIG9wdGltaXphdGlvbiByZWxhdGVkIHRvIHRoaXMNCj4+IGNhc2Uu
DQo+Pg0KPj4+IEFueXdheSwgSSdtIG5vdCBzYXlpbmcgbWVtcG9vbCBpcyBub3QgYSBnb29kIGlk
ZWEsIGJ1dCBJIHRlbmQgdG8gcmVzZXJ2ZSBtZW1vcnkgYXMgbGVzcyBhcyBwb3NzaWJsZSBpZiB0
aGVyZSBhcmUgc29tZSBvdGhlciB3YXkgdG8gbWl0aWdhdGUgdGhlIHNhbWUgd29ya2xvYWQgc2lu
Y2UgcmVzZXJ2aW5nIG1lbW9yeSBpcyBub3QgZnJlZSAod2hpY2ggbWVhbnMgMSBNaUIgbWVtb3J5
IHdpbGwgYmUgb25seSB1c2VkIGZvciB0aGlzLikgRXZlbiB3ZSB3aWxsIGRvIGEgbWVtcG9vbCwg
SSB3b25kZXIgaWYgd2UgY291bGQgdW5pZnkgcGNwdWJ1ZiBhbmQgbWVtcG9vbCB0b2dldGhlciB0
byBtYWtlIGEgYmV0dGVyIHBvb2wuDQo+PiBJIHRvdGFsbHkgYWdyZWUgd2l0aCB5b3VyIG9waW5p
b24uIFdlIHVzZSAyNTYgcGFnZXMgZm9yIHRoZSB3b3JzdC1jYXNlDQo+PiBzY2VuYXJpbywgYW5k
IDEgTWlCIGlzIGFjY2VwdGFibGUgaW4gOEdCIGRldmljZXMuIEhvd2V2ZXIsIGZvciA5NSUgb2YN
Cj4+IHNjZW5hcmlvcywgNjQgcGFnZXMgYXJlIHN1ZmZpY2llbnQgYW5kIG1vcmUgYWNjZXB0YWJs
ZSBmb3Igb3RoZXIgZGV2aWNlcy4NCj4+IEFuZCB5b3UgYXJlIHJpZ2h0LCBJIHdpbGwgY3JlYXRl
IGEgcGF0Y2ggdG8gdW5pZnkgdGhlIHBjcHVidWYgYW5kIG1lbXBvb2wNCj4+IGluIHRoZSBuZXh0
IHN0ZXAuDQo+IEFueXdheSwgaWYgYSBnbG9iYWwgbWVtcG9vbCBpcyByZWFsbHkgbmVlZGVkLiAg
SSdkIGxpa2UgdG8gYWRkDQo+IHNvbWUgbmV3IHN5c2ZzIGludGVyZmFjZSB0byBjaGFuZ2UgdGhp
cyB2YWx1ZSAoYnkgZGVmYXVsdCwgMCkuDQo+IEFsc28geW91IGNvdWxkIHJldXNlIHNvbWUgb2Yg
c2hvcnRsaXZlZCBpbnRlcmZhY2VzIGZvciBnbG9iYWwNCj4gcG9vbCByYXRoZXIgdGhhbiBpbnRy
b2R1Y2UgYW5vdGhlciB0eXBlIG9mIHBhZ2VzLg0KDQpPSy4gSSB3aWxsIG1ha2UgYW5vdGhlciBw
YXRjaCBmb3IgdGhpcy4NCg0KVGhhbmtzLA0KDQo+DQo+IFRoYW5rcywNCj4gR2FvIFhpYW5nDQo=
