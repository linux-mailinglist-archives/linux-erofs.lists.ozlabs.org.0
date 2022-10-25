Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8B60C7F3
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Oct 2022 11:24:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MxRNZ15h8z3cBn
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Oct 2022 20:24:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=FB/QP9Vz;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=HM0APLWO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bounces.elasticemail.net (client-ip=67.227.87.8; helo=n8.mxout.mta4.net; envelope-from=workshops=skillsforafrica.or.ke@bounces.elasticemail.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bounces.elasticemail.net header.i=@bounces.elasticemail.net header.a=rsa-sha256 header.s=api header.b=FB/QP9Vz;
	dkim=pass (1024-bit key; unprotected) header.d=elasticemail.com header.i=@elasticemail.com header.a=rsa-sha256 header.s=api header.b=HM0APLWO;
	dkim-atps=neutral
Received: from n8.mxout.mta4.net (n8.mxout.mta4.net [67.227.87.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MxRNJ6yRzz3c6k
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Oct 2022 20:24:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; d=bounces.elasticemail.net; s=api;
	c=relaxed/simple; t=1666689836;
	h=from:date:subject:reply-to:to:list-unsubscribe:mime-version;
	bh=g7BL4eYXpEdUGBinJht4GKfYImNKg5RPNbW2n0eP3X0=;
	b=FB/QP9Vzvvu2QPMy5NJJj81dP6N2YD2r/5xXRC+YXjuuEesoSIPZ/DHv4MIgU84kn2BRUnejr4+
	0JeMq9/IK/eHnNKKr4Gelovt9S2oOJhQBLbo9yL+fKZouYKF5vakA38TU8U7bl1t34WhnYtrOgJ3b
	rUnYNi/3Gcj5hyGtGbA=
DKIM-Signature: v=1; a=rsa-sha256; d=elasticemail.com; s=api;
	c=relaxed/simple; t=1666689836;
	h=from:date:subject:reply-to:to:list-unsubscribe;
	bh=g7BL4eYXpEdUGBinJht4GKfYImNKg5RPNbW2n0eP3X0=;
	b=HM0APLWOVbYN3f5QQB8/Ai2+tT2GT/YxJPmfbiDNsV8XC9moA/dVKRs0/dYMqdQlocEWlaekbk5
	anjuoE3lgm4tHGfTx6GN9dFw+3fyxLB9Mai18gm1ev9uC/FQmZwKKG0c215UU4c1VDjY1wyWqvKRY
	tPH6qghjaOnxiuFJV+g=
From: Skills for Africa Training Institute <workshops@skillsforafrica.or.ke>
Date: Tue, 25 Oct 2022 09:23:56 +0000
Subject: Contract Management and Legal Drafting Course from 12th to 23rd
 December 2022 in Mombasa, Kenya
Message-Id: <4ui88agtfywm.o7AUHneCS5PpZphUPDTc8g2@133IK.trk.elasticemail.com>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
X-Msg-EID: o7AUHneCS5PpZphUPDTc8g2
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=-eZCfCzX0yw3CIuStP/k/UznJ5zRG4f19y3WKzQ=="
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
Reply-To: workshops@skillsforafrica.or.ke
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-eZCfCzX0yw3CIuStP/k/UznJ5zRG4f19y3WKzQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQoNCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNr
P2Q9NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTmF2ZGdDZ3Jy
cHg4MkN5WWlhelBseWw4dldFNnNvSmJiU3plWEJnbDJPZmVKT3J6S0FMT1REcGhUNk0ybEZ6
dVd2Zl9yd3VtUVYxTXFiQWtfTDJ4VVBpNlExSi05S2tWbHI5d2VDTzlfUXlJVTE+DQpDb250
cmFjdCANCk1hbmFnZW1lbnQgYW5kIExlZ2FsIERyYWZ0aW5nIENvdXJzZSBmcm9tIA0KMTJ0
aCB0byAyM3JkIERlY2VtYmVyIDIwMjIgaW4gTW9tYmFzYSwgDQpLZW55YQ0KDQo8aHR0cHM6
Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1w
VHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE82Tzd0bFNISjc2MkRkZVhHRkU1
UTFvRXc4ZW1oR2lKQzlzY21tZjJaWGJKbUFpUjlwc1ZFMFdFTndUYTZfMGxEbUxqdlIzUlNm
RXFPb0ttSURvSUY0SjgyeUJnclJKNnV3WV8zY1Z4WHRUZ1JPZ0hYLU9pZHF6emxWZzRoQ0VU
OV8wPg0KUmVnaXN0ZXIgZm9yIG9ubGluZSB0cmFpbmluZyANCg0KDQo8aHR0cHM6Ly8xMzNJ
Sy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9kPVdvYXBveS1wVHJGaGg3
OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE82Tzd0bFNISjc2MkRkZVhHRkU1UTFvRXc4
ZW1oR2lKQzlzY21tZjJaWGJMMkYtZ293OU9jRjF2ZDh2Q2RTSmE2TWpPc3FqSm1MYVN2QkR6
VlpwbnFGZXhEcTZmdUE4SE11dC1IYzc0LUJfU2VUSk5XbktTOHVOM0twQ0FGNVNlRGYwPg0K
wqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5jb20vdHJhY2tpbmcvY2xp
Y2s/ZD1Xb2Fwb3ktcFRyRmhoNzkyUkhlSjktUnQyMjVZWXNQbVdqTldzcXFyVHRPNk83dGxT
SEo3NjJEZGVYR0ZFNVExb0V3OGVtaEdpSkM5c2NtbWYyWlhiQ1Y3TVA5SjRJWEVwb3JySWV6
QUpEbjMxQXV5U0gwX0gyTjlNUmVvWWkwYlNXTHV3LWIxRUVoMXB1OEpmUTBvZUpTRWFqcW5N
WW5OUFhpQnViMkVRV0ZBMD4NClJlZ2lzdGVyIHRvIGF0dGVuZCB0aGUgDQp0cmFpbmluZw0K
DQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2luZy9jbGljaz9k
PVdvYXBveS1wVHJGaGg3OTJSSGVKOS1SdDIyNVlZc1BtV2pOV3NxcXJUdE82Tzd0bFNISjc2
MkRkZVhHRkU1UTFvRXc4ZW1oR2lKQzlzY21tZjJaWGJKY1JiQ2RKMy0wNlMteS1jMVlqdGNB
dlFhWDk3c19EOUs0VUlKOV9EMkJfWWE0eVE4NHphV3NDTUt0Slg1TTlWOXVueEFsR2ZPZkhv
V3hjOFhwU2o1NTQwPg0KwqANCg0KPGh0dHBzOi8vMTMzSUsudHJrLmVsYXN0aWNlbWFpbC5j
b20vdHJhY2tpbmcvY2xpY2s/ZD00UlNPR2VTNUhJNktGSml4UXB5a1VIN1NCRFNqMEEyRWRI
ZGNxcUVrLUtNTGRZR3RLMnJuVEdFT3BGT3pjZGp4VzU4VzhtY3ZsMTRyTUtCN2hUSWNrNGg1
LVBvTl9WNW00T0ZRY1JLZG5QSGtMT3dIY0FsY1ZscFJDNEZwNTlFWTdKNkRhRTFjOUdsMlVV
dTFhM1hSNXFFMT4NCkNhbGVuZGFyIGZvciAyMDIyLzIwMjMgDQpXb3Jrc2hvcHMNCsKgDQoN
CjxodHRwczovLzEzM0lLLnRyay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9
NFJTT0dlUzVISTZLRkppeFFweWtVSDdTQkRTajBBMkVkSGRjcXFFay1LTWNLQlc1R3hqYnVY
RmlWbzRFRFFEQUx1a29zT09KV0t0X0FYbUtFQUh1R3BjRGt4bUx1QXFEUHN3eC1uQVhhWmpv
OUVXUmtuR0tva2p5WGYySWtYaE44N0xxdzZIMWZ5LXhiM1dUSTFIbUhqQTE+DQpDb250YWN0
IHVzDQrCoA0KDQo8aHR0cHM6Ly8xMzNJSy50cmsuZWxhc3RpY2VtYWlsLmNvbS90cmFja2lu
Zy9jbGljaz9kPVRkTzFnQ3VRNzFocFdMNjBCV05udHV3ZjJJV0pma19rSlFfT2V4NV9lamp6
aW9aTm82X3FsdVpLWE9nS2t3YmxONDRmUVNnMHJBTWdVN2NobE5yVXJHQ1lkRzlYNHVnOTE0
N0ROeE10WlVnOVNwUEJRZjBFN0Vqazl5QTdDM25yenlCcXhnZlIzMlJQeTF5ZEUyY1dQNXMx
Pg0KV2hhdGFwcA0KwqANClZlbnVlOiANClByaWRlSW5uIFBhcmFkaXNlIEJlYWNoIA0KUmVz
b3J0LCANCk1vbWJhc2EsIEtlbnlhDQpDb3Vyc2UgDQpGZWU6IDMsMDAwVVNEDQpPZmZpY2Ug
DQpUZWxlcGhvbmU6ICsyNTQtNzAyLTI0OS00NDkNClJlZ2lzdGVyIA0KYXMgYSBncm91cCBv
ZiA1IG9yIG1vcmUgcGFydGljaXBhbnRzIGFuZCBnZXQgMjUlIGRpc2NvdW50IG9uIHRoZSBj
b3Vyc2UgZmVlLiANCg0KU2VuZCANCnVzIGFuIGVtYWlsOiANCjxodHRwczovLzEzM0lLLnRy
ay5lbGFzdGljZW1haWwuY29tL3RyYWNraW5nL2NsaWNrP2Q9cmFfS3JxdXltX3ZBSDdhMHhm
eWlSUlJKMG1tTW9nbnlnNTZrbVBlSkRjT0FUZzVoUmtONGptSE13RXpGMHpndE80OEtOTnVM
R1Vkd2xHMXFLalVuYlVNMkllVDBJY09XYmZKbGxUNDJKc1hmNlkxOVFoV0M4b0tDZzB3R1Zo
TU1OUXNMWlhHQWl6NTE4b0VLQW1lQmdSSXdPakdPRmpFR20wcVhxQ182OXRsczNVMm9SV2Jz
UlIySmZxSTVjMDB5RFBCVHdSRkJyVGhEaWVLaHQ4ZzRXMmdXZXRVRmJlUzVHa1dfWHphQl9z
NU4wPg0KdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZ8Kgb3IgDQpjYWxsICsyNTQtNzAy
LTI0OS00NDkNCklOVFJPRFVDVElPTg0KVGhpcyANCnRyYWluaW5nIGNvdXJzZSBjb3ZlcnMg
dGhlIHRocmVlIHN0YWdlcyBvZiBjb250cmFjdGluZzsgbmVnb3RpYXRpbmcgdGhlIOKAmGRl
YWzigJk7IA0KZHJhZnRpbmcgYW5kIGRvY3VtZW50aW5nIHRoYXQgZGVhbCBpbiBhIHJvYnVz
dCwgYnV0IHByYWN0aWNhbCB3YXksIGRyYWZ0aW5nIA0KZGlmZmVyZW50IGxlZ2FsIGxldHRl
cnMsIGFuZCBtYW5hZ2luZyB0aGUgcGVyZm9ybWFuY2Ugb2YgdGhlIGNvbnRyYWN0IGl0c2Vs
Zi4gDQpUaGlzIHRyYWluaW5nIGNvdXJzZSB3aWxsIGhlbHAgcGFydGljaXBhbnRzIHRvIGhh
dmUgYW4gYXdhcmVuZXNzIG9mIHByYWN0aWNlcyBpbiANCm90aGVyIGFyZWFzIGFuZCBvdGhl
ciBpbmR1c3RyaWVzLCB3aGljaCBjYW4gYWRkIHNpZ25pZmljYW50IHZhbHVlIHRvIHRoZWly
IG93biANCnNpdHVhdGlvbnMuIE1vcmVvdmVyLCB0aGUgdHJhaW5pbmcgY291cnNlIHdpbGwg
YWxzbyBnaXZlIGFuIG9wcG9ydHVuaXR5IHRvIA0KY29uc2lkZXIgbWF0dGVycyBmcm9tIHRo
ZSBwZXJzcGVjdGl2ZSBvZiB0aGUgb3RoZXIgcGFydHkgdG8gYSANCmNvbnRyYWN0Lg0KQ09V
UlNFIA0KT0JKRUNUSVZFUw0KwrfCoCANClVwb24gDQpjb21wbGV0aW9uIG9mIHRoaXMgdHJh
aW5pbmcgY291cnNlLCBwYXJ0aWNpcGFudHMgd2lsbCBiZSBhYmxlIA0KdG87DQrCt8KgIA0K
VW5kZXJzdGFuZCANCnRoZSBuZWVkIHRvIG5lZ290aWF0ZSB0aGUg4oCcZGVhbOKAnSBiZWZv
cmUgc3RydWN0dXJpbmcgdGhlIGNvbnRyYWN0IA0KZG9jdW1lbnRhdGlvbg0KwrfCoCANClV0
aWxpemUgDQp0aGUgdG9vbHMgJiB0ZWNobmlxdWVzIHRvIGFzc2lzdCBpbiBzdWNoIG5lZ290
aWF0aW9ucyAmIGVuaGFuY2UgdGhlIA0KZWZmaWNpZW50IG1hbmFnZW1lbnQgb2YgY29udHJh
Y3QNCsK3wqAgDQpBc3Nlc3MgDQp0aGUgZHJhZnRpbmcgYW5kIG1vZGlmaWNhdGlvbiBvZiBz
cGVjaWZpYyBjb250cmFjdCBjbGF1c2VzLCB1c2luZyByZWFsIGV4YW1wbGVzIA0KZnJvbSBp
bnN1cmFuY2UgJiBGYWN0b3JpZXMNCsK3wqAgDQpBcHBseSANCmdvb2QgbGVnYWwgd3JpdGlu
ZyBwcmFjdGljZQ0KwrfCoCANCkRlbW9uc3RyYXRlIA0KdGhlIHJlZ2lzdGVyIG9mIGxlZ2Fs
IHdyaXRpbmcNCsK3wqAgDQpFeGFtaW5lIA0Kd2F5cyB0byBhdm9pZCBkaXNwdXRlcywgb3Ig
dG8gbWFuYWdlIHRoZW0gc3VjY2Vzc2Z1bGx5DQrCt8KgIA0KUHJhY3RpY2FsIA0KdGlwcyBm
b3IgYnVzaW5lc3MgcHJvZmVzc2lvbmFscyB0byBkZWFsIHdpdGggdGhlIGNvbnNlcXVlbmNl
cyBvZiBub24tcGVyZm9ybWFuY2UgDQpsaWtlIG1hY2hpbmVzIG9yIGNvbmRpdGlvbnMNCsK3
wqAgDQpBbmFseXppbmcgDQp0aGUgbWVjaGFuaWNzIG9mIGNvbnRyYWN0aW5nIGluIHRoZSBF
bmdsaXNoIGxhbmd1YWdlDQpEVVJBVElPTg0KMTAgDQpEYXlzDQpXSE8gDQpTSE9VTEQgQVRU
RU5EDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClRoaXMgDQpzZW1pbmFyIGlzIGRlc2lnbmVk
IGZvciByZXByZXNlbnRhdGl2ZXMgZnJvbSBib3RoIElUIHN1cHBsaWVycyBhbmQgdXNlcnMv
YnV5ZXJzLCANCmluY2x1ZGluZzoNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KSW4gDQpob3Vz
ZSBsYXd5ZXJzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkNvbnRyYWN0IA0KbWFuYWdlcnMN
CsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KUHJvY3VyZW1lbnQgDQptYW5hZ2Vycw0KwrfCoMKg
wqDCoMKgwqDCoMKgwqAgDQpCdXllcnMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KTGVnYWwg
DQpkaXJlY3RvcnMgYW5kIG1hbmFnZXJzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClByaXZh
dGUgDQpwcmFjdGljZSBsYXd5ZXJzIGFuZCBjb25zdWx0YW50cw0KwqAgDQpDT1VSU0UgDQpD
T05URU5UDQpXaGF0IA0KaXMgdGhlIOKAnGRlYWzigJ0gYmVoaW5kIHRoZSBjb250cmFjdCwg
YW5kIGhvdyBkbyB5b3UgZ2V0IHRoZXJlPw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpXaGF0
IA0KY29uc3RpdHV0ZXMgYSBjb250cmFjdDogZm9ybSwgaW5ncmVkaWVudHMsIGFuZCBiYXNp
YyANCnN0cnVjdHVyZQ0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpUaGUgDQpjb250ZXh0IG9m
IGNvbW1lcmNpYWwgYXJyYW5nZW1lbnRzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCklubm92
YXRpdmUgDQpjb21tZXJjaWFsIHNvbHV0aW9ucyAoZS5nLiBQYXJ0bmVyaW5nLCDigJxCT09U
4oCdIGNvbnRyYWN0cywgDQpldGMpDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClJlbGF0aW9u
c2hpcCANCmJldHdlZW4gbmVnb3RpYXRpb24gYW5kIGNvbnRyYWN0IGRyYWZ0aW5nDQrCt8Kg
wqDCoMKgwqDCoMKgwqDCoCANCkNsb3NpbmcgDQphIGRlYWwgLSBBdXRob3JpdHkgdG8gc2ln
biBhbmQgYWdlbmN5IHByaW5jaXBsZXMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KRm9ybWFs
aXRpZXMgDQp0byBmaW5hbGlzZSB0aGUgY29udHJhY3QNCk5lZ290aWF0aW5nIA0KYW5kIERy
YWZ0aW5nIENvbnRyYWN0cw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpOZWdvdGlhdGluZyAN
ClByaW5jaXBsZXMgaW4gQ29udHJhY3RpbmcNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KTmVn
b3RpYXRpbmcgDQppbiBkaWZmaWN1bHQgYW5kIGNvbXBsZXggc2l0dWF0aW9ucw0KwrfCoMKg
wqDCoMKgwqDCoMKgwqAgDQpTdHJ1Y3R1cmluZyANCmNvbXBsZXggZG9jdW1lbnRzIOKAkyB0
aGUgaGllcmFyY2h5IG9mIHRlcm1zDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClVzaW5nIA0K
YW5kIG1vZGlmeWluZyBzdGFuZGFyZCBmb3Jtcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpQ
cmVjZWRlbnQgDQppbiBpbnRlcm5hdGlvbmFsIGNvbnRyYWN0aW5nDQrCt8KgwqDCoMKgwqDC
oMKgwqDCoCANCkRlYWxpbmcgDQp3aXRoIGNvbnRyYWN0IHF1YWxpZmljYXRpb25zIGFuZCBh
bWVuZG1lbnRzDQpMZWdhbCANCkRyYWZ0aW5nIGZvciBvcmdhbml6YXRpb25zICYgZmFjdG9y
aWVzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClNpZ25zIA0Kb2YgYSB3ZWxsLWRyYWZ0ZWQg
Y29udHJhY3Q6IFRoZSBzaW1wbGUgcnVsZXMhDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClRo
ZSANCmxhbmd1YWdlIG9mIGRyYWZ0aW5nOiBXaWxsIHYgU2hhbGwgdiBNdXN0DQrCt8KgwqDC
oMKgwqDCoMKgwqDCoCANCklkZW50aWZ5aW5nIA0KdGhlIGxlZ2FsIGZvcm1hbGl0aWVzIGZv
ciBhIGJpbmRpbmcgY29udHJhY3QNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KU3RydWN0dXJl
IA0KYW5kIGZvcm1hdGlvbiBvZiBhIGNvbW1lcmNpYWwgY29udHJhY3Q6IGZvbGxvdyB0aGUg
Zm9ybXVsYSBhbmQgeW91IHdvbuKAmXQgZ28gDQp3cm9uZw0KwrfCoMKgwqDCoMKgwqDCoMKg
wqAgDQpUaGUgDQppbXBvcnRhbmNlIG9mIEJvaWxlcnBsYXRlIGNsYXVzZXM6IG92ZXJsb29r
aW5nIHRoZW0gY2FuIGNvc3QgdGhlIGJ1c2luZXNzIA0KYmlsbGlvbnMgb2YgcG91bmRzLg0K
wrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpUaGUgDQpwcmVsaW1pbmFyeSBkb2N1bWVudHMtIHVz
aW5nIEhlYWRzIG9mIFRlcm1zIGVmZmVjdGl2ZWx5DQrCt8KgwqDCoMKgwqDCoMKgwqDCoCAN
ClZhZ3VlIA0Kd29yZHMgYW5kIGV4cHJlc3Npb25zIGluIGNvbW1lcmNpYWwgY29udHJhY3Rz
LSBrbm93IHRoZSANCnBpdGZhbGxzIQ0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpPdmVydmll
dyANCm9mIGNyb3NzIGJvcmRlciBjb250cmFjdHM6IERpc3RyaWJ1dGlvbiB2IEpvaW50IHZl
bnR1cmUgdiBBZ2VuY3kgDQphZ3JlZW1lbnRzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClNo
YXJlIA0KUHVyY2hhc2UgQWdyZWVtZW50czogYWxsb2NhdGluZ8Kgcmlza3MgYmV0d2VlbiB0
aGUgYnV5ZXIgYW5kIA0Kc2VsbGVywqANCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KVHJvdWJs
ZXNob290aW5nOiANCnRyYWNlIGFuZCBjb3JyZWN0IGVycm9ycyBpbiB5b3VyIGNvbnRyYWN0
DQpQbGFpbiANCkVuZ2xpc2ggaW4gTGVnYWwgQ29ycmVzcG9uZGVuY2UNCsK3wqDCoMKgwqDC
oMKgwqDCoMKgIA0KR29vZCANCmxlZ2FsIHdyaXRpbmcgcHJhY3RpY2UNCsK3wqDCoMKgwqDC
oMKgwqDCoMKgIA0KTW92aW5nIA0KZnJvbSBsZWdhbGVzZSB0byBQbGFpbiBFbmdsaXNoDQrC
t8KgwqDCoMKgwqDCoMKgwqDCoCANClVubmVjZXNzYXJ5IA0KYXJjaGFpYyBhbmQgbWVhbmlu
Z2xlc3MgcGhyYXNlcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpDb2xsb2NhdGlvbnMNCsK3
wqDCoMKgwqDCoMKgwqDCoMKgIA0KUGl0ZmFsbHMgDQphbmQgaXNzdWVzIHJlbGF0aW5nIHRv
IHRoZSB1c2Ugb2YgbGVnYWwgamFyZ29uIGluIGxlZ2FsIA0Kd3JpdGluZw0KwrfCoMKgwqDC
oMKgwqDCoMKgwqAgDQpXcml0aW5nIA0Kc2hvcnQgZW1haWxzDQrCt8KgwqDCoMKgwqDCoMKg
wqDCoCANCldyaXRpbmcgDQpsb25nIGVtYWlscw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpX
cml0aW5nIA0KZm9ybWFsIGVtYWlscw0KTGVnYWwgDQpXcml0aW5nIFRyb3VibGVzaG9vdGlu
ZyBmb3IgaW5zdXJhbmNlIGFuZCBvdGhlciBzZWN0b3JzDQrCt8KgwqDCoMKgwqDCoMKgwqDC
oCANClRoZSANCnByb2JsZW0gb2YgRW5nbGlzaCBpZGlvbXMNCsK3wqDCoMKgwqDCoMKgwqDC
oMKgIA0KUmVwaHJhc2luZyANCkVuZ2xpc2ggaWRpb21zIGVhc2lseSBjb25mdXNlZCB3b3Jk
cw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpDdXR0aW5nIA0KdW5uZWNlc3NhcnkNCsK3wqDC
oMKgwqDCoMKgwqDCoMKgIA0KeSANCndvcmRzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClVz
ZSANCm9mIGNvbnNpc3RlbnQgdGVybWlub2xvZ3kNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0K
QW1iaWd1aXR5OiANCmhvdyB0byBhdm9pZCBpdA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpW
YWd1ZW5lc3M6IA0KaG93IHRvIGF2b2lkIGl0DQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCk1p
c3VzZSANCm9mIHRoZSBwcmVwb3NpdGlvbiBpbiBkYXRlcw0KwrfCoMKgwqDCoMKgwqDCoMKg
wqAgDQpQcm9ibGVtIA0Kd29yZHMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KQ29uc3RhbnRs
eSANCmxpdGlnYXRlZCB3b3Jkcw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpQZXJzb25hbCAN
CnByb25vdW5zDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkNob29zaW5nIA0KdGhlIHJpZ2h0
IHdvcmRzDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClJld3JpdGluZyANCnNlbnRlbmNlcyB0
byByZW1vdmUgZ2VuZGVyLXNwZWNpZmljIGxhbmd1YWdlDQpEcmFmdGluZyANClNwZWNpZmlj
IENsYXVzZXMgaW4gUHJvZHVjdGlvbiAmIFNlcnZpY2VzDQrCt8KgwqDCoMKgwqDCoMKgwqDC
oCANCk9wZXJhdGl2ZSANCnByb3Zpc2lvbnMgYW5kIHBlcmZvcm1hbmNlIG9ibGlnYXRpb25z
DQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANClRpdGxlLCANClJpc2ssIGFuZCBQYXltZW50IHBy
b3Zpc2lvbg0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpDb250cmFjdCANCnZhcmlhdGlvbnM6
IHRyYW5zZmVyIG9mIHJpZ2h0cywgYW1lbmRtZW50LCBhbmQgdGhlIHNjb3BlIG9mIA0Kd29y
aw0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpUZXJtaW5hdGlvbiwgDQpzdXNwZW5zaW9uLCBh
bmQgcmVtZWRpZXMgZm9yIGRlZmF1bHQNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KTGltaXRh
dGlvbiANCmFuZCBleGNsdXNpb24gb2YgbGlhYmlsaXR5LCBmb3JjZSBtYWpldXJlLCBhbmQg
d2FpdmVyDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkxhdyANCm9mIHRoZSBjb250cmFjdCBh
bmQgZGlzcHV0ZSByZXNvbHV0aW9uDQpFZmZlY3RpdmUgDQpDb250cmFjdHMgTWFuYWdlbWVu
dA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpSaXNrIA0KYXNzZXNzbWVudCBhbmQgbWFuYWdl
bWVudA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpBc3NpZ25tZW50IA0Kb2YgcmVzcG9uc2li
aWxpdGllcyBhbmQga2ljay1vZmYgbWVldGluZ3M6IHNldHRpbmcgYW5kIG1hbmFnaW5nIA0K
ZXhwZWN0YXRpb25zDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkRlYWxpbmcgDQp3aXRoIGRl
ZmF1bHRzLCBkZWxheSwgYW5kIGRpc3J1cHRpb24NCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0K
TWFuYWdpbmcgDQpjbGFpbXMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KUGF5bWVudCANCmlz
c3VlcyDigJMgaW5jbHVkaW5nIGludGVybmF0aW9uYWwgdHJhZGUNCsK3wqDCoMKgwqDCoMKg
wqDCoMKgIA0KTGVzc29ucyANCmxlYXJuZWQNCkRlYWxpbmcgDQp3aXRoIERpc3B1dGVzDQrC
t8KgwqDCoMKgwqDCoMKgwqDCoCANClJlY29nbml6aW5nIA0KcG90ZW50aWFsIHByb2JsZW1z
IGFuZCBkZWFsaW5nIHdpdGggaXNzdWVzIGFzIHRoZXkgYXJpc2UNCsK3wqDCoMKgwqDCoMKg
wqDCoMKgIA0KTGVnYWwgDQpyaWdodHMgYW5kIGNvbW1lcmNpYWwgb3V0Y29tZXMgZGlzdGlu
Z3Vpc2hlZA0KwrfCoMKgwqDCoMKgwqDCoMKgwqAgDQpOZWdvdGlhdGlvbiANCnN0cnVjdHVy
ZXMgZm9yIGludGVybmFsIGRpc3B1dGUgcmVzb2x1dGlvbg0KwrfCoMKgwqDCoMKgwqDCoMKg
wqAgDQpFeHRlcm5hbCANCmRpc3B1dGUgcmVzb2x1dGlvbiDigJMgTGl0aWdhdGlvbiBhbmQg
QXJiaXRyYXRpb24NCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KTW9kZXJuIA0KYWx0ZXJuYXRp
dmVzIGluIGRpc3B1dGUgcmVzb2x1dGlvbiDigJMNCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0K
QWRqdWRpY2F0aW9uDQrCt8KgwqDCoMKgwqDCoMKgwqDCoCANCkV4cGVydCANCkRldGVybWlu
YXRpb24NCsK3wqDCoMKgwqDCoMKgwqDCoMKgIA0KTWVkaWF0aW9uDQrCt8KgwqDCoMKgwqDC
oMKgwqDCoCANCk92ZXJ2aWV3IA0Kb2YgdGhlIGNvdXJzZSwgYW5kIGZpbmFsIHF1ZXN0aW9u
IHNlc3Npb24NCsKgDQrCoA0KR0VORVJBTCANCk5PVEVTDQrDmMKgIA0KVGhpcyANCmNvdXJz
ZSBpcyBkZWxpdmVyZWQgYnkgb3VyIHNlYXNvbmVkIHRyYWluZXJzIHdobyBoYXZlIHZhc3Qg
ZXhwZXJpZW5jZSBhcyBleHBlcnQgDQpwcm9mZXNzaW9uYWxzIGluIHRoZSByZXNwZWN0aXZl
IGZpZWxkcyBvZiBwcmFjdGljZS4gVGhlIGNvdXJzZSBpcyB0YXVnaHQgdGhyb3VnaCANCmEg
bWl4IG9mIHByYWN0aWNhbCBhY3Rpdml0aWVzLCB0aGVvcnksIGdyb3VwIHdvcmtzIGFuZCBj
YXNlIA0Kc3R1ZGllcy4NCsOYwqAgDQpUcmFpbmluZyANCm1hbnVhbHMgYW5kIGFkZGl0aW9u
YWwgcmVmZXJlbmNlIG1hdGVyaWFscyBhcmUgcHJvdmlkZWQgdG8gdGhlIA0KcGFydGljaXBh
bnRzLg0Kw5jCoCANClVwb24gDQpzdWNjZXNzZnVsIGNvbXBsZXRpb24gb2YgdGhpcyBjb3Vy
c2UsIHBhcnRpY2lwYW50cyB3aWxsIGJlIGlzc3VlZCB3aXRoIGEgDQpjZXJ0aWZpY2F0ZS4N
CsOYwqAgDQpXZSANCmNhbiBhbHNvIGRvIHRoaXMgYXMgdGFpbG9yLW1hZGUgY291cnNlIHRv
IG1lZXQgb3JnYW5pemF0aW9uLXdpZGUgbmVlZHMuIENvbnRhY3QgDQp1cyB0byBmaW5kIG91
dCBtb3JlOsKgdHJhaW5pbmdAc2tpbGxzZm9yYWZyaWNhLm9yZw0Kw5jCoCANClRoZSANCnRy
YWluaW5nIHdpbGwgYmUgY29uZHVjdGVkIGF0wqBTa2lsbHMgZm9yIEFmcmljYcKgVHJhaW5p
bmcgDQpJbnN0aXR1dGUuDQrDmMKgIA0KVGhlIA0KdHJhaW5pbmcgZmVlIGNvdmVycyB0dWl0
aW9uIGZlZXMsIHRyYWluaW5nIG1hdGVyaWFscywgbHVuY2ggYW5kIHRyYWluaW5nIHZlbnVl
LiANCkFjY29tbW9kYXRpb24gYW5kIGFpcnBvcnQgdHJhbnNmZXIgYXJlIGFycmFuZ2VkIGZv
ciBvdXIgcGFydGljaXBhbnRzIHVwb24gDQpyZXF1ZXN0Lg0Kw5jCoCANClBheW1lbnQgDQpz
aG91bGQgYmUgc2VudCB0byBvdXIgYmFuayBhY2NvdW50IGJlZm9yZSBzdGFydCBvZiB0cmFp
bmluZyBhbmQgcHJvb2Ygb2YgcGF5bWVudCANCnNlbnQgdG86wqB0cmFpbmluZ0Bza2lsbHNm
b3JhZnJpY2Eub3JnDQrCoA0KwqDCoA0KwqANCjxodHRwczovLzEzM0lLLnRyay5lbGFzdGlj
ZW1haWwuY29tL3RyYWNraW5nL3Vuc3Vic2NyaWJlP2Q9eGxFZHpxcU02QXo2VzBQZTVyeGhM
TjUyY1ZCWHhXYXhuN0tVVlA4UTQteVhqUEtDM0dNSTFQRkFrX0wydFhMUmgwdlFoMVRsT0Jn
SVBpVEVyMndZX2h5LWYwc0ltaU1QR0ctMzJ2SjBIWUFxMD4NClVOU1VCU0NSSUJF

--=-eZCfCzX0yw3CIuStP/k/UznJ5zRG4f19y3WKzQ==
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Ty=
pe>
<META name=3DGENERATOR content=3D"MSHTML 6.00.6000.16546"></HEAD>
<BODY>
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: medium none; PADDING-RIGHT: 0cm; mso-eleme=
nt: para-border-div"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin"><?xml:namespace=20
prefix =3D "o" ns =3D "urn:schemas-microsoft-com:office:office" /><o:p=
><FONT=20
face=3DCalibri>
<DIV=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: #15b055 1.5pt solid; PADDING-BOTTOM: 4pt; PADDING-TOP: 0cm; PADD=
ING-LEFT: 0cm; BORDER-LEFT: medium none; PADDING-RIGHT: 0cm; mso-eleme=
nt: para-border-div">
<P class=3DMsoNormal=20
style=3D"BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BO=
TTOM: medium none; PADDING-BOTTOM: 0cm; TEXT-ALIGN: justify; PADDING-T=
OP: 0cm; PADDING-LEFT: 0cm; BORDER-LEFT: medium none; MARGIN: 0cm 0cm =
0pt; LINE-HEIGHT: normal; PADDING-RIGHT: 0cm; mso-outline-level: 2; ms=
o-border-bottom-alt: solid #15B055 1.5pt; mso-padding-alt: 0cm 0cm 4.0=
pt 0cm"><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KNavdgCgrrpx82CyYiazPlyl8vWE6soJbbSze=
XBgl2OfeJOrzKALOTDphT6M2lFzuWvf_rwumQV1MqbAk_L2xUPi6Q1J-9KkVlr9weCO9_Q=
yIU1"><FONT color=3D#410082><FONT=20
face=3D"Times New Roman"><SPAN=20
style=3D"mso-ascii-font-family: Calibri; mso-hansi-font-family: Calibr=
i; mso-bidi-font-family: Calibri">Contract=20
Management and Legal Drafting Course</SPAN><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"> from=20
12th to 23rd December 2022 in Mombasa,=20
Kenya<o:p></o:p></SPAN></FONT></FONT></A></SPAN></B></P></DIV>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1oEw8emhGiJC9sc=
mmf2ZXbJmAiR9psVE0WENwTa6_0lDmLjvR3RSfEqOoKmIDoIF4J82yBgrRJ6uwY_3cVxXt=
TgROgHX-OidqzzlVg4hCET9_0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082><FONT face=3D"Times New Roman">Register for online tra=
ining=20
<o:p></o:p></FONT></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-ascii=
-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-=
theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1oEw8emhGiJC9sc=
mmf2ZXbL2F-gow9OcF1vd8vCdSJa6MjOsqjJmLaSvBDzVZpnqFexDq6fuA8HMut-Hc74-B=
_SeTJNWnKS8uN3KpCAF5SeDf0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1oEw8emhGiJC9sc=
mmf2ZXbCV7MP9J4IXEporrIezAJDn31AuySH0_H2N9MReoYi0bSWLuw-b1EEh1pu8JfQ0o=
eJSEajqnMYnNPXiBub2EQWFA0" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082><FONT face=3D"Times New Roman">Register to attend the=20
training<o:p></o:p></FONT></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
class=3DMsoHyperlink><SPAN=20
style=3D'FONT-SIZE: 12pt; FONT-FAMILY: "Calibri",sans-serif; mso-ascii=
-theme-font: minor-latin; mso-hansi-theme-font: minor-latin; mso-bidi-=
theme-font: minor-latin'><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DWoapoy-p=
TrFhh792RHeJ9-Rt225YYsPmWjNWsqqrTtO6O7tlSHJ762DdeXGFE5Q1oEw8emhGiJC9sc=
mmf2ZXbJcRbCdJ3-06S-y-c1YjtcAvQaX97s_D9K4UIJ9_D2B_Ya4yQ84zaWsCMKtJX5M9=
V9unxAlGfOfHoWxc8XpSj5540" target=3D_blank><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></A></S=
PAN></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMLdYGtK2rnTGEOpFOzcdjxW58W8mcvl14rMK=
B7hTIck4h5-PoN_V5m4OFQcRKdnPHkLOwHcAlcVlpRC4Fp59EY7J6DaE1c9Gl2UUu1a3XR=
5qE1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin"><FONT=20
face=3D"Times New Roman">Calendar for 2022/2023=20
Workshops<o:p></o:p></FONT></SPAN></A></SPAN></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3D4RSOGeS5=
HI6KFJixQpykUH7SBDSj0A2EdHdcqqEk-KMcKBW5GxjbuXFiVo4EDQDALukosOOJWKt_AX=
mKEAHuGpcDkxmLuAqDPswx-nAXaZjo9EWRknGKokjyXf2IkXhN87Lqw6H1fy-xb3WTI1Hm=
HjA1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin"><FONT=20
face=3D"Times New Roman">Contact us<o:p></o:p></FONT></SPAN></A></SPAN=
></U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<U><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><A=20
href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3DTdO1gCuQ=
71hpWL60BWNntuwf2IWJfk_kJQ_Oex5_ejjzioZNo6_qluZKXOgKkwblN44fQSg0rAMgU7=
chlNrUrGCYdG9X4ug9147DNxMtZUg9SpPBQf0E7Ejk9yA7C3nrzyBqxgfR32RPy1ydE2cW=
P5s1" target=3D_blank><SPAN=20
style=3D"COLOR: windowtext; mso-bidi-font-family: Calibri; mso-bidi-th=
eme-font: minor-latin"><FONT=20
face=3D"Times New Roman">Whatapp<o:p></o:p></FONT></SPAN></A></SPAN></=
U></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Venue:=20
</SPAN></B><B style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-bidi-font-family: Calibri">PrideInn Para=
dise Beach=20
Resort</SPAN></B><B style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">,=20
Mombasa, Kenya<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 10pt; LINE-HEIGHT: normal"=
><B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Course=20
Fee: 3,000USD<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Office=20
Telephone: +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<B=20
style=3D"mso-bidi-font-weight: normal"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Register=20
as a group of 5 or more participants and get 25% discount on the cours=
e fee.=20
<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal">=
<SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Send=20
us an email: <A=20
 href=3D"https://133IK.trk.elasticemail.com/tracking/click?d=3Dra_Krqu=
ym_vAH7a0xfyiRRRJ0mmMognyg56kmPeJDcOATg5hRkN4jmHMwEzF0zgtO48KNNuLGUdwl=
G1qKjUnbUM2IeT0IcOWbfJllT42JsXf6Y19QhWC8oKCg0wGVhMMNQsLZXGAiz518oEKAme=
BgRIwOjGOFjEGm0qXqC_69tls3U2oRWbsRR2JfqI5c00yDPBTwRFBrThDieKht8g4W2gWe=
tUFbeS5GkW_XzaB_s5N0" ><SPAN=20
style=3D"mso-bidi-font-family: Calibri; mso-bidi-theme-font: minor-lat=
in"><FONT=20
color=3D#410082=20
face=3D"Times New Roman">training@skillsforafrica.org&nbsp;</FONT></SP=
AN></A>or=20
call +254-702-249-449<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 12pt 0cm 0pt; LINE-HEIGHT: norma=
l"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">INTRODUCTION</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; TEXT-ALIGN: justify; MARGIN: 7.5pt 0cm 0pt=
; LINE-HEIGHT: 15.75pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">This=20
training course covers the three stages of contracting; negotiating th=
e &lsquo;deal&rsquo;;=20
drafting and documenting that deal in a robust, but practical way, dra=
fting=20
different legal letters, and managing the performance of the contract =
itself.=20
This training course will help participants to have an awareness of pr=
actices in=20
other areas and other industries, which can add significant value to t=
heir own=20
situations. Moreover, the training course will also give an opportunit=
y to=20
consider matters from the perspective of the other party to a=20
contract.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">COURSE=20
OBJECTIVES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Upon=20
completion of this training course, participants will be able=20
to;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Understand=20
the need to negotiate the &ldquo;deal&rdquo; before structuring the co=
ntract=20
documentation<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Utilize=20
the tools &amp; techniques to assist in such negotiations &amp; enhanc=
e the=20
efficient management of contract<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Assess=20
the drafting and modification of specific contract clauses, using real=
 examples=20
from insurance &amp; Factories<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Apply=20
good legal writing practice<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Demonstrate=20
the register of legal writing<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Examine=20
ways to avoid disputes, or to manage them successfully<o:p></o:p></SPA=
N></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Practical=20
tips for business professionals to deal with the consequences of non-p=
erformance=20
like machines or conditions<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt; TEXT-INDENT: 14.2pt; tab-stops: list 1.0cm; mso-list: l1 lev=
el1 lfo2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Analyzing=20
the mechanics of contracting in the English language<o:p></o:p></SPAN>=
</P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">DURATION</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">10=20
Days<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">WHO=20
SHOULD ATTEND</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">This=20
seminar is designed for representatives from both IT suppliers and use=
rs/buyers,=20
including:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">In=20
house lawyers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Contract=20
managers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Procurement=20
managers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Buyers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Legal=20
directors and managers<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Private=20
practice lawyers and consultants<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore"><SPAN style=3D'FONT: 7pt "Times New Roman"'=
>&nbsp;=20
</SPAN></SPAN></SPAN><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">COURSE=20
CONTENT</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">What=20
is the &ldquo;deal&rdquo; behind the contract, and how do you get ther=
e?</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">What=20
constitutes a contract: form, ingredients, and basic=20
structure<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">The=20
context of commercial arrangements<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Innovative=20
commercial solutions (e.g. Partnering, &ldquo;BOOT&rdquo; contracts,=20
etc)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Relationship=20
between negotiation and contract drafting<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Closing=20
a deal - Authority to sign and agency principles<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Formalities=20
to finalise the contract<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Negotiating=20
and Drafting Contracts</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Negotiating=20
Principles in Contracting<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Negotiating=20
in difficult and complex situations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Structuring=20
complex documents &#8211; the hierarchy of terms<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Using=20
and modifying standard forms<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Precedent=20
in international contracting<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Dealing=20
with contract qualifications and amendments<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Legal=20
Drafting for organizations &amp; factories</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Signs=20
of a well-drafted contract: The simple rules!<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">The=20
language of drafting: Will v Shall v Must<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Identifying=20
the legal formalities for a binding contract<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Structure=20
and formation of a commercial contract: follow the formula and you won=
&rsquo;t go=20
wrong<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">The=20
importance of Boilerplate clauses: overlooking them can cost the busin=
ess=20
billions of pounds.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">The=20
preliminary documents- using Heads of Terms effectively<o:p></o:p></SP=
AN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Vague=20
words and expressions in commercial contracts- know the=20
pitfalls!<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Overview=20
of cross border contracts: Distribution v Joint venture v Agency=20
agreements<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Share=20
Purchase Agreements: allocating&nbsp;risks between the buyer and=20
seller&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Troubleshooting:=20
trace and correct errors in your contract<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Plain=20
English in Legal Correspondence</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Good=20
legal writing practice<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Moving=20
from legalese to Plain English<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Unnecessary=20
archaic and meaningless phrases<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Collocations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Pitfalls=20
and issues relating to the use of legal jargon in legal=20
writing<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Writing=20
short emails<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Writing=20
long emails<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Writing=20
formal emails<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Legal=20
Writing Troubleshooting for insurance and other sectors</SPAN></B><SPA=
N=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">The=20
problem of English idioms<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Rephrasing=20
English idioms easily confused words<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Cutting=20
unnecessary<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">y=20
words<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Use=20
of consistent terminology<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Ambiguity:=20
how to avoid it<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Vagueness:=20
how to avoid it<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Misuse=20
of the preposition in dates<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Problem=20
words<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Constantly=20
litigated words<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Personal=20
pronouns<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Choosing=20
the right words<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Rewriting=20
sentences to remove gender-specific language<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Drafting=20
Specific Clauses in Production &amp; Services</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Operative=20
provisions and performance obligations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Title,=20
Risk, and Payment provision<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Contract=20
variations: transfer of rights, amendment, and the scope of=20
work<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Termination,=20
suspension, and remedies for default<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Limitation=20
and exclusion of liability, force majeure, and waiver<o:p></o:p></SPAN=
></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Law=20
of the contract and dispute resolution<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Effective=20
Contracts Management</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Risk=20
assessment and management<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Assignment=20
of responsibilities and kick-off meetings: setting and managing=20
expectations<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Dealing=20
with defaults, delay, and disruption<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Managing=20
claims<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Payment=20
issues &#8211; including international trade<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Lessons=20
learned<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt 14.2pt; LINE-HEIGHT:=
 15.75pt"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Dealing=20
with Disputes</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Recognizing=20
potential problems and dealing with issues as they arise<o:p></o:p></S=
PAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Legal=20
rights and commercial outcomes distinguished<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Negotiation=20
structures for internal dispute resolution<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">External=20
dispute resolution &#8211; Litigation and Arbitration<o:p></o:p></SPAN=
></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Modern=20
alternatives in dispute resolution &#8211;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Adjudication<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Expert=20
Determination<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Mediation<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 7.5pt 0cm 0pt; LINE-HEIGHT: 15.75p=
t; TEXT-INDENT: 14.2pt; tab-stops: list 36.0pt; mso-list: l1 level1 lf=
o2"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Symbol; mso-bidi-font-family: S=
ymbol; mso-fareast-font-family: Symbol; mso-bidi-font-size: 12.0pt"><S=
PAN=20
style=3D"mso-list: Ignore">&middot;<SPAN=20
style=3D'FONT: 7pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">Overview=20
of the course, and final question session<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"BACKGROUND: white; MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: 17.15pt"=
><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0cm 0cm 0pt; LINE-HEIGHT: normal; TEXT-INDENT: -13.5p=
t"><B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin">GENERAL=20
NOTES</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 12pt; mso-ascii-font-family: Calibri; mso-ascii-th=
eme-font: minor-latin; mso-hansi-font-family: Calibri; mso-hansi-theme=
-font: minor-latin; mso-bidi-font-family: Calibri; mso-bidi-theme-font=
: minor-latin"><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 0cm 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>This=20
course is delivered by our seasoned trainers who have vast experience =
as expert=20
professionals in the respective fields of practice. The course is taug=
ht through=20
a mix of practical activities, theory, group works and case=20
studies.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Training=20
manuals and additional reference materials are provided to the=20
participants.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Upon=20
successful completion of this course, participants will be issued with=
 a=20
certificate.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>We=20
can also do this as tailor-made course to meet organization-wide needs=
. Contact=20
us to find out more:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; mso-bidi-theme-font: minor-latin; text-underline: none">tr=
aining@skillsforafrica.org</SPAN></A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>The=20
training will be conducted at&nbsp;Skills for Africa&nbsp;Training=20
Institute.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>The=20
training fee covers tuition fees, training materials, lunch and traini=
ng venue.=20
Accommodation and airport transfer are arranged for our participants u=
pon=20
request.<o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph=20
style=3D"MARGIN: 5pt 0cm 0pt 22.5pt; TEXT-INDENT: -18pt; mso-list: l0 =
level1 lfo1"><SPAN=20
style=3D"FONT-FAMILY: Wingdings; mso-bidi-font-family: Wingdings; mso-=
fareast-font-family: Wingdings"><SPAN=20
style=3D"mso-list: Ignore">&Oslash;<SPAN style=3D'FONT: 7pt "Times New=
 Roman"'>&nbsp;=20
</SPAN></SPAN></SPAN><SPAN=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'>Payment=20
should be sent to our bank account before start of training and proof =
of payment=20
sent to:&nbsp;<A><SPAN=20
style=3D"TEXT-DECORATION: none; COLOR: windowtext; mso-bidi-font-famil=
y: Calibri; mso-bidi-theme-font: minor-latin; text-underline: none">tr=
aining@skillsforafrica.org</SPAN></A><o:p></o:p></SPAN></P>
<P class=3DMsoListParagraph style=3D"MARGIN: 5pt 0cm 0pt 22.5pt"><SPAN=
=20
style=3D'FONT-FAMILY: "Calibri",sans-serif; mso-ascii-theme-font: mino=
r-latin; mso-hansi-theme-font: minor-latin; mso-bidi-theme-font: minor=
-latin'><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 10pt"><SPAN=20
style=3D"FONT-SIZE: 12pt; LINE-HEIGHT: 115%; mso-ascii-font-family: Ca=
libri; mso-ascii-theme-font: minor-latin; mso-hansi-font-family: Calib=
ri; mso-hansi-theme-font: minor-latin; mso-bidi-font-family: Calibri; =
mso-bidi-theme-font: minor-latin"><o:p>&nbsp;</o:p></SPAN></P>&nbsp;</=
FONT></o:p></SPAN></DIV>
<P>&nbsp;</P></BODY></HTML>

<img src=3D"https://133IK.trk.elasticemail.com/tracking/open?msgid=3Do=
7AUHneCS5PpZphUPDTc8g2&c=3D1493430534146315699" style=3D"width:1px;hei=
ght:1px" alt=3D"" /><div style=3D"text-align:center; background-color:=
#fff;padding-top:10px;padding-bottom:10px;font-size:8pt;font-family:sa=
ns-serif;"><a href=3D"https://133IK.trk.elasticemail.com/tracking/unsu=
bscribe?d=3DxlEdzqqM6Az6W0Pe5rxhLN52cVBXxWaxn7KUVP8Q4-yXjPKC3GMI1PFAk_=
L2tXLRh0vQh1TlOBgIPiTEr2wY_hy-f0sImiMPGG-32vJ0HYAq0" style=3D"text-ali=
gn:center;text-decoration:none;color:#666;">UNSUBSCRIBE</a></div>
--=-eZCfCzX0yw3CIuStP/k/UznJ5zRG4f19y3WKzQ==--
