Return-Path: <linux-erofs+bounces-2927-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIJRK32Qv2nu6AMAu9opvQ
	(envelope-from <linux-erofs+bounces-2927-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:47:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EB2E86E6
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:47:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdn0l4wn8z2ySb;
	Sun, 22 Mar 2026 17:47:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774162039;
	cv=none; b=euNu/ZPfWJlLXhKo2GhrImOS98FWC2z4PNjl6ZUqZXo9WmttM/0rJjhL4yI9WLLiuN9kUx5fQrI0j8acUm7OSalfxbYmyFvR9NlaBandZejpQmvhW41q+jzBQVMQLtJzbWvG3X9WYPVS2HeVtGvlwFWu3nv/Vj1DbtxnytbY48On9IpYCcsg+poCgC4KnPoKUPby6rqUlvyTothSBaskTLwPynlB3EDOLFI6JUPYawa2udx0f8K0cMljn2LhvzD+BPvTN8hsF4ZD/RH7r+pkPueRErYi3BhsHVhIHi8DS59TgU3T/Kfbplymz5qYycTrohGdoZ26oSMFUyc2+JKshg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774162039; c=relaxed/relaxed;
	bh=KqBYtzAeqqGr8x4bD+eZRcuWHf3FqhTZGpZzSGJoKGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsFKD5I3MQbtOTLREDJXvO8gUZk0Z7mdg89sIHKk8NBDIG6h9e6L+PiRPFeUdL2tnZh8FyU+c1/spi41a8yxoRcobhHxscbDc9DiYDC0KZ7pmr3qR5FLy9GXeYykkOHTbyOUV8vi21VGs2ifJq1/PS+TsAZESn6pyunZ13CWAj2hu5T2/BepfmRPXxV1V0Ken0e+8yYEna9UXVZ/QP2wYt/xvKoZVnHBO/EczdXL8d1hEpK6BZJOXwKpKuKmJkNPPbuhejTKEeKE4Y6bZnk0dWFZgpdmUEJlUndIh3+GDc5w8Ib2eRuFD1zGtOU5S1PdL+7shSEmcqjz6NCC2aqEEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IhZxnE19; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IhZxnE19;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdn0k4Cbtz2xb3
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 17:47:17 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35b982990aeso430381a91.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774162035; x=1774766835; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqBYtzAeqqGr8x4bD+eZRcuWHf3FqhTZGpZzSGJoKGo=;
        b=IhZxnE19LhRWaWceSF7xy2OY/6CyPmPzVTDTAIPnCYhihFO0BYH8zET5Hx1vlmjVJq
         DCPVPjXM769BzEcW7QvhXhENnjBwc6liH66x6lhIzOaqw+BMnDliwe17RGpxys/6oQnq
         2ugAdtspD3a66Ib0YrRg5M+qkTzhAVu/p5afhx1XkpsqVlXWhmAMSY4rsEWP9b0ihzd0
         /rTJpyo7KkMjSWmy89sw120aXXYpBcC1IxCWo8c+X33pvt9X7FCC0EDRhpGlKvjIox4J
         ttpFOPMya1wFxQv6oP1wRUgp1qvyzd1sw6+SjPKjrfbepozxPIxw+tiLweN8ufCBT2pS
         9tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774162035; x=1774766835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqBYtzAeqqGr8x4bD+eZRcuWHf3FqhTZGpZzSGJoKGo=;
        b=grrq5XOnkR+jNSk1ek5H/1Ed7ZRRLJUhTp+A4+fZPKcqRdjldXVFi3QA5qItUu4TUT
         nDG/iPxOPoPeCfUhwxpxUrTsx3tO7at32OpQhyA8vesEEwxson0RxeQYi0DWREPiAzp7
         P9ay1ifR+q3wYqM2WBxiXBMCVCHQ+h5rthvDvGcYFnOfehklUTNChgLHkq9Y7WIq3PU1
         KBNIlDpZKnwCCDC3f8cgNLI99k2l0KDJppkVhAj9aJ/Bin2Ry1kckl7TSWF+lpvxl4DV
         X0nB4o8AfwKoWZHBHAO/gjQCzvsv3TqfwzWfN3kDI5ialyzOi6zSNibeEvZnVhWaiV0M
         s/LA==
X-Gm-Message-State: AOJu0YxaM7HL95S0X8At7d+tD8E3TP98co84P5l+6elQbPzY2z7sy1lU
	KaSB0MuyfPhV48KR0OfMEVeiUML+UQDG+u0bLgajx5mn0yadH8utC2d9HQXJ4Cta
X-Gm-Gg: ATEYQzyaf7cYG8J4gJSnQZZ91WPgT0oZyDXxmzcnsA63sPy02+HsEBfec3IMdMqCEHj
	TfLmbv2CMjjytLZSv/R8Re8GwGMXESFrmmzJf5J+mN2l4jaJ+D7TL9KDE/kFitOH95gaiX6ED+G
	bQfdMSZDEK4bzyvPLNnXbx2g2+v6fk54m7Wxcs2dMjzChfPZ1fp/nHCb13IrUJlVOM7qqgM1WBl
	/y07py6Lzncts/UXBIXoWDsJ6PnxJdyX0FTzzqv+0Lt+/v3skQDf0HJM3k9FphaFscL3QlSk0/Y
	kbkVgmoCDNcb+Ly3+KsFmdHoxXjRqGq1N5tXs+JglHfPyBTRBUBdb00ZoU3U4OG3zYpHklGRN3/
	Sx3Y6AEbP6128pOh76SQHhH0vAs+NGLhtjDSN0GFCbIxYFJMhk2NnnUgSzfFFWnwug2+esIgi90
	bPl1c4zVDf6MXh5hjHJxD61540nGf/zU62hvyEToqPDHrwEkmMVWuHqm9cWO+RHCWnMDFP35Aty
	Spb1fhZgJYQYQtV5ysMKmRW+0ZJrLDlcOEl2w==
X-Received: by 2002:a17:902:e849:b0:297:f3a7:9305 with SMTP id d9443c01a7336-2b0827e94fbmr54662565ad.6.1774162034581;
        Sat, 21 Mar 2026 23:47:14 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836ace98sm71729075ad.80.2026.03.21.23.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:47:14 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] fsck: add --workers option to configure worker threads
Date: Sun, 22 Mar 2026 06:47:06 +0000
Message-ID: <20260322064706.27001-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2927-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B69EB2E86E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a --workers=# command-line option to fsck.erofs to allow users
to configure the number of worker threads used during verification.

Parse the value using strtoul() and validate it against UINT_MAX
before storing it in fsckcfg.nr_workers. Return -EINVAL for invalid
inputs (non-numeric characters or out-of-range values).

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fsck/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..37e21f4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -4,6 +4,7 @@
  * Author: Daeho Jeong <daehojeong@google.com>
  */
 #include <stdlib.h>
+#include <limits.h>
 #include <getopt.h>
 #include <time.h>
 #include <utime.h>
@@ -42,6 +43,7 @@ struct erofsfsck_cfg {
 	erofs_nid_t nid;
 	const char *inode_path;
 	bool nosbcrc;
+	unsigned int nr_workers;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -64,6 +66,7 @@ static struct option long_options[] = {
 	{"nid", required_argument, 0, 15},
 	{"path", required_argument, 0, 16},
 	{"no-sbcrc", no_argument, 0, 512},
+	{"workers", required_argument, 0, 17},
 	{0, 0, 0, 0},
 };
 
@@ -117,6 +120,7 @@ static void usage(int argc, char **argv)
 		" --nid=#                check or extract from the target inode of nid #\n"
 		" --path=X               check or extract from the target inode of path X\n"
 		" --no-sbcrc             bypass the superblock checksum verification\n"
+		" --workers=#            number of worker threads\n"
 		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
@@ -257,6 +261,15 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 16:
 			fsckcfg.inode_path = optarg;
 			break;
+		case 17: {
+			char *endptr;
+			unsigned long v = strtoul(optarg, &endptr, 0);
+
+			if (*endptr || v > UINT_MAX)
+				return -EINVAL;
+			fsckcfg.nr_workers = v;
+			break;
+		}
 		case 512:
 			fsckcfg.nosbcrc = true;
 			break;
-- 
2.43.0


