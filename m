Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB92155AAFA
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jun 2022 16:29:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LVbwm6Nwwz3c4h
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jun 2022 00:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=WJy48bo8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=126.com (client-ip=220.181.15.48; helo=m1548.mail.126.com; envelope-from=cheny_wen@126.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=WJy48bo8;
	dkim-atps=neutral
Received: from m1548.mail.126.com (m1548.mail.126.com [220.181.15.48])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LVbwb4pkqz305M
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jun 2022 00:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ypGs7
	lpxxQx6BOfxMJzF+1MxsCsKZeK+VXcMIsiX7Pk=; b=WJy48bo8MhKICciRJViaQ
	zb6n+kEhfGkKu0scV35OL8dPH9uM48Ja4pzhjMXmVCKuV7+MZETAc5+75OMw6oC/
	JL35zggaw+6PbHsE9Wvhw3ghRd9jaCErmjvfl3Ott1nVntK8EM6l3ThpqD8XzpPX
	r2zEuBByFvAdx1EihTCK5M=
Received: from cheny_wen$126.com ( [120.231.117.174] ) by
 ajax-webmail-wmsvr48 (Coremail) ; Sat, 25 Jun 2022 22:29:02 +0800 (CST)
X-Originating-IP: [120.231.117.174]
Date: Sat, 25 Jun 2022 22:29:02 +0800 (CST)
From: cheny_wen@126.com
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
Subject: Re:Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head
 ready.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
References: <20220625085738.12834-1-cheny_wen@126.com>
 <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Message-ID: <68c6768b.6289.1819b4421df.Coremail.cheny_wen@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MMqowADH3navG7dihL0yAA--.33177W
X-CM-SenderInfo: xfkh05hbzh0qqrswhudrp/1tbimxQrhlx5hG+kegABsz
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
Cc: Even <chenyuwen1@meizu.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

SGkKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7SSZuYnNwO2hhdmUmbmJzcDtzZW50Jm5i
c3A7YSZuYnNwO25ldyZuYnNwO2VtYWlsJm5ic3A7ZnJvbSZuYnNwO21laXp1Jm5ic3A7ZW1haWwm
bmJzcDt3aGljaCZuYnNwO3NpZ25lZCZuYnNwO3RoZSZuYnNwO3BhdGNoLgoKdGhpbmtzJm5ic3A7
Zm9yJm5ic3A7eW91ciZuYnNwO2hlbHAuCuWcqCAyMDIyLTA2LTI1IDE3OjQ0OjQ477yMIkdhbyBY
aWFuZyIgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4g5YaZ6YGT77yaCkhpLA0KDQpPbiBT
YXQsIEp1biAyNSwgMjAyMiBhdCAwNDo1NzozOFBNICswODAwLCBFdmVuIHdyb3RlOg0KPiBGcm9t
OiBFdmVuIDxjaGVueXV3ZW4xQG1laXp1LmNvbT4NCj4gDQo+IFdoZW4gdGhlIHVzZXIgbW91bnRz
IHRoZSBlcm9mcyBzZWNvbmQgdGltZXMsIHRoZSBkZWNvbXByZXNzaW9uIHRocmVhZA0KPiBtYXkg
aHVuZy4gVGhlIHByb2JsZW0gaGFwcGVucyBkdWUgdG8gYSBzZXF1ZW5jZSBvZiBzdGVwcyBsaWtl
IHRoZQ0KPiBmb2xsb3dpbmc6DQo+IA0KPiAxKSBUYXNrIEEgY2FsbGVkIHpfZXJvZnNfbG9hZF9s
em1hX2NvbmZpZyB3aGljaCBvYnRhaW4gYWxsIG9mIHRoZSBub2RlDQo+ICAgIGZyb20gdGhlIHpf
ZXJvZnNfbHptYV9oZWFkLg0KPiANCj4gMikgQXQgdGhpcyB0aW1lLCB0YXNrIEIgY2FsbGVkIHRo
ZSB6X2Vyb2ZzX2x6bWFfZGVjb21wcmVzcyBhbmQgd2FudGVkIHRvDQo+ICAgIGdldCBhIG5vZGUu
IEJ1dCB0aGUgel9lcm9mc19sem1hX2hlYWQgd2FzIGVtcHR5LCB0aGUgVGFzayBCIGhhZCB0bw0K
PiAgICBzbGVlcC4NCj4gDQo+IDMpIFRhc2sgQSByZWxlYXNlIG5vZGVzIGFuZCBwdXNoIG5vZGVz
IGludG8gdGhlIHpfZXJvZnNfbHptYV9oZWFkLiBCdXQNCj4gICAgdGFzayBCIHdhcyBzdGlsbCBz
bGVlcGluZy4NCj4gDQo+IE9uZSBleGFtcGxlIHJlcG9ydCB3aGVuIHRoZSBodW5nIGhhcHBlbnM6
DQo+IHRhc2s6a3dvcmtlci91MzoxIHN0YXRlOkQgc3RhY2s6MTQzODQgcGlkOiA4NiBwcGlkOiAy
IGZsYWdzOjB4MDAwMDQwMDANCj4gV29ya3F1ZXVlOiBlcm9mc191bnppcGQgel9lcm9mc19kZWNv
bXByZXNzcXVldWVfd29yaw0KPiBDYWxsIFRyYWNlOg0KPiAgPFRBU0s+DQo+ICBfX3NjaGVkdWxl
KzB4MjgxLzB4NzYwDQo+ICBzY2hlZHVsZSsweDQ5LzB4YjANCj4gIHpfZXJvZnNfbHptYV9kZWNv
bXByZXNzKzB4NGJjLzB4NTgwDQo+ICA/IGNwdV9jb3JlX2ZsYWdzKzB4MTAvMHgxMA0KPiAgel9l
cm9mc19kZWNvbXByZXNzX3BjbHVzdGVyKzB4NDliLzB4YmEwDQo+ICA/IF9fdXBkYXRlX2xvYWRf
YXZnX3NlKzB4MmIwLzB4MzMwDQo+ICA/IF9fdXBkYXRlX2xvYWRfYXZnX3NlKzB4MmIwLzB4MzMw
DQo+ICA/IHVwZGF0ZV9sb2FkX2F2ZysweDVmLzB4NjkwDQo+ICA/IHVwZGF0ZV9sb2FkX2F2Zysw
eDVmLzB4NjkwDQo+ICA/IHNldF9uZXh0X2VudGl0eSsweGJkLzB4MTEwDQo+ICA/IF9yYXdfc3Bp
bl91bmxvY2srMHhkLzB4MjANCj4gIHpfZXJvZnNfZGVjb21wcmVzc19xdWV1ZS5pc3JhLjArMHgy
ZS8weDUwDQo+ICB6X2Vyb2ZzX2RlY29tcHJlc3NxdWV1ZV93b3JrKzB4MzAvMHg2MA0KPiAgcHJv
Y2Vzc19vbmVfd29yaysweDFkMy8weDNhMA0KPiAgd29ya2VyX3RocmVhZCsweDQ1LzB4M2EwDQo+
ICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzYTAvMHgzYTANCj4gIGt0aHJlYWQrMHhlMi8weDExMA0K
PiAgPyBrdGhyZWFkX2NvbXBsZXRlX2FuZF9leGl0KzB4MjAvMHgyMA0KPiAgcmV0X2Zyb21fZm9y
aysweDIyLzB4MzANCj4gIDwvVEFTSz4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV2ZW4gPGNoZW55
dXdlbjFAbWVpenUuY29tPg0KDQpUaGFua3MgYSBsb3QgZm9yIGNhdGNoaW5nIHRoaXMhDQoNClRo
ZSBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCwgYnV0IGNvdWxkIHlvdSB1c2UgeW91ciByZWFsIG5h
bWUgdG8gc2lnbg0Kb2ZmIHRoZSBwYXRjaCBhbmQgcmVzZW5kIGEgdmVyc2lvbj8gc2VlLA0KaHR0
cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5odG1sI2RldmVsb3Blci1zLWNlcnRpZmljYXRlLW9mLW9yaWdpbi0xLTENCg0KT3RoZXJ3
aXNlIGl0IGxvb2tzIGdvb2QgdG8gbWUsDQpSZXZpZXdlZC1ieTogR2FvIFhpYW5nIDxoc2lhbmdr
YW9AbGludXguYWxpYmFiYS5jb20+DQoNClRoYW5rcywNCkdhbyBYaWFuZw0K
