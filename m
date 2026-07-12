Return-Path: <linux-erofs+bounces-3876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyEeKLt3U2rgbAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jul 2026 13:17:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94D7447B5
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jul 2026 13:17:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nomuaceniaeri.com header.s=mailing-support header.b=aF+SMF2b;
	dmarc=pass (policy=quarantine) header.from=mailing-support.nomuaceniaeri.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3876-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3876-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyjTq4sWXz2xWP;
	Sun, 12 Jul 2026 21:07:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783854479;
	cv=none; b=bUmNUOfpH3m4Ek6mwoMAd/YKjjDBv4t3pEmgr7oE3bgFlvZ9ZSfmsUjRj1sQjQfTBTv0dduGoVTHXn/HAhx40NrMlwgRuPyUUn50kS7UxCSt+lXjyUZYqum6R2SpNxJiOFDfokNrsihdjzh7G6rn0DtFeG4aIFWAWsc8LNDF50ci2OiKxP/JPP3LrNJrDIMaVf6ho+sKU72QR0ZFy9aEpqR/Riqea12vPKTX28UB7cnhOShYlLkYzqTUd2pnEjouC1TSNzXUNUajZSLOjC9CMLH+NOc+H6IjXGPoMOsqSLrG562WBkWIAhEPQ8oOXccqEa3FcCCTz+QVRimBDm+CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783854479; c=relaxed/relaxed;
	bh=+4hNcEfuq4LucC4VtbI0Fs1j+2Wo3jg2vc1JwM5RSQg=;
	h=MIME-Version:Content-Type:Subject:From:To:Date:Message-ID; b=drUGvsUJKsScPCTd8bGeySqJxYdmKZ95tjWEikR93fec34jbBU9r7TwTKzoJVDbpH8atAz9vOQDMAVkSFmoBl/jMD1wqPTiRnj+88Lt5B6vFOPktrv4QlW5djqec6Am6frs7BILdw2M/y6Rp3w/jVSA+XfrPccmJNQDy5zt/hIQdqsaNP9ey7igakC4bzx/tqda4Hs0rQNCAlG3hCSmPOe6kx02HZaYn3UeGv+ts2GG/W1o2+LMOGcoZmLthjJEaJdp/rV1E/I0SBXa+tSDc3caERanw5Wyla4jsltQHzIDPitYEqo/BGwO+QqDrcWQPwmu6MYyCcfux7146n+wsVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=mailing-support.nomuaceniaeri.com; dkim=pass (2048-bit key; unprotected) header.d=nomuaceniaeri.com header.i=@nomuaceniaeri.com header.a=rsa-sha256 header.s=mailing-support header.b=aF+SMF2b; dkim-atps=neutral; spf=pass (client-ip=20.89.99.136; helo=mail.mailing-support.nomuaceniaeri.com; envelope-from=custom-newsletter@mailing-support.nomuaceniaeri.com; receiver=lists.ozlabs.org) smtp.mailfrom=mailing-support.nomuaceniaeri.com
X-Greylist: delayed 1291 seconds by postgrey-1.37 at boromir; Sun, 12 Jul 2026 21:07:59 AEST
Received: from mail.mailing-support.nomuaceniaeri.com (unknown [20.89.99.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyjTq1Wb2z2xQ3
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jul 2026 21:07:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; d=nomuaceniaeri.com; s=mailing-support;
	c=relaxed/relaxed; bh=+4hNcEfuq4LucC4VtbI0Fs1j+2Wo3jg2vc1JwM5RSQg=;
	h=from:to:subject:date:message-id; t=1783853126;
	b=aF+SMF2bZ+MZBbK8v736sV36U/42UyUYAJsUb2Pvkh8Nmp71lV2q/ElsEh/5rfOjVjTyARNnG
	fpJWr/8cQmJ6lHEYHzIUdTtmgRXCseneBhfZQRBt84FOx7Bp/6o5lWiVHog6To1oapSog/VNmI+
	0fHkofnPvggOd+eAGoRryeRH3UroUZl0/jH580tFEH1HhDcV7o97BZw19vn+/qJd7Wh6YPxZtpj
	Ezl6GOlp7mju1DJ7ZXFFAH+p8ryn1BP6RfpV2ZyJYS4OpV3QVDIsi59PVFogrjGCq2vkbh68jyS
	paMmfIOZT7+ElEZVjO3s/jLvLG9mkcibvilhNcsyi2qw==;
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: =?utf-8?b?5pys5Lq656K66KqN44KS5a6M5LqG44GX44Gm44GP44Gg44GV44GE77yI44Ki44Kr44Km44Oz44OI5L+d6K2377yJ?=
From: =?utf-8?b?VGlrVG9r44K744Kt44Ol44Oq44OG44Kj44K744Oz44K/44O8?= <custom-newsletter@mailing-support.nomuaceniaeri.com>
To: linux-erofs@lists.ozlabs.org
Date: Sun, 12 Jul 2026 19:45:28 +0900
Message-ID: <178385312838.38040.9608389370287536369@WIN-JO36SKU1JVT>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Received: from smtp-6.mailing-support.nomuaceniaeri.com (unknown [10.254.110.58]) by mailing-support.nomuaceniaeri.com (Postfix) with ESMTP; Sun, 12 Jul 2026 19:45:28 +0900 (JST)
Received: from localhost (localhost [127.0.0.1]) by smtp-6. mailing-support.nomuaceniaeri.com (Postfix)  with ESMTP id 7AocS9EoXMZPFC for linux-erofs@lists.ozlabs.org; Sun, 12 Jul 2026 19:45:28 +0900 (JST)
List-Unsubscribe: <https://www.mailing-support.nomuaceniaeri.com/unsubscribe/?token=ebd31b430f706b6381571e275b8d13218aeafc02ef869d013ed94da238da5718&type=mailmagazine&campaign=edm580164688177>
X-Rspamd-Action: add header
X-Spamd-Result: default: False [12.90 / 15.00];
	URIBL_BLACK(7.50)[qr-paybayshiz9.com:url,nomuaceniaeri.com:dkim];
	DBL_PHISH(5.00)[qr-paybayshiz9.com:url];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3876-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[nomuaceniaeri.com:s=mailing-support];
	RCPT_COUNT_ONE(0.00)[1];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nomuaceniaeri.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[custom-newsletter@mailing-support.nomuaceniaeri.com,linux-erofs@lists.ozlabs.org];
	DMARC_POLICY_ALLOW(0.00)[mailing-support.nomuaceniaeri.com,quarantine];
	TAGGED_RCPT(0.00)[linux-erofs];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2404:9400:21b9:f100::1:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tiktok.com:url,WIN-JO36SKU1JVT:mid,nomuaceniaeri.com:dkim,mailing-support.nomuaceniaeri.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B94D7447B5
X-Spam: Yes

VGlrVG9r44KS44GU5Yip55So44GE44Gf44Gg44GN44GC44KK44GM44Go44GG44GU44GW44GE44G+
44GZ44CCCgrjgYrlrqLmp5jjga7jgqLjgqvjgqbjg7Pjg4jjgavjgYrjgYTjgabjgIHpgJrluLjj
gajjga/nlbDjgarjgovjgqLjgq/jgrvjgrnnkrDlooPjgYzmpJznn6XjgZXjgozjgb7jgZfjgZ/j
gIIK44Gd44Gu44Gf44KB44CB44K744Kt44Ol44Oq44OG44Kj5L+d6K2344Gu6Kaz54K544GL44KJ
5LiA6YOo5qmf6IO944Gu5Yip55So44KS5LiA5pmC55qE44Gr5Yi26ZmQ44GX44Gm44GK44KK44G+
44GZ44CCCgrjgqLjgqvjgqbjg7Pjg4jjga7lronlhajmgKfjgpLnorroqo3jgZnjgovjgZ/jgoHj
gIHmnKzkurrnorroqo3jgpLlrozkuobjgZfjgabjgY/jgaDjgZXjgYTjgIIK5pys44Oh44O844Or
44KS5Y+X5L+h44GV44KM44Gf44GK5a6i5qeY44Gv44CB5Lul5YmN44Gr5ZCM5qeY44Gu44Oh44O8
44Or44KS5Y+X5L+h44GV44KM44Gm44GE44KL5aC05ZCI44Gn44KC44CB5b+F44Ga6Zu76Kmx55Wq
5Y+36KqN6Ki844KS5a6M5LqG44GX44Gm44GE44Gf44Gg44GN44G+44GZ44KI44GG44GK6aGY44GE
44GE44Gf44GX44G+44GZ44CCCgrilqAg56K66KqN5pa55rOVCuOBlOeZu+mMsuOBruaQuuW4r+mb
u+ipseeVquWPt+OBq+OCiOOCi1NNU+iqjeiovOOCkuihjOOBo+OBpuOBj+OBoOOBleOBhOOAggoK
4pagIOmHjeimgQrmnKzkurrnorroqo3jgYzlrozkuobjgZfjgarjgYTloLTlkIjjgIHkuIDpg6jm
qZ/og73jgYzlvJXjgY3ntprjgY3liLbpmZDjgZXjgozjgovlj6/og73mgKfjgYzjgYLjgorjgb7j
gZnjgIIKCuKWvCDmnKzkurrnorroqo3jgpLplovlp4vjgZnjgosKaHR0cHM6Ly90aWtpb2t0LnFy
LXBheWJheXNoaXo5LmNvbS9zdXBwb3J0L2hlbHAvYXJ0aWNsZS9hY2NvdW50L3Byb2ZpbGUvcmVk
aXJlY3QvMTAwMjg0NzE4NDc1CgrigLvnorroqo3mnJ/pmZAgMjAyNuW5tDfmnIgxMuaXpSAyMzo1
OQrigLvmnKzmiYvntprjgY3jga/jgqLjgqvjgqbjg7Pjg4jkv53orbfjga7jgZ/jgoHjgavlrp/m
lr3jgZXjgozjgabjgYTjgb7jgZnjgIIKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tClRpa1RvayDjgrXjg53jg7zjg4jjg4Hjg7zjg6AKVGlrVG9rIOODmOODq+ODl+OC
u+ODs+OCv+ODvO+8miBodHRwczovL3N1cHBvcnQudGlrdG9rLmNvbS8KCuOBlOS4jeaYjuOBqueC
ueOBr+OBlOOBluOBhOOBvuOBmeOBi++8nwrjg5jjg6vjg5fjgrvjg7Pjgr/jg7zjgpLjgZTopqfj
gYTjgZ/jgaDjgY/jgYvjgIHjgqLjg5fjg6rlhoXjga4gW+ioreWuml0gLSBb5ZWP6aGM44KS5aCx
5ZGKXSDjgYvjgonjgYrllY/jgYTlkIjjgo/jgZvjgY/jgaDjgZXjgYTjgIIKCuOBk+OCjOOBr+iH
quWLlei/lOS/oeODoeODvOODq+OBp+OBmeOAguOBlOi/lOS/oeOBhOOBn+OBoOOBhOOBpuOCguOB
iuetlOOBiOOBp+OBjeOBvuOBm+OCk+OBruOBp+OBlOS6huaJv+OBj+OBoOOBleOBhOOAggotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQrjg5fjg6njgqTjg5Djgrfjg7zj
g53jg6rjgrfjg7wKVGlrVG9rLCAxMDEwMCBWZW5pY2UgQmx2ZCwgQ3VsdmVyIENpdHksIENBIDkw
MjMyCgo=

