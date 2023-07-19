Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DD75929A
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 12:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689761939;
	bh=mZxv6QK4kkz10cHqizPAseMOdFJmg0tOFzqXahIbaBs=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=deCS/6OCgsXPsY82HLVwbs3EPQLkoI7xIi4ck8uGYqYIFpl939e1ccf4RVS5MPvpW
	 apmG7ZNv98WGf8+kttQbNcunZgVszcG5FkQ9KueCPOLBI3UzBHEnvOdON1w3GBaXt4
	 y+y46xSkZxGRaOy09Odo/xmE2/Fdbwrm/hNk4b80VZRxImX92xRasGXe9N8Nv2YaLy
	 g5h1EgtpY1/nXk83NSr6icgTfprM6sVWXVZLSgWGkknJnph/UkCyxxuX6PfglqR8kp
	 PvuMTjU1F6pTEF89B9/W4lPiuD45f8CXHFyJs2rI95fIR5AvulAt741dhvHo4hn7r3
	 wC9h3CvIsVkvQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5Wxv0ZFNz2yw4
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jul 2023 20:18:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=sunshijie@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Wed, 19 Jul 2023 20:18:51 AEST
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5Wxl4vQ8z2xWc
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jul 2023 20:18:51 +1000 (AEST)
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208,217";a="84746276"
Received: from hk-mbx12.mioffice.cn (HELO xiaomi.com) ([10.56.21.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 19 Jul 2023 18:17:41 +0800
Received: from BJ-MBX16.mioffice.cn (10.237.8.136) by HK-MBX12.mioffice.cn
 (10.56.21.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 19 Jul
 2023 18:17:41 +0800
Received: from BJ-MBX18.mioffice.cn (10.237.8.138) by BJ-MBX16.mioffice.cn
 (10.237.8.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Wed, 19 Jul
 2023 18:17:40 +0800
Received: from BJ-MBX18.mioffice.cn ([fe80::99b2:c42d:33a0:2439]) by
 BJ-MBX18.mioffice.cn ([fe80::99b2:c42d:33a0:2439%16]) with mapi id
 15.02.1258.016; Wed, 19 Jul 2023 18:17:40 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdW1BBVENIXSBlcm9mczogZml4IHdyb25n?=
 =?gb2312?Q?_primary_bvec_selection_on_deduplicated_extents?=
Thread-Topic: [External Mail][PATCH] erofs: fix wrong primary bvec selection
 on deduplicated extents
Thread-Index: AQHZug380BXfCK+Su0ukiPiuBvsgQa/A360p
Date: Wed, 19 Jul 2023 10:17:40 +0000
Message-ID: <4a9259a9675e48e083139c22f7a86c8c@xiaomi.com>
References: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: multipart/alternative;
	boundary="_000_4a9259a9675e48e083139c22f7a86c8cxiaomicom_"
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

--_000_4a9259a9675e48e083139c22f7a86c8cxiaomicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

V2hlbiBoYW5kbGluZyBkZWR1cGxpY2F0ZWQgY29tcHJlc3NlZCBkYXRhLCB0aGVyZSBjYW4gYmUg
bXVsdGlwbGUNCmRlY29tcHJlc3NlZCBleHRlbnRzIHBvaW50aW5nIHRvIHRoZSBzYW1lIGNvbXBy
ZXNzZWQgZGF0YSBpbiBvbmUgc2hvdC4NCg0KSW4gc3VjaCBjYXNlcywgdGhlIGJ2ZWNzIHdoaWNo
IGJlbG9uZyB0byB0aGUgbG9uZ2VzdCBleHRlbnQgd2lsbCBiZQ0Kc2VsZWN0ZWQgYXMgdGhlIHBy
aW1hcnkgYnZlY3MgZm9yIHJlYWwgZGVjb21wcmVzc29ycyB0byBkZWNvZGUgYW5kIHRoZQ0Kb3Ro
ZXIgZHVwbGljYXRlZCBidmVjcyB3aWxsIGJlIGRpcmVjdGx5IGNvcGllZCBmcm9tIHRoZSBwcmlt
YXJ5IGJ2ZWNzLg0KDQpQcmV2aW91c2x5LCBvbmx5IHJlbGF0aXZlIG9mZnNldHMgb2YgdGhlIGxv
bmdlc3QgZXh0ZW50IHdhcyBjaGVja2VkIHRvDQpkZWNvbXByZXNzIHRoZSBwcmltYXJ5IGJ2ZWNz
LiAgT24gcmFyZSBvY2Nhc2lvbnMsIGl0IGNhbiBiZSBpbmNvcnJlY3QNCmlmIHRoZXJlIGFyZSBz
ZXZlcmFsIGV4dGVudHMgd2l0aCB0aGUgc2FtZSBzdGFydCByZWxhdGl2ZSBvZmZzZXQuDQpBcyBh
IHJlc3VsdCwgc29tZSBzaG9ydCBidmVjcyBjb3VsZCBiZSBzZWxlY3RlZCBmb3IgZGVjb21wcmVz
c2lvbiBhbmQNCnRoZW4gY2F1c2UgZGF0YSBjb3JydXB0aW9uLg0KDQpGb3IgZXhhbXBsZSwgYXMg
U2hpamllIFN1biByZXBvcnRlZCBvZmYtbGlzdCwgY29uc2lkZXJpbmcgdGhlIGZvbGxvd2luZw0K
ZXh0ZW50cyBvZiBhIGZpbGU6DQogMTE3OiAgIDkwMzM0NS4uICA5MTUyNTAgfCAgIDExOTA1IDog
ICAgIDM4NTAyNC4uICAgIDM4OTEyMCB8ICAgIDQwOTYNCi4uLg0KIDExOTogICA5MTk3MjkuLiAg
OTMwMzIzIHwgICAxMDU5NCA6ICAgICAzODUwMjQuLiAgICAzODkxMjAgfCAgICA0MDk2DQouLi4N
CiAxMjQ6ICAgOTY4ODgxLi4gIDk4MDc4NiB8ICAgMTE5MDUgOiAgICAgMzg1MDI0Li4gICAgMzg5
MTIwIHwgICAgNDA5Ng0KDQpUaGUgc3RhcnQgcmVsYXRpdmUgb2Zmc2V0IGlzIHRoZSBzYW1lOiAy
MjI1LCBidXQgZXh0ZW50IDExOSAoOTE5NzI5Li4NCjkzMDMyMykgaXMgc2hvcnRlciB0aGFuIHRo
ZSBvdGhlcnMuDQoNCkxldCdzIHJlc3RyaWN0IHRoZSBidmVjIGxlbmd0aCBpbiBhZGRpdGlvbiB0
byB0aGUgc3RhcnQgb2Zmc2V0IGlmIGJ2ZWNzDQphcmUgbm90IGZ1bGwuDQoNClJlcG9ydGVkLWJ5
OiBTaGlqaWUgU3VuIDxzdW5zaGlqaWVAeGlhb21pLmNvbT4NCkZpeGVzOiA1YzJhNjQyNTJjNWQg
KCJlcm9mczogaW50cm9kdWNlIHBhcnRpYWwtcmVmZXJlbmNlZCBwY2x1c3RlcnMiKQ0KU2lnbmVk
LW9mZi1ieTogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+DQotLS0NCiBm
cy9lcm9mcy96ZGF0YS5jIHwgNyArKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL3pkYXRhLmMgYi9m
cy9lcm9mcy96ZGF0YS5jDQppbmRleCBiNjlkODlhMTFkZDAuLmRlNGYxMjE1MmI2MiAxMDA2NDQN
Ci0tLSBhL2ZzL2Vyb2ZzL3pkYXRhLmMNCisrKyBiL2ZzL2Vyb2ZzL3pkYXRhLmMNCkBAIC0xMTQ0
LDEwICsxMTQ0LDExIEBAIHN0YXRpYyB2b2lkIHpfZXJvZnNfZG9fZGVjb21wcmVzc2VkX2J2ZWMo
c3RydWN0IHpfZXJvZnNfZGVjb21wcmVzc19iYWNrZW5kICpiZSwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHpfZXJvZnNfYnZlYyAqYnZlYykNCiB7DQog
ICAgICAgIHN0cnVjdCB6X2Vyb2ZzX2J2ZWNfaXRlbSAqaXRlbTsNCisgICAgICAgdW5zaWduZWQg
aW50IHBnbnI7DQoNCi0gICAgICAgaWYgKCEoKGJ2ZWMtPm9mZnNldCArIGJlLT5wY2wtPnBhZ2Vv
ZnNfb3V0KSAmIH5QQUdFX01BU0spKSB7DQotICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHBn
bnI7DQotDQorICAgICAgIGlmICghKChidmVjLT5vZmZzZXQgKyBiZS0+cGNsLT5wYWdlb2ZzX291
dCkgJiB+UEFHRV9NQVNLKSAmJg0KKyAgICAgICAgICAgKGJ2ZWMtPmVuZCA9PSBQQUdFX1NJWkUg
fHwNCisgICAgICAgICAgICBidmVjLT5vZmZzZXQgKyBidmVjLT5lbmQgPT0gYmUtPnBjbC0+bGVu
Z3RoKSkgew0KICAgICAgICAgICAgICAgIHBnbnIgPSAoYnZlYy0+b2Zmc2V0ICsgYmUtPnBjbC0+
cGFnZW9mc19vdXQpID4+IFBBR0VfU0hJRlQ7DQogICAgICAgICAgICAgICAgREJHX0JVR09OKHBn
bnIgPj0gYmUtPm5yX3BhZ2VzKTsNCiAgICAgICAgICAgICAgICBpZiAoIWJlLT5kZWNvbXByZXNz
ZWRfcGFnZXNbcGducl0pIHsNCi0tDQoyLjI0LjQNClRlc3RlZC1ieSBTaGlqaWUgU3VuIDxzdW5z
aGlqaWVAeGlhb21pLmNvbT4NCg0KDQpUaGFua3MsDQoNClN1biBTaGlqaWUNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGlu
dXguYWxpYmFiYS5jb20+DQq3osvNyrG85DogMjAyM8TqN9TCMTnI1SAxNDo1NDo1OQ0KytW8/sjL
OiBsaW51eC1lcm9mc0BsaXN0cy5vemxhYnMub3JnDQqzrcvNOiBMS01MOyBHYW8gWGlhbmc7IMvv
yr+93A0K1vfM4jogW0V4dGVybmFsIE1haWxdW1BBVENIXSBlcm9mczogZml4IHdyb25nIHByaW1h
cnkgYnZlYyBzZWxlY3Rpb24gb24gZGVkdXBsaWNhdGVkIGV4dGVudHMNCg0KW83isr/Tyrz+XSC0
y9PKvP7AtNS009rQocPXuavLvs3isr+jrMfrvffJ97SmwO2ho8j0ttTTyrz+sLLIq9DUtObSyaOs
x+u9q9PKvP7XqreiuPhtaXNlY0B4aWFvbWkuY29tvfjQ0Le0wKENCg0KV2hlbiBoYW5kbGluZyBk
ZWR1cGxpY2F0ZWQgY29tcHJlc3NlZCBkYXRhLCB0aGVyZSBjYW4gYmUgbXVsdGlwbGUNCmRlY29t
cHJlc3NlZCBleHRlbnRzIHBvaW50aW5nIHRvIHRoZSBzYW1lIGNvbXByZXNzZWQgZGF0YSBpbiBv
bmUgc2hvdC4NCg0KSW4gc3VjaCBjYXNlcywgdGhlIGJ2ZWNzIHdoaWNoIGJlbG9uZyB0byB0aGUg
bG9uZ2VzdCBleHRlbnQgd2lsbCBiZQ0Kc2VsZWN0ZWQgYXMgdGhlIHByaW1hcnkgYnZlY3MgZm9y
IHJlYWwgZGVjb21wcmVzc29ycyB0byBkZWNvZGUgYW5kIHRoZQ0Kb3RoZXIgZHVwbGljYXRlZCBi
dmVjcyB3aWxsIGJlIGRpcmVjdGx5IGNvcGllZCBmcm9tIHRoZSBwcmltYXJ5IGJ2ZWNzLg0KDQpQ
cmV2aW91c2x5LCBvbmx5IHJlbGF0aXZlIG9mZnNldHMgb2YgdGhlIGxvbmdlc3QgZXh0ZW50IHdh
cyBjaGVja2VkIHRvDQpkZWNvbXByZXNzIHRoZSBwcmltYXJ5IGJ2ZWNzLiAgT24gcmFyZSBvY2Nh
c2lvbnMsIGl0IGNhbiBiZSBpbmNvcnJlY3QNCmlmIHRoZXJlIGFyZSBzZXZlcmFsIGV4dGVudHMg
d2l0aCB0aGUgc2FtZSBzdGFydCByZWxhdGl2ZSBvZmZzZXQuDQpBcyBhIHJlc3VsdCwgc29tZSBz
aG9ydCBidmVjcyBjb3VsZCBiZSBzZWxlY3RlZCBmb3IgZGVjb21wcmVzc2lvbiBhbmQNCnRoZW4g
Y2F1c2UgZGF0YSBjb3JydXB0aW9uLg0KDQpGb3IgZXhhbXBsZSwgYXMgU2hpamllIFN1biByZXBv
cnRlZCBvZmYtbGlzdCwgY29uc2lkZXJpbmcgdGhlIGZvbGxvd2luZw0KZXh0ZW50cyBvZiBhIGZp
bGU6DQogMTE3OiAgIDkwMzM0NS4uICA5MTUyNTAgfCAgIDExOTA1IDogICAgIDM4NTAyNC4uICAg
IDM4OTEyMCB8ICAgIDQwOTYNCi4uLg0KIDExOTogICA5MTk3MjkuLiAgOTMwMzIzIHwgICAxMDU5
NCA6ICAgICAzODUwMjQuLiAgICAzODkxMjAgfCAgICA0MDk2DQouLi4NCiAxMjQ6ICAgOTY4ODgx
Li4gIDk4MDc4NiB8ICAgMTE5MDUgOiAgICAgMzg1MDI0Li4gICAgMzg5MTIwIHwgICAgNDA5Ng0K
DQpUaGUgc3RhcnQgcmVsYXRpdmUgb2Zmc2V0IGlzIHRoZSBzYW1lOiAyMjI1LCBidXQgZXh0ZW50
IDExOSAoOTE5NzI5Li4NCjkzMDMyMykgaXMgc2hvcnRlciB0aGFuIHRoZSBvdGhlcnMuDQoNCkxl
dCdzIHJlc3RyaWN0IHRoZSBidmVjIGxlbmd0aCBpbiBhZGRpdGlvbiB0byB0aGUgc3RhcnQgb2Zm
c2V0IGlmIGJ2ZWNzDQphcmUgbm90IGZ1bGwuDQoNClJlcG9ydGVkLWJ5OiBTaGlqaWUgU3VuIDxz
dW5zaGlqaWVAeGlhb21pLmNvbT4NCkZpeGVzOiA1YzJhNjQyNTJjNWQgKCJlcm9mczogaW50cm9k
dWNlIHBhcnRpYWwtcmVmZXJlbmNlZCBwY2x1c3RlcnMiKQ0KU2lnbmVkLW9mZi1ieTogR2FvIFhp
YW5nIDxoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20+DQotLS0NCiBmcy9lcm9mcy96ZGF0YS5j
IHwgNyArKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL3pkYXRhLmMgYi9mcy9lcm9mcy96ZGF0YS5j
DQppbmRleCBiNjlkODlhMTFkZDAuLmRlNGYxMjE1MmI2MiAxMDA2NDQNCi0tLSBhL2ZzL2Vyb2Zz
L3pkYXRhLmMNCisrKyBiL2ZzL2Vyb2ZzL3pkYXRhLmMNCkBAIC0xMTQ0LDEwICsxMTQ0LDExIEBA
IHN0YXRpYyB2b2lkIHpfZXJvZnNfZG9fZGVjb21wcmVzc2VkX2J2ZWMoc3RydWN0IHpfZXJvZnNf
ZGVjb21wcmVzc19iYWNrZW5kICpiZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IHpfZXJvZnNfYnZlYyAqYnZlYykNCiB7DQogICAgICAgIHN0cnVjdCB6
X2Vyb2ZzX2J2ZWNfaXRlbSAqaXRlbTsNCisgICAgICAgdW5zaWduZWQgaW50IHBnbnI7DQoNCi0g
ICAgICAgaWYgKCEoKGJ2ZWMtPm9mZnNldCArIGJlLT5wY2wtPnBhZ2VvZnNfb3V0KSAmIH5QQUdF
X01BU0spKSB7DQotICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHBnbnI7DQotDQorICAgICAg
IGlmICghKChidmVjLT5vZmZzZXQgKyBiZS0+cGNsLT5wYWdlb2ZzX291dCkgJiB+UEFHRV9NQVNL
KSAmJg0KKyAgICAgICAgICAgKGJ2ZWMtPmVuZCA9PSBQQUdFX1NJWkUgfHwNCisgICAgICAgICAg
ICBidmVjLT5vZmZzZXQgKyBidmVjLT5lbmQgPT0gYmUtPnBjbC0+bGVuZ3RoKSkgew0KICAgICAg
ICAgICAgICAgIHBnbnIgPSAoYnZlYy0+b2Zmc2V0ICsgYmUtPnBjbC0+cGFnZW9mc19vdXQpID4+
IFBBR0VfU0hJRlQ7DQogICAgICAgICAgICAgICAgREJHX0JVR09OKHBnbnIgPj0gYmUtPm5yX3Bh
Z2VzKTsNCiAgICAgICAgICAgICAgICBpZiAoIWJlLT5kZWNvbXByZXNzZWRfcGFnZXNbcGducl0p
IHsNCi0tDQoyLjI0LjQNCg0KIy8qKioqKiqxvtPKvP68sMbkuL28/rqs09DQocPXuavLvrXEsaPD
3NDFz6KjrL32z97T2reiy824+MnPw+a12Na31tDB0LP2tcS49sjLu/LIutfpoaO9+9a5yM66zsbk
y/vIy9LUyM66ztDOyr3KudPDo6iw/MCotauyu8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4tNbGoaK7
8smit6KjqbG+08q8/tbQtcTQxc+ioaPI57n7xPq07crVwcuxvtPKvP6jrMfrxPrBory0tee7sLvy
08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP6joSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1l
bnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBp
cyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlz
IGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVp
biBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFy
dGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNv
bnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElm
IHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K

--_000_4a9259a9675e48e083139c22f7a86c8cxiaomicom_
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
</span></font>#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=
=D0=D0=A1=C3=D7=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=
=D3=DA=B7=A2=CB=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=
=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=
=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=
=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=
=A1=A2=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=
=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=
=C1=A2=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=
=A2=C9=BE=B3=FD=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments con=
tain confidential information from XIAOMI, which is intended only for the p=
erson or
 entity whose address is listed above. Any use of the information contained=
 herein in any way (including, but not limited to, total or partial disclos=
ure, reproduction, or dissemination) by persons other than the intended rec=
ipient(s) is prohibited. If you
 receive this e-mail in error, please notify the sender by phone or email i=
mmediately and delete it!******/#
</body>
</html>

--_000_4a9259a9675e48e083139c22f7a86c8cxiaomicom_--
