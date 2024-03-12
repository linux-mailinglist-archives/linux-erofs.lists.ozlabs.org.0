Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59987978A
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 16:29:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvHd039P3z3dSn
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Mar 2024 02:29:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manchester.ac.uk (client-ip=2a01:111:f403:c206::1; helo=cwxp265cu007.outbound.protection.outlook.com; envelope-from=gael.donval@manchester.ac.uk; receiver=lists.ozlabs.org)
Received: from CWXP265CU007.outbound.protection.outlook.com (mail-ukwestazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvHct6bkQz30Kd
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Mar 2024 02:29:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiHlLW7bHVhlCU7I47OYVDfWoSUUnSDUa7IP26GWDRhNs7YWvHtt/dUeoWULGv57MFuMhPmGXLmBRf55t0Ohy5hIpV1QO1C766cEHdE9a89XB+18FQYcSwxGD7OLOeuRsgSCHP1KtC8MEm6qY8TqQw8Kl1hOAu+HxsB/ECd79E+Qtgn6H41j1d73eC+wxyOAU4upcnqyEtG6SqBmlBSEZ1VBD0H1wsJuxNxiCrTmLfev1nw5AA+HV0b7RU+oux7F5tna3T6FgtNJr8t/lbEQNyOsznLyejYmShLUmaVYSsEZ1M0RC6QwT7orvmJIC1sYZvUBfr5RxGbbcFHNbrt56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxCqRp+NYWpROx6UM0mkeZJ+VaIJsoQgIBzi5BqWcjU=;
 b=gS5klyZ6Cgmhgg9oZWVJ5j/zZFeI7TCpSQST6QeyeCv59pHVK380+0eT9ZrBDQJ216yDJfEMskZdE65AB3FKEoC3q2PkaDmy7v+3H5mVAoYUEZJDBMXKu0bQpwEmtV3ZfEjxuIuC0jI2nd9B52iwzW6AENUv6izeopEE+h3eg22tGz9HowyX/Pdneqpq2tDycNYSDQGhMwK374Jo3fCxN6HtOgMaT+gHkEV4KX//mKK2P/N5jKlWh9aP4MK1PMpyv04uRcL/sUHgg6D5oMGI3tOXUfjTeNrzbaJeYubvHcETG1SVVQzJ3qL3lsMheweJqfjRTPd/4tMBN8Fin++qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::14)
 by LO0P265MB6099.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:248::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:29:06 +0000
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15]) by LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:29:06 +0000
From: Gael Donval <gael.donval@manchester.ac.uk>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Topic: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Index:  AQHadGOiPlVwdje8XEOnbl0bbKegWbEz69QAgAAALICAAAYPAIAACIKAgAAGmICAAAvJAIAACNOAgAARCYCAABRzgA==
Date: Tue, 12 Mar 2024 15:29:06 +0000
Message-ID: <0dc621aba5349289c8e28611b285756850c53d8a.camel@manchester.ac.uk>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
	 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
	 <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
	 <691120bfed626b78cc1107166f2fd964ca23ce99.camel@manchester.ac.uk>
	 <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
	 <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
	 <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
	 <876af3499c628f385de3416788754cdb38962471.camel@manchester.ac.uk>
	 <4dfda4c0-4dab-4517-879e-72af0981f474@linux.alibaba.com>
In-Reply-To: <4dfda4c0-4dab-4517-879e-72af0981f474@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6406:EE_|LO0P265MB6099:EE_
x-ms-office365-filtering-correlation-id: 9410547b-4665-4612-0cd9-08dc42a927d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  A1WV6SHg16/2gNlFMWK2ijkhg/6EX7xq9caTW8iGHCP/XWsRE+KRH2xpvg0UczH/c+LABFD8VIIxOClRokezjWFQKHorZCaARiTTyfmMe7Mil9iMWi71+sY4Y3fyXchwCk6+jkhQ1/nouVQ2e6xN3OcrRsMdEvQgvvVDXdKfpaLGM6/DEK5BZgFXR2tvoA5ufZmdr0aKOBlxzFJQlKQxECTqJf0AwDF7IRm17awkwIiM3/hvOW1d8GfAZxD6pXSqVh4RwEFwobuoHc53O6Dfo+fcL+jtuWpdhu+ALHTetNemQgT52DLdBvEBWnFrnrZVniHih8asYthlmwsdsQp7bYDQDQDmgeO1eAhbwXj+uR8mIBQcHWFMGFeZfk5FMWhk8D6aFSt3rC++kztTu2q3We+QGMDNN87yZ/RdNSeP6mdKUqN6XSavwp0mlbvGJwesXk/UrjSo8l5xlkIdaOiIIxyk8KSvz7HiGJzeReBEZIsU2ACAzgl10OdCHOVR+tyDLUFW487N6PCIUpiLALjq68uuhAf5Axq8lUJ+YR7GEmj7tuoekpUQ4R21FH4xdRkg/t7SyBqqcBLADXFpZBL1oKgCnOTZ+Wmai91hsU22ze4jShlUJ+CJjzOG+c57lKvaZgL0EKLa92R8+fSQdZGbcIHkf/pB9F/UKuGBI/PgQjM=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TmlJZG9GWGNVdzZ4MDdqN0V0UHJFLzhLdnA0Uk9wVDgzMnRzQ3ZndXNjUElo?=
 =?utf-8?B?MEpiUmVRa3hBYS9PK2dHYTZHOXpWdnQwU3JKby8xdGpEd21ZTFU4YUVyMEJZ?=
 =?utf-8?B?MTVDTlVxcWpDMGtIdHYrakNFNXhHSTNrU2o1QithTkNJNkVSQzJYVHFJT1c4?=
 =?utf-8?B?Nnl0RjF6enFsSXo2alE3dVZMejdlNU9WQUIyU0plWDJtOUVwQU0vbEt0OXAy?=
 =?utf-8?B?Zk9iZnhtNnQ0Ykphc3QvdVVOcHdtM203QnlHSHhYc0lPSk9SLzFlWjk2N0hW?=
 =?utf-8?B?TXhjc0RlQWVDb2twZ0JhdTdJS3c0c2t1TzRnMHVvT04vemJOZVJoUmhNUy9U?=
 =?utf-8?B?NmczM2JkT2duMS9WZktFelc1QnJHVnh6KzFmelI3a2RXY0lNZWk2dytqZ01q?=
 =?utf-8?B?ckNHRnJucFZMalFiVVQvSGY1WnFKcXJkcC8rdjg3ZG96aVVyenVLUmhxWUM3?=
 =?utf-8?B?VjdDL2VGcnY5RXlwVzJUUGxick9CbGlPNk5BcVNXSWhLVDU3NlJDeEhvaEZU?=
 =?utf-8?B?UXVENWFPQWtkc0swVzNNbVZ2Zzc5cmhWVndWSm5HRFhTTVpLOGtzQU82eVZH?=
 =?utf-8?B?bTAybEtrcmNQdHFaVlFGaGJZeDJuQTNmUnBYRjB1T1ZIZEtMY2VDS1NvWVpL?=
 =?utf-8?B?Y1ZEV1RYYnZRbFV4WXN4eE5HS1krQmhEd2lGRW5VU1F1b3ZwZHZzYWZnUWkw?=
 =?utf-8?B?ZUxPM0ZuUHZIS1hQTG5BV3cvbVBqYjBkenAvVFpqY0dXaXFOZ2wvbUhpTkxN?=
 =?utf-8?B?WlQ5YXNsQ1RPZmhmaGZrY05BVSt2LzZ6bGhpRkxmTUlHcFpoTWh5dVJzcWEw?=
 =?utf-8?B?Qi9SS2t3VjhSc2RMQ2xneTZNU2JXZ2xPVDdnTXN6dUl1cW42OFVWQWlYaEE5?=
 =?utf-8?B?TEpwUFZXTk1LMEdCWHh0aGxuemRzUzBoOXhpa2FuSFovcFduUFAySTdMcnBy?=
 =?utf-8?B?czMreVZubFc5b1Joc3Z5bG9YeWRvK1B2YXRJcTVtUVd0ekVnMVRWNURVbjRn?=
 =?utf-8?B?SlZOZmdrWE9CYXZCMkE0S1NCYVdaTStyY3BnM0NlOG9LQXhUMS9iOGhaMUhi?=
 =?utf-8?B?NHVSZFhBQnlSeE5ROXZCZ09rd1Zhc040c3JWaEZBSStQOHBhWks3dmVvNG5Z?=
 =?utf-8?B?eFpnblAydWdxVEZDZy9lbnhiY0ZXaFlqbGY2ZmxNOC9HanZQMkNVZkpCTWRN?=
 =?utf-8?B?dWlJc2kzaWVuV3QxeDFxNDJOQnQvN0FYMkVZUUQ3aVQzMkxFRW5XY0RiclEw?=
 =?utf-8?B?elBueFVLdzJEWHBYaE9lcGZwS3pIeHVrQVg4VHF6alJNN0x5NDdxOUNsejBL?=
 =?utf-8?B?WHBhUWozdUc5bXJTVE1BcmI2S3FYSjYxTTRlbUUrUUNkaU8wTTFaWFBmeEti?=
 =?utf-8?B?VVczMk1oRTRHaTduT2xPZENjU2FrbkQ2QU8rU0VuczlsWFFqemFBYjBUU0Z4?=
 =?utf-8?B?ZUtnL29rTHJmUEdoVUdVK2w1MzE0dUJlNVZINFNsd0h4VEJPYXBwOVRWTWV0?=
 =?utf-8?B?ZDh6V3lzL1JCdDg1YUdaVE02MkJwekQyLzZBeVgrc0NSRnNUOCt5QU9MSWEw?=
 =?utf-8?B?WVIzQks1VDVFOGE0SGF0TkFiWFY5Q0FvNG1ySDZMSWdOc2IxczJaMGRsRGJE?=
 =?utf-8?B?MGlhOTlhbk8vTkwwaUZ0R21ZWHdGY2hFSTZMbG1xQytFT052dGp2R1BMNWRR?=
 =?utf-8?B?OVkzSmhmMFl2MGsrUjhLZ0JYd3F6U3EvM292ck00K1MwbFBPbVVGbzRCbXBB?=
 =?utf-8?B?Wjd2S2NzOVVMVzZxU2RFc2NCRXpEcWo5eG84Y2Yvb3AwY1ZhdmU5M1hFWUhN?=
 =?utf-8?B?bUd5YjZjeHUzVGZzaldmOGJ1RHNWMHFpZDdoSjRhcWE2SG1qNEZEbGRNTXlK?=
 =?utf-8?B?QklRQ0R6RUV0MU5DaUZNTDdKenE5OU85VG5vc0FHNk1Cc0lCMVZGQTRCN05F?=
 =?utf-8?B?b0oyTTFvdU5STWw3bU1DbUowUWVGL3J5NVl0UjA2ZUR4NXVJQkdweWVVVEZK?=
 =?utf-8?B?UHh6UVVpZHJKYkIxUXBhT29sdVdpK211N0NaWHk5TmthR2VCNzE3bmtGNlYx?=
 =?utf-8?B?RFJ0YVdrNjVwMGd0Qk44WTAvQmd2Q1piVjJVSytxci9yZ3pwT1V2TXFaOWFs?=
 =?utf-8?B?bGVCU1FDTVMyZE9vTGpFV1ZtREFlK05nSVN2SDU5eXdwNEdvRnpsRlFzMzds?=
 =?utf-8?Q?yBxtMro7aGyvIKHpNqODQvM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43FEF3C31E0784F8396D5C428BC1DC2@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9410547b-4665-4612-0cd9-08dc42a927d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 15:29:06.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21xrszYO0Yvsf1/5LvQAfhAXPcag0fgl/8VhmLzfTHCG2+ObrSabaOBUDUZFAhmdKxNtzTXS0l528xa0xyNOzjLwlm3vI9vY+Xrsvy+tc0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6099
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

T24gVHVlLCAyMDI0LTAzLTEyIGF0IDIyOjE1ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IA0K
PiANCj4gT24gMjAyNC8zLzEyIDIxOjE0LCBHYWVsIERvbnZhbCB3cm90ZToNCj4gPiBPbiBUdWUs
IDIwMjQtMDMtMTIgYXQgMjA6NDMgKzA4MDAsIEdhbyBYaWFuZyB3cm90ZToNCj4gPiA+IA0KPiAN
Cj4gLi4uDQo+IA0KPiA+ID4gWWVzLCBidXQgdGhhdCBuZWVkcyBhIG5ldyB2ZXJzaW9uIChtYXli
ZSBlcm9mcy11dGlscyAxLjgpIHRob3VnaC4NCj4gPiANCj4gPiBPZiBjb3Vyc2UhDQo+ID4gDQo+
ID4gPiANCj4gPiA+IEFsc28gSSdtIG5vdCBzdXJlIGhvdyB0YXIgLS14YXR0cnMgd29ya3MgZm9y
ICJidHJmcy5jb21wcmVzc2lvbiIsDQo+ID4gPiBkb2VzIGl0IGFsc28gd29yayBpbiBhIHJlbGF4
ZWQgbW9kZT8gQ291bGQgeW91IGdpdmUgbW9yZSBpbnB1dHMNCj4gPiA+ICYgdHJpZXMgd2l0aCAi
dGFyIC0teGF0dHJzIj8NCj4gPiANCj4gPiBUYXIganVzdCBzdG9yZXMgWEFUVFJTIGFzIHRoZWly
IG93biBmaWVsZC4gV2hlbiBJDQo+ID4gDQo+ID4gwqDCoMKgICQgdGFyIC0teGF0dHJzIC1jZiBm
b28udGFyIGZvbw0KPiA+IA0KPiA+IGFuZCBpbnNwZWN0IHRoZSB0YXIgZmlsZSBpdCBhcHBlYXJz
IFhBVFRSUyBhcmUgc3RvcmVkIGFzIGFyYml0cmFyeQ0KPiA+IFNDSElMWSBhdHRyaWJ1dGVzOg0K
PiA+IA0KPiA+IMKgwqDCoA0KPiA+IC4vUGF4SGVhZGVycy9mb28wMDAwNjQ0MDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDIwMTE0NTc0MDMzMjIyMDEwNzc2DQo+ID4gwqDCoMKgIHh1c3RhcjAwMzAgbXRp
bWU9MTcxMDI0MTQyNi40NTgwOTc5MTENCj4gPiDCoMKgwqAgMzAgYXRpbWU9MTcxMDI0MTQyNi40
NTgwOTc5MTENCj4gPiDCoMKgwqAgMzAgY3RpbWU9MTcxMDI0MTQyNi40NTgwOTc5MTENCj4gPiDC
oMKgwqAgMzkgU0NISUxZLnhhdHRyLmJ0cmZzLmNvbXByZXNzaW9uPXpzdGQNCj4gPiDCoMKgwqAg
Zm9vLzAwMDA3NTUwMDAxNzUwMDAwMTc1MDAwMDAwMDAwMDAwMTQ1NzQwMzMyMjIwMTE1NTENCj4g
PiDCoMKgwqAgNXVzdGFyMDBnZG9udmFsZ2RvbnZhbA0KPiA+IMKgwqDCoCBbLi4uXQ0KPiA+IA0K
PiA+IFNvIHRhciBibGluZGx5IHNlcmlhbGl6ZXMgZXZlcnl0aGluZy4NCj4gPiANCj4gPiANCj4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUgYW55dGhpbmcgdGhlIEJUUkZTIHBlb3Bs
ZSBjb3VsZCBkbyB0byBtYWtlIHRoZWlyIEZTDQo+ID4gPiA+IGVhc2llcg0KPiA+ID4gPiB0bw0K
PiA+ID4gPiB3b3JrIHdpdGg/DQo+ID4gPiANCj4gPiA+IE5vcGUsIEkgdGhpbmsgaXQncyB1bnJl
bGF0ZWQgdG8gQlRSRlMgYnV0IHN1Y2ggeGF0dHJzIGFyZSBhbG1vc3QNCj4gPiA+IG1lYW5pbmds
ZXNzIGZvciBFUk9GUyB0byBrZWVwIChzaW5jZSB0aGV5IGFyZSB0aGVpciBvd24geGF0dHJzLikN
Cj4gPiANCj4gPiBBaCB0aGF0J3MgaW50ZXJlc3RpbmcuDQo+ID4gDQo+ID4gSSBzdXNwZWN0IHRo
YXQgaW4gdGhpcyBpbnN0YW5jZSB0aGUgeGF0dHJzIHdvdWxkIG5vdCBiZSB1c2VmdWwgYXQNCj4g
PiBhbGwNCj4gPiBidXQgb3RoZXIgY29tcG9uZW50cyBsaWtlIFNFTGludXggdXNlcyB4YXR0cnMg
dG8gcGVyZm9ybSBNQUMgYW5kDQo+ID4gd2hvDQo+ID4ga25vd3Mgd2hhdCBvdGhlciB4YXR0cnMt
YmFzZWQgc2NoZW1lcyBleGlzdCBvdXQgdGhlcmUuLi4NCj4gDQo+IEVST0ZTIHdpbGwga2VlcCBj
b21tb24geGF0dHJzIGxpa2Ugc2VsaW51eCwgYnV0IEVST0ZTIGRvZXNuJ3Qga2VlcA0KPiBidHJm
cy4gbmFtZXNwYWNlIChvciBvdGhlciBhcmJpdHJhcnkgeGF0dHIgbmFtZXNwYWNlcykgbGlrZSBv
dGhlcg0KPiBmaWxlc3lzdGVtcyBsaWtlIGV4dDQsIHhmcywgZjJmcywgc3F1YXNoZnMsIGV0Yy7C
oCBFUk9GUyBvbmx5IHN1cHBvcnRzDQo+ICJ1c2VyLiIsICJ0cnVzdGVkLiIgYW5kIHNvbWUgInN5
c3RlbS4iIGRvbWFpbnMuwqAgSW4gb3RoZXIgd29yZHMsIElmDQo+IEVST0ZTIGhhcyBpdHMgb3du
IHhhdHRyIG5hbWVzcGFjZSwgSSB0aGluayBvdGhlciBmc2VzIHdvbid0IHN1cHBvcnQNCj4gImVy
b2ZzLiIgdG9vLCBhbHNvIHNlZToNCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNDIwMDkyNzM5Ljc1NDY0LTEtbzQ1MTY4Njg5
MkBnbWFpbC5jb21fXzshIVBEaUg0RU5manIyX0p3IUJXZG1LVDdIQVZVLXVqcW5lS2JFY2JsTDBD
SkM5RmhRLU16aWtTTjAzOEtqbFE3SFFxZGJ2MUdwT3RwWnNCUkFvVzUzOFJQSFZwSDMta0w3QzVE
ckpWMWx6SmJRX3VTY2RRJA0KPiDCoFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPiANCj4gQmVjYXVz
ZSB0aGF0IGlzIHNpbXBsZSwgeW91IGRvbid0IGV2ZW4ga25vdyBpZiB0aGUgY29udGVudCBpbiBz
b21lDQo+IGFyYml0cmFyeSBuYW1lc3BhY2UgaXMgc3RhdGljIG9yIGR5bmFtaWMuwqAgT3IgaWYg
aXQgaGFzIHNvbWUgc2VjdXJpdHkNCj4gaXNzdWUgdG8ga2VlcCB0aGVtLg0KDQpJIGRvbid0IHRo
aW5rIHN1cHBvcnRpbmcgM3JkLXBhcnR5IEZTIGlzIHRoZSBxdWVzdGlvbiBoZXJlIGF0IGFsbC7C
oElmDQpgYnRyZnMuY29tcHJlc3Npb249enN0ZGAgaXMgc2V0LCBJIGRvbid0IGV4cGVjdCBlcm9m
cyB0byBkbyBhbnl0aGluZw0KYWJvdXQgaXQuIE5vIHN1cHBvcnQuIE5vIHVuZGVyc3RhbmRpbmcg
b2Ygd2hhdCBpdCBpcyBhYm91dCBldmVuLiBKdXN0DQp0aGF0IHRoZXJlIGlzIG1ldGFkYXRhIHRo
ZXJlIGVyb2ZzIGlnbm9yZXMuDQoNClRoZSByZWFsIHF1ZXN0aW9uIGlzIG1vcmU6IGRvZXMgaXQg
bWF0dGVyLCBzZWN1cml0eS13aXNlLCBpZg0KYGJ0cmZzLmNvbXByZXNzaW9uPXpzdGRgIGlzIGFk
ZGVkIGFzIG1ldGFkYXRhIChqdXN0IGxpa2UgaXQgaXMgYWRkZWQgaW4NCnRhcik/DQoNCklmIHRo
ZXJlIGlzIG5vIGhhcm0sIHRoZXJlIGNvdWxkIGJlIGFuIGFyZ3VtZW50IHRvIGtlZXAgdGhlbSBh
cyBwdXJlDQptZXRhZGF0YSAodGhhdCBlcm9mcyBkb2VzIE5PVCBhY3Qgb24hIG5vIHN1cHBvcnQp
Lg0KDQpJZiB0aGVyZSBpcyBoYXJtLCBta2ZzLmVyb2ZzIHNob3VsZCBzdHJpcCBhbnl0aGluZyB0
aGF0IGl0IGRvZXMgbm90DQpzdXBwb3J0IHdpdGhvdXQgcHJvZHVjaW5nIGFuIGVycm9yLg0KDQpF
aXRoZXIgd2F5LCB0aGVyZSBzaG91bGQgYmUgbm8gZXJyb3IuIDopDQoNCkdhw6tsDQoNCg0KPiAN
Cj4gPiANCj4gPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRoZW4gdG8gZG8gd2hhdCB0YXIgZG9lcyBh
bmQgYmxpbmRseSBzZXJpYWxpemUNCj4gPiAoYW5kDQo+ID4gZXhwb3NlKSBldmVyeXRoaW5nIGFu
ZCBwcm92aWRlIGEgLS14YXR0cnMtZXhjbHVkZT1wYXR0ZXJuIGluIGNhc2UNCj4gPiBwZW9wbGUg
d2FudCBzb21ldGhpbmcgbW9yZSBmaW5lLWdyYWluZWQ/DQo+IA0KPiBBcyBJIHNhaWQgYWJvdmUu
DQo+IA0KPiBUaGFua3MsDQo+IEdhbyBYaWFuZw0KPiANCj4gPiANCj4gPiBUaGUgb25seSBtYWlu
IHByb2JsZW0gY3VycmVudGx5IGlzIHRoYXQgZXJvZnMgdHJpZXMgdG8gYmUgc21hcnQNCj4gPiBh
Ym91dA0KPiA+IHhhdHRycyBhbmQgZXJyb3JzIG91dCB3aGVuIGl0IGRvZXMgbm90IGtub3cgYWJv
dXQgc29tZXRoaW5nLiBJdA0KPiA+IHNob3VsZA0KPiA+IHJlYWxseSBiZSBtb3JlIGdyYWNlZnVs
Lj4gDQo+ID4gVGhhbmtzLA0KPiA+IEdhw6tsDQo+ID4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IFRo
YW5rcywNCj4gPiA+IEdhbyBYaWFuZw0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBHYcOrbA0K
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4gR2FvIFhp
YW5nDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgaGVscCwNCj4gPiA+
ID4gPiA+IEdhw6tsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiAN
Cg0K
