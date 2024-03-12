Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1F8798C3
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 17:16:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvJfV0TS0z3dSJ
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Mar 2024 03:16:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manchester.ac.uk (client-ip=2a01:111:f403:261a::701; helo=gbr01-lo4-obe.outbound.protection.outlook.com; envelope-from=gael.donval@manchester.ac.uk; receiver=lists.ozlabs.org)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:261a::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvJfQ4X2Qz3cN9
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Mar 2024 03:15:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovnu+t1XYWCKnlt/BImRKMSf+TkjhBNuz6ErghAn3eVUyVJ/jTcXN6vaffuGFaBKFtkdy6LepixakOegYmKYc5xYjy7yuTfzl4EL0J0o5uM2WGw83RX6XeIrLWYNLFM/J/YxMwafZmSjvm4BpSr5eXykgEdOT3QjZxyKe2iAt0uV3M6tsqcdvpDiHuX1JWC4w+KNkvSGvjR4XcTbzmwqBiBOR9imqxf5YLO8ehmNGjVbXi3KS8K/G75GE4ct0VPyj2acJwecoEAdZ4T9OctYMg3pXGKtF0r/vrbHho7d8GkLZfk9O0RySyqbIe1cthl5Kjcb7RG5wXBazmgxWU5NAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6+QSybB+/GSwZPacK0Z14MFWINctug2Gpop8P9cmZY=;
 b=H/wqs1qoZJdp332YCKdYNxlhjIZ9aXSgxlvCzoBuvqQRkxDnvckTv6eEWHTE8fLN5rUHeaTaBMMG7serjlrAy/yK/rSO2twtlpoX2HqtQlgOKuKuTGMJnBo+EEC0yFxCEBH3zTALPl0r8JBiPOrpKkstgzISnpPccZDFZc3S4bw6Ho3QA7E6B5WkUIKPC21oaMXuyX6JYSd45aI4zYwNJ+qHamGdw4B9U1M7lzRuFkEG4eQKxAbjX0/GKGxbrS9T6W06eC8ZagpHY6yaSynbU2Ddx3jKmKaYEOZQpLUaR7LeH8K2Q150byja2bGjfAtQLuHasCAVrc9THUsPcmBF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::14)
 by CWLP265MB6401.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:15:31 +0000
Received: from LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15]) by LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3e09:1ac4:faf1:bd15%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:15:31 +0000
From: Gael Donval <gael.donval@manchester.ac.uk>
To: "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Topic: mkfs.erofs fails (failed to build shared xattrs, err 61)
Thread-Index:  AQHadGOiPlVwdje8XEOnbl0bbKegWbEz69QAgAAALICAAAYPAIAACIKAgAAGmICAAAvJAIAACNOAgAARCYCAABRzgIAAAuqAgAAKDgA=
Date: Tue, 12 Mar 2024 16:15:31 +0000
Message-ID: <3335bbeb92ee627c3db5a31a8d247fa8c972fc86.camel@manchester.ac.uk>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
	 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
	 <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
	 <691120bfed626b78cc1107166f2fd964ca23ce99.camel@manchester.ac.uk>
	 <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
	 <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
	 <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
	 <876af3499c628f385de3416788754cdb38962471.camel@manchester.ac.uk>
	 <4dfda4c0-4dab-4517-879e-72af0981f474@linux.alibaba.com>
	 <0dc621aba5349289c8e28611b285756850c53d8a.camel@manchester.ac.uk>
	 <1b57afc3-53e0-42d7-87aa-bddd1ceec10b@linux.alibaba.com>
In-Reply-To: <1b57afc3-53e0-42d7-87aa-bddd1ceec10b@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB6406:EE_|CWLP265MB6401:EE_
x-ms-office365-filtering-correlation-id: fa09119f-6756-4ce9-2c99-08dc42afa39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  SennmSSVX5Eht3iiPp5ZFwLALfm14/+r3uelZmvV9EeJh/2imXkEHvCnxe+4lvMAWEDsF5pTA6TnbZxyjkhW58agqO4hsN6IVLYwoYl0SZooJz9iNZr3JxG5nkyAfpzp3jUd9CbEk7z1LGoDJ+GvwegdXbHtSn2raSBrYjkFjU431IokK848fbr+0PIeMTDxKHw/RXdkOtvNcdv1P7XQZX2s6ppfHRSjLWoicxY5I8v96xnTbPElJKdiUB90SfGjodiv0ervXCmzOgxsNaDOMu1dP88mGQsdDmlYlSoAkBZ1l2F0pUaF0sg3M2iT7I5b96u82jgvAUicO1PEABDA2ihuKpJ6phl14AND+nFqAalYYMkE25J4qHSJ4f5ZzkKXaDeuxvyzzkzFA6Hxf/VjWksRqgxv79aRAwMzkz+mQSH4RKwkcGqu3lkdKdC8t3EyulPtX+yvJQDA9SyvUGb02uOknljoGKPS3riThCryRAi052KXBYHn2kMOCCkcYg4fjIXHRtUKQRnyOLpzPj74Vnabkbdmp0DnyO5m57VNu9IF+TNTRQhVYc6Qb4/Gdn5PPBkeDDIeJTgB24cU/Sp+jitsTaM0MQvzn+DS/rRi1FgKGmV5CTdVffeuk/K1UDrcrxjYK6BBpwaib5GrWw+3Sg1j7DqHYKAB8FKCbY63QpyuyW76O0YXAD/W+K505wGwFeX0tUlnDAZKBG1V+2ho/A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RkFMMHMyTWxyMGVvZjh3UTJnM1pnbVJlM1Qvclg0TlRWZlQ1TVEwLytpYzhJ?=
 =?utf-8?B?TEw1Z3EzbG4xTmVIN2VhYzErSC8yRUMrWXk4d1NBZmNiR1ZxK2FWRy9aZCtz?=
 =?utf-8?B?eWhSSWhCOEUvOEJJaDlVcm92WlBWYm40UEdlMmQxaksvcUUwRWl1WmRQZEdk?=
 =?utf-8?B?YXFJL0Y1dFFtOVltQU5jS3N4aElUcTl4ZTRaUWVYanZXUVNPOTZZSmdXaGhz?=
 =?utf-8?B?cTlEWTBxMmlCSDV6YlBJTnkzSmdRQlpVeEIxRHh5QzJ0QXA1YjlRaCtDUHZH?=
 =?utf-8?B?aXlIT0pRb0luZ2JMeWJ6YjBGekhXTGVzc2xqQnJjY3owQkZuNUpUclo5eDZq?=
 =?utf-8?B?elM4YmlrSDFqL3VNSkFRQkE5RmdLMEFFR3ljSmEwTnpKUytGMEtzRThGU1lo?=
 =?utf-8?B?bEE2WWRKMTVKeHRvRXdHdVdDcjlLUytOdE9MaVUzc1RUWENLQnJZUkhrakRH?=
 =?utf-8?B?SE9FUWllTDZYeFA0dkdxcE1nZ01kYnV6QU5Jd0FiODB5R3RiMFA0cm9VSXZ1?=
 =?utf-8?B?RnpxWmc5YjRYYmlBOTFINjJUZmRCZlJpUUN2RFFCMVhNYWlxWVlqOTUyY2Rv?=
 =?utf-8?B?UWg0MHZPRTZwUUZYK0lmb2tHWXZyVkRsdkdTNWJyL2VEYW5sRStKSnRYUks2?=
 =?utf-8?B?K1FpdWtOOEJwWGNiek9JaENQMU55MUFCejJpRU04UHpRbFc5N3VoeFNXUFNX?=
 =?utf-8?B?dnl0cTVOSEkrQ2pNRUp3RXVqYUJ3NkY4WU1QU2dtTDZwZVZOSEkrc1o3RlFM?=
 =?utf-8?B?eXVEaHJxaUVwR3QreWpLZG5nQ2tyMEl6QVV6cGZHL1ltWjFpSkR6UGQ4bW5D?=
 =?utf-8?B?TmtHN2JHQ0JqV1BuQXBIVUszYjNEd3J1TkFIaUo1SzNKa1FKeDlhcWxsaXVR?=
 =?utf-8?B?czJXV2hvNEt0RTBkWHFvNzV4OFBvcjJGMmdzQjFlTmxKdStGeHBYSFp5dGtq?=
 =?utf-8?B?aXlnMjRySkt3alVWelhlaU43ZmdTS09DdWgraGV6MlNIK1ducGVjNThYMi9F?=
 =?utf-8?B?R2E0K2o4TWxJZUNESHBPdWk5TmpNSUZnY25LSG50UkRlem5SSCtpRWpsVGdn?=
 =?utf-8?B?SXlGenZqMFZESGpibWJlUnF4Wnd1U1dFa09FeWd1RkhWYW1hQi95eW1iVGxk?=
 =?utf-8?B?T0kzVWo2eHBtNXo2UGsrbXE2Rlk3QldiTlFjeXZ2ei9YRG5Kd2pGeDBhVU9U?=
 =?utf-8?B?K3kzd0g1S25LMWhTUE13RGdaNkppbGp4TEQ5czVTWWFxb2tMaktNTmluS0xv?=
 =?utf-8?B?UnBpa0N5bG4wWWZ2TGJrd3NmNUFSajRHNXV4UkxsQ21PRUxUeWNJWXh0UmRF?=
 =?utf-8?B?L1lLU0IveHRDRy9DUmt3ZjNZL01YWTdoVVg3SnVoTnZpYnJYTjNIQzNzcTZI?=
 =?utf-8?B?S0tlRGhHRFJ4cnlXQmlSSHpJN20yQjZsS1dvR1VkdFQ2N1FBcDNobWtaNnYz?=
 =?utf-8?B?dUh4aTA1ZDd4WjZUb2lIM1pEU04zRldDWC9CUVVWM3lWRmRMOS9iZngyL3gy?=
 =?utf-8?B?TytMRHJLaFJ0d0pJYVdRL1pkOTNZTkN1b0o3ci9GaURUajh5VVplcndRaUZ5?=
 =?utf-8?B?NjFCVnZmMTJsN016WDNLcHM2ZzBpTGVDQVlLSkhyQWNMalYzVEpHYXp4ZHlr?=
 =?utf-8?B?S3h6TFhMOXdaN0tkQUFlWFNQblVqblVKRXlDNkRNeGUyVVE4OUpUU2d6LzlZ?=
 =?utf-8?B?MlJRSXZTalR1S1k3VzROb3k5UXZNMThlK3NQQ3Nrdkt4bzhjVjVObmVqbFJp?=
 =?utf-8?B?YkNhZTJlQ09yM0VTaGc4OUhqUXc4WXRHR3VybUZwZkV4WnlURVJjdUdWWkU1?=
 =?utf-8?B?d3A0SDBQaXhSc1FmdFM0WkJlLzdZTW1jaWZqdElTeVZ5NFQ1QnZhN3NqQWNh?=
 =?utf-8?B?WENac05xVTBIQXdaa0c3UEFVY1BPTkxVMUM4eXp6RDJuV0NsZXNSZUJFbzlJ?=
 =?utf-8?B?SDBGanpzVDR3d09wSmEvZVR6VnRYVml5Ky9ycjlGbVA1MElUOEh3aU5odXgw?=
 =?utf-8?B?SnNhTGFNUnBjSGlTdXRydFRQMWFPeVpnUlRUYXZnU0FONzhPakZKNzJybkhW?=
 =?utf-8?B?SklwQWZ0b3E3TXZwemlrL2N3a1YvNEw2aWtYRVRjRVZMNGo5c2thM0JwK01u?=
 =?utf-8?B?Mkh0LzUrSTVsY1UxNElsWnFyQ1lONXFGK1o5bWVRRGw5VnV6RlBnMFl4NmU1?=
 =?utf-8?Q?7QrEIlc/7MFlG/lFbCLsC50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F1027FEC8DCD4287AA6F78463885C9@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6406.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa09119f-6756-4ce9-2c99-08dc42afa39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 16:15:31.1334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGkOU3iMWwsD/zRIqHRc/F0sgGi5OAHli1YuBOfZroE9R1DD9hrNmly+2NQWN03CcNQWLakAGzpOylX6yUFji5cXonwU9Fgu9HvpViMnUxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6401
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

PiA+IElmIHRoZXJlIGlzIGhhcm0sIG1rZnMuZXJvZnMgc2hvdWxkIHN0cmlwIGFueXRoaW5nIHRo
YXQgaXQgZG9lcyBub3QNCj4gPiBzdXBwb3J0IHdpdGhvdXQgcHJvZHVjaW5nIGFuIGVycm9yLg0K
PiA+IA0KPiA+IEVpdGhlciB3YXksIHRoZXJlIHNob3VsZCBiZSBubyBlcnJvci4gOikNCj4gDQo+
IEZhaXIgZW5vdWdoLCBJIHRoaW5rIEkgd2lsbCBkbyB0aGlzIGZvciBlcm9mcy11dGlscyAxLjgs
IGJ1dCBJIHRlbmQNCj4gdG8gY29uc2lkZXIgdW5zdXBwb3J0ZWQgeGF0dHIgbmFtZXNwYWNlcyBh
cyB3YXJuIG1lc3NhZ2VzLCB1c2Vycw0KPiBjb3VsZCBzaWxlbmNlIHRoZXNlIHdpdGggcHJvcGVy
ICctZCcgbWVzc2FnZSBsZXZlbHMuDQoNCkknbSBhYnNvbHV0ZWx5IGZpbmUgd2l0aCB0aGF0IGFz
IGxvbmcgYXMgbWtmcy5lcm9mcyBnb2VzIHRocm91Z2ggd2l0aA0KZ2VuZXJhdGluZyB0aGUgRlMg
KGl0IGRvZXMgbm90IGdlbmVyYXRlIGFueXRoaW5nIHJpZ2h0IG5vdykgYW5kIHJldHVybnMNCnN1
Y2Nlc3MgdG8gdGhlIHNoZWxsLg0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgaGVscCwNCkdhw6ts
DQoNCg0KPiANCj4gVGhhbmtzLA0KPiBHYW8gWGlhbmcNCg0K
