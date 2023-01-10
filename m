Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D7A663CCD
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 10:28:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrlqW4ymNz3cDT
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 20:28:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n9CEFSr/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n9CEFSr/;
	dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrlqR4BgVz3c6W
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 20:28:34 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id a184so8320882pfa.9
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgrssnqzzuQeUQAx7JCLvPH/9gy9+kPk1Qy7viTbcT4=;
        b=n9CEFSr/P2xORL1Zt95lgg8UKj3Y70CIYxz3ms/gK8i3EVTRtR9RtNoT/sNVh07dOx
         kHEzr0G+ZrCy5wU9mWxCLSBhtMJ5JlHZuikaKY383djyz0ECQZ2MO0v7LYHtnOtojXgf
         mOwkFdGLsHDHtCak+wTIqf6tWtrIvRJY/hIMwcrAd3SvZqfezE3Tr4qfWOiCzXvZkOUk
         mfCz67Hc4O2q/mXpWAJZIQ4b4sSiRisOA0h3pnDw1fprnIgsHEr3YDrXdnYaVIfudORU
         ZjW2rh4T2zJCIsLQLOB0cEhn22RcfYW5Az1rt3Gg/FIorESYBLc+oLCfRfsAgy1jrluR
         hnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgrssnqzzuQeUQAx7JCLvPH/9gy9+kPk1Qy7viTbcT4=;
        b=gC2kfcfYXA7aXyakbLqhL2j8Y2wzeeFCoMl8nK9CC4CpCBq/YRh4fegW90uvm/Ci1f
         YTKWSa9UwhD2Jrb61lqjGTFJ4OAZI+zRhBlnMCqB89ZzYzAwDsUPgN5hM5aBP6Usl5H7
         V0hA1g0aXnv5ly9Wc33KMeleMY7g0iMVXjicWLw5oy0fpizAId/g/lZ18AaXjL3j9Zoa
         N+qjO5daHfGK7hfcryKGU87kwYRwiS30YjF5mVvgl9q6+6obJOToiNlCRJeweG+59JRa
         neGKdID/mHDGWz56cb5vEaSOadc00a9jIdu5obyfpF16AK3qFkWDw28Ar09x+1BOK7Zr
         5cjg==
X-Gm-Message-State: AFqh2kpbFlSFIPc1h8I3hoddyUATcez8XKB+/CGdJlvCh4YYb6TnS8mn
	wCfqBqDy/1ib+1eoYVxk7bqyT6X78hg=
X-Google-Smtp-Source: AMrXdXv1WOMbhbO7J7IbjYVmhy1mmtSDDcE+HCYjBB1sTvcSS/jmnvul58LqwscKW1yeAKk29qKrlQ==
X-Received: by 2002:a05:6a00:bdd:b0:582:e67b:205f with SMTP id x29-20020a056a000bdd00b00582e67b205fmr21751482pfu.1.1673342912876;
        Tue, 10 Jan 2023 01:28:32 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 125-20020a620483000000b005817fa83bcesm4866880pfe.76.2023.01.10.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:28:32 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/3] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Tue, 10 Jan 2023 17:28:20 +0800
Message-Id: <fedb5e3bae9f7ee90e2c1e2e72cb9f05711579ae.1673342258.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2a43acac96332c626483f6320eb0e06aba62c776.1673342258.git.huyue2@coolpad.com>
References: <2a43acac96332c626483f6320eb0e06aba62c776.1673342258.git.huyue2@coolpad.com>
In-Reply-To: <2a43acac96332c626483f6320eb0e06aba62c776.1673342258.git.huyue2@coolpad.com>
References: <2a43acac96332c626483f6320eb0e06aba62c776.1673342258.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Diretly call {z_}erofs_read_one_data() to avoid duplicated code.
Accordingly, fragment and partial-referenced plusters are also supported
after this change.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v3: switch to use new naming and commit message as well

v2: parameter '0' -> false and update commit message

 fsck/main.c | 56 ++++++++++-------------------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..a01ca76 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -366,7 +366,6 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
-	struct erofs_map_dev mdev;
 	int ret = 0;
 	bool compressed;
 	erofs_off_t pos = 0;
@@ -427,54 +426,19 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			BUG_ON(!raw);
 		}
 
-		mdev = (struct erofs_map_dev) {
-			.m_deviceid = map.m_deviceid,
-			.m_pa = map.m_pa,
-		};
-		ret = erofs_map_dev(&sbi, &mdev);
-		if (ret) {
-			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
-				  map.m_pa, map.m_deviceid, inode->nid | 0ULL,
-				  ret);
-			goto out;
-		}
-
-		if (compressed && map.m_llen > buffer_size) {
-			buffer_size = map.m_llen;
-			buffer = realloc(buffer, buffer_size);
-			BUG_ON(!buffer);
-		}
-
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
-		if (ret < 0) {
-			erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  mdev.m_pa, map.m_plen, inode->nid | 0ULL,
-				  ret);
-			goto out;
-		}
-
 		if (compressed) {
-			struct z_erofs_decompress_req rq = {
-				.in = raw,
-				.out = buffer,
-				.decodedskip = 0,
-				.interlaced_offset =
-					map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
-						erofs_blkoff(map.m_la) : 0,
-				.inputsize = map.m_plen,
-				.decodedlength = map.m_llen,
-				.alg = map.m_algorithmformat,
-				.partial_decoding = 0
-			};
-
-			ret = z_erofs_decompress(&rq);
-			if (ret < 0) {
-				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
-					  mdev.m_pa, map.m_plen,
-					  inode->nid | 0ULL, strerror(-ret));
-				goto out;
+			if (map.m_llen > buffer_size) {
+				buffer_size = map.m_llen;
+				buffer = realloc(buffer, buffer_size);
+				BUG_ON(!buffer);
 			}
+			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
+						    0, map.m_llen, false);
+		} else {
+			ret = erofs_read_one_data(&map, raw, 0, map.m_plen);
 		}
+		if (ret)
+			goto out;
 
 		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
 					map.m_llen) < 0) {
-- 
2.17.1

