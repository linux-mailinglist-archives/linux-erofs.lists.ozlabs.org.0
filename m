Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1366513F
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 02:50:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ns9bq3hS3z3cGh
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 12:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RS9KXGur;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RS9KXGur;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ns9bg38c6z3c3N
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 12:49:49 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id c85so7021425pfc.8
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB0IAL3oqJcQL6j/nrfVypxL0yORPjZGHUtTFKuAW1w=;
        b=RS9KXGur3U5O4kKwu+7hW5qDsuJxYQ9W3GseNVsxlE14q4VSdLyW1ZFlEYL0n3RF6V
         TP7YjsMlqoDSZ2Hbp7cukHKw0pg5hC8BJUMKBDzi4ntfVuQiO3HqQmSQbfUW0syukdGf
         HDPXi2xZ/4YVwk8rvtLHAXdCodRY/vxhNIMTElHZ5p48eeuVjK6yvEvT2F0W11rCiMZ6
         e01Jh9Lr4FYaYfX7e5jRDpDwXZTOEPSNK+x4jrWLTav/mi6IGVx9b9A/8GFuHgu2uMFW
         azS8SF9QGq1LPZMDIVZOBI8sFPQOkm0l2xfWR24uO6aPjbydVid3wwm8US+5s6nQTHm5
         TMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB0IAL3oqJcQL6j/nrfVypxL0yORPjZGHUtTFKuAW1w=;
        b=l+wL+pD9cbmWKe+UHsqDhj6KVepQJdGjPAKyc0Jx8bSx0auZxdMhi9yLHv1c0Mwnvi
         /n3XOvIUcuWkPf2g6wPinShKWkYiSuREoKOBiGn2bLm+3aWhHP8RD2l4b75HArsDBVgq
         CZyDEcNqJVyMwqb08uktxngZjgSUxv12ra6oHzA6FHQbGGX65qbpYhjX02U3ihlkBaKk
         JIiho8e0gL3sZuLceiUjO0fELE/M9XUSrVMvIC4pi9jbDWPDypCarD85ulxBGLL0nkfd
         JVx0dhITYCg9gnwU77HwjrVJIXYIF3l4zWDLC40iJVln1VEb5O4cW2ZtnJY0EI8ZTVoW
         zTZg==
X-Gm-Message-State: AFqh2koPcE6inhEbJzk6OJwRtzXIgyIFN+arasglJUIDoVQSw4ysrQjz
	0oCb30enFm9wy+wnkd0wj1kDjw9iE/g=
X-Google-Smtp-Source: AMrXdXtlpuJlKjLoXWKTEpYXjGJps3g2ByU4ipjiU1Rfd69zsvuoAsdVsVen0IeWZXTTtO7GrKHZHA==
X-Received: by 2002:a05:6a00:e8d:b0:580:c223:90e9 with SMTP id bo13-20020a056a000e8d00b00580c22390e9mr61281177pfb.6.1673401787799;
        Tue, 10 Jan 2023 17:49:47 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a623002000000b0056283e2bdbdsm8669847pfw.138.2023.01.10.17.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:49:47 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH resend v3 2/3] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Wed, 11 Jan 2023 09:49:27 +0800
Message-Id: <115e61fc9c2d34cab6d3dd78383ac57c94a491fc.1673401718.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
References: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
In-Reply-To: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
References: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
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

