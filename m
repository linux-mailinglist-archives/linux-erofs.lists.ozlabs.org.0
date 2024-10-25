Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F39AF718
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 03:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729820638;
	bh=YRC3cOpVFCcFmpHmJPAcPU3Ali1vpl0KPVIdhi0f9Ok=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ff0AklQVEk5uWnkezlXZN9Q9+PJlgcIa2mBzrk50K074MS1EkvpIBbl4ckXMfVSfi
	 bsjxyMY1kq8p4Z9bi7F9pG1DK4ckTn8Jg6iK6dI+O/vVrxh65b3oYK5S7a8XZvH/1M
	 D88WI4TuYQb9/ygkRRhNpINNsd20QfpNqkGx5X0ROiR87S1BqNN8smoRPKw80AbiyI
	 QI2+DFhogVs23hXYnGVWRGNb5ZgJj+3wKKPLYzyq9fMrC+aokCwbOJd080i1ryr75M
	 SRFsbh2wvnHEUgtyEl+lXzIk7v98cyS+OUo83PLapvXqVzXEmvJI+H1JQJLMCELQ3x
	 uVFE+zRKkgx2A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZQYV030Hz2xnK
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 12:43:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=118.143.206.90
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729820635;
	cv=none; b=OSmykMZObwrqBZjgrcIIwquDTG9zXQT7iUyUWIjG5/1Pwyp7BKrsGWiScH3itD+pqdimEgDPp1WpiVjrlRLDC+esAo22TfbIL4bgKOn6jLaM6uktlybolK925mmKJlvqaYcrV8EN2gZ8bO/NIvm+u+OMzco+NiGqFzTMIW725K7M4qtEs+0Ag59/m9EjdUjI9T9Iv/GFTH4PitOa9tqiuwrVAF5kBd7eHUiAtBcVdPOCoZtwrxpaRU6ZUwbIrvoHxSY/1MfEhDhraWfxMr23pCy64z/IwYrLWU0p3FJrEo7GkiNMPUvlpKwV8sCKnbS18KhXeav2RwNg9reAojZl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729820635; c=relaxed/relaxed;
	bh=YRC3cOpVFCcFmpHmJPAcPU3Ali1vpl0KPVIdhi0f9Ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MaPzhSn3TpyShBgPrzOoWN2P/ZQu74g/Nj3Lo0jfNNTm3PDgUL/7NrH9ZVtcNGzLS1VzcuqZfHqfZcs1cq5sqDxr5Pi63iUjxQeHuLi3w7P1ma8w2xG96kKjDH8VExXR8WX54fAWydWv2gZoJoug+qmCdWNHAYZhuIjEKxHArNo+yoUn8bjNHwcQjejxIKp8xAPo7nK0Q2YWMXrgZjgX1vYCY+O6hJApTpiKVuDJ0riOTtkwmJciIq/ea+soxlXTpizZ/HBJh4eyfYAsxMfNN9hlE2AoIpUDCZD6YM/waJhLBYU3dYrvTEdKUw1v/vUUmXlgSWVLyEHwlsIAVYz4gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass (client-ip=118.143.206.90; helo=outboundhk.mxmail.xiaomi.com; envelope-from=huangjianan@xiaomi.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaomi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=118.143.206.90; helo=outboundhk.mxmail.xiaomi.com; envelope-from=huangjianan@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Fri, 25 Oct 2024 12:43:54 AEDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZQYQ1Cgmz2xJK
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 12:43:54 +1100 (AEDT)
X-CSE-ConnectionGUID: DqK2u4iSQTOQH0V7udThrA==
X-CSE-MsgGUID: InP8gByWTGaJ1H0VlgjkqQ==
X-IronPort-AV: E=Sophos;i="6.11,230,1725292800"; 
   d="scan'208";a="99598863"
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [External Mail]Re: [PATCH] erofs-utils: avoid allocating large
 arrays on the stack
Thread-Topic: [External Mail]Re: [PATCH] erofs-utils: avoid allocating large
 arrays on the stack
Thread-Index: AQHbJfnUALw7iSNLxkSbnJYg7YRZ7rKVlwwAgACVQwA=
Date: Fri, 25 Oct 2024 01:42:47 +0000
Message-ID: <c3367a2e-ff0e-4eb9-91cf-004f3e284d86@xiaomi.com>
References: <20241024094806.634534-1-huangjianan@xiaomi.com>
 <CAB=BE-QGVZPJizeOceDgjZ-D8JL12AYp8O8Y-qMm2pn+ER-2Jw@mail.gmail.com>
In-Reply-To: <CAB=BE-QGVZPJizeOceDgjZ-D8JL12AYp8O8Y-qMm2pn+ER-2Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.88.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8988E60221FF04CA122D2C6524B2090@xiaomi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=0.9 required=5.0 tests=RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_SOFTFAIL,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@xiaomi.com>
Cc: "zhaoyifan@sjtu.edu.cn" <zhaoyifan@sjtu.edu.cn>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

T24gMjAyNC8xMC8yNSAwOjQ4LCBTYW5kZWVwIERoYXZhbGUgd3JvdGU6DQo+IA0KPiBIaSBKaWFu
YW4sDQo+IA0KPiBPbiBUaHUsIE9jdCAyNCwgMjAyNCBhdCAyOjQ54oCvQU0gSmlhbmFuIEh1YW5n
IHZpYSBMaW51eC1lcm9mcw0KPiA8bGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZz4gd3JvdGU6
DQo+Pg0KPj4gVGhlIGRlZmF1bHQgcHRocmVhZCBzdGFjayBzaXplIG9mIGJpb25pYyBpcyAxTS4g
VXNlIG1hbGxvYyB0byBhdm9pZA0KPj4gc3RhY2sgb3ZlcmZsb3cuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogSmlhbmFuIEh1YW5nIDxodWFuZ2ppYW5hbkB4aWFvbWkuY29tPg0KPj4gLS0tDQo+PiAg
IGxpYi9jb21wcmVzcy5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2xpYi9jb21wcmVzcy5jIGIvbGliL2NvbXByZXNzLmMNCj4+IGluZGV4
IGNiZDQ2MjAuLjQ3YmE2NjIgMTAwNjQ0DQo+PiAtLS0gYS9saWIvY29tcHJlc3MuYw0KPj4gKysr
IGIvbGliL2NvbXByZXNzLmMNCj4+IEBAIC00NTEsMzEgKzQ1MSwzNyBAQCBzdGF0aWMgaW50IHpf
ZXJvZnNfZmlsbF9pbmxpbmVfZGF0YShzdHJ1Y3QgZXJvZnNfaW5vZGUgKmlub2RlLCB2b2lkICpk
YXRhLA0KPj4gICAgICAgICAgcmV0dXJuIGxlbjsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgdm9p
ZCB0cnlyZWNvbXByZXNzX3RyYWlsaW5nKHN0cnVjdCB6X2Vyb2ZzX2NvbXByZXNzX3NjdHggKmN0
eCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGVyb2ZzX2Nv
bXByZXNzICplYywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
aW4sIHVuc2lnbmVkIGludCAqaW5zaXplLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2b2lkICpvdXQsIHVuc2lnbmVkIGludCAqY29tcHJlc3NlZHNpemUpDQo+PiArc3Rh
dGljIGludCB0cnlyZWNvbXByZXNzX3RyYWlsaW5nKHN0cnVjdCB6X2Vyb2ZzX2NvbXByZXNzX3Nj
dHggKmN0eCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZXJv
ZnNfY29tcHJlc3MgKmVjLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKmluLCB1bnNpZ25lZCBpbnQgKmluc2l6ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2b2lkICpvdXQsIHVuc2lnbmVkIGludCAqY29tcHJlc3NlZHNpemUpDQo+PiAg
IHsNCj4+ICAgICAgICAgIHN0cnVjdCBlcm9mc19zYl9pbmZvICpzYmkgPSBjdHgtPmljdHgtPmlu
b2RlLT5zYmk7DQo+PiAtICAgICAgIGNoYXIgdG1wW1pfRVJPRlNfUENMVVNURVJfTUFYX1NJWkVd
Ow0KPj4gKyAgICAgICBjaGFyICp0bXA7DQo+PiAgICAgICAgICB1bnNpZ25lZCBpbnQgY291bnQ7
DQo+PiAgICAgICAgICBpbnQgcmV0ID0gKmNvbXByZXNzZWRzaXplOw0KPj4NCj4+ICsgICAgICAg
dG1wID0gbWFsbG9jKFpfRVJPRlNfUENMVVNURVJfTUFYX1NJWkUpOw0KPj4gKyAgICAgICBpZiAo
IXRtcCkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+ICAgICAg
ICAgIC8qIG5vIG5lZWQgdG8gcmVjb21wcmVzcyAqLw0KPj4gICAgICAgICAgaWYgKCEocmV0ICYg
KGVyb2ZzX2Jsa3NpeihzYmkpIC0gMSkpKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVybjsNCj4+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+IFlvdSBjYW4gbW92ZSBhbGxvY2F0aW9u
IGhlcmUgaW5zdGVhZCBvZiBhdCB0aGUgdG9wIHRvIGF2b2lkIG1hbGxvYw0KPiBjb3N0IGlmIHdl
IGRvIG5vdCBuZWVkIHRoZSB0bXAuDQo+IA0KPiBBbHNvIG5lZWQgdG8gZnJlZSB0bXAgb24gYWxs
IHRoZSBleGl0IHBhdGhzLg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgc2VuZCBv
dXQgdjIgdG8gZml4IHRoZXNlIGlzc3Vlcy4NCg0KVGhhbmtzLA0KSmlhbmFuLg0KDQo+IA0KPiBU
aGFua3MsDQo+IFNhbmRlZXAuDQo+IA0KPj4gICAgICAgICAgY291bnQgPSAqaW5zaXplOw0KPj4g
ICAgICAgICAgcmV0ID0gZXJvZnNfY29tcHJlc3NfZGVzdHNpemUoZWMsIGluLCAmY291bnQsICh2
b2lkICopdG1wLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm91
bmRkb3duKHJldCwgZXJvZnNfYmxrc2l6KHNiaSkpKTsNCj4+ICAgICAgICAgIGlmIChyZXQgPD0g
MCB8fCByZXQgKyAoKmluc2l6ZSAtIGNvdW50KSA+PQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHJvdW5kdXAoKmNvbXByZXNzZWRzaXplLCBlcm9mc19ibGtzaXooc2JpKSkpDQo+PiAtICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4NCj4+
ICAgICAgICAgIC8qIHJlcGxhY2UgdGhlIG9yaWdpbmFsIGNvbXByZXNzZWQgZGF0YSBpZiBhbnkg
Z2FpbiAqLw0KPj4gICAgICAgICAgbWVtY3B5KG91dCwgdG1wLCByZXQpOw0KPj4gICAgICAgICAg
Kmluc2l6ZSA9IGNvdW50Ow0KPj4gICAgICAgICAgKmNvbXByZXNzZWRzaXplID0gcmV0Ow0KPj4g
Kw0KPj4gKyAgICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGJvb2wgel9l
cm9mc19maXh1cF9kZWR1cGVkX2ZyYWdtZW50KHN0cnVjdCB6X2Vyb2ZzX2NvbXByZXNzX3NjdHgg
KmN0eCwNCj4+IEBAIC02MzEsOSArNjM3LDE0IEBAIGZyYWdfcGFja2luZzoNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGZpeF9kZWR1cGVkZnJhZzsNCj4+ICAgICAgICAgICAgICAg
ICAgfQ0KPj4NCj4+IC0gICAgICAgICAgICAgICBpZiAobWF5X2lubGluZSAmJiBsZW4gPT0gZS0+
bGVuZ3RoKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHJ5cmVjb21wcmVzc190cmFpbGlu
ZyhjdHgsIGgsIGN0eC0+cXVldWUgKyBjdHgtPmhlYWQsDQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmUtPmxlbmd0aCwgZHN0LCAmY29tcHJlc3NlZHNpemUpOw0K
Pj4gKyAgICAgICAgICAgICAgIGlmIChtYXlfaW5saW5lICYmIGxlbiA9PSBlLT5sZW5ndGgpIHsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHRyeXJlY29tcHJlc3NfdHJhaWxpbmco
Y3R4LCBoLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjdHgtPnF1ZXVlICsgY3R4LT5oZWFkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZS0+bGVuZ3RoLCBkc3QsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjb21wcmVz
c2Vkc2l6ZSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgICAgICAg
IH0NCj4+DQo+PiAgICAgICAgICAgICAgICAgIGUtPmNvbXByZXNzZWRibGtzID0gQkxLX1JPVU5E
X1VQKHNiaSwgY29tcHJlc3NlZHNpemUpOw0KPj4gICAgICAgICAgICAgICAgICBEQkdfQlVHT04o
ZS0+Y29tcHJlc3NlZGJsa3MgKiBibGtzeiA+PSBlLT5sZW5ndGgpOw0KPj4gLS0NCj4+IDIuNDMu
MA0KPj4NCg0K
