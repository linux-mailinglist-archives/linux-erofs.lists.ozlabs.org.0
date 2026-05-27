Return-Path: <linux-erofs+bounces-3486-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNMiKFbCFmrOqgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3486-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2026 12:07:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303A5E260F
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2026 12:07:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQQJr39Pkz2xLs;
	Wed, 27 May 2026 20:07:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779876428;
	cv=none; b=mHSV64Pt16T8PbkaoRZCYuTPTcCmxQYMNCZFzWd5BfoLCKyibCIkHbMz5kad49SdKUrch25f0RQzc7rhxgG4dT1EYqmW/NColfUxO/DSjkWQmCwxQNk9nAEW3td++cpJ5v1Sk69osaeDy1bVs9XgIH6OMWiOb1vt8B9MeJ6NfVpx/SVTiNXZFom4hiMWE3fw/7I9Fi3HC6anLm7VQ+gZIr+k+d73yTneyLksmUxNEVKAB3Jq+caJtnSMQP+xcQfVumMm/TeNfH6o/Ck2wIMVoB0zbfCBEdGT3qy2eDQt1FXxIhSKcTVAm7UFPD4uP2mlUGjffjL0a2OBU4hJ11x2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779876428; c=relaxed/relaxed;
	bh=a03i2oHU0t4IU0LmzV4QeyAVNl1U2/D3tCzEV/4lN8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpdGrrWRKXUATqpuy4lxHdXdhWrOuaAxVObn5YwV7ui7vcoI4Ch1Eaui3BA4CUO+54Zp0uI9hJUZeamJwnMWlXLhY4H9HfqaXZoRn8yjXAoq4/wkyXc36Cgx8RyBHJRc5lJKQ6XQq/UAGlGpBSB/KWCCY01jGmY/V2OQszUwe2kWoia8Ls7DmiQVKLwVstNjOuM1zYME3JYFmTbOkYoTduVdjKPvOYT2rEKw6UOEZzHeX6wfwSrBwhsS2CBEv1eurHfXPPbbLkY/JqkTPz2zK7XSrTeEv8iInq5a+wBsnzTkc0QWUrGJamkfCYp5XMkkrklr5ZWeZBYTqLnjiOvCzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXaF5rCy; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xXaF5rCy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQJn6493z2xHK
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2026 20:07:02 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a03i2oHU0t4IU0LmzV4QeyAVNl1U2/D3tCzEV/4lN8U=;
	b=xXaF5rCyX281Tjq9xMiNpAWElwkfuRGiPMil9kWt++lUwMcbhH8Id+hqWB0PhM86EJNOHf5cP
	XzJTUCkacoxbc5n5ogMANEQZaWdFhYgcUln2nlIksEBjAZsEmYHBq8eAn+UuA0WMfX+fm03FdmB
	LF2LhwsfSDcmQDXYBhIIo9A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gQQ7g5WzfzmV6T
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2026 17:59:11 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id A928040538
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2026 18:06:58 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 27 May
 2026 18:06:58 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <guoxuenan@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: build: drop stale liblzma path handling
Date: Wed, 27 May 2026 18:05:58 +0800
Message-ID: <20260527100558.980152-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3486-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,install.md:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 9303A5E260F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

liblzma now uses PKG_CHECK_MODULES() for path discovery, but a
leftover assignment still rewrote liblzma_LIBS to plain `-llzma`,
dropping pkg-config linker flags such as `-L${prefix}/lib`, which
breaks custom liblzma path discovery.

Remove the redundant logic and drop the obsolete INSTALL.md reference
to --with-liblzma-{incdir,libdir}.

Reported-by: Guo Xuenan <guoxuenan@huawei.com>
Fixes: 37ada1b449ae ("erofs-utils: support liblzma auto-detection")
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 configure.ac    | 7 -------
 docs/INSTALL.md | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 45b8190..f68bb74 100644
--- a/configure.ac
+++ b/configure.ac
@@ -808,13 +808,6 @@ fi
 
 if test "x${have_liblzma}" = "xyes"; then
   AC_DEFINE([HAVE_LIBLZMA], [1], [Define to 1 if liblzma is enabled.])
-  liblzma_LIBS="-llzma"
-  test -z "${with_liblzma_libdir}" ||
-    liblzma_LIBS="-L${with_liblzma_libdir} $liblzma_LIBS"
-  test -z "${with_liblzma_incdir}" ||
-    liblzma_CFLAGS="-I${with_liblzma_incdir}"
-  AC_SUBST([liblzma_LIBS])
-  AC_SUBST([liblzma_CFLAGS])
 fi
 
 if test "x$have_zlib" = "xyes"; then
diff --git a/docs/INSTALL.md b/docs/INSTALL.md
index 2e818da..0290c2d 100644
--- a/docs/INSTALL.md
+++ b/docs/INSTALL.md
@@ -42,9 +42,6 @@ $ ./configure --enable-lzma
 $ make
 ```
 
-Additionally, you could specify liblzma target paths with
-`--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
-
 ## How to build erofsfuse
 
 It's disabled by default as an experimental feature for now due
-- 
2.47.3


