Return-Path: <linux-erofs+bounces-2972-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIhnCZC1wmlilAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2972-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 17:02:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7D3188C6
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 17:02:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgFD41BtNz2ynP;
	Wed, 25 Mar 2026 03:02:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774368132;
	cv=none; b=QaVyrIABtvpHG3exMLPj0vOxsYN+M48Rc+fxmUsi6OehGnbqle4j320s8LcL595CeAsv1YnujCv6464M9ytEfijuydiWZ0IixMVEX4Div2ljumk4Uh7CDQ6P2W80wrf4WAdrBYj3qTeeJocged6Rak26f3YunQMLoUM8kI15OsVd996x0GESBXVZPt+b58iPsXoGDz6VI1D2KYXH2sd1UFKXdVstyEZzafL3Br6wBuPAYXxD6BetkktHBbW1Jv2NLcJhJ+s1oNUQLs+hs7PeYhn3oRjcxWjua+BjLUkNmdCeo6BwWZz+dcLeXQqCjasiv+L5e2S0s08L+6TtxjTv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774368132; c=relaxed/relaxed;
	bh=SYYYy19iizwkzxGaRoLQSHvTeGMYtbhLYcniGC3Mz5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VugTYlFnio+SeQ/bkEyim9TrxZEN+zE7ZGGRpIqAokmY7YqRicoQPCB3VlxnOVkEbI6QwYbXGuAi7u5flwvdRlRHpBIVn0COz5NR/zvUvJG+x2Hb+GP9oCiPwRY3VKyAPWjqw7cLWEVS07YvTPLYF02QKEblscH97EFuH0Quc2fTSUvX5gjRi7VKvdfqH9qEJNKd3oE1Fb1cw8lIKPDKsrV2BLqw1BPQlXxsKqVEyaPzX1HjwTp0acZ7WrjxU4NCrqlbdKZKV6nWXNEi5lucubhDQ5HeOdY3alwYQtdQyem0JPtpMPNJGZsaRsps1LZg3ek5eAcqQ84F7VAjPR2hvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GakXPwaz; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GakXPwaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgFD11HPMz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 03:02:08 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SYYYy19iizwkzxGaRoLQSHvTeGMYtbhLYcniGC3Mz5A=;
	b=GakXPwaziS0nD2URflhEF4oDCpdxK5X+VF4V88YtvWCThthOiU+t+9Op1GyiAnSsTjOqvDUTF
	aEz+39Rus/KKQ7BrZegRvCAENn0hTMgyLJJOyCAFiQgcBWeaxXDUMpTOEOPjDYxtXfk7S7N0RsG
	7QgoEsBSTucQv5M3PcsFMDM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fgF4p4dJKz1prLL;
	Tue, 24 Mar 2026 23:55:54 +0800 (CST)
Received: from kwepemr100015.china.huawei.com (unknown [7.202.195.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ED7E40537;
	Wed, 25 Mar 2026 00:02:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (7.202.195.162) by
 kwepemr100015.china.huawei.com (7.202.195.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Mar 2026 00:02:02 +0800
Received: from kwepemr500015.china.huawei.com ([7.202.195.162]) by
 kwepemr500015.china.huawei.com ([7.202.195.162]) with mapi id 15.02.1544.011;
 Wed, 25 Mar 2026 00:02:02 +0800
From: "Lihongbo(hb-lee,OS Lab)" <lihongbo22@huawei.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, " Gao Xiang"
	<hsiangkao@linux.alibaba.com>
Subject: RE: [PATCH v2] erofs: fix .fadvise() for page cache sharing
Thread-Topic: [PATCH v2] erofs: fix .fadvise() for page cache sharing
Thread-Index: AQHcu6Z3Y/oikVxFtkOwxPw1j4kkbLW9182W
Date: Tue, 24 Mar 2026 16:02:02 +0000
Message-ID: WeLink-17743681214731&sendType=REPLY_WITHOUT_ATTACHMENTS-openHarmony
References: <20260324155407.371642-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260324155407.371642-1-hsiangkao@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: multipart/alternative;
	boundary="_000_WeLink17743681214731sendTypeREPLYWITHOUTATTACHMENTSopen_"
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,INVALID_MSGID,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.10 / 15.00];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	MID_MISSING_BRACKETS(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2972-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-kernel.vger.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:dkim,huawei.com:email,ozlabs.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2EF7D3188C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--_000_WeLink17743681214731sendTypeREPLYWITHOUTATTACHMENTSopen_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9rLCBsb29rIGdvb2QgdG8gbWUNCg0KUmV2aWV3ZWQtYnk6IEhvbmdibyBMaSA8bGlob25n
Ym8yMkBodWF3ZWkuY29tPG1haWx0bzpsaWhvbmdibzIyQGh1YXdlaS5jb20+Pg0KDQpUaGFua3Mu
DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkxpIEhvbmdibw0KTWFpbDog
bGlob25nYm8yMkBodWF3ZWkuY29tPG1haWx0bzpsaWhvbmdibzIyQGh1YXdlaS5jb20+DQrlj5Hk
u7bkurrvvJpHYW8gWGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbTxtYWlsdG86aHNp
YW5na2FvQGxpbnV4LmFsaWJhYmEuY29tPj4NCuaUtuS7tuS6uu+8mmxpbnV4LWVyb2ZzQGxpc3Rz
Lm96bGFicy5vcmcgPGxpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmc8bWFpbHRvOmxpbnV4LWVy
b2ZzQGxpc3RzLm96bGFicy5vcmc+Pg0K5oqE4oCD6YCB77yaTEtNTCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzxtYWlsdG86bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4+OyBHYW8g
WGlhbmcgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbTxtYWlsdG86aHNpYW5na2FvQGxpbnV4
LmFsaWJhYmEuY29tPj47IExpaG9uZ2JvKGhiLWxlZSxPUyBMYWIpIDxsaWhvbmdibzIyQGh1YXdl
aS5jb208bWFpbHRvOmxpaG9uZ2JvMjJAaHVhd2VpLmNvbT4+DQrkuLvigIPpopjvvJpbUEFUQ0gg
djJdIGVyb2ZzOiBmaXggLmZhZHZpc2UoKSBmb3IgcGFnZSBjYWNoZSBzaGFyaW5nDQrml7bigIPp
l7TvvJoyMDI2LTAzLTI044CAMjM6NTQ6MTUNCg0KQ3VycmVudGx5LCAuZmFkdmlzZSgpIGRvZXNu
J3Qgd29yayB3ZWxsIGlmIHBhZ2UgY2FjaGUgc2hhcmluZyBpcyBvbg0Kc2luY2Ugc2hhcmVkIGlu
b2RlcyBiZWxvbmcgdG8gYSBwc2V1ZG8gZnMgZ2VuZXJhdGVkIHdpdGggaW5pdF9wc2V1ZG8oKSwN
CmFuZCBzYi0+c19iZGkgaXMgdGhlIGRlZmF1bHQgb25lICZub29wX2JhY2tpbmdfZGV2X2luZm8u
DQoNClRoZW4sIGdlbmVyaWNfZmFkdmlzZSgpIHdpbGwganVzdCBiZWhhdmUgYXMgYSBuby1vcCBp
ZiBzYi0+c19iZGkgaXMNCiZub29wX2JhY2tpbmdfZGV2X2luZm8sIGJ1dCBhcyB0aGUgYmRldiBm
cyAodGhlIGJkZXYgZnMgY2hhbmdlcw0KaW5vZGVfdG9fYmRpKCkgaW5zdGVhZCksIGl0J3MgYWN0
dWFsbHkgTk9UIGEgcHVyZSBtZW1mcy4NCg0KTGV0J3MgZ2VuZXJhdGUgYSByZWFsIGJkaSBmb3Ig
ZXJvZnNfaXNoYXJlX21udCBpbnN0ZWFkLg0KDQpGaXhlczogZDg2ZDc4MTdjMDQyICgiZXJvZnM6
IGltcGxlbWVudCAuZmFkdmlzZSBmb3IgcGFnZSBjYWNoZSBzaGFyZSIpDQpDYzogSG9uZ2JvIExp
IDxsaWhvbmdibzIyQGh1YXdlaS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFu
Z2thb0BsaW51eC5hbGliYWJhLmNvbT4NCi0tLQ0KdjI6DQogLSBoYW5kbGUgc3VwZXJfc2V0dXBf
YmRpKCkgZmFpbHVyZSBwcm9wZXJseS4NCg0KIGZzL2Vyb2ZzL2lzaGFyZS5jIHwgMTUgKysrKysr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9mcy9lcm9mcy9pc2hhcmUuYyBiL2ZzL2Vyb2ZzL2lzaGFyZS5j
DQppbmRleCA4MjlkNTBkNWM3MTcuLmVjNDMzYmFjYzU5MiAxMDA2NDQNCi0tLSBhL2ZzL2Vyb2Zz
L2lzaGFyZS5jDQorKysgYi9mcy9lcm9mcy9pc2hhcmUuYw0KQEAgLTIwMCw4ICsyMDAsMTkgQEAg
c3RydWN0IGlub2RlICplcm9mc19yZWFsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGJvb2wg
Km5lZWRfaXB1dCkNCg0KIGludCBfX2luaXQgZXJvZnNfaW5pdF9pc2hhcmUodm9pZCkNCiB7DQot
ICAgICAgIGVyb2ZzX2lzaGFyZV9tbnQgPSBrZXJuX21vdW50KCZlcm9mc19hbm9uX2ZzX3R5cGUp
Ow0KLSAgICAgICByZXR1cm4gUFRSX0VSUl9PUl9aRVJPKGVyb2ZzX2lzaGFyZV9tbnQpOw0KKyAg
ICAgICBzdHJ1Y3QgdmZzbW91bnQgKm1udDsNCisgICAgICAgaW50IHJldDsNCisNCisgICAgICAg
bW50ID0ga2Vybl9tb3VudCgmZXJvZnNfYW5vbl9mc190eXBlKTsNCisgICAgICAgaWYgKElTX0VS
UihtbnQpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG1udCk7DQorICAgICAgIC8q
IGdlbmVyaWNfZmFkdmlzZSgpIGRvZXNuJ3Qgd29yayBpZiBzX2JkaSA9PSAmbm9vcF9iYWNraW5n
X2Rldl9pbmZvICovDQorICAgICAgIHJldCA9IHN1cGVyX3NldHVwX2JkaShtbnQtPm1udF9zYik7
DQorICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAga2Vybl91bm1vdW50KG1udCk7DQor
ICAgICAgIGVsc2UNCisgICAgICAgICAgICAgICBlcm9mc19pc2hhcmVfbW50ID0gbW50Ow0KKyAg
ICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KIHZvaWQgZXJvZnNfZXhpdF9pc2hhcmUodm9pZCkNCi0t
DQoyLjQzLjUNCg0K

--_000_WeLink17743681214731sendTypeREPLYWITHOUTATTACHMENTSopen_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVu
dD0iTWljcm9zb2Z0IEV4Y2hhbmdlIFNlcnZlciI+DQo8IS0tIGNvbnZlcnRlZCBmcm9tIHRleHQg
LS0+PHN0eWxlPjwhLS0gLkVtYWlsUXVvdGUgeyBtYXJnaW4tbGVmdDogMXB0OyBwYWRkaW5nLWxl
ZnQ6IDRwdDsgYm9yZGVyLWxlZnQ6ICM4MDAwMDAgMnB4IHNvbGlkOyB9IC0tPjwvc3R5bGU+DQo8
L2hlYWQ+DQo8Ym9keT4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksSGVsdmV0aWNh
IWltcG9ydGFudDsgZm9udC1zaXplOjE3LjBweDsgY29sb3I6IzMzMzMzMyI+DQo8YnI+DQo8YnI+
DQo8c3BhbiBzdHlsZT0iY29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDsiPk9rLDwvc3Bhbj48
c3BhbiBzdHlsZT0iY29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDsiPiBsb29rIGdvb2QgdG8g
bWU8L3NwYW4+PGJyPg0KPGJyPg0KPHNwYW4gc3R5bGU9ImNvbG9yOiMwMDAwMDA7Zm9udC1zaXpl
OjE0cHg7Ij5SZXZpZXdlZDwvc3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6IzAwMDAwMDtmb250LXNp
emU6MTRweDsiPi1ieTogSG9uZ2JvIExpICZsdDs8YSBocmVmPSJtYWlsdG86bGlob25nYm8yMkBo
dWF3ZWkuY29tIj5saWhvbmdibzIyQGh1YXdlaS5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+DQo8YnI+
DQo8c3BhbiBzdHlsZT0iY29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDsiPlRoYW5rPC9zcGFu
PjxzcGFuIHN0eWxlPSJjb2xvcjojMDAwMDAwO2ZvbnQtc2l6ZToxNHB4OyI+cy48L3NwYW4+PGJy
Pg0KPGJyPg0KPGJyPg0KPGhyIGlkPSJjbGllbnRfc2lnbmF0dXJlX3NlcGFyYXRvciIgc3R5bGU9
ImJvcmRlci10b3A6ZG90dGVkIDFweCI+DQo8c3BhbiBzdHlsZT0iY29sb3I6IzAwMDAwMDtmb250
LXNpemU6MTRweDsiPkxpIEhvbmdibyA8L3NwYW4+PGJyPg0KPHNwYW4gc3R5bGU9ImNvbG9yOiMw
MDAwMDA7Zm9udC1zaXplOjE0cHg7Ij5NYWlsOiA8YSBocmVmPSJtYWlsdG86bGlob25nYm8yMkBo
dWF3ZWkuY29tIj4NCmxpaG9uZ2JvMjJAaHVhd2VpLmNvbTwvYT48L3NwYW4+PC9kaXY+DQo8ZGl2
IG5hbWU9IkFueU9mZmljZS1CYWNrZ3JvdW5kLUltYWdlIiBzdHlsZT0iYm9yZGVyLXRvcDoxcHgg
c29saWQgI0I1QzRERjtwYWRkaW5nOjhweDsgYmFja2dyb3VuZC1yZXBlYXQ6IHJlcGVhdC14OyI+
DQo8ZGl2IHN0eWxlPSJ3b3JkLWJyZWFrOmJyZWFrLWFsbDsiPjxiPuWPkeS7tuS6uu+8mjwvYj5H
YW8gWGlhbmcgJmx0OzxhIGhyZWY9Im1haWx0bzpoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20i
PmhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbTwvYT4mZ3Q7PC9kaXY+DQo8ZGl2IHN0eWxlPSJ3
b3JkLWJyZWFrOmJyZWFrLWFsbDsiPjxiPuaUtuS7tuS6uu+8mjwvYj5saW51eC1lcm9mc0BsaXN0
cy5vemxhYnMub3JnICZsdDs8YSBocmVmPSJtYWlsdG86bGludXgtZXJvZnNAbGlzdHMub3psYWJz
Lm9yZyI+bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZzwvYT4mZ3Q7PC9kaXY+DQo8ZGl2IHN0
eWxlPSJ3b3JkLWJyZWFrOmJyZWFrLWFsbDsiPjxiPuaKhOKAg+mAge+8mjwvYj5MS01MICZsdDs8
YSBocmVmPSJtYWlsdG86bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyI+bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzwvYT4mZ3Q7OyBHYW8gWGlhbmcgJmx0OzxhIGhyZWY9Im1haWx0bzpo
c2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20iPmhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbTwv
YT4mZ3Q7OyBMaWhvbmdibyhoYi1sZWUsT1MgTGFiKSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxpaG9u
Z2JvMjJAaHVhd2VpLmNvbSI+bGlob25nYm8yMkBodWF3ZWkuY29tPC9hPiZndDs8L2Rpdj4NCjxk
aXYgc3R5bGU9IndvcmQtYnJlYWs6YnJlYWstYWxsOyI+PGI+5Li74oCD6aKY77yaPC9iPltQQVRD
SCB2Ml0gZXJvZnM6IGZpeCAuZmFkdmlzZSgpIGZvciBwYWdlIGNhY2hlIHNoYXJpbmc8L2Rpdj4N
CjxkaXYgc3R5bGU9IndvcmQtYnJlYWs6YnJlYWstYWxsOyI+PGI+5pe24oCD6Ze077yaPC9iPjIw
MjYtMDMtMjTjgIAyMzo1NDoxNTwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxmb250IHNpemU9
IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTBwdDsiPg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0
Ij5DdXJyZW50bHksIC5mYWR2aXNlKCkgZG9lc24ndCB3b3JrIHdlbGwgaWYgcGFnZSBjYWNoZSBz
aGFyaW5nIGlzIG9uPGJyPg0Kc2luY2Ugc2hhcmVkIGlub2RlcyBiZWxvbmcgdG8gYSBwc2V1ZG8g
ZnMgZ2VuZXJhdGVkIHdpdGggaW5pdF9wc2V1ZG8oKSw8YnI+DQphbmQgc2ItJmd0O3NfYmRpIGlz
IHRoZSBkZWZhdWx0IG9uZSAmYW1wO25vb3BfYmFja2luZ19kZXZfaW5mby48YnI+DQo8YnI+DQpU
aGVuLCBnZW5lcmljX2ZhZHZpc2UoKSB3aWxsIGp1c3QgYmVoYXZlIGFzIGEgbm8tb3AgaWYgc2It
Jmd0O3NfYmRpIGlzPGJyPg0KJmFtcDtub29wX2JhY2tpbmdfZGV2X2luZm8sIGJ1dCBhcyB0aGUg
YmRldiBmcyAodGhlIGJkZXYgZnMgY2hhbmdlczxicj4NCmlub2RlX3RvX2JkaSgpIGluc3RlYWQp
LCBpdCdzIGFjdHVhbGx5IE5PVCBhIHB1cmUgbWVtZnMuPGJyPg0KPGJyPg0KTGV0J3MgZ2VuZXJh
dGUgYSByZWFsIGJkaSBmb3IgZXJvZnNfaXNoYXJlX21udCBpbnN0ZWFkLjxicj4NCjxicj4NCkZp
eGVzOiBkODZkNzgxN2MwNDIgKCZxdW90O2Vyb2ZzOiBpbXBsZW1lbnQgLmZhZHZpc2UgZm9yIHBh
Z2UgY2FjaGUgc2hhcmUmcXVvdDspPGJyPg0KQ2M6IEhvbmdibyBMaSAmbHQ7bGlob25nYm8yMkBo
dWF3ZWkuY29tJmd0Ozxicj4NClNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyAmbHQ7aHNpYW5na2Fv
QGxpbnV4LmFsaWJhYmEuY29tJmd0Ozxicj4NCi0tLTxicj4NCnYyOjxicj4NCiZuYnNwOy0gaGFu
ZGxlIHN1cGVyX3NldHVwX2JkaSgpIGZhaWx1cmUgcHJvcGVybHkuPGJyPg0KPGJyPg0KJm5ic3A7
ZnMvZXJvZnMvaXNoYXJlLmMgfCAxNSAmIzQzOyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQz
OyYjNDM7JiM0MzsmIzQzOyYjNDM7JiM0MzsmIzQzOy0tPGJyPg0KJm5ic3A7MSBmaWxlIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoJiM0MzspLCAyIGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYg
LS1naXQgYS9mcy9lcm9mcy9pc2hhcmUuYyBiL2ZzL2Vyb2ZzL2lzaGFyZS5jPGJyPg0KaW5kZXgg
ODI5ZDUwZDVjNzE3Li5lYzQzM2JhY2M1OTIgMTAwNjQ0PGJyPg0KLS0tIGEvZnMvZXJvZnMvaXNo
YXJlLmM8YnI+DQomIzQzOyYjNDM7JiM0MzsgYi9mcy9lcm9mcy9pc2hhcmUuYzxicj4NCkBAIC0y
MDAsOCAmIzQzOzIwMCwxOSBAQCBzdHJ1Y3QgaW5vZGUgKmVyb2ZzX3JlYWxfaW5vZGUoc3RydWN0
IGlub2RlICppbm9kZSwgYm9vbCAqbmVlZF9pcHV0KTxicj4NCiZuYnNwOzxicj4NCiZuYnNwO2lu
dCBfX2luaXQgZXJvZnNfaW5pdF9pc2hhcmUodm9pZCk8YnI+DQombmJzcDt7PGJyPg0KLSZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBlcm9mc19pc2hhcmVfbW50ID0ga2Vybl9t
b3VudCgmYW1wO2Vyb2ZzX2Fub25fZnNfdHlwZSk7PGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyByZXR1cm4gUFRSX0VSUl9PUl9aRVJPKGVyb2ZzX2lzaGFyZV9tbnQp
Ozxicj4NCiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVjdCB2
ZnNtb3VudCAqbW50Ozxicj4NCiYjNDM7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGludCByZXQ7PGJyPg0KJiM0Mzs8YnI+DQomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBtbnQgPSBrZXJuX21vdW50KCZhbXA7ZXJvZnNfYW5vbl9mc190eXBlKTs8
YnI+DQomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoSVNfRVJS
KG1udCkpPGJyPg0KJiM0MzsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIFBUUl9F
UlIobW50KTs8YnI+DQomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
KiBnZW5lcmljX2ZhZHZpc2UoKSBkb2Vzbid0IHdvcmsgaWYgc19iZGkgPT0gJmFtcDtub29wX2Jh
Y2tpbmdfZGV2X2luZm8gKi88YnI+DQomIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyByZXQgPSBzdXBlcl9zZXR1cF9iZGkobW50LSZndDttbnRfc2IpOzxicj4NCiYjNDM7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChyZXQpPGJyPg0KJiM0Mzsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsga2Vybl91bm1vdW50KG1udCk7PGJyPg0KJiM0Mzsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZWxzZTxicj4NCiYjNDM7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGVyb2ZzX2lzaGFyZV9tbnQgPSBtbnQ7PGJyPg0KJiM0Mzsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIHJldDs8YnI+DQombmJz
cDt9PGJyPg0KJm5ic3A7PGJyPg0KJm5ic3A7dm9pZCBlcm9mc19leGl0X2lzaGFyZSh2b2lkKTxi
cj4NCi0tIDxicj4NCjIuNDMuNTxicj4NCjxicj4NCjwvZGl2Pg0KPC9zcGFuPjwvZm9udD48L2Rp
dj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_WeLink17743681214731sendTypeREPLYWITHOUTATTACHMENTSopen_--

