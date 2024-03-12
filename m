Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF48794E2
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 14:15:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvDf45tTdz3dRp
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Mar 2024 00:15:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manchester.ac.uk (client-ip=2a01:111:f403:261b::700; helo=gbr01-cwx-obe.outbound.protection.outlook.com; envelope-from=gael.donval@manchester.ac.uk; receiver=lists.ozlabs.org)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:261b::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvDf12cZXz3bws
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Mar 2024 00:15:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UalctvCH1nXSaIXprNZgVdvF4Mf4UQlnUAmw0P6WcPYWv5rLOELxZ+fTQc89xDGLiOR0tr0wbCQ+7LQXkbyDNIJ01rDsuV9j5T4yU7aVxk08e4q/KwwEpKaS1vrA/aiacgGUsqVPrldybSY+W/sCrRVO3d04nz4VI43FePR8UAQ8ZcbYV5xiistkpqAJ8BRQ9h7/0SZ2mtqPCF8C9v9NTuofCWrWa6p2rP0bX5GC5rqc4pD8iH3yuN9JS6dZnLJv3jtDGF0Mw9DLAadNwb+kLYXPpDGN2/ZxlPIsHkfwy5NMfm8+QYcuYa7Irv5yDE0oGbF18AyE2jpygorgWhsGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z73XRFJ1Zg2tfElz398ZgMTbmZRcNgzP5DdipVgeUls=;
 b=IEfwNinNhklI7eT8g4AsPnLj8xKsxZzxSel9b34kSuE9akWNaRmexcKc2eztnfMYuZw2fZujF2d/Ni0HCeHEtOotWFnz1kR+IObGAYgaJBpHkUqKQlDAqA8qui/d0bRNHSRbVir1mVLd+Z+JZ6C78JpXBgbbd7uM14Ig0Ly2yrGYnYw0JUhwMQoXH+OHfpKJncgRpeVveTbBqnZ5qMSDdzFcLQ9XQOpTHHjfSUZIJyk3c726opu5LQWhwLayytdFUXrAn6yAfFriMvm6t3aoTZU88MuPVj6IRPBPxgKmxh3hkxlvUwKoPnZWJ5lDLwQG2Owbsn2dncsZwhwv5Qz0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::14)
 by LO4P265MB7324.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 13:14:56 +0000
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15]) by LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:14:55 +0000
From: Gael Donval <gael.donval@manchester.ac.uk>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Topic: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Index:  AQHadGOiPlVwdje8XEOnbl0bbKegWbEz69QAgAAALICAAAYPAIAACIKAgAAGmICAAAvJAIAACNOA
Date: Tue, 12 Mar 2024 13:14:55 +0000
Message-ID: <876af3499c628f385de3416788754cdb38962471.camel@manchester.ac.uk>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
	 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
	 <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
	 <691120bfed626b78cc1107166f2fd964ca23ce99.camel@manchester.ac.uk>
	 <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
	 <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
	 <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
In-Reply-To: <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6406:EE_|LO4P265MB7324:EE_
x-ms-office365-filtering-correlation-id: e903c116-87f9-4864-814e-08dc42966953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  u4ojTwUHf9VTGQ5KL/NN52NA9VPTW5D8BwI86L885qga1HLB1KYdyc1174NUrdOq5f+PIL9JMduNqQFEM99VviBwKINgm6yRidc0y5wqFiMyoGyus3KyjAbmKxHbO3pc5lBgTsSCGJ5Kxaajhv/11+BsWo8FYrmjgjQHIG/fFbqeqnCGejQbwhQ27RrAfPcaUU6+XaSP3fbYlIf77CARoVEONsT+D21hVYdtxrBechzpO3juvEvBafGc4gtBrH0ANYkqk7mUGl9DZopqOM5JpdgTo/K+71bxkBzexkplgMt8hbfWeUltU/7b4mztNFh7Lj03ukkqXT/WsnMFVebanp2AzDAea1J2TVWIVRgArd8jpccTkBzwA87iFYfdgWRrTAJyHRN6AtqSVJJek0qbpPj1d0ozA0mUYjMVm7QuAnpRRhF9tzAUGwRUAtA5qvrWMVW0ac89H8kYTc+4NKPZ54e8MaEMYiUYQNge/yl6fL7k2VHRNBavvp92Sm7BQjHbsBCD3oCfYqy3I3OGFeFoLg82G7kGzfxoEZAKFzGLVfau3s5+qhpiPGfOWTUS9oyUkMTAXYw5pynihJoYV22VgzIGWF61F/y1yh8QiptA36HwxbK2uBLDrJz7Kj7qJ2s2ATVmOmfWfe3suwkKfuMMJkM3SzcAmnMqQeUJKSb9o0o=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a0NoTVdnZVpVenJ0RUR6V2g2Ny9mUldwZ1Zqc3JrSXlCblA5aDBab0J6UmJN?=
 =?utf-8?B?RWg1YUZ3b2pUZzArUW1od3R5Sk5Zbk0ya1Npa0ErQ29CUXhjKyswVTNhMkZZ?=
 =?utf-8?B?WHZiT0YxVnpVSlF0MUlmbnhCKzdtSXZpYTMvUEpEN2VkRnlWMFduSGhBL2d4?=
 =?utf-8?B?amIwc0JleGFSTTY1blJ5YytwczF1MmlCb0lHT1phVnNvRThnQmVKVk5RMC9r?=
 =?utf-8?B?YXhQckM2YzM5ZlB1K1pUazMzeXZ1NmYvdTJiZE5yNmlkbjlqRUFhVkhUbUU2?=
 =?utf-8?B?ZVRHeWRhMXBFeHl3cU5HdGZnclI5R2lSVSs5MGl3cUFwQ01peWFBRHg4eElm?=
 =?utf-8?B?Z2lKNGVjMEYzaUNveE1NMytQV05NQ3pQTmprTTJldGkvdDRvTVZNK1JUcXB6?=
 =?utf-8?B?TVVnM3FiNktKZTVrWmxIWjdqeHpDcVpQTktKSWZDU2hzb3lvWEo4RUhCaG5l?=
 =?utf-8?B?RVVYdlhwamxPQktaRU1wbkhzVkg5TkZ6SGgvMXAwR1ZiTGxwNFBqeXlBMVJx?=
 =?utf-8?B?TWVkM1lBaHMydFBuZ0xKTEZVSS9sUFQxUy9OcWljcjVoSVBSc28xeERHTHMz?=
 =?utf-8?B?Vkk1S3NGcXJUTkZVdW5yNkZVbzhCWUxGbHhTa3VQL2JCVDZ6aEd4eWdTcVIx?=
 =?utf-8?B?WjhYZ2t5MmNya21MUUYrZE9jQzNxaGhJU3dEVWZOMHhFYnNFZDU2MlhVTlVy?=
 =?utf-8?B?OFRxdnpCeE4ybWhuWW1maGVycDd5OXJpYUNnSEx6eXoyREd4MWdZWGVkNXUw?=
 =?utf-8?B?bWdGZTNLWk4reDJKdzNBbDJmUFlWZGFyUHVBUlYrcXppZ1p0K3JKeXJXSGs2?=
 =?utf-8?B?cFY2TUFkUDlLOFcvN3FTNko0TlVleTBaZ3RrUDRLTnM4ZlZuTW90c3lQb005?=
 =?utf-8?B?ZUl2MFROSjhUTHgrUHIvUFpRVWJoZndmcnM3VGxyL2ZjWllXVG5WUFM3ZWtG?=
 =?utf-8?B?MS9CTlNacU8rSFZCVHB5cTMrQk55R1o2aXg1Wm1NUXFGSlhTUG91ZnBCREdX?=
 =?utf-8?B?eXI5WWloVHBpMnZ4a0Y2TUxMQkxaTjB0cklZb0JDamJYaE8xVUtzNmpNbzZi?=
 =?utf-8?B?N0VrbVV6N1RNUk9LYmtrVDRtWGRaUjZMblM1NDVnRlNjOCtJay8xWm02Q1lw?=
 =?utf-8?B?c2x1THFyV2xLeGVaS081c3BWVkFHY0RmbWFQRlNQWStqelRodENOenlhTDNl?=
 =?utf-8?B?TUdiODF6RG9uT0Z0NkE0VlRuSWJ6aUlXZHU2bGtuQWZvQXdBdVlUeEhKVFRE?=
 =?utf-8?B?TktiUjYxbGtxNkZGcldjL1k4U0JuWThINjhKTUpXWlN1L1BCUkpzWmVMMUln?=
 =?utf-8?B?SFl2UVdORzdVcFNWYXUyZGE5QXB1OVM3QStDV1hYVkNraVZ1R2ZqdHc5SzVm?=
 =?utf-8?B?N0k0SDVEcGpadmhMTlEyWEZJYzRURzNqOGphTVJEeVg0ODdSQU1WZXcyY1Ry?=
 =?utf-8?B?NHBPbGVVL0pSWVJpTGhpM1RlZFhMMDQxZm9IUVI4bHF2MDk0VWNFRGdLekFG?=
 =?utf-8?B?eC9GWnZuZGdLWVA0WnNaR1hybHZnNG1YVHMxYVYrVGdKTUo4YUFqNUd6WE1o?=
 =?utf-8?B?NkJwZXhYY3hmdnd0aDFHY2pSNXZhSnFGMmF2eTc5QVp2aStoZnpLWTVNNkZq?=
 =?utf-8?B?VkdTVi9nZ0hEM0FTdVloRUQ2T0RraThLQlhrbU1Hb3VMREx5dVUyTm1yQTdh?=
 =?utf-8?B?d2ZsYnl5cUptUWJraGdpb2RoaDBpbDVjb2dLc0JYcUwvWXFualRGck5JckRV?=
 =?utf-8?B?TUdwb3NaL1JsSHBqajZKbDFpNW9kOGVHQ1ZuNkZiZ2JzSGpQb3dWT3h1czhU?=
 =?utf-8?B?a3hzd040YkdMMy8zUUw3ZjRwWE9UWG5CZXY0a0F4dXhDd3hNdmxiL1c5M2ZM?=
 =?utf-8?B?Y05uTUtQM2dnWWVSbmd1NDl3aERPSHVtdzhieHlpQXp2Z3lEMTc5R3J6amVC?=
 =?utf-8?B?VzBTMk5NVWNoU2FueUhZYUFHUFNyYUlmTXdEbzE5WWcrODlWWlNhbzN6QTNE?=
 =?utf-8?B?bjRUVUJjSExnZUNaSDJ0cmRUdEVYcnNwdktYcVlrZ2cvblBuV05Ua1BvT3NU?=
 =?utf-8?B?NFpFZ3Z1QlhqVk43eVNvVllERmRZSk1ma2xGYWl5TlhLSDljRWxkdUlGVG5z?=
 =?utf-8?B?SVZ5WW5KRk4rYndOcFNqbnYxbWJhak5oNzlya2FRSkVNb2wwdFhyR1hlVTN2?=
 =?utf-8?Q?9g6p7fdksJs2zS+iJCwHjr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84F1E007350DDD4498223E000C2F5EAB@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e903c116-87f9-4864-814e-08dc42966953
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 13:14:55.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2/xE3C17vzwRDSPw/pPTWDZMt7AQZU/V47EHyaDCwSak7c1/VfKB63nvgCqrJqLtUHPzIuKyFZVc451P/PXjyHlsJVW0G3jhUoQxu5//5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7324
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

T24gVHVlLCAyMDI0LTAzLTEyIGF0IDIwOjQzICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IA0K
PiANCj4gT24gMjAyNC8zLzEyIDIwOjAxLCBHYWVsIERvbnZhbCB3cm90ZToNCj4gPiBPbiBUdWUs
IDIwMjQtMDMtMTIgYXQgMTk6MzcgKzA4MDAsIEdhbyBYaWFuZyB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAyMDI0LzMvMTIgMTk6MDcsIEdhZWwgRG9udmFsIHdyb3RlOg0KPiA+ID4g
PiA+IE9uIDIwMjQvMy8xMiAxODo0NCwgR2FvIFhpYW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGkg
R2FlbCwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gMjAyNC8zLzEyIDE3OjU3LCBHYWVs
IERvbnZhbCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRGVhciBsaXN0LA0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoCAkIG1rZGlyIGZvbyAmJiB0b3VjaCBmb28vYmFyICYm
IG1rZnMuZXJvZnMNCj4gPiA+ID4gPiA+ID4gZm9vLmVyb2ZzLmltZw0KPiA+ID4gPiA+ID4gPiBm
b28NCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoCBta2ZzLmVyb2ZzIDEuNy4xDQo+ID4gPiA+ID4g
PiA+IMKgwqDCoMKgwqAgPEU+IGVyb2ZzOiBmYWlsZWQgdG8gYnVpbGQgc2hhcmVkIHhhdHRyczog
W0Vycm9yDQo+ID4gPiA+ID4gPiA+IDYxXSBObw0KPiA+ID4gPiA+ID4gPiBkYXRhDQo+ID4gPiA+
ID4gPiA+IGF2YWlsYWJsZQ0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgIDxFPiBlcm9mczrCoMKg
wqDCoCBDb3VsZCBub3QgZm9ybWF0IHRoZSBkZXZpY2UgOiBbRXJyb3INCj4gPiA+ID4gPiA+ID4g
NjFdDQo+ID4gPiA+ID4gPiA+IE5vDQo+ID4gPiA+ID4gPiA+IGRhdGEgYXZhaWxhYmxlDQo+ID4g
PiA+ID4gPiA+IFRoYXQgaXMgYXQgYSBsb2NhdGlvbiBiYWNrZWQgYnkgQlRSRlMgKGJ0cmZzLXBy
b2dzDQo+ID4gPiA+ID4gPiA+IHY2LjcuMSkgb24NCj4gPiA+ID4gPiA+ID4ga2VybmVsIDYuOC4w
Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSWYgSSB1c2UgYSBUTVBGUy1zdXBwb3J0
ZWQgZm9sZGVyIGluc3RlYWQgYWxsIGdvZXMgd2VsbC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBPZiBjb3Vyc2UgKE5CICIteC0xIiksDQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgICQgbWtkaXIgZm9vICYmIHRvdWNoIGZvby9i
YXIgJiYgbWtmcy5lcm9mcyAteC0xDQo+ID4gPiA+ID4gPiA+IGZvby5lcm9mcy5pbWcNCj4gPiA+
ID4gPiA+ID4gZm9vDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBhbHNvIHdvcmtzIGJ1
dCBpcyBub3QgaG93IG1rZnMuZXJvZnMgaXMgbWVhbnQgdG8gd29yayBpbg0KPiA+ID4gPiA+ID4g
PiB0aGUNCj4gPiA+ID4gPiA+ID4gZ2VuZXJhbCBjYXNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IEN1cnJlbnRseSBJIGRvbid0IGhhdmUgc29tZSBCVFJGUyBlbnZpcm9ubWVudCwgSSBjb3VsZCBz
ZXQNCj4gPiA+ID4gPiA+IHVwDQo+ID4gPiA+ID4gPiBvbmUNCj4gPiA+ID4gPiA+IGxhdGVyLg0K
PiA+ID4gPiA+ID4gWWV0IGluIHBhcmFsbGVsIGNvdWxkIHlvdSBwcm92aWRlIGEgZnVsbCBtZXNz
YWdlIG9mDQo+ID4gPiA+ID4gPiAic3RyYWNlIG1rZnMuZXJvZnMgLXgtMSBmb28uZXJvZnMuaW1n
IGZvbyIgb24gQlRSRlMgdG9vPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHNvcnJ5LCBJIG1lYW50
ICJzdHJhY2UgbWtmcy5lcm9mcyBmb28uZXJvZnMuaW1nIGZvbyINCj4gPiA+ID4gDQo+ID4gPiA+
IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gSGVyZSBpdCBpcy4NCj4gPiA+ID4gDQo+ID4gPiANCj4g
PiA+IFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCBCVFJGUyBjb3VsZCBleHRyYWN0IHRoZWlyIGlu
dGVybmFsDQo+ID4gPiB4YXR0cnMgKCJpbm9kZSBwcm9wZXJ0aWVzIikgaW4gdGhlaXIgb3duIG5h
bWVzcGFjZSB3aGljaA0KPiA+ID4gZG9uJ3QgYmVsb25nIHRvIHRoZSBvcmlnaW5hbCBmaWxlIGl0
c2VsZiBsaWtlOg0KPiA+ID4gDQo+ID4gPiBYQVRUUl9CVFJGU19QUkVGSVggImNvbXByZXNzaW9u
IiAtPiBidHJmcy5jb21wcmVzc2lvbiA9IHpzdGQNCj4gPiA+IA0KPiA+ID4gSSB0aGluayBJIG5l
ZWQgdG8gaW50cm9kdWNlIHNvbWV0aGluZyB0byBmb3JtYWxseSBpZ25vcmUNCj4gPiA+IHRoZXNl
IHhhdHRycyBsaWtlOiBgLS14YXR0cnMtZXhjbHVkZT1wYXR0ZXJuYDoNCj4gPiA+IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5nbnUub3JnL3NvZnR3YXJlL3Rhci9tYW51
YWwvaHRtbF9ub2RlL0V4dGVuZGVkLUZpbGUtQXR0cmlidXRlcy5odG1sX187ISFQRGlINEVOZmpy
Ml9KdyFEcXVfdEgyelRfVEtFaEhOaTJDWlRvWWxtWUZlWmF5V0UxQlFWUWpaQlpxNGVnallTMWJB
VlM3QmFzUUo5QkVUSm9WSU5QRUItcDA2eTdpeklVbVdrLTJWbm9mT1Fad0xydyQNCj4gPiA+IMKg
wqBbZ251Wy5db3JnXQ0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBjb3VsZCB3b3JrIGJ1dCBhIG1v
ZGUgd2hlcmUgRVJPRlMga2VlcCB0aGUgWEFUVFJTIGl0DQo+ID4gcmVjb2duaXNlcyBhbmQgaWdu
b3JlIHRoZSBvbmVzIGl0IGRvZXNuJ3Qgd291bGQgcHJvYmFibHkgcHJvdmUNCj4gPiB1c2VmdWwN
Cj4gPiBpbiB0aGUgZ2VuZXJhbCBjYXNlLg0KPiA+IA0KPiA+IEkgd291bGQgc3VnZ2VzdCBhIC0t
c3RyaWN0LXhhdHRycyBtb2RlIGJlaGF2aW5nIGxpa2UgaXQgZG9lcyB0b2RheSwNCj4gPiByZXF1
aXJpbmcgZXhwbGljaXQgLS14YXR0cnMtZXhjbHVkZSB0byB3aGl0ZWxpc3QgWEFUVFJTLg0KPiA+
IA0KPiA+IFRoZSBkZWZhdWx0IHdvdWxkIGJlIGEgcmVsYXhlZCBtb2RlIHdoZXJlIGlnbm9yZWQg
WEFUVFJTIGFyZQ0KPiA+IHJlcG9ydGVkDQo+ID4gb24gc3RkZXJyIGF0IElORk8gbGV2ZWwuIFdv
dWxkIHRoYXQgbWFrZSBzZW5zZSBhbmQgYmUgYWxyaWdodD8NCj4gDQo+IFllcywgYnV0IHRoYXQg
bmVlZHMgYSBuZXcgdmVyc2lvbiAobWF5YmUgZXJvZnMtdXRpbHMgMS44KSB0aG91Z2guDQoNCk9m
IGNvdXJzZSENCg0KPiANCj4gQWxzbyBJJ20gbm90IHN1cmUgaG93IHRhciAtLXhhdHRycyB3b3Jr
cyBmb3IgImJ0cmZzLmNvbXByZXNzaW9uIiwNCj4gZG9lcyBpdCBhbHNvIHdvcmsgaW4gYSByZWxh
eGVkIG1vZGU/IENvdWxkIHlvdSBnaXZlIG1vcmUgaW5wdXRzDQo+ICYgdHJpZXMgd2l0aCAidGFy
IC0teGF0dHJzIj8NCg0KVGFyIGp1c3Qgc3RvcmVzIFhBVFRSUyBhcyB0aGVpciBvd24gZmllbGQu
IFdoZW4gScKgDQoNCiAgICQgdGFyIC0teGF0dHJzIC1jZiBmb28udGFyIGZvbw0KDQphbmQgaW5z
cGVjdCB0aGUgdGFyIGZpbGUgaXQgYXBwZWFycyBYQVRUUlMgYXJlIHN0b3JlZCBhcyBhcmJpdHJh
cnkNClNDSElMWSBhdHRyaWJ1dGVzOg0KDQogICAuL1BheEhlYWRlcnMvZm9vMDAwMDY0NDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAyMDExNDU3NDAzMzIyMjAxMDc3Ng0KICAgeHVzdGFyMDAzMCBtdGlt
ZT0xNzEwMjQxNDI2LjQ1ODA5NzkxMQ0KICAgMzAgYXRpbWU9MTcxMDI0MTQyNi40NTgwOTc5MTEN
CiAgIDMwIGN0aW1lPTE3MTAyNDE0MjYuNDU4MDk3OTExDQogICAzOSBTQ0hJTFkueGF0dHIuYnRy
ZnMuY29tcHJlc3Npb249enN0ZA0KICAgZm9vLzAwMDA3NTUwMDAxNzUwMDAwMTc1MDAwMDAwMDAw
MDAwMTQ1NzQwMzMyMjIwMTE1NTENCiAgIDV1c3RhcjAwZ2RvbnZhbGdkb252YWwNCiAgIFsuLi5d
DQoNClNvIHRhciBibGluZGx5IHNlcmlhbGl6ZXMgZXZlcnl0aGluZy4NCg0KDQo+IA0KPiA+IA0K
PiA+IElzIHRoZXJlIGFueXRoaW5nIHRoZSBCVFJGUyBwZW9wbGUgY291bGQgZG8gdG8gbWFrZSB0
aGVpciBGUyBlYXNpZXINCj4gPiB0bw0KPiA+IHdvcmsgd2l0aD8NCj4gDQo+IE5vcGUsIEkgdGhp
bmsgaXQncyB1bnJlbGF0ZWQgdG8gQlRSRlMgYnV0IHN1Y2ggeGF0dHJzIGFyZSBhbG1vc3QNCj4g
bWVhbmluZ2xlc3MgZm9yIEVST0ZTIHRvIGtlZXAgKHNpbmNlIHRoZXkgYXJlIHRoZWlyIG93biB4
YXR0cnMuKQ0KDQpBaCB0aGF0J3MgaW50ZXJlc3RpbmcuDQoNCkkgc3VzcGVjdCB0aGF0IGluIHRo
aXMgaW5zdGFuY2UgdGhlIHhhdHRycyB3b3VsZCBub3QgYmUgdXNlZnVsIGF0IGFsbA0KYnV0IG90
aGVyIGNvbXBvbmVudHMgbGlrZSBTRUxpbnV4IHVzZXMgeGF0dHJzIHRvIHBlcmZvcm0gTUFDIGFu
ZCB3aG8NCmtub3dzIHdoYXQgb3RoZXIgeGF0dHJzLWJhc2VkIHNjaGVtZXMgZXhpc3Qgb3V0IHRo
ZXJlLi4uDQoNCldvdWxkIGl0IG1ha2Ugc2Vuc2UgdGhlbiB0byBkbyB3aGF0IHRhciBkb2VzIGFu
ZCBibGluZGx5IHNlcmlhbGl6ZSAoYW5kDQpleHBvc2UpIGV2ZXJ5dGhpbmcgYW5kIHByb3ZpZGUg
YSAtLXhhdHRycy1leGNsdWRlPXBhdHRlcm4gaW4gY2FzZQ0KcGVvcGxlIHdhbnQgc29tZXRoaW5n
IG1vcmUgZmluZS1ncmFpbmVkPw0KDQpUaGUgb25seSBtYWluIHByb2JsZW0gY3VycmVudGx5IGlz
IHRoYXQgZXJvZnMgdHJpZXMgdG8gYmUgc21hcnQgYWJvdXQNCnhhdHRycyBhbmQgZXJyb3JzIG91
dCB3aGVuIGl0IGRvZXMgbm90IGtub3cgYWJvdXQgc29tZXRoaW5nLiBJdCBzaG91bGQNCnJlYWxs
eSBiZSBtb3JlIGdyYWNlZnVsLg0KDQpUaGFua3MsDQpHYcOrbA0KDQoNCj4gDQo+IFRoYW5rcywN
Cj4gR2FvIFhpYW5nDQo+IA0KPiA+IA0KPiA+IEdhw6tsDQo+ID4gDQo+ID4gPiANCj4gPiA+IFRo
YW5rcywNCj4gPiA+IEdhbyBYaWFuZw0KPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBo
ZWxwLA0KPiA+ID4gPiBHYcOrbA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gDQoNCg==
