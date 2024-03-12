Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69487938A
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 13:01:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvC0x1rKzz3d4L
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 23:01:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manchester.ac.uk (client-ip=2a01:111:f403:261b::701; helo=gbr01-cwx-obe.outbound.protection.outlook.com; envelope-from=gael.donval@manchester.ac.uk; receiver=lists.ozlabs.org)
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:261b::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvC0r576kz2xYY
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Mar 2024 23:01:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDpBCtpmxD+Nwl82ebU2AQ/qDM6Ok6HqfsfYX5Em8Fb/PnNGUImOJuEN96OU3/spTrOQAygptKbSq+pHHedgvPVrcGyHomebFaIztftScMNxTuMz8rVNsUJuZXQTLMFERslnGL7ZYFoh0esPFTIWkKB2NZ8APy6lJmZXWtMFQXVgE42TB1PBIdRl+4epdZZL/bTmNWXM0CJ3SkPKkVKmEJP4Ri0qZOdKAa/oVnPIKfuNA9MK4OGmA2FAFMcNJEz2Zp9/UTuNB1/bAOs5wvXhozckkquPRYfnyP6yyxDhB+p20u7SXvPcYs5Yu4vnzk8d/PiyT4Gqfj7Wx3qIK/9zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2jcIA4+iOnjAXVSgjZz2d+mCoA1thi+2shAtMKd/qY=;
 b=D2FyEXvYtFbwGYcFS06oHS32tPaQG0lSOOEX7f9DnzlhT+pPNNY5BuGvkgzmQI0sG48Jr52j62vDkomaI1GNQqaDgydtz0F17Dbq7lXkDEBgpheR8HbJRA9c51DPxBU8ZIExXNGK6ye8i1z6sFuF92PpeehlP+KeE1HuECAraKZS+zPR52kR8+/7LIWAvdMHk79n3WNOArmGciVZQAcZR6NQ4NDgBbuYn/NHVM9gv37ww4GUNcjU6qvfmxyjh4QLPtT6eC1W3oAZYHkDzjYumSrYfOP2hV/T46N0CtvGmDT0o9ci7Hf5t08ODZa5PSIEFVBHgm/UerYbr4u4/T5D4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::14)
 by LO0P265MB6454.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 12:01:10 +0000
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15]) by LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 12:01:10 +0000
From: Gael Donval <gael.donval@manchester.ac.uk>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Topic: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Index: AQHadGOiPlVwdje8XEOnbl0bbKegWbEz69QAgAAALICAAAYPAIAACIKAgAAGmIA=
Date: Tue, 12 Mar 2024 12:01:10 +0000
Message-ID: <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
	 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
	 <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
	 <691120bfed626b78cc1107166f2fd964ca23ce99.camel@manchester.ac.uk>
	 <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
In-Reply-To: <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6406:EE_|LO0P265MB6454:EE_
x-ms-office365-filtering-correlation-id: 1a79976b-354b-449a-298c-08dc428c1b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  E7y1u9ClZtVro7CyxEqHkjzHL2HvCEfZUuTbFFV464MF8rT3Kdeo/dRVEu9DZtE9IKAcwhGPrQpfPFxgXUZaEtSA7auyxkq6BsDFfSR/dOMw6XYTjYpxyGm2ZyP5grT1PmOdtY8OrDbGRUSK55tAbKXz4C5VfOopCEICFDy8JW7XDvjfQ7KK0C21vtm81PT0ddvBwEyBsRjN2mACazRhPaFRfly3S08saIIFwvzvdcKHuTsdkx23T6bEUNy16EvOur3E8HzcCCUGXRmgSWnslFZQ/TckgADYm82JoirECVmeqhO8R/30TNSDJJJmvbBjH1C9pmOmyfid0PqsS5s4mpOaKgVV8XlvE+9AYMcmalW0VDlZBdKVc6Il0Q9gbfB982ZA2+pyNhPTtqaHyVK/d96jw8QiGlbq233owFfm4FQBX3KSFAk0anbT9+F4zeOp7MchJcgl3uW0xHs50LYeDfGzOchyAdtO69vWY8T5PBDSMIx8oe/7sX7o+qo19LDAbrBK78+jzgKD7NSJoVa9TWMGmNqWdgN3EcTawc1UNrcyub68hWm+EPSN9ijkSlvOxLTSRuc77u33/HN5Jmdvf8YQNxxW6FHaIa1BiCmnHhr7XgZUPjozL4iDnoxbuJenomlLgSP1Cwe4aaOS3yuPaJ7k08JMvAXv8Qy5gND/oGk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dDkrTzRtamlPMmlBTFBUS0tpSXBiRDlGRXlFMDlTVFkxRURpM1ZTWlBHb0FH?=
 =?utf-8?B?NWxDOHJ3R3EvVFl6TFZYUU52YlVURkNuTUMxekh3OVl5OTg4aldsdnpJUktr?=
 =?utf-8?B?Z1NKTVpsWjIxV3hZRXFKRGRjWThLaFpnUFVtdkRoTVRLNHFQZjVReXdtbnVO?=
 =?utf-8?B?eFB0bDRmTkpFMmNyRDlGUUlXWGdqSkVTNVFDL0Q5UHhFZnVHR3JFTzYxVHNk?=
 =?utf-8?B?ZXB0Qi9PemYzTEFzdDBCS3l3SGsxT1MyekhOVFpxWUF5MzZlbjdVK1hKQ3Mz?=
 =?utf-8?B?ZDk0SVJKMG1JcVQ1U2NWWDFqQ1ZmazVzMEZ0NDkxVi9yZDkrTGdlNUVvRnBm?=
 =?utf-8?B?UW1PNG9LNXo2RFZ0MnV3SHpMVWZIZlQvQk5Wc3l1VEwrbkFzeW4zZ0NIWEVu?=
 =?utf-8?B?bVRlK2tNL1lpdFZDQW1LOFI0QW04MW5CdEt2d0hYY1FwcTBxK0hRNkV4OUI5?=
 =?utf-8?B?U3FGR0hld3FpZnloRFBPUDVaM3hycnI5bDRrN202VWFSb3FYZGVLVXZtZngz?=
 =?utf-8?B?V3JLWGRzU2Exa1JRYVJ2NzV4OTUvUWNPSk9MOXVZdmhVZGo2cTN5VnZ3NFNE?=
 =?utf-8?B?a01FaU1kekViR280cUwvM2NPSVZucDRpL29uTXl6MVBFaTJ4UjJEaHpJWHlC?=
 =?utf-8?B?d2hFY2JTY3hrUGFVeFd1MytRZ1pWVE01VEE0cHJwZFh5QzViRUlFdW4vU2dj?=
 =?utf-8?B?Z2Urd1luTEw3eFlCbmkzVllDSENqdVNpNzM4RlBpYzFGcy9sQWtNQkV5UzhY?=
 =?utf-8?B?QUdyZmJWa2Y1UzhaRVROL3JEQUgwYTA3ZFMzR3JTbFdIUWw4RHlCdnM5bG9i?=
 =?utf-8?B?VEtXZzNsdWNEcWhzRDJrWGpDMHJxNG9UTEdyaHB2L0dGUTlCSnJzSnNja3hZ?=
 =?utf-8?B?Z25PcTBab3FxT2NqSjFBQjZOelZsVDY4RUM0d2daaFg0MGFJbkpUZi9XRHR6?=
 =?utf-8?B?OXpSckhXMUU4dTJpRlRBbnJDa09vUDhPaU03N3Boc0hZWHV1UENkL3lSbU1C?=
 =?utf-8?B?MlQ0aXFzMnc1OEtLWUEyc1loOXB1SkFMZ2hKRE4vajlzUzB0U2FYQTlHS0lk?=
 =?utf-8?B?Q1Y5NkpmOGp4bDJLTGZLVjRyTGgxVEpsNGJPNC9mM2FjcHNxYmh0SDNUSkI5?=
 =?utf-8?B?MlhoVzVxclNYTGpRZGsrZGc3L1pjYWwvbkt2andocTl0QlNZQmpIeU1pYWI1?=
 =?utf-8?B?V25Tdmh1NFJFYlBaUFRlK1NLNTVMOUFTcXdwTG5sV0x2VEhRWVltMHgwS3RW?=
 =?utf-8?B?MVpyRWNGUDFhUHY2bmI0aC9zQkVGQzJKK0VHdzlGV3hKT0NvWkowd083UERi?=
 =?utf-8?B?MDhvUmVTVDVEYStvZUNJc2s0QVhqNkptdzVLSzY2bnl4T3NWZFNUY2RtcFpQ?=
 =?utf-8?B?Y2V2NEw0RkNuWlY3WVlzdUtvNVV3YW02MFdnekdFQWFFcmZPZVUrUHBWK0M4?=
 =?utf-8?B?SnFVWFUyNFRkZEY4alZYV0FDT0dwNnd6SDhVdENyNWlrNlEvR0dHSnJNMGRJ?=
 =?utf-8?B?ZGQ0MTFUM2RHRG52dTJYOHBDTXBWS3QwZWdvbjRlL0RBTWRVR1RDOW5YVXV6?=
 =?utf-8?B?cXcxK0ZhRHNjbnljRFJQeXl0WXdpQTh2NlZ3Qzh5N3owNDJmQXZFVmJvdGkw?=
 =?utf-8?B?c3dVZ0NOc2ZGbUpCZVRKcUJzaGhNdHFhV3kxYnZEZVZ0MDlUaHRzWHVOMlRp?=
 =?utf-8?B?VEYvQVNXWkdKeE14SW5LMWdpbzZNUU1vNmt5eHhZemgxWElWd1I4c1JHbFFV?=
 =?utf-8?B?NUZzVW9hTVRxQy95YlpiM1o3T3YvbDNtQWNZaFM1SUQxcnJOemU0bjRkMjU4?=
 =?utf-8?B?SGQ1akJLSVA4SUVvUWNkL2pBcVhsNVRaZXRlcDluRkZuTWhrb0NYdU9qVjh6?=
 =?utf-8?B?MHVqUk03N1J3c2JoNWdZL1JLMUVKV2llK2FCbHNWY2UwUGNvanpTNkdHK0JK?=
 =?utf-8?B?R0VOdE9tOUNLaDVyeVF5bk94U0pDNTlGcFlXdnVaMk1tbDdleHZmVCtZb1Zt?=
 =?utf-8?B?bkRtZ1l3VVA0Zm1VazdsdjFkOTZkZlByQW1hNzZTRFJYS3J5SDViNm9pcGsx?=
 =?utf-8?B?Qm82UlQ2SXNUL2dUa2VZemRYWHJBbkYwdjJSdWc2SlJtaXphMk9FS1FmdXUx?=
 =?utf-8?B?MTNLUlJxQVpqaFJvRDk2WVIzWGorU2hpSktOY0g0eHRmZ1FyOE1HeGVVTVRr?=
 =?utf-8?Q?Fv7Z2y30SBsTjvD3x20MtxM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <193FD55EA8AA254682E6C8884EF60863@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a79976b-354b-449a-298c-08dc428c1b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 12:01:10.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EifBQANA8TGN8Nv8KZH6JIb2T36Vq2Sql+xCv+0JvSnNN4zGsg/orw/Xol4Hn7kBv1C3iFvNm0MMWp4PVbML79xKhj1mwErIt82rZUq4zyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6454
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

T24gVHVlLCAyMDI0LTAzLTEyIGF0IDE5OjM3ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IA0K
PiANCj4gT24gMjAyNC8zLzEyIDE5OjA3LCBHYWVsIERvbnZhbCB3cm90ZToNCj4gPiA+IE9uIDIw
MjQvMy8xMiAxODo0NCwgR2FvIFhpYW5nIHdyb3RlOg0KPiA+ID4gPiBIaSBHYWVsLA0KPiA+ID4g
PiANCj4gPiA+ID4gT24gMjAyNC8zLzEyIDE3OjU3LCBHYWVsIERvbnZhbCB3cm90ZToNCj4gPiA+
ID4gPiBEZWFyIGxpc3QsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqDCoMKgwqAgJCBta2RpciBm
b28gJiYgdG91Y2ggZm9vL2JhciAmJiBta2ZzLmVyb2ZzIGZvby5lcm9mcy5pbWcNCj4gPiA+ID4g
PiBmb28NCj4gPiA+ID4gPiDCoMKgwqDCoCBta2ZzLmVyb2ZzIDEuNy4xDQo+ID4gPiA+ID4gwqDC
oMKgwqAgPEU+IGVyb2ZzOiBmYWlsZWQgdG8gYnVpbGQgc2hhcmVkIHhhdHRyczogW0Vycm9yIDYx
XSBObw0KPiA+ID4gPiA+IGRhdGENCj4gPiA+ID4gPiBhdmFpbGFibGUNCj4gPiA+ID4gPiDCoMKg
wqDCoCA8RT4gZXJvZnM6wqDCoMKgwqAgQ291bGQgbm90IGZvcm1hdCB0aGUgZGV2aWNlIDogW0Vy
cm9yIDYxXQ0KPiA+ID4gPiA+IE5vDQo+ID4gPiA+ID4gZGF0YSBhdmFpbGFibGUNCj4gPiA+ID4g
PiBUaGF0IGlzIGF0IGEgbG9jYXRpb24gYmFja2VkIGJ5IEJUUkZTIChidHJmcy1wcm9ncyB2Ni43
LjEpIG9uDQo+ID4gPiA+ID4ga2VybmVsIDYuOC4wLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElm
IEkgdXNlIGEgVE1QRlMtc3VwcG9ydGVkIGZvbGRlciBpbnN0ZWFkIGFsbCBnb2VzIHdlbGwuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT2YgY291cnNlIChOQiAiLXgtMSIpLA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoMKgICQgbWtkaXIgZm9vICYmIHRvdWNoIGZvby9i
YXIgJiYgbWtmcy5lcm9mcyAteC0xDQo+ID4gPiA+ID4gZm9vLmVyb2ZzLmltZw0KPiA+ID4gPiA+
IGZvbw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGFsc28gd29ya3MgYnV0IGlzIG5vdCBob3cgbWtm
cy5lcm9mcyBpcyBtZWFudCB0byB3b3JrIGluIHRoZQ0KPiA+ID4gPiA+IGdlbmVyYWwgY2FzZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCj4gPiA+ID4gDQo+
ID4gPiA+IEN1cnJlbnRseSBJIGRvbid0IGhhdmUgc29tZSBCVFJGUyBlbnZpcm9ubWVudCwgSSBj
b3VsZCBzZXQgdXANCj4gPiA+ID4gb25lDQo+ID4gPiA+IGxhdGVyLg0KPiA+ID4gPiBZZXQgaW4g
cGFyYWxsZWwgY291bGQgeW91IHByb3ZpZGUgYSBmdWxsIG1lc3NhZ2Ugb2YNCj4gPiA+ID4gInN0
cmFjZSBta2ZzLmVyb2ZzIC14LTEgZm9vLmVyb2ZzLmltZyBmb28iIG9uIEJUUkZTIHRvbz8NCj4g
PiA+IA0KPiA+ID4gc29ycnksIEkgbWVhbnQgInN0cmFjZSBta2ZzLmVyb2ZzIGZvby5lcm9mcy5p
bWcgZm9vIg0KPiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IEhlcmUgaXQgaXMuDQo+ID4gDQo+IA0K
PiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgQlRSRlMgY291bGQgZXh0cmFjdCB0aGVpciBpbnRl
cm5hbA0KPiB4YXR0cnMgKCJpbm9kZSBwcm9wZXJ0aWVzIikgaW4gdGhlaXIgb3duIG5hbWVzcGFj
ZSB3aGljaA0KPiBkb24ndCBiZWxvbmcgdG8gdGhlIG9yaWdpbmFsIGZpbGUgaXRzZWxmIGxpa2U6
DQo+IA0KPiBYQVRUUl9CVFJGU19QUkVGSVggImNvbXByZXNzaW9uIiAtPiBidHJmcy5jb21wcmVz
c2lvbiA9IHpzdGQNCj4gDQo+IEkgdGhpbmsgSSBuZWVkIHRvIGludHJvZHVjZSBzb21ldGhpbmcg
dG8gZm9ybWFsbHkgaWdub3JlDQo+IHRoZXNlIHhhdHRycyBsaWtlOiBgLS14YXR0cnMtZXhjbHVk
ZT1wYXR0ZXJuYDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vd3d3Lmdu
dS5vcmcvc29mdHdhcmUvdGFyL21hbnVhbC9odG1sX25vZGUvRXh0ZW5kZWQtRmlsZS1BdHRyaWJ1
dGVzLmh0bWxfXzshIVBEaUg0RU5manIyX0p3IURxdV90SDJ6VF9US0VoSE5pMkNaVG9ZbG1ZRmVa
YXlXRTFCUVZRalpCWnE0ZWdqWVMxYkFWUzdCYXNRSjlCRVRKb1ZJTlBFQi1wMDZ5N2l6SVVtV2st
MlZub2ZPUVp3THJ3JA0KPiDCoFtnbnVbLl1vcmddDQoNCkkgdGhpbmsgdGhhdCBjb3VsZCB3b3Jr
IGJ1dCBhIG1vZGUgd2hlcmUgRVJPRlMga2VlcCB0aGUgWEFUVFJTIGl0DQpyZWNvZ25pc2VzIGFu
ZCBpZ25vcmUgdGhlIG9uZXMgaXQgZG9lc24ndCB3b3VsZCBwcm9iYWJseSBwcm92ZSB1c2VmdWwN
CmluIHRoZSBnZW5lcmFsIGNhc2UuwqANCg0KSSB3b3VsZCBzdWdnZXN0IGEgLS1zdHJpY3QteGF0
dHJzIG1vZGUgYmVoYXZpbmcgbGlrZSBpdCBkb2VzIHRvZGF5LA0KcmVxdWlyaW5nIGV4cGxpY2l0
IC0teGF0dHJzLWV4Y2x1ZGUgdG8gd2hpdGVsaXN0IFhBVFRSUy4NCg0KVGhlIGRlZmF1bHQgd291
bGQgYmUgYSByZWxheGVkIG1vZGUgd2hlcmUgaWdub3JlZCBYQVRUUlMgYXJlIHJlcG9ydGVkDQpv
biBzdGRlcnIgYXQgSU5GTyBsZXZlbC4gV291bGQgdGhhdCBtYWtlIHNlbnNlIGFuZCBiZSBhbHJp
Z2h0Pw0KDQpJcyB0aGVyZSBhbnl0aGluZyB0aGUgQlRSRlMgcGVvcGxlIGNvdWxkIGRvIHRvIG1h
a2UgdGhlaXIgRlMgZWFzaWVyIHRvDQp3b3JrIHdpdGg/DQoNCkdhw6tsDQoNCj4gDQo+IFRoYW5r
cywNCj4gR2FvIFhpYW5nDQo+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciBoZWxwLA0KPiA+IEdhw6ts
DQo+ID4gDQo+ID4gDQoNCg==
