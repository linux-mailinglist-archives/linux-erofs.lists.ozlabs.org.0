Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7B2E8367
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 10:50:56 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D6gJF3RlLzDqKL
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 20:50:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=outlook.com (client-ip=40.92.253.100;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huww98@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=ul22pI3b; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253100.outbound.protection.outlook.com [40.92.253.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6gJ519gYzDqHV
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jan 2021 20:50:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJuVuZ+IdddeJudzBjxLQ9Up8nsQIdRtkEltHTE6hapCy7k5wN5ehyvswFYMnwkKvbqaVda+xzO4muVvSELORdWT3Iiz0J7mwm3XbNkBKVL08A0zWKyG9VHqtpWvLfWMzIqMANdgYSfbCMWSWVaCCJPTFr8VTri5QQ69tH2a3oeAONECaVYOTqwE6IunfebgyUE+f883cKNtRSUVE0DiYCIwBB4H+yDc4Zh5TA2e1aPloUjyo6VF1ZCGgURoq8sDAORtwyRSaYJK7hD8Rh64wgLqLPoNLCUDyWCjUbL1v2ZxF9FUiSLw0GgEsGTTQAY7ZDLtgqEXMJbta15p4irYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fzJzhvBhM2oWjjrYfWdpzQor6stwZr9KTv0C3K7oc4=;
 b=ZCpTSqQ+ZPcRO8qAPTyTzAwfM3wsBDPnfC8KZeD9UPq//AH0F6dPfsFOShy0gMp4OLSykxtm+Shu0COXXP2inqObaQAZSpEb6RQm3sgge0aNR3/5/Ba4O+50nEfBZAySjPKV63ibVmM+jqmhWJju8jawwEuRTSFPrp/bUnQSZLfL1W8+soGVm1dsxg8+VYUwTFLf/EIsz2g4WkSNLT3lizKNKg3u3sz6Ua2+iIxWw64t1i2hXMLtlY+evSu9UFeb4fKjlOBNUXOu/21mHo31Uxpc9heTLwTQCsejg8KEyXT+05TQyPB34rRAuzmNZWTyoP+dmCbFP+18YzzjAkZvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fzJzhvBhM2oWjjrYfWdpzQor6stwZr9KTv0C3K7oc4=;
 b=ul22pI3bSJELOtkK/G2Y9Y4olRbeJEQdG4XeN+JeoMO3zDP6xQGLxVMtsTpD63NMn8X7bftYYhH9mNORMfsXniVzjgsl4vfoRaGRjtcD3abjYQ4ouzgwqdNWE7Jm+WyamhJOWiXD3O7jBbnMgWu1ia0y5n0h+gBc7OG7Kgih+RrM5M80PdB+vY5ZMt3A7ZQ4OdrjEc/xS9e2yZOI9DR+9oDUfT6W0NOdTDyYdgZBztBTKJ56FkW+F0ep1qV00KdbWD1mBCn6dOb23LiyvnPu8y+sg8Gk4s9amY+ZUKaRUAIqb64qXrO0kwTYuA7YZ7a/iCNFmynUb5uAH4W+4uFUFw==
Received: from SG2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::50) by
 SG2APC01HT237.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::458)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 1 Jan
 2021 09:50:24 +0000
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebd::53)
 by SG2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebd::214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Fri, 1 Jan 2021 09:50:24 +0000
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e]) by ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e%7]) with mapi id 15.20.3721.020; Fri, 1 Jan 2021
 09:50:24 +0000
From: =?gb2312?B?uvog5+LOxA==?= <huww98@outlook.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Thread-Topic: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Thread-Index: AQHW4B7UvtkbKVSyb0qE7Z6nlVRX4qoSgwOA
Date: Fri, 1 Jan 2021 09:50:24 +0000
Message-ID: <ME3P282MB1938B2C9837F9767503036D8C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
References: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:0CB3195AADC22B58D65BB34AF1B3280FED7C9555262CDE2B5B42266DAD209050;
 UpperCasedChecksum:CE5350615B5C15C741574773FB8656A685025095558FAD434E4CA5F5032A32DF;
 SizeAsReceived:7074; Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [LfTO76rsnxvo57xf+joAMbb+lWJjb/DLjTV7xrLrc6Pojv4KWa4ZMOoCfDaYWbhU]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 097a5eff-5e1e-44b0-859f-08d8ae3aa911
x-ms-traffictypediagnostic: SG2APC01HT237:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhaxWVYq+70nry9I4sVLPYcXEtNA84UxsdqLcL/8g6RrlF9+vliyHfzSR/eKQWyCcEGuCc/BmyJDR1ur6gJ91hPQhI7oJHys/eQYf2ZbmhIfcq4pGgGUrcf0hsN5y33pez3OHLH95EaSXs1FQ9gs+jayLgLRmDzUQHpQ0O/RGehcTaxQ2o0O6Go6njywCVdvX+7/D4D8IJ9bKLw7bOmUElVs61pDieZAgvFMed55VfvO6+AR5WaJbVNfpnT9JpR7
x-ms-exchange-antispam-messagedata: qqcPdU+tT6Em4uwxFFpJ6wmd25ZIovWO24jUSPHy5uSlLBoshftZqOvPelst7567F5YXXOfy2dogplmBvx39QdOl0fDENfenT0xw0majQOYdlOja14mwXw2UQmb6xINAK6x1bRWhupIepSO5y0jrneviOqCrQUELCMSDtJXgWyaGwn/Tv1xkEZkC9qntN5qhmepgMkQBwDULgL8c983AQg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_ME3P282MB1938B2C9837F9767503036D8C0D50ME3P282MB1938AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a5eff-5e1e-44b0-859f-08d8ae3aa911
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2021 09:50:24.0251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT237
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_ME3P282MB1938B2C9837F9767503036D8C0D50ME3P282MB1938AUSP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpUaGlzIGlzIG15IGZpcnN0IHRpbWUgc2VuZGluZyBwYXRjaGVzIGJ5IGVtYWls
LiBJZiBzb21ldGhpbmcgaXMgbm90IHByb3Blcmx5IGRvbmUsIHBsZWFzZSBwb2ludCBpdCBvdXQu
DQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIGZvciBub3c6IEhvdyBhbSBJIHN1cHBvc2VkIHRvIHN1Ym1p
dCBwYXRjaGVzIHRvIGVyb2ZzLXV0aWxzIG5vdz8gU29tZSBFLW1haWwgYWRkcmVzcyBsaXN0ZWQg
aW4gQVVUSE9SUyBhbmQgUkVBRE1FIHNlZW1zIG5vIGxvbmdlciB2YWxpZCAoZW1haWwgdG8gZ2Fv
eGlhbmcyNUBodWF3ZWkuY29tPG1haWx0bzpnYW94aWFuZzI1QGh1YXdlaS5jb20+IHdhcyByZWpl
Y3RlZCkuIElzIGl0IGVub3VnaCB0byBwb3N0IHRoZSBwYXRjaGVzIHRvIHRoaXMgbWFpbGluZyBs
aXN0PyBJIGFkZGVkIGFsbCBhZGRyZXNzZXMgaW4gUkVBRE1FLCBidXQgSSBnb3QgYSBtZXNzYWdl
IHNhaWQgbXkgZW1haWwgaXMgcmVqZWN0ZWQuIEmhr20gbm90IHN1cmUgd2hvIGFjdHVhbGx5IHJl
Y2VpdmVkIG15IGVtYWlsLg0KDQq3orz+yMs6ILr6IOfizsQ8bWFpbHRvOmh1d3c5OEBvdXRsb29r
LmNvbT4NCreiy83KsbzkOiAyMDIxxOox1MIxyNUgMTc6MTYNCsrVvP7IyzogTGkgR3VpZnU8bWFp
bHRvOmJsdWNlLmxpZ3VpZnVAaHVhd2VpLmNvbT47IE1pYW8gWGllPG1haWx0bzptaWFveGllQGh1
YXdlaS5jb20+OyBGYW5nIFdlaTxtYWlsdG86ZmFuZ3dlaTFAaHVhd2VpLmNvbT4NCrOty806IEdh
byBYaWFuZzxtYWlsdG86Z2FveGlhbmcyNUBodWF3ZWkuY29tPjsgQ2hhbyBZdTxtYWlsdG86eXVj
aGFvMEBodWF3ZWkuY29tPjsgbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZzxtYWlsdG86bGlu
dXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZz47ILr65+LOxDxtYWlsdG86aHV3dzk4QG91dGxvb2su
Y29tPg0K1vfM4jogW1BBVENIIDEvMl0gZXJvZnMtdXRpbHM6IG9wdGltaXplIG1rZnMgdG8gTyhO
KSwgTiA9ICNmaWxlcw0KDQpXaGVuIHVzaW5nIEVST0ZTIHRvIHBhY2sgb3VyIGRhdGFzZXQgd2hp
Y2ggY29uc2lzdHMgb2YgbWlsbGlvbnMgb2YNCmZpbGVzLCBta2ZzLmVyb2ZzIGlzIHZlcnkgc2xv
dyBjb21wYXJlZCB3aXRoIG1rc3F1YXNoZnMuDQoNClRoZSBib3R0bGVuZWNrIGlzIGBlcm9mc19i
YWxsb2NgIGFuZCBgZXJvZnNfbWFwYmhgIGZ1bmN0aW9uLCB3aGljaA0KaXRlcmF0ZSBvdmVyIGFs
bCBwcmV2aW91c2x5IGFsbG9jYXRlZCBidWZmZXIgYmxvY2tzLCBtYWtpbmcgdGhlDQpjb21wbGV4
aXR5IG9mIHRoZSBhbGdyaXRobSBPKE5eMikgd2hlcmUgTiBpcyB0aGUgbnVtYmVyIG9mIGZpbGVz
Lg0KDQpXaXRoIHRoaXMgcGF0Y2g6DQoNCiogZ2xvYmFsIGBsYXN0X21hcHBlZF9ibG9ja2AgaXMg
bWFudGFpbmVkIHRvIGF2b2lkIGZ1bGwgc2NhbiBpbg0KICBgZXJvZnNfbWFwYmhgIGZ1bmN0aW9u
Lg0KDQoqIGdsb2JhbCBgbm9uX2Z1bGxfYnVmZmVyX2Jsb2Nrc2AgbWFudGFpbnMgYSBsaXN0IG9m
IGJ1ZmZlciBibG9jayBmb3INCiAgZWFjaCB0eXBlIGFuZCBlYWNoIHBvc3NpYmxlIHJlbWFpbmlu
ZyBieXRlcyBpbiB0aGUgYmxvY2suIFRoZW4gaXQgaXMNCiAgdXNlZCB0byBpZGVudGlmeSB0aGUg
bW9zdCBzdWl0YWJsZSBibG9ja3MgaW4gZnV0dXJlIGBlcm9mc19iYWxsb2NgLA0KICBhdm9pZGlu
ZyBmdWxsIHNjYW4uDQoNClNvbWUgbmV3IGRhdGEgc3RydWN0dXJlIGlzIGFsbG9jYXRlZCBpbiB0
aGlzIHBhdGNoLCBtb3JlIFJBTSB1c2FnZSBpcw0KZXhwZWN0ZWQsIGJ1dCBub3QgbXVjaC4gV2hl
biBJIHRlc3QgaXQgd2l0aCBJbWFnZU5ldCBkYXRhc2V0ICgxLjMzTQ0KZmlsZXMpLCA3R2lCIFJB
TSBpcyBjb25zdW1lZCwgYW5kIGl0IHRha2VzIGFib3V0IDQgaG91cnMuIE1vc3QgdGltZSBpcw0K
c3BlbnQgb24gSU8uDQoNClNpZ25lZC1vZmYtYnk6IEh1IFdlaXdlbiA8aHV3dzk4QG91dGxvb2su
Y29tPg0KLS0tDQogbGliL2NhY2hlLmMgfCAxMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4OSBpbnNlcnRpb25z
KCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9jYWNoZS5jIGIvbGliL2Nh
Y2hlLmMNCmluZGV4IDBkNWM0YTUuLjM0MTJhMGIgMTAwNjQ0DQotLS0gYS9saWIvY2FjaGUuYw0K
KysrIGIvbGliL2NhY2hlLmMNCkBAIC0xOCw2ICsxOCwxOCBAQCBzdGF0aWMgc3RydWN0IGVyb2Zz
X2J1ZmZlcl9ibG9jayBibGtoID0gew0KIH07DQogc3RhdGljIGVyb2ZzX2Jsa190IHRhaWxfYmxr
YWRkcjsNCg0KKy8qKg0KKyAqIFNvbWUgYnVmZmVycyBhcmUgbm90IGZ1bGwsIHdlIGNhbiByZXVz
ZSBpdCB0byBzdG9yZSBtb3JlIGRhdGENCisgKiAyIGZvciBEQVRBLCBNRVRBDQorICogRVJPRlNf
QkxLU0laIGZvciBlYWNoIHBvc3NpYmxlIHJlbWFpbmluZyBieXRlcyBpbiB0aGUgbGFzdCBibG9j
aw0KKyAqKi8NCitzdGF0aWMgc3RydWN0IGVyb2ZzX2J1ZmZlcl9ibG9ja19yZWNvcmQgew0KKyAg
ICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQorICAgICAgIHN0cnVjdCBlcm9mc19idWZmZXJf
YmxvY2sgKmJiOw0KK30gbm9uX2Z1bGxfYnVmZmVyX2Jsb2Nrc1syXVtFUk9GU19CTEtTSVpdOw0K
Kw0KK3N0YXRpYyBzdHJ1Y3QgZXJvZnNfYnVmZmVyX2Jsb2NrICpsYXN0X21hcHBlZF9ibG9jayA9
ICZibGtoOw0KKw0KIHN0YXRpYyBib29sIGVyb2ZzX2JoX2ZsdXNoX2Ryb3BfZGlyZWN0bHkoc3Ry
dWN0IGVyb2ZzX2J1ZmZlcl9oZWFkICpiaCkNCiB7DQogICAgICAgICByZXR1cm4gZXJvZnNfYmhf
Zmx1c2hfZ2VuZXJpY19lbmQoYmgpOw0KQEAgLTYyLDYgKzc0LDEyIEBAIHN0cnVjdCBlcm9mc19i
aG9wcyBlcm9mc19idWZfd3JpdGVfYmhvcHMgPSB7DQogLyogcmV0dXJuIGJ1ZmZlcl9oZWFkIG9m
IGVyb2ZzIHN1cGVyIGJsb2NrICh3aXRoIHNpemUgMCkgKi8NCiBzdHJ1Y3QgZXJvZnNfYnVmZmVy
X2hlYWQgKmVyb2ZzX2J1ZmZlcl9pbml0KHZvaWQpDQogew0KKyAgICAgICBmb3IgKGludCBpID0g
MDsgaSA8IDI7IGkrKykgew0KKyAgICAgICAgICAgICAgIGZvciAoaW50IGogPSAwOyBqIDwgRVJP
RlNfQkxLU0laOyBqKyspIHsNCisgICAgICAgICAgICAgICAgICAgICAgIGluaXRfbGlzdF9oZWFk
KCZub25fZnVsbF9idWZmZXJfYmxvY2tzW2ldW2pdLmxpc3QpOw0KKyAgICAgICAgICAgICAgIH0N
CisgICAgICAgfQ0KKw0KICAgICAgICAgc3RydWN0IGVyb2ZzX2J1ZmZlcl9oZWFkICpiaCA9IGVy
b2ZzX2JhbGxvYyhNRVRBLCAwLCAwLCAwKTsNCg0KICAgICAgICAgaWYgKElTX0VSUihiaCkpDQpA
QCAtMTMxLDcgKzE0OSw4IEBAIHN0cnVjdCBlcm9mc19idWZmZXJfaGVhZCAqZXJvZnNfYmFsbG9j
KGludCB0eXBlLCBlcm9mc19vZmZfdCBzaXplLA0KIHsNCiAgICAgICAgIHN0cnVjdCBlcm9mc19i
dWZmZXJfYmxvY2sgKmN1ciwgKmJiOw0KICAgICAgICAgc3RydWN0IGVyb2ZzX2J1ZmZlcl9oZWFk
ICpiaDsNCi0gICAgICAgdW5zaWduZWQgaW50IGFsaWduc2l6ZSwgdXNlZDAsIHVzZWRtYXg7DQor
ICAgICAgIHVuc2lnbmVkIGludCBhbGlnbnNpemUsIHVzZWQwLCB1c2VkbWF4LCB0b3RhbF9zaXpl
Ow0KKyAgICAgICBzdHJ1Y3QgZXJvZnNfYnVmZmVyX2Jsb2NrX3JlY29yZCAqIHJldXNpbmcgPSBO
VUxMOw0KDQogICAgICAgICBpbnQgcmV0ID0gZ2V0X2FsaWduc2l6ZSh0eXBlLCAmdHlwZSk7DQoN
CkBAIC0xNDMsNyArMTYyLDM4IEBAIHN0cnVjdCBlcm9mc19idWZmZXJfaGVhZCAqZXJvZnNfYmFs
bG9jKGludCB0eXBlLCBlcm9mc19vZmZfdCBzaXplLA0KICAgICAgICAgdXNlZG1heCA9IDA7DQog
ICAgICAgICBiYiA9IE5VTEw7DQoNCi0gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShjdXIsICZi
bGtoLmxpc3QsIGxpc3QpIHsNCisgICAgICAgZXJvZnNfZGJnKCJiYWxsb2Mgc2l6ZT0lbHUgYWxp
Z25zaXplPSV1IHVzZWQwPSV1Iiwgc2l6ZSwgYWxpZ25zaXplLCB1c2VkMCk7DQorICAgICAgIGlm
ICh1c2VkMCA9PSAwIHx8IGFsaWduc2l6ZSA9PSBFUk9GU19CTEtTSVopIHsNCisgICAgICAgICAg
ICAgICBnb3RvIGFsbG9jOw0KKyAgICAgICB9DQorICAgICAgIHRvdGFsX3NpemUgPSBzaXplICsg
cmVxdWlyZWRfZXh0ICsgaW5saW5lX2V4dDsNCisgICAgICAgaWYgKHRvdGFsX3NpemUgPCBFUk9G
U19CTEtTSVopIHsNCisgICAgICAgICAgICAgICAvLyBUcnkgZmluZCBhIG1vc3QgZml0IGJsb2Nr
Lg0KKyAgICAgICAgICAgICAgIERCR19CVUdPTih0eXBlIDwgMCB8fCB0eXBlID4gMSk7DQorICAg
ICAgICAgICAgICAgc3RydWN0IGVyb2ZzX2J1ZmZlcl9ibG9ja19yZWNvcmQgKm5vbl9mdWxscyA9
IG5vbl9mdWxsX2J1ZmZlcl9ibG9ja3NbdHlwZV07DQorICAgICAgICAgICAgICAgZm9yIChzdHJ1
Y3QgZXJvZnNfYnVmZmVyX2Jsb2NrX3JlY29yZCAqciA9IG5vbl9mdWxscyArIHJvdW5kX3VwKHRv
dGFsX3NpemUsIGFsaWduc2l6ZSk7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIg
PCBub25fZnVsbHMgKyBFUk9GU19CTEtTSVo7IHIrKykgew0KKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCFsaXN0X2VtcHR5KCZyLT5saXN0KSkgew0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZXJvZnNfYnVmZmVyX2Jsb2NrX3JlY29yZCAqcmV1c2VfY2FuZGlkYXRl
ID0NCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpc3Rf
Zmlyc3RfZW50cnkoJnItPmxpc3QsIHN0cnVjdCBlcm9mc19idWZmZXJfYmxvY2tfcmVjb3JkLCBs
aXN0KTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gX19lcm9mc19iYXR0
YWNoKHJldXNlX2NhbmRpZGF0ZS0+YmIsIE5VTEwsIHNpemUsIGFsaWduc2l6ZSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlcXVpcmVkX2V4dCArIGlu
bGluZV9leHQsIHRydWUpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0
ID49IDApIHsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXVzaW5n
ID0gcmV1c2VfY2FuZGlkYXRlOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJiID0gcmV1c2VfY2FuZGlkYXRlLT5iYjsNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1c2VkbWF4ID0gKHJldCArIHJlcXVpcmVkX2V4dCkgJSBFUk9GU19CTEtT
SVogKyBpbmxpbmVfZXh0Ow0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KKyAgICAgICAgICAgICAgIH0NCisgICAgICAgfQ0KKw0KKyAgICAgICAvKiBUcnkgcmV1
c2UgbGFzdCBvbmVzLCB3aGljaCBhcmUgbm90IG1hcHBlZCBhbmQgY2FuIGJlIGV4dGVuZGVkICov
DQorICAgICAgIGN1ciA9IGxhc3RfbWFwcGVkX2Jsb2NrOw0KKyAgICAgICBpZiAoY3VyID09ICZi
bGtoKSB7DQorICAgICAgICAgICAgICAgY3VyID0gbGlzdF9uZXh0X2VudHJ5KGN1ciwgbGlzdCk7
DQorICAgICAgIH0NCisgICAgICAgZm9yICg7IGN1ciAhPSAmYmxraDsgY3VyID0gbGlzdF9uZXh0
X2VudHJ5KGN1ciwgbGlzdCkpIHsNCiAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHVzZWRf
YmVmb3JlLCB1c2VkOw0KDQogICAgICAgICAgICAgICAgIHVzZWRfYmVmb3JlID0gY3VyLT5idWZm
ZXJzLm9mZiAlIEVST0ZTX0JMS1NJWjsNCkBAIC0xNzUsMjIgKzIyNSwzMiBAQCBzdHJ1Y3QgZXJv
ZnNfYnVmZmVyX2hlYWQgKmVyb2ZzX2JhbGxvYyhpbnQgdHlwZSwgZXJvZnNfb2ZmX3Qgc2l6ZSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCg0KICAgICAgICAgICAgICAgICBp
ZiAodXNlZG1heCA8IHVzZWQpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldXNpbmcgPSBO
VUxMOw0KICAgICAgICAgICAgICAgICAgICAgICAgIGJiID0gY3VyOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgIHVzZWRtYXggPSB1c2VkOw0KICAgICAgICAgICAgICAgICB9DQogICAgICAgICB9
DQoNCiAgICAgICAgIGlmIChiYikgew0KKyAgICAgICAgICAgICAgIGVyb2ZzX2RiZygicmV1c2lu
ZyBidWZmZXIuIHVzZWRtYXg9JXUiLCB1c2VkbWF4KTsNCiAgICAgICAgICAgICAgICAgYmggPSBt
YWxsb2Moc2l6ZW9mKHN0cnVjdCBlcm9mc19idWZmZXJfaGVhZCkpOw0KICAgICAgICAgICAgICAg
ICBpZiAoIWJoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9N
RU0pOw0KKyAgICAgICAgICAgICAgIGlmIChyZXVzaW5nKSB7DQorICAgICAgICAgICAgICAgICAg
ICAgICBsaXN0X2RlbCgmcmV1c2luZy0+bGlzdCk7DQorICAgICAgICAgICAgICAgICAgICAgICBm
cmVlKHJldXNpbmcpOw0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgZ290byBm
b3VuZDsNCiAgICAgICAgIH0NCg0KK2FsbG9jOg0KICAgICAgICAgLyogYWxsb2NhdGUgYSBuZXcg
YnVmZmVyIGJsb2NrICovDQotICAgICAgIGlmICh1c2VkMCA+IEVST0ZTX0JMS1NJWikNCisgICAg
ICAgaWYgKHVzZWQwID4gRVJPRlNfQkxLU0laKSB7DQorICAgICAgICAgICAgICAgZXJvZnNfZGJn
KCJ1c2VkMCA+IEVST0ZTX0JMS1NJWiIpOw0KICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BU
UigtRU5PU1BDKTsNCisgICAgICAgfQ0KDQorICAgICAgIGVyb2ZzX2RiZygibmV3IGJ1ZmZlciBi
bG9jayIpOw0KICAgICAgICAgYmIgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCBlcm9mc19idWZmZXJf
YmxvY2spKTsNCiAgICAgICAgIGlmICghYmIpDQogICAgICAgICAgICAgICAgIHJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOw0KQEAgLTIxMSw2ICsyNzEsMTYgQEAgZm91bmQ6DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVxdWlyZWRfZXh0ICsgaW5saW5lX2V4dCwgZmFsc2UpOw0KICAg
ICAgICAgaWYgKHJldCA8IDApDQogICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKHJldCk7
DQorICAgICAgIGlmIChyZXQgIT0gMCkgew0KKyAgICAgICAgICAgICAgIC8qIFRoaXMgYnVmZmVy
IGlzIG5vdCBmdWxsIHlldCwgd2UgbWF5IHJldXNlIGl0ICovDQorICAgICAgICAgICAgICAgcmV1
c2luZyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IGVyb2ZzX2J1ZmZlcl9ibG9ja19yZWNvcmQpKTsN
CisgICAgICAgICAgICAgICBpZiAoIXJldXNpbmcpIHsNCisgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KKyAgICAgICAgICAgICAgIH0NCisgICAgICAgICAg
ICAgICByZXVzaW5nLT5iYiA9IGJiOw0KKyAgICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJnJl
dXNpbmctPmxpc3QsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZub25fZnVsbF9i
dWZmZXJfYmxvY2tzW3R5cGVdW0VST0ZTX0JMS1NJWiAtIHJldCAtIGlubGluZV9leHRdLmxpc3Qp
Ow0KKyAgICAgICB9DQogICAgICAgICByZXR1cm4gYmg7DQogfQ0KDQpAQCAtMjQ3LDggKzMxNywx
MCBAQCBzdGF0aWMgZXJvZnNfYmxrX3QgX19lcm9mc19tYXBiaChzdHJ1Y3QgZXJvZnNfYnVmZmVy
X2Jsb2NrICpiYikNCiB7DQogICAgICAgICBlcm9mc19ibGtfdCBibGthZGRyOw0KDQotICAgICAg
IGlmIChiYi0+YmxrYWRkciA9PSBOVUxMX0FERFIpDQorICAgICAgIGlmIChiYi0+YmxrYWRkciA9
PSBOVUxMX0FERFIpIHsNCiAgICAgICAgICAgICAgICAgYmItPmJsa2FkZHIgPSB0YWlsX2Jsa2Fk
ZHI7DQorICAgICAgICAgICAgICAgbGFzdF9tYXBwZWRfYmxvY2sgPSBiYjsNCisgICAgICAgfQ0K
DQogICAgICAgICBibGthZGRyID0gYmItPmJsa2FkZHIgKyBCTEtfUk9VTkRfVVAoYmItPmJ1ZmZl
cnMub2ZmKTsNCiAgICAgICAgIGlmIChibGthZGRyID4gdGFpbF9ibGthZGRyKQ0KQEAgLTI1OSwx
NSArMzMxLDE2IEBAIHN0YXRpYyBlcm9mc19ibGtfdCBfX2Vyb2ZzX21hcGJoKHN0cnVjdCBlcm9m
c19idWZmZXJfYmxvY2sgKmJiKQ0KDQogZXJvZnNfYmxrX3QgZXJvZnNfbWFwYmgoc3RydWN0IGVy
b2ZzX2J1ZmZlcl9ibG9jayAqYmIsIGJvb2wgZW5kKQ0KIHsNCi0gICAgICAgc3RydWN0IGVyb2Zz
X2J1ZmZlcl9ibG9jayAqdCwgKm50Ow0KLQ0KLSAgICAgICBpZiAoIWJiIHx8IGJiLT5ibGthZGRy
ID09IE5VTExfQUREUikgew0KLSAgICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZSh0LCBudCwgJmJsa2gubGlzdCwgbGlzdCkgew0KLSAgICAgICAgICAgICAgICAgICAgICAgaWYg
KCFlbmQgJiYgKHQgPT0gYmIgfHwgbnQgPT0gJmJsa2gpKQ0KLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCi0gICAgICAgICAgICAgICAgICAgICAgICh2b2lkKV9fZXJvZnNf
bWFwYmgodCk7DQotICAgICAgICAgICAgICAgICAgICAgICBpZiAoZW5kICYmIHQgPT0gYmIpDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICBEQkdfQlVHT04o
IWVuZCk7DQorICAgICAgIHN0cnVjdCBlcm9mc19idWZmZXJfYmxvY2sgKnQgPSBsYXN0X21hcHBl
ZF9ibG9jazsNCisgICAgICAgd2hpbGUgKDEpIHsNCisgICAgICAgICAgICAgICB0ID0gbGlzdF9u
ZXh0X2VudHJ5KHQsIGxpc3QpOw0KKyAgICAgICAgICAgICAgIGlmICh0ID09ICZibGtoKSB7DQor
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgICAgICAgICB9DQorICAgICAg
ICAgICAgICAgKHZvaWQpX19lcm9mc19tYXBiaCh0KTsNCisgICAgICAgICAgICAgICBpZiAodCA9
PSBiYikgew0KKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAg
IH0NCiAgICAgICAgIH0NCiAgICAgICAgIHJldHVybiB0YWlsX2Jsa2FkZHI7DQpAQCAtMzM0LDYg
KzQwNyw5IEBAIHZvaWQgZXJvZnNfYmRyb3Aoc3RydWN0IGVyb2ZzX2J1ZmZlcl9oZWFkICpiaCwg
Ym9vbCB0cnlyZXZva2UpDQogICAgICAgICBpZiAoIWxpc3RfZW1wdHkoJmJiLT5idWZmZXJzLmxp
c3QpKQ0KICAgICAgICAgICAgICAgICByZXR1cm47DQoNCisgICAgICAgaWYgKGJiID09IGxhc3Rf
bWFwcGVkX2Jsb2NrKSB7DQorICAgICAgICAgICAgICAgbGFzdF9tYXBwZWRfYmxvY2sgPSBsaXN0
X3ByZXZfZW50cnkoYmIsIGxpc3QpOw0KKyAgICAgICB9DQogICAgICAgICBsaXN0X2RlbCgmYmIt
Pmxpc3QpOw0KICAgICAgICAgZnJlZShiYik7DQoNCi0tDQoyLjMwLjANCg0K

--_000_ME3P282MB1938B2C9837F9767503036D8C0D50ME3P282MB1938AUSP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This is my first time sending p=
atches by email. If something is not properly done, please point it out.</s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have a question for now: How =
am I supposed to submit patches to erofs-utils now? Some E-mail address lis=
ted in AUTHORS and README seems no longer valid (email to
<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a> was reje=
cted). Is it enough to post the patches to this mailing list? I added all a=
ddresses in README, but I got a message said my email is rejected. I=A1=AFm=
 not sure who actually received my email.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:SimSun"><o:p>&nbsp;</o:p></span></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><b>=B7=A2=BC=FE=C8=
=CB<span lang=3D"EN-US">: </span>
</b><span lang=3D"EN-US"><a href=3D"mailto:huww98@outlook.com"><span lang=
=3D"EN-US"><span lang=3D"EN-US">=BA=FA</span></span><span lang=3D"EN-US"><s=
pan lang=3D"EN-US">
</span></span><span lang=3D"EN-US"><span lang=3D"EN-US">=E7=E2=CE=C4</span>=
</span></a><br>
</span><b>=B7=A2=CB=CD=CA=B1=BC=E4<span lang=3D"EN-US">: </span></b><span l=
ang=3D"EN-US">2021</span>=C4=EA<span lang=3D"EN-US">1</span>=D4=C2<span lan=
g=3D"EN-US">1</span>=C8=D5<span lang=3D"EN-US"> 17:16<br>
</span><b>=CA=D5=BC=FE=C8=CB<span lang=3D"EN-US">: </span></b><span lang=3D=
"EN-US"><a href=3D"mailto:bluce.liguifu@huawei.com">Li Guifu</a>;
<a href=3D"mailto:miaoxie@huawei.com">Miao Xie</a>; <a href=3D"mailto:fangw=
ei1@huawei.com">
Fang Wei</a><br>
</span><b>=B3=AD=CB=CD<span lang=3D"EN-US">: </span></b><span lang=3D"EN-US=
"><a href=3D"mailto:gaoxiang25@huawei.com">Gao Xiang</a>;
<a href=3D"mailto:yuchao0@huawei.com">Chao Yu</a>; <a href=3D"mailto:linux-=
erofs@lists.ozlabs.org">
linux-erofs@lists.ozlabs.org</a>; <a href=3D"mailto:huww98@outlook.com"><sp=
an lang=3D"EN-US"><span lang=3D"EN-US">=BA=FA=E7=E2=CE=C4</span></span></a>=
<br>
</span><b>=D6=F7=CC=E2<span lang=3D"EN-US">: </span></b><span lang=3D"EN-US=
">[PATCH 1/2] erofs-utils: optimize mkfs to O(N), N =3D #files</span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:SimSun"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">When using EROFS to pack our dataset which consi=
sts of millions of<br>
files, mkfs.erofs is very slow compared with mksquashfs.<br>
<br>
The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which<br>
iterate over all previously allocated buffer blocks, making the<br>
complexity of the algrithm O(N^2) where N is the number of files.<br>
<br>
With this patch:<br>
<br>
* global `last_mapped_block` is mantained to avoid full scan in<br>
&nbsp; `erofs_mapbh` function.<br>
<br>
* global `non_full_buffer_blocks` mantains a list of buffer block for<br>
&nbsp; each type and each possible remaining bytes in the block. Then it is=
<br>
&nbsp; used to identify the most suitable blocks in future `erofs_balloc`,<=
br>
&nbsp; avoiding full scan.<br>
<br>
Some new data structure is allocated in this patch, more RAM usage is<br>
expected, but not much. When I test it with ImageNet dataset (1.33M<br>
files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is<br>
spent on IO.<br>
<br>
Signed-off-by: Hu Weiwen &lt;huww98@outlook.com&gt;<br>
---<br>
&nbsp;lib/cache.c | 102 +++++++++++++++++++++++++++++++++++++++++++++------=
-<br>
&nbsp;1 file changed, 89 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/lib/cache.c b/lib/cache.c<br>
index 0d5c4a5..3412a0b 100644<br>
--- a/lib/cache.c<br>
+++ b/lib/cache.c<br>
@@ -18,6 +18,18 @@ static struct erofs_buffer_block blkh =3D {<br>
&nbsp;};<br>
&nbsp;static erofs_blk_t tail_blkaddr;<br>
&nbsp;<br>
+/**<br>
+ * Some buffers are not full, we can reuse it to store more data<br>
+ * 2 for DATA, META<br>
+ * EROFS_BLKSIZ for each possible remaining bytes in the last block<br>
+ **/<br>
+static struct erofs_buffer_block_record {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block *bb;<br>
+} non_full_buffer_blocks[2][EROFS_BLKSIZ];<br>
+<br>
+static struct erofs_buffer_block *last_mapped_block =3D &amp;blkh;<br>
+<br>
&nbsp;static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return erofs_bh_flush_gene=
ric_end(bh);<br>
@@ -62,6 +74,12 @@ struct erofs_bhops erofs_buf_write_bhops =3D {<br>
&nbsp;/* return buffer_head of erofs super block (with size 0) */<br>
&nbsp;struct erofs_buffer_head *erofs_buffer_init(void)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int i =3D 0; i &lt; 2; i++) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (int j =3D 0; j &lt; EROFS_BLKSIZ; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_list_head(&=
amp;non_full_buffer_blocks[i][j].list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_head *=
bh =3D erofs_balloc(META, 0, 0, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(bh))<br>
@@ -131,7 +149,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_=
off_t size,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block =
*cur, *bb;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_head *=
bh;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alignsize, used0, usedma=
x;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alignsize, used0, usedma=
x, total_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block_record * re=
using =3D NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D get_alignsize(=
type, &amp;type);<br>
&nbsp;<br>
@@ -143,7 +162,38 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs=
_off_t size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usedmax =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(cur, &amp;blkh.li=
st, list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; erofs_dbg(&quot;balloc size=3D%lu ali=
gnsize=3D%u used0=3D%u&quot;, size, alignsize, used0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used0 =3D=3D 0 || alignsize =3D=
=3D EROFS_BLKSIZ) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto alloc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_size =3D size + required_ext + =
inline_ext;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_size &lt; EROFS_BLKSIZ) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; // Try find a most fit block.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DBG_BUGON(type &lt; 0 || type &gt; 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct erofs_buffer_block_record *non_fulls =3D non_full_buffer_=
blocks[type];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (struct erofs_buffer_block_record *r =3D non_fulls + round_u=
p(total_size, alignsize);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r &lt; non_fulls + EROFS_BLKSIZ; r++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(=
&amp;r-&gt;list)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block_record *reuse_can=
didate =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_first_entry(&amp;=
r-&gt;list, struct erofs_buffer_block_record, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D __erofs_battach(reuse_candidate-&gt=
;bb, NULL, size, alignsize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; required_ext + inline_=
ext, true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; reusing =3D reuse_candidate;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb =3D reuse_candidate-&gt;bb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; usedmax =3D (ret + required_ext) % EROFS_BLKSIZ + inline_ext;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try reuse last ones, which are not=
 mapped and can be extended */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur =3D last_mapped_block;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cur =3D=3D &amp;blkh) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur =3D list_next_entry(cur, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; cur !=3D &amp;blkh; cur =3D li=
st_next_entry(cur, list)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned int used_before, used;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; used_before =3D cur-&gt;buffers.off % EROFS_BLKSIZ;<b=
r>
@@ -175,22 +225,32 @@ struct erofs_buffer_head *erofs_balloc(int type, erof=
s_off_t size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (usedmax &lt; used) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reusing =3D NULL=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb =
=3D cur;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usedm=
ax =3D used;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; erofs_dbg(&quot;reusing buffer. usedmax=3D%u&quot;, usedmax);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bh =3D malloc(sizeof(struct erofs_buffer_head));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!bh)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ERR_PTR(-ENOMEM);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (reusing) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;re=
using-&gt;list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(reusing);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto found;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+alloc:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate a new buffer b=
lock */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used0 &gt; EROFS_BLKSIZ)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used0 &gt; EROFS_BLKSIZ) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; erofs_dbg(&quot;used0 &gt; EROFS_BLKSIZ&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-ENOSPC);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; erofs_dbg(&quot;new buffer block&quot=
;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb =3D malloc(sizeof(struc=
t erofs_buffer_block));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-ENOMEM);<br>
@@ -211,6 +271,16 @@ found:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; required_ext + inline_ext, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ERR_PTR(ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* This buffer is not full yet, we may reuse it */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reusing =3D malloc(sizeof(struct erofs_buffer_block_record));<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!reusing) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-=
ENOMEM);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reusing-&gt;bb =3D bb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_add_tail(&amp;reusing-&gt;list,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;non_full_buffer_blocks[type][EROFS_BLK=
SIZ - ret - inline_ext].list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bh;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -247,8 +317,10 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_b=
lock *bb)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; erofs_blk_t blkaddr;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb-&gt;blkaddr =3D=3D NULL_ADDR)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb-&gt;blkaddr =3D=3D NULL_ADDR) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bb-&gt;blkaddr =3D tail_blkaddr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; last_mapped_block =3D bb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blkaddr =3D bb-&gt;blkaddr=
 + BLK_ROUND_UP(bb-&gt;buffers.off);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (blkaddr &gt; tail_blka=
ddr)<br>
@@ -259,15 +331,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_=
block *bb)<br>
&nbsp;<br>
&nbsp;erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block *t, *nt;<br=
>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bb || bb-&gt;blkaddr =3D=3D NULL=
_ADDR) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry_safe(t, nt, &amp;blkh.list, list) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!end &amp;&a=
mp; (t =3D=3D bb || nt =3D=3D &amp;blkh))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void)__erofs_ma=
pbh(t);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (end &amp;&am=
p; t =3D=3D bb)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBG_BUGON(!end);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct erofs_buffer_block *t =3D last=
_mapped_block;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; t =3D list_next_entry(t, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (t =3D=3D &amp;blkh) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (void)__erofs_mapbh(t);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (t =3D=3D bb) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return tail_blkaddr;<br>
@@ -334,6 +407,9 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool try=
revoke)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;bb-&g=
t;buffers.list))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb =3D=3D last_mapped_block) {<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; last_mapped_block =3D list_prev_entry(bb, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;bb-&gt;list)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(bb);<br>
&nbsp;<br>
-- <br>
2.30.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:SimSun"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_ME3P282MB1938B2C9837F9767503036D8C0D50ME3P282MB1938AUSP_--
