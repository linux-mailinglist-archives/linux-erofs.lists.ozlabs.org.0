Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112A75929E
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 12:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689761988;
	bh=SPBETE+AXFG0rt8Z6xYv+eUYlzu7VmJS8fuNDSekMIY=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hoeniaBR2rjsruXqVmgTbe5QUc7xFPZQt/I+ekSBuza0406NbHVRaFPni5B8MI/8e
	 1ff1U/LV3PdPNPLqr+tzVG2EWU8u6MsI0mX1ZiGiF7Ke+vyAhI/RwUcVxlfTy/t1Oa
	 DGb1bGD6VwNjuiNfJyJ5wpr4Ul53PDroCNCNX2dx2LVOSjcibR6g0yFxGQjf4aE17x
	 BSXaHAkPk0ehdoBDwa5xujx7h5aePUxjg0FZ8v/i2V3y+W9hU4BpFW+ZTaGGfDGEG3
	 T3HmaALujctgDUskz9QnnuJpMDNIlzWTDcOwCxz3DMmoMgRiuM6tbzxzZRETxKwLKs
	 ZIWokWLYiCJ2A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5Wyr05rMz304b
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 20:19:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=sunshijie@xiaomi.com; receiver=lists.ozlabs.org)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5Wym2Qbnz2xwD
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 20:19:44 +1000 (AEST)
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208,217";a="84746485"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 19 Jul 2023 18:19:43 +0800
Received: from BJ-MBX14.mioffice.cn (10.237.8.134) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 19 Jul
 2023 18:19:43 +0800
Received: from BJ-MBX18.mioffice.cn (10.237.8.138) by BJ-MBX14.mioffice.cn
 (10.237.8.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 19 Jul
 2023 18:19:42 +0800
Received: from BJ-MBX18.mioffice.cn ([fe80::99b2:c42d:33a0:2439]) by
 BJ-MBX18.mioffice.cn ([fe80::99b2:c42d:33a0:2439%16]) with mapi id
 15.02.1258.016; Wed, 19 Jul 2023 18:19:42 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdW1BBVENIXSBlcm9mczogZml4IHdyb25n?=
 =?gb2312?Q?_primary_bvec_selection_on_deduplicated_extents?=
Thread-Topic: [External Mail][PATCH] erofs: fix wrong primary bvec selection
 on deduplicated extents
Thread-Index: AQHZug380BXfCK+Su0ukiPiuBvsgQa/A360pgAABBOA=
Date: Wed, 19 Jul 2023 10:19:42 +0000
Message-ID: <c9142b7608054e8884b1c9dcc5e52761@xiaomi.com>
References: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>,<4a9259a9675e48e083139c22f7a86c8c@xiaomi.com>
In-Reply-To: <4a9259a9675e48e083139c22f7a86c8c@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: multipart/alternative;
	boundary="_000_c9142b7608054e8884b1c9dcc5e52761xiaomicom_"
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
From: =?utf-8?b?5a2Z5aOr5p2wIHZpYSBMaW51eC1lcm9mcw==?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb2312?B?y+/Kv73c?= <sunshijie@xiaomi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_c9142b7608054e8884b1c9dcc5e52761xiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

R2FvIFhpYW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+Ow0KbGludXgtZXJvZnNAbGlz
dHMub3psYWJzLm9yZzsNCkxLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQpXaGVu
IGhhbmRsaW5nIGRlZHVwbGljYXRlZCBjb21wcmVzc2VkIGRhdGEsIHRoZXJlIGNhbiBiZSBtdWx0
aXBsZQ0KZGVjb21wcmVzc2VkIGV4dGVudHMgcG9pbnRpbmcgdG8gdGhlIHNhbWUgY29tcHJlc3Nl
ZCBkYXRhIGluIG9uZSBzaG90Lg0KDQpJbiBzdWNoIGNhc2VzLCB0aGUgYnZlY3Mgd2hpY2ggYmVs
b25nIHRvIHRoZSBsb25nZXN0IGV4dGVudCB3aWxsIGJlDQpzZWxlY3RlZCBhcyB0aGUgcHJpbWFy
eSBidmVjcyBmb3IgcmVhbCBkZWNvbXByZXNzb3JzIHRvIGRlY29kZSBhbmQgdGhlDQpvdGhlciBk
dXBsaWNhdGVkIGJ2ZWNzIHdpbGwgYmUgZGlyZWN0bHkgY29waWVkIGZyb20gdGhlIHByaW1hcnkg
YnZlY3MuDQoNClByZXZpb3VzbHksIG9ubHkgcmVsYXRpdmUgb2Zmc2V0cyBvZiB0aGUgbG9uZ2Vz
dCBleHRlbnQgd2FzIGNoZWNrZWQgdG8NCmRlY29tcHJlc3MgdGhlIHByaW1hcnkgYnZlY3MuICBP
biByYXJlIG9jY2FzaW9ucywgaXQgY2FuIGJlIGluY29ycmVjdA0KaWYgdGhlcmUgYXJlIHNldmVy
YWwgZXh0ZW50cyB3aXRoIHRoZSBzYW1lIHN0YXJ0IHJlbGF0aXZlIG9mZnNldC4NCkFzIGEgcmVz
dWx0LCBzb21lIHNob3J0IGJ2ZWNzIGNvdWxkIGJlIHNlbGVjdGVkIGZvciBkZWNvbXByZXNzaW9u
IGFuZA0KdGhlbiBjYXVzZSBkYXRhIGNvcnJ1cHRpb24uDQoNCkZvciBleGFtcGxlLCBhcyBTaGlq
aWUgU3VuIHJlcG9ydGVkIG9mZi1saXN0LCBjb25zaWRlcmluZyB0aGUgZm9sbG93aW5nDQpleHRl
bnRzIG9mIGEgZmlsZToNCiAxMTc6ICAgOTAzMzQ1Li4gIDkxNTI1MCB8ICAgMTE5MDUgOiAgICAg
Mzg1MDI0Li4gICAgMzg5MTIwIHwgICAgNDA5Ng0KLi4uDQogMTE5OiAgIDkxOTcyOS4uICA5MzAz
MjMgfCAgIDEwNTk0IDogICAgIDM4NTAyNC4uICAgIDM4OTEyMCB8ICAgIDQwOTYNCi4uLg0KIDEy
NDogICA5Njg4ODEuLiAgOTgwNzg2IHwgICAxMTkwNSA6ICAgICAzODUwMjQuLiAgICAzODkxMjAg
fCAgICA0MDk2DQoNClRoZSBzdGFydCByZWxhdGl2ZSBvZmZzZXQgaXMgdGhlIHNhbWU6IDIyMjUs
IGJ1dCBleHRlbnQgMTE5ICg5MTk3MjkuLg0KOTMwMzIzKSBpcyBzaG9ydGVyIHRoYW4gdGhlIG90
aGVycy4NCg0KTGV0J3MgcmVzdHJpY3QgdGhlIGJ2ZWMgbGVuZ3RoIGluIGFkZGl0aW9uIHRvIHRo
ZSBzdGFydCBvZmZzZXQgaWYgYnZlY3MNCmFyZSBub3QgZnVsbC4NCg0KUmVwb3J0ZWQtYnk6IFNo
aWppZSBTdW4gPHN1bnNoaWppZUB4aWFvbWkuY29tPg0KRml4ZXM6IDVjMmE2NDI1MmM1ZCAoImVy
b2ZzOiBpbnRyb2R1Y2UgcGFydGlhbC1yZWZlcmVuY2VkIHBjbHVzdGVycyIpDQpTaWduZWQtb2Zm
LWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4NCg0KVGVzdGVkLWJ5
OiBTaGlqaWUgU3VuIDxzdW5zaGlqaWVAeGlhb21pLmNvbT4NCg0KVGhhbmtzLA0KU3VuIFNoaWpp
ZQ0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IMvvyr+93A0K
t6LLzcqxvOQ6IDIwMjPE6jfUwjE5yNUgMTg6MTc6NDANCsrVvP7IyzogR2FvIFhpYW5nOyBsaW51
eC1lcm9mc0BsaXN0cy5vemxhYnMub3JnDQqzrcvNOiBMS01MDQrW98ziOiC08Li0OiBbRXh0ZXJu
YWwgTWFpbF1bUEFUQ0hdIGVyb2ZzOiBmaXggd3JvbmcgcHJpbWFyeSBidmVjIHNlbGVjdGlvbiBv
biBkZWR1cGxpY2F0ZWQgZXh0ZW50cw0KDQoNCldoZW4gaGFuZGxpbmcgZGVkdXBsaWNhdGVkIGNv
bXByZXNzZWQgZGF0YSwgdGhlcmUgY2FuIGJlIG11bHRpcGxlDQpkZWNvbXByZXNzZWQgZXh0ZW50
cyBwb2ludGluZyB0byB0aGUgc2FtZSBjb21wcmVzc2VkIGRhdGEgaW4gb25lIHNob3QuDQoNCklu
IHN1Y2ggY2FzZXMsIHRoZSBidmVjcyB3aGljaCBiZWxvbmcgdG8gdGhlIGxvbmdlc3QgZXh0ZW50
IHdpbGwgYmUNCnNlbGVjdGVkIGFzIHRoZSBwcmltYXJ5IGJ2ZWNzIGZvciByZWFsIGRlY29tcHJl
c3NvcnMgdG8gZGVjb2RlIGFuZCB0aGUNCm90aGVyIGR1cGxpY2F0ZWQgYnZlY3Mgd2lsbCBiZSBk
aXJlY3RseSBjb3BpZWQgZnJvbSB0aGUgcHJpbWFyeSBidmVjcy4NCg0KUHJldmlvdXNseSwgb25s
eSByZWxhdGl2ZSBvZmZzZXRzIG9mIHRoZSBsb25nZXN0IGV4dGVudCB3YXMgY2hlY2tlZCB0bw0K
ZGVjb21wcmVzcyB0aGUgcHJpbWFyeSBidmVjcy4gIE9uIHJhcmUgb2NjYXNpb25zLCBpdCBjYW4g
YmUgaW5jb3JyZWN0DQppZiB0aGVyZSBhcmUgc2V2ZXJhbCBleHRlbnRzIHdpdGggdGhlIHNhbWUg
c3RhcnQgcmVsYXRpdmUgb2Zmc2V0Lg0KQXMgYSByZXN1bHQsIHNvbWUgc2hvcnQgYnZlY3MgY291
bGQgYmUgc2VsZWN0ZWQgZm9yIGRlY29tcHJlc3Npb24gYW5kDQp0aGVuIGNhdXNlIGRhdGEgY29y
cnVwdGlvbi4NCg0KRm9yIGV4YW1wbGUsIGFzIFNoaWppZSBTdW4gcmVwb3J0ZWQgb2ZmLWxpc3Qs
IGNvbnNpZGVyaW5nIHRoZSBmb2xsb3dpbmcNCmV4dGVudHMgb2YgYSBmaWxlOg0KIDExNzogICA5
MDMzNDUuLiAgOTE1MjUwIHwgICAxMTkwNSA6ICAgICAzODUwMjQuLiAgICAzODkxMjAgfCAgICA0
MDk2DQouLi4NCiAxMTk6ICAgOTE5NzI5Li4gIDkzMDMyMyB8ICAgMTA1OTQgOiAgICAgMzg1MDI0
Li4gICAgMzg5MTIwIHwgICAgNDA5Ng0KLi4uDQogMTI0OiAgIDk2ODg4MS4uICA5ODA3ODYgfCAg
IDExOTA1IDogICAgIDM4NTAyNC4uICAgIDM4OTEyMCB8ICAgIDQwOTYNCg0KVGhlIHN0YXJ0IHJl
bGF0aXZlIG9mZnNldCBpcyB0aGUgc2FtZTogMjIyNSwgYnV0IGV4dGVudCAxMTkgKDkxOTcyOS4u
DQo5MzAzMjMpIGlzIHNob3J0ZXIgdGhhbiB0aGUgb3RoZXJzLg0KDQpMZXQncyByZXN0cmljdCB0
aGUgYnZlYyBsZW5ndGggaW4gYWRkaXRpb24gdG8gdGhlIHN0YXJ0IG9mZnNldCBpZiBidmVjcw0K
YXJlIG5vdCBmdWxsLg0KDQpSZXBvcnRlZC1ieTogU2hpamllIFN1biA8c3Vuc2hpamllQHhpYW9t
aS5jb20+DQpGaXhlczogNWMyYTY0MjUyYzVkICgiZXJvZnM6IGludHJvZHVjZSBwYXJ0aWFsLXJl
ZmVyZW5jZWQgcGNsdXN0ZXJzIikNClNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8aHNpYW5na2Fv
QGxpbnV4LmFsaWJhYmEuY29tPg0KLS0tDQogZnMvZXJvZnMvemRhdGEuYyB8IDcgKysrKy0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9mcy9lcm9mcy96ZGF0YS5jIGIvZnMvZXJvZnMvemRhdGEuYw0KaW5kZXggYjY5ZDg5
YTExZGQwLi5kZTRmMTIxNTJiNjIgMTAwNjQ0DQotLS0gYS9mcy9lcm9mcy96ZGF0YS5jDQorKysg
Yi9mcy9lcm9mcy96ZGF0YS5jDQpAQCAtMTE0NCwxMCArMTE0NCwxMSBAQCBzdGF0aWMgdm9pZCB6
X2Vyb2ZzX2RvX2RlY29tcHJlc3NlZF9idmVjKHN0cnVjdCB6X2Vyb2ZzX2RlY29tcHJlc3NfYmFj
a2VuZCAqYmUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB6X2Vyb2ZzX2J2ZWMgKmJ2ZWMpDQogew0KICAgICAgICBzdHJ1Y3Qgel9lcm9mc19idmVjX2l0
ZW0gKml0ZW07DQorICAgICAgIHVuc2lnbmVkIGludCBwZ25yOw0KDQotICAgICAgIGlmICghKChi
dmVjLT5vZmZzZXQgKyBiZS0+cGNsLT5wYWdlb2ZzX291dCkgJiB+UEFHRV9NQVNLKSkgew0KLSAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGludCBwZ25yOw0KLQ0KKyAgICAgICBpZiAoISgoYnZlYy0+
b2Zmc2V0ICsgYmUtPnBjbC0+cGFnZW9mc19vdXQpICYgflBBR0VfTUFTSykgJiYNCisgICAgICAg
ICAgIChidmVjLT5lbmQgPT0gUEFHRV9TSVpFIHx8DQorICAgICAgICAgICAgYnZlYy0+b2Zmc2V0
ICsgYnZlYy0+ZW5kID09IGJlLT5wY2wtPmxlbmd0aCkpIHsNCiAgICAgICAgICAgICAgICBwZ25y
ID0gKGJ2ZWMtPm9mZnNldCArIGJlLT5wY2wtPnBhZ2VvZnNfb3V0KSA+PiBQQUdFX1NISUZUOw0K
ICAgICAgICAgICAgICAgIERCR19CVUdPTihwZ25yID49IGJlLT5ucl9wYWdlcyk7DQogICAgICAg
ICAgICAgICAgaWYgKCFiZS0+ZGVjb21wcmVzc2VkX3BhZ2VzW3BnbnJdKSB7DQotLQ0KMi4yNC40
DQpUZXN0ZWQtYnkgU2hpamllIFN1biA8c3Vuc2hpamllQHhpYW9taS5jb20+DQoNCg0KVGhhbmtz
LA0KDQpTdW4gU2hpamllDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+
yMs6IEdhbyBYaWFuZyA8aHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29tPg0Kt6LLzcqxvOQ6IDIw
MjPE6jfUwjE5yNUgMTQ6NTQ6NTkNCsrVvP7IyzogbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9y
Zw0Ks63LzTogTEtNTDsgR2FvIFhpYW5nOyDL78q/vdwNCtb3zOI6IFtFeHRlcm5hbCBNYWlsXVtQ
QVRDSF0gZXJvZnM6IGZpeCB3cm9uZyBwcmltYXJ5IGJ2ZWMgc2VsZWN0aW9uIG9uIGRlZHVwbGlj
YXRlZCBleHRlbnRzDQoNClvN4rK/08q8/l0gtMvTyrz+wLTUtNPa0KHD17mry77N4rK/o6zH6733
yfe0psDtoaPI9LbU08q8/rCyyKvQ1LTm0smjrMfrvavTyrz+16q3orj4bWlzZWNAeGlhb21pLmNv
bb340NC3tMChDQoNCldoZW4gaGFuZGxpbmcgZGVkdXBsaWNhdGVkIGNvbXByZXNzZWQgZGF0YSwg
dGhlcmUgY2FuIGJlIG11bHRpcGxlDQpkZWNvbXByZXNzZWQgZXh0ZW50cyBwb2ludGluZyB0byB0
aGUgc2FtZSBjb21wcmVzc2VkIGRhdGEgaW4gb25lIHNob3QuDQoNCkluIHN1Y2ggY2FzZXMsIHRo
ZSBidmVjcyB3aGljaCBiZWxvbmcgdG8gdGhlIGxvbmdlc3QgZXh0ZW50IHdpbGwgYmUNCnNlbGVj
dGVkIGFzIHRoZSBwcmltYXJ5IGJ2ZWNzIGZvciByZWFsIGRlY29tcHJlc3NvcnMgdG8gZGVjb2Rl
IGFuZCB0aGUNCm90aGVyIGR1cGxpY2F0ZWQgYnZlY3Mgd2lsbCBiZSBkaXJlY3RseSBjb3BpZWQg
ZnJvbSB0aGUgcHJpbWFyeSBidmVjcy4NCg0KUHJldmlvdXNseSwgb25seSByZWxhdGl2ZSBvZmZz
ZXRzIG9mIHRoZSBsb25nZXN0IGV4dGVudCB3YXMgY2hlY2tlZCB0bw0KZGVjb21wcmVzcyB0aGUg
cHJpbWFyeSBidmVjcy4gIE9uIHJhcmUgb2NjYXNpb25zLCBpdCBjYW4gYmUgaW5jb3JyZWN0DQpp
ZiB0aGVyZSBhcmUgc2V2ZXJhbCBleHRlbnRzIHdpdGggdGhlIHNhbWUgc3RhcnQgcmVsYXRpdmUg
b2Zmc2V0Lg0KQXMgYSByZXN1bHQsIHNvbWUgc2hvcnQgYnZlY3MgY291bGQgYmUgc2VsZWN0ZWQg
Zm9yIGRlY29tcHJlc3Npb24gYW5kDQp0aGVuIGNhdXNlIGRhdGEgY29ycnVwdGlvbi4NCg0KRm9y
IGV4YW1wbGUsIGFzIFNoaWppZSBTdW4gcmVwb3J0ZWQgb2ZmLWxpc3QsIGNvbnNpZGVyaW5nIHRo
ZSBmb2xsb3dpbmcNCmV4dGVudHMgb2YgYSBmaWxlOg0KIDExNzogICA5MDMzNDUuLiAgOTE1MjUw
IHwgICAxMTkwNSA6ICAgICAzODUwMjQuLiAgICAzODkxMjAgfCAgICA0MDk2DQouLi4NCiAxMTk6
ICAgOTE5NzI5Li4gIDkzMDMyMyB8ICAgMTA1OTQgOiAgICAgMzg1MDI0Li4gICAgMzg5MTIwIHwg
ICAgNDA5Ng0KLi4uDQogMTI0OiAgIDk2ODg4MS4uICA5ODA3ODYgfCAgIDExOTA1IDogICAgIDM4
NTAyNC4uICAgIDM4OTEyMCB8ICAgIDQwOTYNCg0KVGhlIHN0YXJ0IHJlbGF0aXZlIG9mZnNldCBp
cyB0aGUgc2FtZTogMjIyNSwgYnV0IGV4dGVudCAxMTkgKDkxOTcyOS4uDQo5MzAzMjMpIGlzIHNo
b3J0ZXIgdGhhbiB0aGUgb3RoZXJzLg0KDQpMZXQncyByZXN0cmljdCB0aGUgYnZlYyBsZW5ndGgg
aW4gYWRkaXRpb24gdG8gdGhlIHN0YXJ0IG9mZnNldCBpZiBidmVjcw0KYXJlIG5vdCBmdWxsLg0K
DQpSZXBvcnRlZC1ieTogU2hpamllIFN1biA8c3Vuc2hpamllQHhpYW9taS5jb20+DQpGaXhlczog
NWMyYTY0MjUyYzVkICgiZXJvZnM6IGludHJvZHVjZSBwYXJ0aWFsLXJlZmVyZW5jZWQgcGNsdXN0
ZXJzIikNClNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8aHNpYW5na2FvQGxpbnV4LmFsaWJhYmEu
Y29tPg0KLS0tDQogZnMvZXJvZnMvemRhdGEuYyB8IDcgKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9lcm9m
cy96ZGF0YS5jIGIvZnMvZXJvZnMvemRhdGEuYw0KaW5kZXggYjY5ZDg5YTExZGQwLi5kZTRmMTIx
NTJiNjIgMTAwNjQ0DQotLS0gYS9mcy9lcm9mcy96ZGF0YS5jDQorKysgYi9mcy9lcm9mcy96ZGF0
YS5jDQpAQCAtMTE0NCwxMCArMTE0NCwxMSBAQCBzdGF0aWMgdm9pZCB6X2Vyb2ZzX2RvX2RlY29t
cHJlc3NlZF9idmVjKHN0cnVjdCB6X2Vyb2ZzX2RlY29tcHJlc3NfYmFja2VuZCAqYmUsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6X2Vyb2ZzX2J2ZWMg
KmJ2ZWMpDQogew0KICAgICAgICBzdHJ1Y3Qgel9lcm9mc19idmVjX2l0ZW0gKml0ZW07DQorICAg
ICAgIHVuc2lnbmVkIGludCBwZ25yOw0KDQotICAgICAgIGlmICghKChidmVjLT5vZmZzZXQgKyBi
ZS0+cGNsLT5wYWdlb2ZzX291dCkgJiB+UEFHRV9NQVNLKSkgew0KLSAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCBwZ25yOw0KLQ0KKyAgICAgICBpZiAoISgoYnZlYy0+b2Zmc2V0ICsgYmUtPnBj
bC0+cGFnZW9mc19vdXQpICYgflBBR0VfTUFTSykgJiYNCisgICAgICAgICAgIChidmVjLT5lbmQg
PT0gUEFHRV9TSVpFIHx8DQorICAgICAgICAgICAgYnZlYy0+b2Zmc2V0ICsgYnZlYy0+ZW5kID09
IGJlLT5wY2wtPmxlbmd0aCkpIHsNCiAgICAgICAgICAgICAgICBwZ25yID0gKGJ2ZWMtPm9mZnNl
dCArIGJlLT5wY2wtPnBhZ2VvZnNfb3V0KSA+PiBQQUdFX1NISUZUOw0KICAgICAgICAgICAgICAg
IERCR19CVUdPTihwZ25yID49IGJlLT5ucl9wYWdlcyk7DQogICAgICAgICAgICAgICAgaWYgKCFi
ZS0+ZGVjb21wcmVzc2VkX3BhZ2VzW3BnbnJdKSB7DQotLQ0KMi4yNC40DQoNCiMvKioqKioqsb7T
yrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQxc+io6y99s/e09q3osvNuPjJz8PmtdjWt9bQ
wdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7yMvS1MjOus7Qzsq9yrnTw6OosPzAqLWrsrvP
3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJoreio6mxvtPKvP7W0LXE0MXPoqGjyOe5+8T6
tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+o6Eg
VGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZv
cm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNv
biBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhl
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQg
bm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9u
LCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJl
Y2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBl
cnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0
ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==

--_000_c9142b7608054e8884b1c9dcc5e52761xiaomicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p></p>
<div class=3D"_rp_S4" style=3D"width: 1267px;">
<div class=3D"_rp_o1">
<div class=3D"_rp_q2 disableTextSelection _rp_y2" role=3D"heading" aria-lev=
el=3D"3">
<div class=3D"_rp_I2">
<div class=3D"_rp_62">
<div class=3D"_rp_32">
<div class=3D"ms-font-color-neutralSecondary ms-font-weight-semilight ms-fo=
nt-s _rp_e8">
<div>
<div>
<div class=3D"_rp_f8">
<div class=3D"_rw_2" id=3D"ItemHeader.ToContainer" role=3D"heading" tabinde=
x=3D"-1" style=3D"max-width: calc(100% - 200px);">
<div class=3D"rpHighlightAllClass rpHighlightAllRecipientsClass rpHighlight=
ToClass recipientWellWrapping _rw_3">
<div class=3D"_rw_a" tabindex=3D"0" aria-label=3D"=D6=C1=CA=D5=BC=FE=C8=CB=
=A1=A3=CA=B9=D3=C3=BC=FD=CD=B7=BC=FC=B5=BC=BA=BD=C1=D0=B1=ED=A3=AC=C8=BB=BA=
=F3=CA=B9=D3=C3 Enter =BC=FC=B4=F2=BF=AA=C1=AA=CF=B5=C8=CB=BF=A8=C6=AC=A1=
=A3">
<div class=3D"_rw_9"><span tabindex=3D"-1" class=3D"_rw_b"><span class=3D"_=
rw_8 PersonaPaneLauncher" tabindex=3D"-1">
<div class=3D"_pe_d _pe_G _pe_i" tabindex=3D"-1" aria-expanded=3D"false" ar=
ia-haspopup=3D"true" style=3D"width: 255.828px;">
<span autoid=3D"_pe_b" class=3D"_pe_l _pe_G _pe_W1 bidi _pe_m1 ms-font-s _p=
e_S allowTextSelection" style=3D"width: 253.828px;">Gao Xiang &lt;hsiangkao=
@linux.alibaba.com&gt;;</span></div>
</span></span><span tabindex=3D"-1" class=3D"_rw_b"><span class=3D"_rw_8 Pe=
rsonaPaneLauncher" tabindex=3D"-1">
<div class=3D"_pe_d _pe_G _pe_i" tabindex=3D"-1" aria-expanded=3D"false" ar=
ia-haspopup=3D"true" style=3D"width: 162.078px;">
<span autoid=3D"_pe_b" class=3D"_pe_l _pe_G _pe_W1 bidi _pe_m1 ms-font-s _p=
e_S allowTextSelection" style=3D"width: 160.078px;">linux-erofs@lists.ozlab=
s.org;</span></div>
</span></span><span tabindex=3D"-1" class=3D"_rw_b"><span class=3D"_rw_8 Pe=
rsonaPaneLauncher" tabindex=3D"-1">
<div class=3D"_pe_d _pe_G _pe_i" tabindex=3D"-1" aria-expanded=3D"false" ar=
ia-haspopup=3D"true" style=3D"width: 219.625px;">
<span autoid=3D"_pe_b" class=3D"_pe_l _pe_G _pe_W1 bidi _pe_m1 ms-font-s _p=
e_S allowTextSelection" style=3D"width: 217.625px;">LKML &lt;linux-kernel@v=
ger.kernel.org&gt;</span></div>
</span></span></div>
</div>
</div>
</div>
<button type=3D"button" class=3D"ms-font-s _rw_4 o365button ms-font-color-n=
eutralPrimary" role=3D"button" aria-label=3D"=C6=E4=CB=FB=CA=D5=BC=FE=C8=CB=
" title=3D"=CF=D4=CA=BE=B8=FC=B6=E0">
<span class=3D"_fc_3 owaimg _rw_5 ms-Icon--chevronsDown ms-icon-font-size-1=
2 ms-fcl-ns-b"></span>
</button></div>
</div>
</div>
</div>
</div>
</div>
<div class=3D"_rp_32"></div>
</div>
</div>
<div class=3D"_rp_x2">
<div class=3D"_rp_32"></div>
<div></div>
</div>
</div>
</div>
<div class=3D"_rp_45 _rp_35">
<div></div>
<div>
<div data-reactroot=3D""></div>
</div>
<div></div>
<div></div>
<div role=3D"document">
<div autoid=3D"_rp_x" class=3D"_rp_T4" id=3D"Item.MessagePartBody">
<div class=3D"_rp_U4 ms-font-weight-regular ms-font-color-neutralDark rpHig=
hlightAllClass rpHighlightBodyClass" id=3D"Item.MessageUniqueBody" style=3D=
"">
<div style=3D"">
<div style=3D"">
<div style=3D"">
<div dir=3D"ltr" style=3D"">
<div id=3D"x_divtagdefaultwrapper" style=3D""><font style=3D""><span id=3D"=
x_divtagdefaultwrapper" style=3D"">
<div style=3D"color: black; font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont; font-size: 12pt; margin-top: 0px; margin-bottom: 0px;">
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">When handling deduplicated compressed =
data, there can be multiple</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">decompressed extents pointing to the s=
ame compressed data in one shot.</span></font><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">In such cases, the bvecs which belong =
to the longest extent will be</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">selected as the primary bvecs for real=
 decompressors to decode and the</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">other duplicated bvecs will be directl=
y copied from the primary bvecs.</span></font><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Previously, only relative offsets of t=
he longest extent was checked to</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">decompress the primary bvecs.&nbsp; On=
 rare occasions, it can be incorrect</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">if there are several extents with the =
same start relative offset.</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">As a result, some short bvecs could be=
 selected for decompression and</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">then cause data corruption.</span></fo=
nt><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">For example, as Shijie Sun reported of=
f-list, considering the following</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">extents of a file:</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&nbsp;117:&nbsp;&nbsp; 903345..&nbsp; =
915250 |&nbsp;&nbsp; 11905 :&nbsp;&nbsp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&n=
bsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">...</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&nbsp;119:&nbsp;&nbsp; 919729..&nbsp; =
930323 |&nbsp;&nbsp; 10594 :&nbsp;&nbsp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&n=
bsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">...</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">&nbsp;124:&nbsp;&nbsp; 968881..&nbsp; =
980786 |&nbsp;&nbsp; 11905 :&nbsp;&nbsp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&n=
bsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span></font><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">The start relative offset is the same:=
 2225, but extent 119 (919729..</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">930323) is shorter than the others.</s=
pan></font><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Let's restrict the bvec length in addi=
tion to the start offset if bvecs</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">are not full.</span></font><br>
<br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Reported-by: Shijie Sun &lt;sunshijie@=
xiaomi.com&gt;</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Fixes: 5c2a64252c5d (&quot;erofs: intr=
oduce partial-referenced pclusters&quot;)</span></font><br>
<font face=3D"Microsoft YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont" size=3D"1" color=3D"#212121"=
><span style=3D"font-size: 13.32px;">Signed-off-by: Gao Xiang &lt;hsiangkao=
@linux.alibaba.com&gt;</span></font></div>
<div style=3D"margin-top: 0px; margin-bottom: 0px;"><font face=3D"Microsoft=
 YaHei UI,Microsoft YaHei,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans=
-serif,serif,EmojiFont" size=3D"1" color=3D"#212121" style=3D"color: black;=
 font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size: =
12pt;"><span style=3D"font-size: 13.32px;"></span></font><font face=3D"Micr=
osoft YaHei UI, Microsoft YaHei, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=
=CC=E5, sans-serif, serif, EmojiFont"><span style=3D"font-size: 13.32px;"><=
br>
</span></font><font color=3D"#000000" face=3D"Calibri, Helvetica, sans-seri=
f, serif, EmojiFont"><span style=3D"font-size: 12pt;">Tested-by: Shijie Sun=
 &lt;sunshijie@xiaomi.com&gt;</span></font></div>
<div style=3D"color: black; font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont; font-size: 12pt; margin-top: 0px; margin-bottom: 0px;">
<br>
</div>
<div style=3D"color: black; font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont; font-size: 12pt; margin-top: 0px; margin-bottom: 0px;">
Thanks,&nbsp;</div>
<div style=3D"color: black; font-family: Calibri, Helvetica, sans-serif, se=
rif, EmojiFont; font-size: 12pt; margin-top: 0px; margin-bottom: 0px;">
Sun Shijie</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<br>
<p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> =CB=EF=
=CA=BF=BD=DC<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2023=C4=EA7=D4=C219=C8=D5 18:17:40<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Gao Xiang; linux-erofs@lists.ozlabs.org<br>
<b>=B3=AD=CB=CD:</b> LKML<br>
<b>=D6=F7=CC=E2:</b> =B4=F0=B8=B4: [External Mail][PATCH] erofs: fix wrong =
primary bvec selection on deduplicated extents</font>
<div>&nbsp;</div>
</div>
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">When handling dedup=
licated compressed data, there can be multiple</span><br style=3D"color:rgb=
(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHe=
i&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emoji=
Font; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">decompressed extents p=
ointing to the same compressed data in one shot.</span><br style=3D"color:r=
gb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Ya=
Hei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emo=
jiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">In such cases, the bve=
cs which belong to the longest extent will be</span><br style=3D"color:rgb(=
33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei=
&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiF=
ont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">selected as the primar=
y bvecs for real decompressors to decode and the</span><br style=3D"color:r=
gb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Ya=
Hei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emo=
jiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">other duplicated bvecs=
 will be directly copied from the primary bvecs.</span><br style=3D"color:r=
gb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Ya=
Hei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emo=
jiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Previously, only relat=
ive offsets of the longest extent was checked to</span><br style=3D"color:r=
gb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Ya=
Hei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emo=
jiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">decompress the primary=
 bvecs.&nbsp; On rare occasions, it can be incorrect</span><br style=3D"col=
or:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsof=
t YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif=
,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">if there are several e=
xtents with the same start relative offset.</span><br style=3D"color:rgb(33=
,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&q=
uot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFon=
t; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">As a result, some shor=
t bvecs could be selected for decompression and</span><br style=3D"color:rg=
b(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaH=
ei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emoj=
iFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">then cause data corrup=
tion.</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft Y=
aHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=
=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">For example, as Shijie=
 Sun reported off-list, considering the following</span><br style=3D"color:=
rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Y=
aHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Em=
ojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">extents of a file:</sp=
an><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&q=
uot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;117:&nbsp;&nbsp;=
 903345..&nbsp; 915250 |&nbsp;&nbsp; 11905 :&nbsp;&nbsp;&nbsp;&nbsp; 385024=
..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span><br style=3D"col=
or:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsof=
t YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif=
,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">...</span><br style=3D=
"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micr=
osoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,s=
erif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;119:&nbsp;&nbsp;=
 919729..&nbsp; 930323 |&nbsp;&nbsp; 10594 :&nbsp;&nbsp;&nbsp;&nbsp; 385024=
..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span><br style=3D"col=
or:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsof=
t YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif=
,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">...</span><br style=3D=
"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micr=
osoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,s=
erif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;124:&nbsp;&nbsp;=
 968881..&nbsp; 980786 |&nbsp;&nbsp; 11905 :&nbsp;&nbsp;&nbsp;&nbsp; 385024=
..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096</span><br style=3D"col=
or:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsof=
t YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif=
,EmojiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">The start relative off=
set is the same: 2225, but extent 119 (919729..</span><br style=3D"color:rg=
b(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaH=
ei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Emoj=
iFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">930323) is shorter tha=
n the others.</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Mic=
rosoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,=
SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Let's restrict the bve=
c length in addition to the start offset if bvecs</span><br style=3D"color:=
rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft Y=
aHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,Em=
ojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">are not full.</span><b=
r style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,=
&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sa=
ns-serif,serif,EmojiFont; font-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Reported-by: Shijie Su=
n &lt;sunshijie@xiaomi.com&gt;</span><br style=3D"color:rgb(33,33,33); font=
-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=
=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-siz=
e:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Fixes: 5c2a64252c5d (&=
quot;erofs: introduce partial-referenced pclusters&quot;)</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">Signed-off-by: Gao Xia=
ng &lt;hsiangkao@linux.alibaba.com&gt;</span><br style=3D"color:rgb(33,33,3=
3); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=
=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; fo=
nt-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">---</span><br style=3D=
"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micr=
osoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,s=
erif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;fs/erofs/zdata.c=
 | 7 &#43;&#43;&#43;&#43;---</span><br style=3D"color:rgb(33,33,33); font-f=
amily:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=
=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:1=
3.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;1 file changed, =
4 insertions(&#43;), 3 deletions(-)</span><br style=3D"color:rgb(33,33,33);=
 font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=
=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-=
size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">diff --git a/fs/erofs/=
zdata.c b/fs/erofs/zdata.c</span><br style=3D"color:rgb(33,33,33); font-fam=
ily:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=
=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3=
333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">index b69d89a11dd0..de=
4f12152b62 100644</span><br style=3D"color:rgb(33,33,33); font-family:&quot=
;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=
=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">--- a/fs/erofs/zdata.c=
</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei =
UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&#43;&#43;&#43; b/fs/e=
rofs/zdata.c</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Micr=
osoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,S=
imSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">@@ -1144,10 &#43;1144,=
11 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_ba=
ckend *be,</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Micros=
oft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,Sim=
Sun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct=
 z_erofs_bvec *bvec)</span><br style=3D"color:rgb(33,33,33); font-family:&q=
uot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=
=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"=
>
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;{</span><br styl=
e=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;=
Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-ser=
if,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; struct z_erofs_bvec_item *item;</span><br style=3D"col=
or:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsof=
t YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif=
,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; unsigned int pgnr;</span><br style=3D"color:rgb(33,33,3=
3); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=
=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; fo=
nt-size:13.3333px">
<br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot=
;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,=
sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">-&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!((bvec-&gt;offset &#43; be-&gt;pcl-&gt;pageofs_out) &a=
mp; ~PAGE_MASK)) {</span><br style=3D"color:rgb(33,33,33); font-family:&quo=
t;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=
=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"=
>
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">-&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned in=
t pgnr;</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft=
 YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun=
,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">-</span><br style=3D"c=
olor:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micros=
oft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,ser=
if,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!((bvec-&gt;offset &#43; be-&gt;pcl-&gt;pageofs_out=
) &amp; ~PAGE_MASK) &amp;&amp;</span><br style=3D"color:rgb(33,33,33); font=
-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=
=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-siz=
e:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bvec-&gt;end =3D=3D PAGE_SIZE =
||</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHe=
i UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=
=CE=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&#43;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bvec-&gt;offset &#43; bve=
c-&gt;end =3D=3D be-&gt;pcl-&gt;length)) {</span><br style=3D"color:rgb(33,=
33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&qu=
ot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont=
; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgnr =
=3D (bvec-&gt;offset &#43; be-&gt;pcl-&gt;pageofs_out) &gt;&gt; PAGE_SHIFT;=
</span><br style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei =
UI&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBG_BU=
GON(pgnr &gt;=3D be-&gt;nr_pages);</span><br style=3D"color:rgb(33,33,33); =
font-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=
=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-=
size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!b=
e-&gt;decompressed_pages[pgnr]) {</span><br style=3D"color:rgb(33,33,33); f=
ont-family:&quot;Microsoft YaHei UI&quot;,&quot;Microsoft YaHei&quot;,=CE=
=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,serif,EmojiFont; font-=
size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">--</span><br style=3D"=
color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micro=
soft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,se=
rif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">2.24.4</span><br style=
=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;M=
icrosoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-seri=
f,serif,EmojiFont; font-size:13.3333px">
Tested-by Shijie Sun &lt;sunshijie@xiaomi.com&gt;</p>
<p><br>
</p>
<p>Thanks,&nbsp;</p>
<p>Sun Shijie</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Gao X=
iang &lt;hsiangkao@linux.alibaba.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2023=C4=EA7=D4=C219=C8=D5 14:54:59<br>
<b>=CA=D5=BC=FE=C8=CB:</b> linux-erofs@lists.ozlabs.org<br>
<b>=B3=AD=CB=CD:</b> LKML; Gao Xiang; =CB=EF=CA=BF=BD=DC<br>
<b>=D6=F7=CC=E2:</b> [External Mail][PATCH] erofs: fix wrong primary bvec s=
election on deduplicated extents</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">[=CD=E2=B2=BF=D3=CA=BC=FE] =B4=CB=D3=CA=BC=FE=C0=
=B4=D4=B4=D3=DA=D0=A1=C3=D7=B9=AB=CB=BE=CD=E2=B2=BF=A3=AC=C7=EB=BD=F7=C9=F7=
=B4=A6=C0=ED=A1=A3=C8=F4=B6=D4=D3=CA=BC=FE=B0=B2=C8=AB=D0=D4=B4=E6=D2=C9=A3=
=AC=C7=EB=BD=AB=D3=CA=BC=FE=D7=AA=B7=A2=B8=F8misec@xiaomi.com=BD=F8=D0=D0=
=B7=B4=C0=A1<br>
<br>
When handling deduplicated compressed data, there can be multiple<br>
decompressed extents pointing to the same compressed data in one shot.<br>
<br>
In such cases, the bvecs which belong to the longest extent will be<br>
selected as the primary bvecs for real decompressors to decode and the<br>
other duplicated bvecs will be directly copied from the primary bvecs.<br>
<br>
Previously, only relative offsets of the longest extent was checked to<br>
decompress the primary bvecs.&nbsp; On rare occasions, it can be incorrect<=
br>
if there are several extents with the same start relative offset.<br>
As a result, some short bvecs could be selected for decompression and<br>
then cause data corruption.<br>
<br>
For example, as Shijie Sun reported off-list, considering the following<br>
extents of a file:<br>
&nbsp;117:&nbsp;&nbsp; 903345..&nbsp; 915250 |&nbsp;&nbsp; 11905 :&nbsp;&nb=
sp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096<=
br>
...<br>
&nbsp;119:&nbsp;&nbsp; 919729..&nbsp; 930323 |&nbsp;&nbsp; 10594 :&nbsp;&nb=
sp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096<=
br>
...<br>
&nbsp;124:&nbsp;&nbsp; 968881..&nbsp; 980786 |&nbsp;&nbsp; 11905 :&nbsp;&nb=
sp;&nbsp;&nbsp; 385024..&nbsp;&nbsp;&nbsp; 389120 |&nbsp;&nbsp;&nbsp; 4096<=
br>
<br>
The start relative offset is the same: 2225, but extent 119 (919729..<br>
930323) is shorter than the others.<br>
<br>
Let's restrict the bvec length in addition to the start offset if bvecs<br>
are not full.<br>
<br>
Reported-by: Shijie Sun &lt;sunshijie@xiaomi.com&gt;<br>
Fixes: 5c2a64252c5d (&quot;erofs: introduce partial-referenced pclusters&qu=
ot;)<br>
Signed-off-by: Gao Xiang &lt;hsiangkao@linux.alibaba.com&gt;<br>
---<br>
&nbsp;fs/erofs/zdata.c | 7 &#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 4 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c<br>
index b69d89a11dd0..de4f12152b62 100644<br>
--- a/fs/erofs/zdata.c<br>
&#43;&#43;&#43; b/fs/erofs/zdata.c<br>
@@ -1144,10 &#43;1144,11 @@ static void z_erofs_do_decompressed_bvec(struct=
 z_erofs_decompress_backend *be,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct z_erofs_bvec *bvec)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct z_erofs_bvec_item *item;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pgnr;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((bvec-&gt;offset &#43; be-&gt;p=
cl-&gt;pageofs_out) &amp; ~PAGE_MASK)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int pgnr;<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((bvec-&gt;offset &#43; be-&=
gt;pcl-&gt;pageofs_out) &amp; ~PAGE_MASK) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bvec-&gt=
;end =3D=3D PAGE_SIZE ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bve=
c-&gt;offset &#43; bvec-&gt;end =3D=3D be-&gt;pcl-&gt;length)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pgnr =3D (bvec-&gt;offset &#43; be-&gt;pcl-&gt;pageofs_out)=
 &gt;&gt; PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DBG_BUGON(pgnr &gt;=3D be-&gt;nr_pages);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!be-&gt;decompressed_pages[pgnr]) {<br>
--<br>
2.24.4<br>
<br>
</div>
</span></font></div>
#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address
 is listed above. Any use of the information contained herein in any way (i=
ncluding, but not limited to, total or partial disclosure, reproduction, or=
 dissemination) by persons other than the intended recipient(s) is prohibit=
ed. If you receive this e-mail in
 error, please notify the sender by phone or email immediately and delete i=
t!******/#
</body>
</html>

--_000_c9142b7608054e8884b1c9dcc5e52761xiaomicom_--
