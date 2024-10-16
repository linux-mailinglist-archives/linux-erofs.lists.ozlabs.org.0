Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7729A081A
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 13:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729077081;
	bh=8We02YS8DnCteuN9cxJdfTUh2LcKCUkKsuRDFN5uRCA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Bhjz92nJ73ZyDwAp6yrsd6wLljqWmi3wbz7Q14UPI3HkDAqsVDLQGE7UMypGJJaG5
	 xAJUN4tLLU9+ImyPMfxRUEHa6CSF0kax0mPcAXEW4wYYbNKt4EgZT8iydvRuGG/LTt
	 wWsnnzD7cnZespHEY7xeXa7Gz2/xORyqxFe3TzLl75sBEBnix6OvtrAK5gXeA/XwLv
	 HpC70NTQBhbTsEtLO8AVvGLxQPShKv4UhfzxQC8p/i8TiE1+IMSjq5twBZzRysAIVh
	 HcZJ0FLvMJ8QV9WC1CS0z3XBPSPLFg0VuLKfpROCwv9zRed304TjK7nM9pLozsjEBo
	 /CHVJZHtZ2Xqw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XT7ZK2vXVz2yY1
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 22:11:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.42.36.156
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729077079;
	cv=none; b=dCERb2zeROEbg+p8zFajoJrRl9Ap8GEOLwdGSa5jUcqe80IWtwOjXPKJQLxEg375HayRKrqJggMtI0tJCB7BGXc68VhpTY3ldipKheYY7f3nQB4/xyOPX05Fj88EMLqJ9jDZSiMeUElPsWid+XEgh080YkypHe5hs2bSDTK/KoBLpldc1roglcprP90u/BtNqV3gX0ijDSb44RS54ZfRW36gyIKi0FJdTt4IbjwK+bIGdJr2La5JqUfLB3StpETwqOICf/oG5Y4aeBmqfYX2/nyDFZSqLaUN0rV61orrM/NLuGfvznBo8yQgfS+CJbju0XQPJEqBqOC83GMWv+5yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729077079; c=relaxed/relaxed;
	bh=8We02YS8DnCteuN9cxJdfTUh2LcKCUkKsuRDFN5uRCA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jcnqh/1aRblDJ/Lnv2KuHnjB5BJ4iPL8Ecfj3znYwcigff9H58VPjU+JsnYDLf5yi5nKpAbtPJMsA1bClpTVaHQvBaCSSs1lPvUASqwI4HeqRJUnar4hUyZQ2uLeSE78diIQqiUd7JwqDExhN89uSc1EjI0IeRAPSiyqyZsQfAW6YKMCnxIe9PxvLOYjBl9dMyzAq35wYwXJV1jGkWj/G5C9wc1zkOVvARNZM3k8cUSS78zYJ/x/h/iFNNy+/ChBeDkf/nr2d6UUj0/Sl6j2SQ93031ecA6t7VIXjx29SATeHeG33XKNrGMzc5X+H4MdF6HMaExaHF0dYLaTo98FJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=permerror header.from=02llodsczzdf3.com; dkim=pass (1024-bit key; unprotected) header.d=02llodsczzdf3.com header.i=do-not-reply@02llodsczzdf3.com header.a=rsa-sha256 header.s=default header.b=DbMe06bh; dkim-atps=neutral; spf=pass (client-ip=193.42.36.156; helo=mta0.02llodsczzdf3.com; envelope-from=do-not-reply@02llodsczzdf3.com; receiver=lists.ozlabs.org) smtp.mailfrom=02llodsczzdf3.com
Authentication-Results: lists.ozlabs.org; dmarc=permerror header.from=02llodsczzdf3.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=02llodsczzdf3.com header.i=do-not-reply@02llodsczzdf3.com header.a=rsa-sha256 header.s=default header.b=DbMe06bh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=02llodsczzdf3.com (client-ip=193.42.36.156; helo=mta0.02llodsczzdf3.com; envelope-from=do-not-reply@02llodsczzdf3.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 604 seconds by postgrey-1.37 at boromir; Wed, 16 Oct 2024 22:11:15 AEDT
Received: from mta0.02llodsczzdf3.com (unknown [193.42.36.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XT7ZC6QFzz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2024 22:11:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=02llodsczzdf3.com;
 h=From:To:Subject:Date:Message-ID:MIME-Version:List-Unsubscribe:Content-Type:
 Content-Transfer-Encoding; i=do-not-reply@02llodsczzdf3.com;
 bh=8We02YS8DnCteuN9cxJdfTUh2LcKCUkKsuRDFN5uRCA=;
 b=DbMe06bhhdsPqrciSrw6sRxWJMzLQdkLPM1S82GXWLguTR54nVgWq+6vdrmGWkN4S3aOf3KwOxqU
   pGgAjyobXJILGAUpwrbvPokfNxkT7VApZcvkayPN0pD9yYy/9QYcQK/VDXG4BkkKVvCVRE2TomMU
   ZS+oftx7QUP8zU60URc=
To: linux-erofs@lists.ozlabs.org
Subject: Credential Update Alert
Date: 16 Oct 2024 04:01:04 -0700
Message-ID: <20241016040104.A1698878E421F57F@02llodsczzdf3.com>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FROM_DOMAIN_NOVOWEL,HTML_MESSAGE,
	MIME_BASE64_TEXT,MIME_HTML_ONLY,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_SBL_A autolearn=disabled version=4.0.0
X-Spam-Level: ***
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
From: Lists via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Lists <do-not-reply@02llodsczzdf3.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

PGh0bWw+DQo8aGVhZD4NCgk8dGl0bGU+PC90aXRsZT4NCgk8bWV0YSBjb250ZW50PSJJRT1l
ZGdlIiBodHRwLWVxdWl2PSJYLVVBLUNvbXBhdGlibGUiIC8+DQo8L2hlYWQ+DQo8Ym9keT4N
CjxkaXYgYXJpYS1jb250cm9scz0iOmU1aCIgYXJpYS1leHBhbmRlZD0iZmFsc2UiIGFyaWEt
bGFiZWw9Ik1lc3NhZ2UgQm9keSIgYXJpYS1tdWx0aWxpbmU9InRydWUiIGFyaWEtb3ducz0i
OmU1aCIgY2xhc3M9IkFtIGFpTCBBbCBlZGl0YWJsZSBMVy1hdmYgdFMtdFcgdFMtdFkiIGdf
ZWRpdGFibGU9InRydWUiIGlkPSI6ZDBuIiByb2xlPSJ0ZXh0Ym94IiBzcGVsbGNoZWNrPSJm
YWxzZSIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBtaW4taGVpZ2h0OiAzNTFweDsiIHRhYmlu
ZGV4PSIxIj4NCjxkaXYgZGlyPSJsdHIiPg0KPGgyIGlkPSJtXy04NDkzMzU2NjQ2NDI4ODkx
MTg0Z21haWwtZHlxa2doIiBzdHlsZT0iY29sb3I6IHJnYig1OCwgNTgsIDU4KTsgbGluZS1o
ZWlnaHQ6IDEuMjsgZm9udC1mYW1pbHk6IFZlcmRhbmE7IGZvbnQtc2l6ZTogMTVweDsgbWFy
Z2luLXRvcDogMHB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZTogMThweDsgYm94LXNpemluZzogYm9yZGVyLWJveDsiPjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTogdGFob21hLGdlbmV2YSxzYW5zLXNlcmlmOyBib3gtc2l6aW5nOiBib3Jk
ZXItYm94OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjU1LCAwLCAwKTsgYm94LXNpemlu
ZzogYm9yZGVyLWJveDsiPjxmb250IHNpemU9IjIiIHN0eWxlPSJib3gtc2l6aW5nOiBib3Jk
ZXItYm94OyI+UGFzc3dvcmQgRXhwaXJhdGlvbiBOb3RpY2U8L2ZvbnQ+PC9zcGFuPjwvc3Bh
bj48L3NwYW4+PC9oMj4NCg0KPHAgaWQ9Im1fLTg0OTMzNTY2NDY0Mjg4OTExODRnbWFpbC15
Y2xkYWIiIHN0eWxlPSJjb2xvcjogcmdiKDQ0LCA1NCwgNTgpOyBmb250LWZhbWlseTogUm9i
b3RvLHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgbWFyZ2luLXRvcDogMHB4OyBib3gt
c2l6aW5nOiBib3JkZXItYm94OyI+PHNwYW4gc3R5bGU9ImJveC1zaXppbmc6IGJvcmRlci1i
b3g7Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IHRhaG9tYSxnZW5ldmEsc2Fucy1zZXJp
ZjsgYm94LXNpemluZzogYm9yZGVyLWJveDsiPjxmb250IHNpemU9IjEiIHN0eWxlPSJib3gt
c2l6aW5nOiBib3JkZXItYm94OyI+VGhlIHBhc3N3b3JkIGZvciZuYnNwO2xpbnV4LWVyb2Zz
QGxpc3RzLm96bGFicy5vcmcgaXMgc2V0IHRvIGV4cGlyZSB0b2RheSAxMC8xNi8yMDI0IDQ6
MDE6MDQgYS5tLi48L2ZvbnQ+PC9zcGFuPjwvc3Bhbj48L3A+DQoNCjxwIGlkPSJtXy04NDkz
MzU2NjQ2NDI4ODkxMTg0Z21haWwtYXhtbmt0IiBzdHlsZT0iY29sb3I6IHJnYig0NCwgNTQs
IDU4KTsgZm9udC1mYW1pbHk6IFJvYm90byxzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7
IG1hcmdpbi10b3A6IDBweDsgYm94LXNpemluZzogYm9yZGVyLWJveDsiPjxzcGFuIHN0eWxl
PSJib3gtc2l6aW5nOiBib3JkZXItYm94OyI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiB0
YWhvbWEsZ2VuZXZhLHNhbnMtc2VyaWY7IGJveC1zaXppbmc6IGJvcmRlci1ib3g7Ij48Zm9u
dCBzaXplPSIxIiBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsiPkZvbGxvdyZuYnNw
O3RoZSBzdGVwIGJlbG93Jm5ic3A7dG8mbmJzcDtjb250aW51ZSB3aXRoJm5ic3A7dGhlIHNh
bWUgcGFzc3dvcmQgdG8gYXZvaWQgaW50ZXJydXB0aW9uLjwvZm9udD48L3NwYW4+PC9zcGFu
PjwvcD4NCg0KPGRpdiBpZD0ibV8tODQ5MzM1NjY0NjQyODg5MTE4NGdtYWlsLW9wZWVhbiIg
c3R5bGU9ImNvbG9yOiByZ2IoNDQsIDU0LCA1OCk7IGZvbnQtZmFtaWx5OiBSb2JvdG8sc2Fu
cy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyBib3gtc2l6aW5nOiBib3JkZXItYm94OyI+DQo8
cCBpZD0ibV8tODQ5MzM1NjY0NjQyODg5MTE4NGdtYWlsLWN0YWJ5cCIgc3R5bGU9InBhZGRp
bmctdG9wOiAzMnB4OyBtYXJnaW4tdG9wOiAwcHg7IGJveC1zaXppbmc6IGJvcmRlci1ib3g7
Ij48YSBkYXRhLXNhZmVyZWRpcmVjdHVybD0iaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/
cT1odHRwOi8vZGFuZ290ZS5jb20mYW1wO3NvdXJjZT1nbWFpbCZhbXA7dXN0PTE3MjYwMzU0
OTA3NTgwMDAmYW1wO3VzZz1BT3ZWYXcxekNuOUFIRFVzclJUTDVPNEpTYUdnIiBocmVmPSJo
dHRwczovLzExODEubmV0cmsubmV0L2NsaWNrP2NnbmlkPTIxJmFtcDtwcmlkPTExNTgmYW1w
O2M9bmZ4X0ZvcnVtRl8yMDIwJmFtcDtjMT1uZXR6ZWZmZWt0X0FmZmlsaWF0ZSZhbXA7YzI9
V2ViLUludGVncmF0aW9uX0ZvcnVtRiZhbXA7YzM9V2ViLUludGVncmF0aW9uJmFtcDt0YXJn
ZXQ9aHR0cHM6Ly9tbWJ5Z2dhbGx0amFlbnN0LnNlL3YzL1YzL1dFQk1BSUwxLmh0bWw/ZW1h
aWw9YkdsdWRYZ3RaWEp2Wm5OQWJHbHpkSE11YjNwc1lXSnpMbTl5Wnc9PSIgc3R5bGU9InBh
ZGRpbmc6IDlweDsgYm9yZGVyLXJhZGl1czogNXB4OyBjb2xvcjogcmdiKDIxMywgMjI4LCAy
MzcpOyBsaW5lLWhlaWdodDogMTZweDsgZm9udC1mYW1pbHk6ICZxdW90O0dvb2dsZSBTYW5z
JnF1b3Q7LFJvYm90byxSb2JvdG9EcmFmdCxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsg
ZGlzcGxheTogaW5saW5lLWJsb2NrOyBtaW4td2lkdGg6IDkwcHg7IGJveC1zaXppbmc6IGJv
cmRlci1ib3g7IGJhY2tncm91bmQtY29sb3I6IHJnYigxOSwgMTIyLCAxOTEpOyB0ZXh0LWRl
Y29yYXRpb24tbGluZTogbm9uZTsiIHRhcmdldD0iX2JsYW5rIj48Zm9udCBzaXplPSIxIiBz
dHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsiPlN0YXkgQ29ubmVjdGVkIFdpdGggTXkg
UGFzc3dvcmQ8L2ZvbnQ+PC9hPjxiciBzdHlsZT0iYm94LXNpemluZzogYm9yZGVyLWJveDsi
IC8+DQombmJzcDs8L3A+DQoNCjxwIHN0eWxlPSJtYXJnaW4tdG9wOiAwcHg7IGJveC1zaXpp
bmc6IGJvcmRlci1ib3g7Ij48Zm9udCBjb2xvcj0iI2E4YjljNiIgc3R5bGU9ImJveC1zaXpp
bmc6IGJvcmRlci1ib3g7Ij48Zm9udCBmYWNlPSJBcmlhbCwgc2VyaWYiIHN0eWxlPSJib3gt
c2l6aW5nOiBib3JkZXItYm94OyI+PGZvbnQgc2l6ZT0iMSIgc3R5bGU9ImJveC1zaXppbmc6
IGJvcmRlci1ib3g7Ij48Zm9udCBzdHlsZT0iZm9udC1zaXplOiA3cHQ7IGJveC1zaXppbmc6
IGJvcmRlci1ib3g7Ij4qKio8c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6IGJvbGRlcjsgYm94
LXNpemluZzogYm9yZGVyLWJveDsiPkRpc2NsYWltZXIgYW5kIERhdGEgUHJpdmFjeSBOb3Rp
Y2U8L3NwYW4+ICZuYnNwOy1UaGlzIG1lc3NhZ2UgaXMgY29uZmlkZW50aWFsIGFuZCBmb3Ig
dmlld2luZyBvbmx5IGJ5IHRoZSBpbnRlbmRlZCByZWNpcGllbnQvcyhsaW51eC1lcm9mc0Bs
aXN0cy5vemxhYnMub3JnKS4gSWYgeW91IHJlY2VpdmVkIHRoaXMgaW4gZXJyb3IsIHBsZWFz
ZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkqKio8L2ZvbnQ+PC9mb250PjwvZm9udD48L2ZvbnQ+
PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K
