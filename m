Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2791D77BCD9
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 17:20:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPdPb4FCDz30hY
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 01:20:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=marketsdatainfousa.onmicrosoft.com (client-ip=2a01:111:f403:700f::716; helo=ind01-max-obe.outbound.protection.outlook.com; envelope-from=claire.davis@marketsdatainfousa.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f403:700f::716])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPdPW1pNgz2xZp
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 01:20:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNsJJ0pEDlkPuCEAgfM2arxoZud4Sdl9jS4sdvgLnxVZx1RoOqUaO29zwS3vmSmAwxk4YZBncBl68aBrghf+f+G5rkHm2jmGkU2T9azrhzU1CA74dIm1TClpYQGIrwQu8NW4YVO6BvfiIoAdkg/FlZyDnkkWPs7KnyEq55OC6lR615q8z26xeYrva57JskJxU+sBacqKFAbRjokT59vzlGQQNqp+DpAV20tMpj6iiaqnpiqBsocIEKXLO64Ok35LthevI36PI2W6CD/Sn8gM1Z6nh+dZirHeWfdNAwI0VD/vxVuWZE5NfWzsUL6fuidRR367DJqWgRN2yjc47ygarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMFzvP9Jz1W1A/DrJaWVzol1qX9x1nAkPbx0wiZx8Tw=;
 b=hnegnlfTpy+2+OIIKCy584GYTPerS+vA1YV4aXJ8cj1xBI3IY9teCyYswxmBQyHKZYCNhg6Fv6W9cay2DpP2Tl0lZ+t9Fbma32oQTtZQ6H98xM3lJFa7axz78O29gkvpobGS9w7aWR2iud4Vbf6nrdnsoMK0FR3q5Vv8vhhHQisiXw6xnlxL9YolrKrR8/2+CW0cRn312nCuru4sAmmcwv9i58ZP0XrwDD5eXPHwyAeVUGhuzdM7GjhOeVshvypk7cTGCG2X99kJicsME54wQnicRPSvUO9SG8YOvuK92ruLfjbSQXEDdiThzTfHF2aR8fBqnQTKeA3KgXRf0T1wXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marketsdatainfousa.onmicrosoft.com; dmarc=pass action=none
 header.from=marketsdatainfousa.onmicrosoft.com; dkim=pass
 header.d=marketsdatainfousa.onmicrosoft.com; arc=none
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:166::10)
 by PN0P287MB1495.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:19:53 +0000
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::6a29:84ee:ce0e:2830]) by PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::6a29:84ee:ce0e:2830%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:19:53 +0000
From: Claire Davis <Claire.Davis@marketsdatainfousa.onmicrosoft.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: lists Learning & Training decision makers
Thread-Topic: lists Learning & Training decision makers
Thread-Index: AQHZzsLGW9gryBMtqEWFVIqxvf6RvQ==
Date: Mon, 14 Aug 2023 15:19:53 +0000
Message-ID:  <a6b5331a-b953-3fc6-5fda-497741c52411@marketsdatainfousa.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=marketsdatainfousa.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0603:EE_|PN0P287MB1495:EE_
x-ms-office365-filtering-correlation-id: ae8c9991-33e3-490a-c4c9-08db9cd9e8cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  mJxBeSF9YGEN77WQoPW6W354A1ReJvBATYzg6m79KkxMvmIPoBHSxLjZtS4yx46bIGyrvAKrpurirkjmAeyHXJDHHkqim1XQiSE9UtGLSNZFSaGN82lbLJuztQp/qWtbeZnnyJTaD0IhbG/l0MetG2U8nVTCGVn6OdEww9+6Z+9n/6KzwFyqOmwzCR33pV8oV3m9kWgWzW9IVY7hFgYdcIF8QTc0OjsL1LH6+l98qBh0ZK/jOk+EvbUoP8Mupo02y5kZvAVciIKaNAWRyEiMOnVzlvyluRszkT8+sAu2kx/p3UNWirDDFFl3c/wtrKl5voV37X1qLkeq5r+d58DTu0YWubAZFiaz1puFch6ANekaLdJcEnvY88ia7rZKtJsqW/BXq8rJYtaCYeGt24jhCKWs58CtJKaIiIMqxNQHw1qEqOsIBnzYQwTEBqyrynzHPNoRNS8/T7aSpxPWE8AKzonfES0E90XH8IYtwR1flRqOmPdz2jcg6ikTxaf+g3PxKmsMGsc9BR67JcfcezWOz0ZntvBdVa3EIgIpooIG4b3axLdA0BwITAHGotULbw9mhRcJpwSrJIuvURGP6h0MCVeUOy+hBmlv1oiLwd0bKA3N4CCRw98nNmPJzguJKH3VkV9aNed54JlKIa0vaUFTA6jOVXN590fltlTZozXGvcCHn0CXtF6qStmnQL6p8vL80kBXcivKX8p5jHD4qYQG3MkjWzG2Imr4hjuz0pJmkbEottHMfLCH5oNMJrmbbP+3
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0603.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(396003)(346002)(376002)(136003)(366004)(186006)(451199021)(1800799006)(83380400001)(122000001)(2906002)(38070700005)(38100700002)(66899021)(6486002)(6506007)(86362001)(316002)(6916009)(71200400001)(41300700001)(66476007)(76116006)(66446008)(64756008)(91956017)(66946007)(66556008)(8676002)(6512007)(478600001)(8936002)(31696002)(31686004)(5660300002)(2616005)(13220200016)(437434003)(581174003)(6396002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Z1hHZHRMN0djSkJ0cXNkU1hYRUZTdkpVcWY2YUYycHVudmtwT2w2b3RvS1M5?=
 =?utf-8?B?ZHJid3FGZ0RGK1Q2Z2ZiempWaDJOdWZWbStnQWFQRE1pMWlMWlk4RjBoeVYz?=
 =?utf-8?B?T211U01JVXBhN2JNalNBU3lCZnBkREdqVTdvUzFPd2I5eVFsZHV0M2oxNFNo?=
 =?utf-8?B?enRkVVY4RkJNaWhYY2lBZ0hYWU5oZ3FIV3Jqd2Y1cUNjc0Q5aHdRQVdJNlZG?=
 =?utf-8?B?TWYybDBzQmxMWjF5UmhDZHN4TWhvTU5GcUVKSzVZbGdGUi9GVnRaQzhHZUtp?=
 =?utf-8?B?ZnhJdTU4aisrejlKZkpiMFN4dmpPZlpYZDltYjhRRjVZZWd5USsvTnVLTEFG?=
 =?utf-8?B?KzBRVmpUV1lhYmpyY1pSVkpRVFVHSHNwY2RTUFdGMzNTbTg2OERsVi9hK1kx?=
 =?utf-8?B?S01MTGpvTmQvb3BQMGs0ODREbjAvdy9oSUcwenJ2N05xM1UwaWRBWHFWQ0VQ?=
 =?utf-8?B?OEtWZmdCN0ZneGpEWmI0ZEJlUW5IVkJkdXZIdFdMUHlCcXUvbnVRSktPUzls?=
 =?utf-8?B?bm9NUE94YVk2aDJsOTZicFhFY2cvSmZYSkwwNlVNeW1QdDE1WjJyZVN5UThH?=
 =?utf-8?B?ZFg3NUMyQmNYZmV4ZHRTdTlTTmIrNldCalE5cUlsZEVKejBCbEhsZEhYR2N5?=
 =?utf-8?B?Ni9EV09iVFl1clgzRWhzRXY4WWpQRGtBeDRzMUJhVWlySGtVL3VPZ1ZMdmZJ?=
 =?utf-8?B?QnQ3NFZETzJ1LzBmalIycUNrZDJveDBBWE1XNUdFUDdmSzJRVHZqakp0SzlG?=
 =?utf-8?B?dWRQL0hoc3pxY0hXSUxpQTBkaVNoZXhmZWE0Z0xxRVJiM0FZR0dJNUZFSE1I?=
 =?utf-8?B?Rk9udGhONlZ1Ty9xYzE0VEdQaENMVFNGd2kxdlcxNVd6UlRCVVpIOEs1c2lV?=
 =?utf-8?B?NTJnVkNBS2lDSjMyWEVYb2VxWk9rK1dJa3lEbU5DMUM2NzRGNE5OR2VwTEZS?=
 =?utf-8?B?d1Q2MndHS0tXQ29oK1JRZEtUVEwxZ2sxUzIzc2JjVkFid0E4d0JieURNRGd3?=
 =?utf-8?B?cDFRTWFFSEw1NkxCMHlxL0JSNktrTnN2RU5LTGFUcFkyRHVwRFV5YzR6eUcr?=
 =?utf-8?B?R29ubjVkNmZnN09nMjYzRW1sWmk2aThST3JBaWZLV0dMejRKK09ud2F1akpI?=
 =?utf-8?B?QjZyWDRBb0JIYUdRMS9TLzZyRlRxZ0d4eEJaZG11U1RyZlc0YkhzL3pyN2Vt?=
 =?utf-8?B?MXdIL0t5a09ScTEvRVYzNVZEK1drNnFMWTJ2eG5Uc3ZEbVgxTE9qN3FndklO?=
 =?utf-8?B?Qk5vNTMrWlN6dk5ma292bmV4eHQ3aEw0STZPMy92QVI1UFBjUEFBb29vaDdF?=
 =?utf-8?B?M2tOY0xPSEdUSWxyNU9qMWV2emZSUjJtcDlwV2R4WStFcUw4WStIc1liVlQy?=
 =?utf-8?B?QUc4RlhQSTVSWW8yUlhBbHhMSXBFd0VEMzRHSHhheWJpVTF5WENUbVFoVEg4?=
 =?utf-8?B?end2TTl4TmUreithNVpBMVdVT2ZJTmh3K05pRGFWZlBEZGErUVZWL2tDSUM5?=
 =?utf-8?B?ZjV6M3ZvY0pDYVIyNnQ4ME9ONDVFbmJUcCtnMGhQZjVSQlJUbytXYnNpaExY?=
 =?utf-8?B?RUdrR01vUVBoRkwwdTJCVTdmNEtBV2xlWWlMRENOaFVXNW9YZTBQWFdVeGRn?=
 =?utf-8?B?UUN6NEp6T1VJZkVxUTFDeXRicFhxNEFpQnhIVG9ONHA5YWxLLzdWNFhhY1ZL?=
 =?utf-8?B?TTdhb3BUWHBiRVQvU1pYc0x3bkhwVDRPQ0o4UUdsd0FnWWVHL1RpMy9Zank2?=
 =?utf-8?B?dFJkejZyZXI1VnQzdVRZMG91ZEpTMmJBcFZJSWM2UmJoWmhPUVVPb3Rub214?=
 =?utf-8?B?T1hQY2o1VHFVYlJrTG9JbTlFYmpOQjk4a0pVemhUNjdvajFBNEplNEVQTFZ5?=
 =?utf-8?B?Z1diT085ZHBMY3BUbVlPSUR3YWpnRnlwMThWR1RkdUdXRFkwaFJwSDVKa0lj?=
 =?utf-8?B?NHBoZUY5N2RKaCtBdFJQaXZpUmhJUWJobkF0SVl0ZVEvVjhlc1ZtVm5DK2lR?=
 =?utf-8?B?dEhTQlV4NDNrVlpRRkdtcitrTGRVeVNwMzF1b09HSHpZdFd0Y0ZEdW15M2Qz?=
 =?utf-8?B?ZDBjMEJ4VE5SNnlrc2VTYkF2cFh3bEozcWNSQlZ4bW1zQy9yYmw2RGxBZkJH?=
 =?utf-8?B?SzF4ZENRanRibkRjbVZZZE9iMUZqdXgyTVhnUGM0NnlSMXdlZmY2b3VTVzdp?=
 =?utf-8?B?Q2p1b0FOaFJzejV6cXlObnJubnVWQTlKbFhxeXBldXI1RjRrRDRCWXgzUkV4?=
 =?utf-8?B?dGxWRkYvV0NVbC9FYkR6WjJhYys5dmhrbXRpeXNONWR1SGUzNWdGTGdudXBY?=
 =?utf-8?Q?MKfuurhx8+OrBNi7Qh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55034C63464CCA46B3A3BFC206D3F779@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marketsdatainfousa.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8c9991-33e3-490a-c4c9-08db9cd9e8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 15:19:53.0523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62dfda68-9244-4547-9a56-5a49125b28f2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SamI769xDAtWiR0tly4Iq9Ujo9iT/SAFvRnntld4Y35BFJlpH3Qisa1gznlzwk960lih5rpaL7mlAOlTmikvamKnbZVnlZVD5A77wZwFzBpzPgov4wLPTC4kH10HJ8PvS0szQIgePVTfFEVCI6zSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1495
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

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBMZWFybmluZywgVHJhaW5pbmcsIFRh
bGVudCBEZXZlbG9wbWVudCwgQ29ycG9yYXRlIA0KVHJhaW5pbmcgZXRjIGNvbnRhY3RzLiBJ4oCZ
bSBsb29raW5nIHRvIGZpbmQgdGhlIHJpZ2h0IHBlcnNvbiB3aG8gbG9va3MgDQphZnRlciB5b3Vy
IHByb3NwZWN0aW5nIGFuZCBsZWFkIGdlbmVyYXRpb24uDQoNCldlIGhlbHAgY29tcGFuaWVzIGdy
b3cgc2FsZXMgd2l0aCBvdXIgaGlnaGx5IHRhcmdldGVkIGVtYWlsIGxpc3RzLg0KDQpQbGVhc2Ug
bGV0IHVzIGtub3cgeW91ciB0YXJnZXQgaW5kdXN0cmllcyBhbmQgam9iIHRpdGxlcyBzbyB3ZSBj
YW4gc2VuZCANCnlvdSB0aGUgbnVtYmVycyBvZiBjb250YWN0cy4NCg0KUmVnYXJkcywNCkNsYWly
ZQ0KDQpPbiBUdWUsIDI3LTA2LTIwMjMgMTE6NDMgQU0sICJDbGFpcmUgRGF2aXMiIHdyb3RlOg0K
DQpIaSwNCg0KV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gcmVhY2hpbmcgb3V0IHRvIHRvcCBs
ZXZlbCBkZWNpc2lvbnMgbWFrZXJzIHRvIA0KcHJvbW90ZS9zZWxsIHlvdXIgc2VydmljZXM/DQoN
CkxlYXJuaW5nL1RyYWluaW5nL1RhbGVudCBEZXZlbG9wbWVudA0KQ1ZEIEh1bWFuIFJlc291cmNl
DQpDVkQgTGVhcm5pbmcNCkNvcnBvcmF0ZSBUcmFpbmluZw0KTWVldGluZyAmIEV2ZW50cw0KT3du
ZXJzLCBDRU8sIFByZXNpZGVudHMgZXRjDQoNCldlIHdvdWxkIGJlIGhhcHB5IHRvIGN1c3RvbWl6
ZSB5b3VyIGxpc3QgYWNjb3JkaW5nbHkgZm9yIGFueSBvdGhlciANCnJlcXVpcmVtZW50cyB0aGF0
IHlvdSBoYXZlLg0KDQpJbmR1c3RyaWVzOg0KSW5mb3JtYXRpb24gVGVjaG5vbG9neSB8RmluYW5j
ZSB8QWR2ZXJ0aXNpbmcgJiBNYXJrZXRpbmcgfENvbnN0cnVjdGlvbiANCmFuZCBSZWFsIGVzdGF0
ZSB8Q2hhcml0eSBhbmQgTkdP4oCZcyB8RWR1Y2F0aW9uIHxQdWJsaXNoaW5nIHxSZXRhaWwgfCAN
CkNvbnN1bWVyIHwgTWFudWZhY3R1cmluZyB8R292ZXJubWVudCAmIHB1YmxpYyBhZ2VuY2llcyB8
RWxlY3Ryb25pY3MgYW5kIA0KVGVsZWNvbW11bmljYXRpb25zIHxJbmR1c3RyeSBhc3NvY2lhdGlv
bnMgfEhlYWx0aGNhcmUgfCBIb3NwaXRhbGl0eSANCnxMZWdhbCBTZXJ2aWNlcyB8Rm9vZCAmIEJl
dmVyYWdlcyB8TWVkaWEgJiBFbnRlcnRhaW5tZW50IHxFbmVyZ3kgYW5kIA0KY2hlbWljYWxzIHxB
ZXJvc3BhY2UgYW5kIERlZmVuc2UgfFRyYW5zcG9ydGF0aW9uIGFuZCBMb2dpc3RpY3MgRVRDLg0K
DQpBcHByZWNpYXRlIHlvdXIgcmVzcG9uc2UuDQoNClJlZ2FyZHMsDQpDbGFpcmUNCg0KQ2xhaXJl
IERhdmlzIHwgTWFya2V0aW5nIENvbnN1bHRhbnQNCg0KUmVwbHkgb25seSBvcHQtb3V0IGluIHRo
ZSBzdWJqZWN0IGxpbmUgdG8gcmVtb3ZlIGZyb20gdGhlIG1haWxpbmcgbGlzdC4NCg==
