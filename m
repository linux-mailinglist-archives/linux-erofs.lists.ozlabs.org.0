Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8845A034
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 11:28:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hz0hf6wXRz3hP1
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 21:28:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637663282;
	bh=Mp9KekZoSzctVdRzZ3aV/eYT7aGI1RfdkGzRiAIfTe8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=U5RscH/FJ1V+RzngXjx+hdTBFS0In9EultO/ZDh/kkvwTYKlfJHzmeAdyzgQqPPiA
	 L1WKSxCT+RcZXYew6j6xqaiuCRA+N0RNcpVUTCp21lQiTefx0IsBijC4KgeRNeR+0Y
	 8KhRGscaJSjgJC+uGf3s/qMpXMSkyss1/mpRa7wfytFmqawQIT+Cl5jo0fPC8WlJBc
	 xEkPeh/7XjPd5mUBL25jdTSZdkN1AdctJBRB0GBV8iGgEFQI0+HCVTfwf+WHXMDw16
	 QlSGJuSp4RXQT6cRxGfPn7tK4K5pPbQwmXBsdUUQqKFStqzBy9lBiR7gwSf0qfO8dX
	 2Dg95YuAjJipA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xiaomi.com (client-ip=207.226.244.123;
 helo=hkspamc1-admin.mioffice.cn; envelope-from=haojianhua1@xiaomi.com;
 receiver=<UNKNOWN>)
Received: from hkspamc1-admin.mioffice.cn (outboundhk.mxmail.xiaomi.com
 [207.226.244.123])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Hz09m0Mc9z3dr3
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 21:04:38 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.87,257,1631548800"; d="scan'208,217";a="12008220"
Received: from hk-mbx03.mioffice.cn (HELO xiaomi.com) ([10.56.8.123])
 by hkspamc1-admin.mioffice.cn with ESMTP; 23 Nov 2021 18:03:04 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 23 Nov 2021
 18:03:03 +0800
Received: from BJ-MBX06.mioffice.cn (10.237.8.126) by BJ-MBX01.mioffice.cn
 (10.237.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 23 Nov 2021
 18:03:03 +0800
Received: from BJ-MBX06.mioffice.cn ([::1]) by BJ-MBX06.mioffice.cn
 ([fe80::8c4e:49f9:763a:bb1e%13]) with mapi id 15.02.0986.009; Tue, 23 Nov
 2021 18:03:03 +0800
To: "xiang@kernel.org" <xiang@kernel.org>, Huang Jianan <huangjianan@oppo.com>
Subject: Re: [External Mail]Re: [PATCH] erofs: Deadlock caused by kswap work
 in low memory scenarios
Thread-Topic: [External Mail]Re: [PATCH] erofs: Deadlock caused by kswap work
 in low memory scenarios
Thread-Index: AQHX4BXCFCniJjbebUuSGL/F52pwsA==
Date: Tue, 23 Nov 2021 10:03:02 +0000
Message-ID: <85e3d32c89cc44c991bfc1aa24962228@xiaomi.com>
References: <669247783482488c8654c55e67fe1ac3@xiaomi.com>,
 <64eb8b6e-ee30-8649-ba42-e08db17dfea0@oppo.com>,
 <20211123051612.GA4009@hsiangkao-HP-ZHAN-66-Pro-G1>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: multipart/alternative;
 boundary="_000_85e3d32c89cc44c991bfc1aa24962228xiaomicom_"
MIME-Version: 1.0
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
From: =?utf-8?b?Smlhbmh1YTEgSGFvIOmDneW7uuWNjiB2aWEgTGludXgtZXJvZnM=?=
 <linux-erofs@lists.ozlabs.org>
Reply-To: =?utf-8?B?Smlhbmh1YTEgSGFvIOmDneW7uuWNjg==?= <haojianhua1@xiaomi.com>
Cc: "zhangshiming@oppo.com" <zhangshiming@oppo.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, "yh@oppo.com" <yh@oppo.com>,
 "guanyuwei@oppo.com" <guanyuwei@oppo.com>,
 "guoweichao@oppo.com" <guoweichao@oppo.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_85e3d32c89cc44c991bfc1aa24962228xiaomicom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmlhbmFuIGFuZCBHYW8gWGlhbmcNCg0KV2UgaGF2ZSBicm91Z2h0IHRoaXMgcGF0Y2ggZm9y
IHRlc3RpbmcuIFRoYW5rcyBmb3IgeW91ciByZXBseS4NCg0KDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpKaWFuaHVhMSBIYW8NCg0KRnJvbTogR2FvIFhpYW5nPG1haWx0bzp4
aWFuZ0BrZXJuZWwub3JnPg0KRGF0ZTogMjAyMS0xMS0yMyAxMzoxNg0KVG86IEh1YW5nIEppYW5h
bjxtYWlsdG86aHVhbmdqaWFuYW5Ab3Bwby5jb20+OyBKaWFuaHVhMSBIYW8g6YOd5bu65Y2OPG1h
aWx0bzpoYW9qaWFuaHVhMUB4aWFvbWkuY29tPg0KQ0M6IHhpYW5nQGtlcm5lbC5vcmc8bWFpbHRv
OnhpYW5nQGtlcm5lbC5vcmc+OyBsaW51eC1lcm9mczxtYWlsdG86bGludXgtZXJvZnNAbGlzdHMu
b3psYWJzLm9yZz47IGxpbnV4LWtlcm5lbDxtYWlsdG86bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IGNoYW88bWFpbHRvOmNoYW9Aa2VybmVsLm9yZz47IGd1b3dlaWNoYW9Ab3Bwby5jb208
bWFpbHRvOmd1b3dlaWNoYW9Ab3Bwby5jb20+OyBndWFueXV3ZWlAb3Bwby5jb208bWFpbHRvOmd1
YW55dXdlaUBvcHBvLmNvbT47IHloQG9wcG8uY29tPG1haWx0bzp5aEBvcHBvLmNvbT47IHpoYW5n
c2hpbWluZ0BvcHBvLmNvbTxtYWlsdG86emhhbmdzaGltaW5nQG9wcG8uY29tPg0KU3ViamVjdDog
W0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSF0gZXJvZnM6IERlYWRsb2NrIGNhdXNlZCBieSBrc3dh
cCB3b3JrIGluIGxvdyBtZW1vcnkgc2NlbmFyaW9zDQoqVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFhJQU9NSS4gUGxlYXNlIHRyZWF0IHRoaXMgZW1haWwgd2l0aCBjYXV0
aW9uKg0KDQoNCkhpIEppYW5hbiBhbmQgSmlhbmh1YSwNCg0KT24gVHVlLCBOb3YgMjMsIDIwMjEg
YXQgMTE6NTg6MzJBTSArMDgwMCwgSHVhbmcgSmlhbmFuIHdyb3RlOg0KPiDlnKggMjAyMS8xMS8y
MyAxMDo1OSwgSmlhbmh1YTEgSGFvIOmDneW7uuWNjiB2aWEgTGludXgtZXJvZnMg5YaZ6YGTOg0K
PiA+ICpXZSBhbHNvIGZvdW5kIHRoYXQgaXQgaXMgZWFzeSB0byBjYXVzZSBkZWFkbG9jayBpbiB0
aGUga3N3YXAgc2NlbmXvvIwgV2UNCj4gPiBvYnNlcnZlZCB0aGUgZm9sbG93aW5nIGRlYWRsb2Nr
IGluIHRoZSBzdHJlc3MgdGVzdCB1bmRlciBsb3cgbWVtb3J5DQo+ID4gc2NlbmFyaW/vvIwqKu+7
vyoqU2FtZSBhcyAiZXJvZnM6IGZpeCBkZWFkbG9jayB3aGVuIHNocmluayBlcm9mcyBzbGFiIi4q
DQo+ID4gKioNCj4gPg0KPiA+IFRocmVhZCBBOiBUaHJlYWQgQjoNCj4gPg0KPiA+IGVyb2ZzX3Ry
eV90b19yZWxlYXNlX3dvcmtncm91cChncnAgPQ0KPiA+IDB4RkZGRkZGODdBREZFRTYxMCllcm9m
c19pbnNlcnRfd29ya2dyb3VwKCkNCj4gPg0KPiA+IGVyb2ZzX3dvcmtncm91cF90cnlfdG9fZnJl
ZXplKGdycCwgMSkvL3hhIGxvY2sgaXMgaGVsZCBoZXJlDQo+ID4NCj4gPiAvL3NldCByZWYgY291
bnQgdG8gRVJPRlNfTE9DS0VEX01BR0lDeGFfbG9jaygmc2JpLT5tYW5hZ2VkX3BzbG90cyk7DQo+
ID4NCj4gPiBhdG9taWNfY21weGNoZygmZ3JwLT5yZWZjb3VudCwgdmFsLEVST0ZTX0xPQ0tFRF9N
QUdJQylwcmUgPQ0KPiA+IF9feGFfY21weGNoZygmc2JpLT5tYW5hZ2VkX3BzbG90cywgZ3JwLT5p
bmRleCwgTlVMTCwgZ3JwLCBHRlBfTk9GUyk7DQo+ID4NCj4gPiB4YV9lcmFzZSgmc2JpLT5tYW5h
Z2VkX3BzbG90cywgZ3JwLT5pbmRleCllcm9mc193b3JrZ3JvdXBfZ2V0KHByZSkNCj4gPiAvL3By
ZSA9IGdycCA9IDB4RkZGRkZGODdBREZFRTYxMA0KPiA+DQo+ID4gLy9zdHVjayB0aGVyZSB0byB3
YWl0IGZvciB4YSBsb2NrLCBhbHJlYWR5IGhlbGQgYnkgdGhyZWFkDQo+ID4gQmVyb2ZzX3dhaXRf
b25fd29ya2dyb3VwX2ZyZWV6ZWQoZ3JwKTsNCj4gPg0KPiA+IHhhX2xvY2soeGEpOyAvL3dhaXQg
cmVmIGNvdW50IHRvIGJlIHVubG9ja2VkLCB3aGljaCBzaG91bGQgYmUgZG9uZSBieQ0KPiA+IHRo
cmVhZCBBDQo+ID4NCj4gPiBhdG9taWNfY29uZF9yZWFkX3JlbGF4ZWQoJmdycC0+cmVmY291bnQs
IFZBTCAhPSBFUk9GU19MT0NLRURfTUFHSUMpOw0KPiA+DQo+ID4gRm9sbG93LXVwIGZpeDppdCBu
ZWVkIHRvIGhvbGQgdGhlIHhhIGxvY2sgYmVmb3JlIGZyZWV6ZSB0aGUgd29ya2dyb3VwDQo+ID4N
Cj4gPiBiZWFjdXNlIHdlIHdpbGwgb3BlcmF0ZSB4YXJyeT8NCj4gPg0KPiBIaSwgIEppYW5IdWEs
DQo+DQo+IFRoZSBmaXggaXMgaW4gdGhlIHBhdGNoLCBwbGVhc2UgdGVzdCBpdCBraW5kbHkgaWYg
eW91IGhhdmUgY29uZGl0aW9uLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1lcm9m
cy9ZWmNKcERzM0ZLcFNmekFFQEItUDdUUU1ENk0tMDE0Ni9ULyN0DQoNClRoYW5rcyBmb3IgdGhl
IHJlcG9ydCwgSSBoYWQgc29tZSBvdGhlciB3b3JrIHRvIGRvIGp1c3Qgbm93Lg0KDQpJJ3ZlIHB1
c2hlZCBvdXQgdGhpcyBwYXRjaCB0byBmaXhlcyBicmFuY2ggYW5kIHdpbGwgc2VuZCB0byBMaW51
cyB0aGlzDQp3ZWVrOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQveGlhbmcvZXJvZnMuZ2l0L2NvbW1pdC8/aWQ9ZGVjY2Q0NDRkMjg0NGYxZTg5MzE0ZGZj
Mzk1NmNjY2ZkYjgxM2I2NQ0KDQpBcyBKaWFuYW4gc2FpZCwgSSBiZWxpZXZlIHRoaXMgcGF0Y2gg
Y2FuIGZpeCB5b3VyIGlzc3VlIGFuZCBwbGVhc2UgdGFrZQ0KYSB0cnkgaW4gYWR2YW5jZS4gQWxz
bywgaXQgZG9lc24ndCBlZmZlY3QgdjQuMTkgYW5kIHY1LjQgTFRTLCBvbmx5IHY1LjEwDQphbmQg
djUuMTUgTFRTIGFyZSBpbXBhY3RlZC4NCg0KVGhhbmtzIGZvciB5b3VyIHJlcG9ydCENCkdhbyBY
aWFuZw0KDQojLyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOea
hOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuuea
hOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9
v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWI
tuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6
huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5
tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRh
aW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRl
ZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBh
Ym92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkg
d2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNj
bG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIg
dGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNl
aXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhv
bmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K

--_000_85e3d32c89cc44c991bfc1aa24962228xiaomicom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZT5ib2R5IHsgbGluZS1oZWlnaHQ6IDEu
NTsgfWJsb2NrcXVvdGUgeyBtYXJnaW4tdG9wOiAwcHg7IG1hcmdpbi1ib3R0b206IDBweDsgbWFy
Z2luLWxlZnQ6IDAuNWVtOyB9Ym9keSB7IGZvbnQtc2l6ZTogMTRweDsgZm9udC1mYW1pbHk6ICJN
aWNyb3NvZnQgWWFIZWkgVUkiOyBjb2xvcjogcmdiKDAsIDAsIDApOyBsaW5lLWhlaWdodDogMS41
OyB9PC9zdHlsZT4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdj48c3Bhbj48L3NwYW4+SGkgSmlhbmFu
IGFuZCZuYnNwOzxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiB0cmFuc3BhcmVudDsiPkdh
byBYaWFuZzwvc3Bhbj48L2Rpdj4NCjxkaXY+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6
IHRyYW5zcGFyZW50OyI+PGJyPg0KPC9zcGFuPjwvZGl2Pg0KPGRpdj5XZSBoYXZlIGJyb3VnaHQg
dGhpcyBwYXRjaCBmb3IgdGVzdGluZy4mbmJzcDtUaGFua3MgZm9yIHlvdXIgcmVwbHkuPC9kaXY+
DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+
DQo8aHIgc3R5bGU9IndpZHRoOiAyMTBweDsgaGVpZ2h0OiAxcHg7IiBjb2xvcj0iI2I1YzRkZiIg
c2l6ZT0iMSIgYWxpZ249ImxlZnQiPg0KPGRpdj48c3Bhbj4NCjxkaXYgc3R5bGU9Ik1BUkdJTjog
MTBweDsgRk9OVC1GQU1JTFk6IHZlcmRhbmE7IEZPTlQtU0laRTogMTBwdCI+DQo8ZGl2PkppYW5o
dWExIEhhbyZuYnNwOzwvZGl2Pg0KPC9kaXY+DQo8L3NwYW4+PC9kaXY+DQo8YmxvY2txdW90ZSBz
dHlsZT0ibWFyZ2luLVRvcDogMHB4OyBtYXJnaW4tQm90dG9tOiAwcHg7IG1hcmdpbi1MZWZ0OiAw
LjVlbTsgbWFyZ2luLVJpZ2h0OiBpbmhlcml0Ij4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8ZGl2IHN0
eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9wOnNvbGlkICNCNUM0REYgMS4wcHQ7cGFkZGluZzoz
LjBwdCAwY20gMGNtIDBjbSI+DQo8ZGl2IHN0eWxlPSJQQURESU5HLVJJR0hUOiA4cHg7IFBBRERJ
TkctTEVGVDogOHB4OyBGT05ULVNJWkU6IDEycHg7Rk9OVC1GQU1JTFk6dGFob21hO0NPTE9SOiMw
MDAwMDA7IEJBQ0tHUk9VTkQ6ICNlZmVmZWY7IFBBRERJTkctQk9UVE9NOiA4cHg7IFBBRERJTkct
VE9QOiA4cHgiPg0KPGRpdj48Yj5Gcm9tOjwvYj4mbmJzcDs8YSBocmVmPSJtYWlsdG86eGlhbmdA
a2VybmVsLm9yZyI+R2FvIFhpYW5nPC9hPjwvZGl2Pg0KPGRpdj48Yj5EYXRlOjwvYj4mbmJzcDsy
MDIxLTExLTIzJm5ic3A7MTM6MTY8L2Rpdj4NCjxkaXY+PGI+VG86PC9iPiZuYnNwOzxhIGhyZWY9
Im1haWx0bzpodWFuZ2ppYW5hbkBvcHBvLmNvbSI+SHVhbmcgSmlhbmFuPC9hPjsgPGEgaHJlZj0i
bWFpbHRvOmhhb2ppYW5odWExQHhpYW9taS5jb20iPg0KSmlhbmh1YTEgSGFvIOmDneW7uuWNjjwv
YT48L2Rpdj4NCjxkaXY+PGI+Q0M6PC9iPiZuYnNwOzxhIGhyZWY9Im1haWx0bzp4aWFuZ0BrZXJu
ZWwub3JnIj54aWFuZ0BrZXJuZWwub3JnPC9hPjsgPGEgaHJlZj0ibWFpbHRvOmxpbnV4LWVyb2Zz
QGxpc3RzLm96bGFicy5vcmciPg0KbGludXgtZXJvZnM8L2E+OyA8YSBocmVmPSJtYWlsdG86bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZyI+bGludXgta2VybmVsPC9hPjsgPGEgaHJlZj0ibWFp
bHRvOmNoYW9Aa2VybmVsLm9yZyI+DQpjaGFvPC9hPjsgPGEgaHJlZj0ibWFpbHRvOmd1b3dlaWNo
YW9Ab3Bwby5jb20iPmd1b3dlaWNoYW9Ab3Bwby5jb208L2E+OyA8YSBocmVmPSJtYWlsdG86Z3Vh
bnl1d2VpQG9wcG8uY29tIj4NCmd1YW55dXdlaUBvcHBvLmNvbTwvYT47IDxhIGhyZWY9Im1haWx0
bzp5aEBvcHBvLmNvbSI+eWhAb3Bwby5jb208L2E+OyA8YSBocmVmPSJtYWlsdG86emhhbmdzaGlt
aW5nQG9wcG8uY29tIj4NCnpoYW5nc2hpbWluZ0BvcHBvLmNvbTwvYT48L2Rpdj4NCjxkaXY+PGI+
U3ViamVjdDo8L2I+Jm5ic3A7W0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSF0gZXJvZnM6IERlYWRs
b2NrIGNhdXNlZCBieSBrc3dhcCB3b3JrIGluIGxvdyBtZW1vcnkgc2NlbmFyaW9zPC9kaXY+DQo8
L2Rpdj4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+KlRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20g
b3V0c2lkZSBvZiBYSUFPTUkuIFBsZWFzZSB0cmVhdCB0aGlzIGVtYWlsIHdpdGggY2F1dGlvbio8
L2Rpdj4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj5IaSBKaWFu
YW4gYW5kIEppYW5odWEsPC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj5PbiBUdWUsIE5v
diAyMywgMjAyMSBhdCAxMTo1ODozMkFNICYjNDM7MDgwMCwgSHVhbmcgSmlhbmFuIHdyb3RlOjwv
ZGl2Pg0KPGRpdj4mZ3Q7IOWcqCAyMDIxLzExLzIzIDEwOjU5LCBKaWFuaHVhMSBIYW8g6YOd5bu6
5Y2OIHZpYSBMaW51eC1lcm9mcyDlhpnpgZM6PC9kaXY+DQo8ZGl2PiZndDsgJmd0OyAqV2UgYWxz
byBmb3VuZCB0aGF0IGl0IGlzIGVhc3kgdG8gY2F1c2UgZGVhZGxvY2sgaW4gdGhlIGtzd2FwIHNj
ZW5l77yMIFdlPC9kaXY+DQo8ZGl2PiZndDsgJmd0OyBvYnNlcnZlZCB0aGUgZm9sbG93aW5nIGRl
YWRsb2NrIGluIHRoZSBzdHJlc3MgdGVzdCB1bmRlciBsb3cgbWVtb3J5PC9kaXY+DQo8ZGl2PiZn
dDsgJmd0OyBzY2VuYXJpb++8jCoq77u/KipTYW1lIGFzICZxdW90O2Vyb2ZzOiBmaXggZGVhZGxv
Y2sgd2hlbiBzaHJpbmsgZXJvZnMgc2xhYiZxdW90Oy4qPC9kaXY+DQo8ZGl2PiZndDsgJmd0OyAq
KjwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDs8L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7IFRocmVhZCBBOiBU
aHJlYWQgQjo8L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7PC9kaXY+DQo8ZGl2PiZndDsgJmd0OyBlcm9m
c190cnlfdG9fcmVsZWFzZV93b3JrZ3JvdXAoZ3JwID08L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7IDB4
RkZGRkZGODdBREZFRTYxMCllcm9mc19pbnNlcnRfd29ya2dyb3VwKCk8L2Rpdj4NCjxkaXY+Jmd0
OyAmZ3Q7PC9kaXY+DQo8ZGl2PiZndDsgJmd0OyBlcm9mc193b3JrZ3JvdXBfdHJ5X3RvX2ZyZWV6
ZShncnAsIDEpLy94YSBsb2NrIGlzIGhlbGQgaGVyZTwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDs8L2Rp
dj4NCjxkaXY+Jmd0OyAmZ3Q7IC8vc2V0IHJlZiBjb3VudCB0byBFUk9GU19MT0NLRURfTUFHSUN4
YV9sb2NrKCZhbXA7c2JpLSZndDttYW5hZ2VkX3BzbG90cyk7PC9kaXY+DQo8ZGl2PiZndDsgJmd0
OzwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDsgYXRvbWljX2NtcHhjaGcoJmFtcDtncnAtJmd0O3JlZmNv
dW50LCB2YWwsRVJPRlNfTE9DS0VEX01BR0lDKXByZSA9PC9kaXY+DQo8ZGl2PiZndDsgJmd0OyBf
X3hhX2NtcHhjaGcoJmFtcDtzYmktJmd0O21hbmFnZWRfcHNsb3RzLCBncnAtJmd0O2luZGV4LCBO
VUxMLCBncnAsIEdGUF9OT0ZTKTs8L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7PC9kaXY+DQo8ZGl2PiZn
dDsgJmd0OyB4YV9lcmFzZSgmYW1wO3NiaS0mZ3Q7bWFuYWdlZF9wc2xvdHMsIGdycC0mZ3Q7aW5k
ZXgpZXJvZnNfd29ya2dyb3VwX2dldChwcmUpPC9kaXY+DQo8ZGl2PiZndDsgJmd0OyAvL3ByZSA9
IGdycCA9IDB4RkZGRkZGODdBREZFRTYxMDwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDs8L2Rpdj4NCjxk
aXY+Jmd0OyAmZ3Q7IC8vc3R1Y2sgdGhlcmUgdG8gd2FpdCBmb3IgeGEgbG9jaywgYWxyZWFkeSBo
ZWxkIGJ5IHRocmVhZDwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDsgQmVyb2ZzX3dhaXRfb25fd29ya2dy
b3VwX2ZyZWV6ZWQoZ3JwKTs8L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7PC9kaXY+DQo8ZGl2PiZndDsg
Jmd0OyB4YV9sb2NrKHhhKTsgLy93YWl0IHJlZiBjb3VudCB0byBiZSB1bmxvY2tlZCwgd2hpY2gg
c2hvdWxkIGJlIGRvbmUgYnk8L2Rpdj4NCjxkaXY+Jmd0OyAmZ3Q7IHRocmVhZCBBPC9kaXY+DQo8
ZGl2PiZndDsgJmd0OzwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDsgYXRvbWljX2NvbmRfcmVhZF9yZWxh
eGVkKCZhbXA7Z3JwLSZndDtyZWZjb3VudCwgVkFMICE9IEVST0ZTX0xPQ0tFRF9NQUdJQyk7PC9k
aXY+DQo8ZGl2PiZndDsgJmd0OzwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDsgRm9sbG93LXVwIGZpeDpp
dCBuZWVkIHRvIGhvbGQgdGhlIHhhIGxvY2sgYmVmb3JlIGZyZWV6ZSB0aGUgd29ya2dyb3VwPC9k
aXY+DQo8ZGl2PiZndDsgJmd0OzwvZGl2Pg0KPGRpdj4mZ3Q7ICZndDsgYmVhY3VzZSB3ZSB3aWxs
IG9wZXJhdGUgeGFycnk/PC9kaXY+DQo8ZGl2PiZndDsgJmd0OzwvZGl2Pg0KPGRpdj4mZ3Q7IEhp
LCZuYnNwOyBKaWFuSHVhLDwvZGl2Pg0KPGRpdj4mZ3Q7PC9kaXY+DQo8ZGl2PiZndDsgVGhlIGZp
eCBpcyBpbiB0aGUgcGF0Y2gsIHBsZWFzZSB0ZXN0IGl0IGtpbmRseSBpZiB5b3UgaGF2ZSBjb25k
aXRpb24uPC9kaXY+DQo8ZGl2PiZndDsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZXJv
ZnMvWVpjSnBEczNGS3BTZnpBRUBCLVA3VFFNRDZNLTAxNDYvVC8jdDwvZGl2Pg0KPGRpdj4mbmJz
cDs8L2Rpdj4NCjxkaXY+VGhhbmtzIGZvciB0aGUgcmVwb3J0LCBJIGhhZCBzb21lIG90aGVyIHdv
cmsgdG8gZG8ganVzdCBub3cuPC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj5JJ3ZlIHB1
c2hlZCBvdXQgdGhpcyBwYXRjaCB0byBmaXhlcyBicmFuY2ggYW5kIHdpbGwgc2VuZCB0byBMaW51
cyB0aGlzPC9kaXY+DQo8ZGl2PndlZWs6PC9kaXY+DQo8ZGl2Pmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3hpYW5nL2Vyb2ZzLmdpdC9jb21taXQvP2lkPWRl
Y2NkNDQ0ZDI4NDRmMWU4OTMxNGRmYzM5NTZjY2NmZGI4MTNiNjU8L2Rpdj4NCjxkaXY+Jm5ic3A7
PC9kaXY+DQo8ZGl2PkFzIEppYW5hbiBzYWlkLCBJIGJlbGlldmUgdGhpcyBwYXRjaCBjYW4gZml4
IHlvdXIgaXNzdWUgYW5kIHBsZWFzZSB0YWtlPC9kaXY+DQo8ZGl2PmEgdHJ5IGluIGFkdmFuY2Uu
IEFsc28sIGl0IGRvZXNuJ3QgZWZmZWN0IHY0LjE5IGFuZCB2NS40IExUUywgb25seSB2NS4xMDwv
ZGl2Pg0KPGRpdj5hbmQgdjUuMTUgTFRTIGFyZSBpbXBhY3RlZC48L2Rpdj4NCjxkaXY+Jm5ic3A7
PC9kaXY+DQo8ZGl2PlRoYW5rcyBmb3IgeW91ciByZXBvcnQhPC9kaXY+DQo8ZGl2PkdhbyBYaWFu
ZzwvZGl2Pg0KPGRpdj4mbmJzcDs8L2Rpdj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KIy8qKioq
KirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/v
vIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTn
u4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zk
vYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5Hv
vInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzo
r7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7k
u7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlh
bCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhl
IHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcw0KIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVz
ZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRp
bmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXBy
b2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1t
YWlsIGluDQogZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFp
bCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_85e3d32c89cc44c991bfc1aa24962228xiaomicom_--
