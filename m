Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D15663BB1
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 09:50:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrkzV64S4z3cKb
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 19:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n2T1mepf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n2T1mepf;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrkzJ5Frnz3c6P
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 19:50:20 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id 20so2850891pfu.13
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rntazpxWNvol4EXTzfUrHLRo/0CaAbJ5b6GPd/rBn0=;
        b=n2T1mepfbZE5WWvXxtzGuq+IgzDgTdBYggeJY4EN7qOW8ChXXVuXI62P6Weu5IB4cs
         ZE0RlzUdDduST7lJCYy+Zk8uObrd9DkzH6KaXtL40+gOMnExSse7PYeT7/Xcb/InOnae
         itsT0OzjNCMOy1CTyHhwtfcDF0RwllJ/RtPFT9N0XF8CXir4ZfYRYeyMGHIMvD0TDUgt
         mSReVVJ7L7UTSdDrQq0qCNOwAc+ax3qCel6AF95vJSdhMpAOdCmvJTxwYxOUExdhE390
         PKxlPl89LTKMuVozLyRsSbm/M/zGMBOVSTLFCXElk/3kn8lJ3ZkUk5TzXmt7BGhS1mkx
         ZEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rntazpxWNvol4EXTzfUrHLRo/0CaAbJ5b6GPd/rBn0=;
        b=55SEG4R+dROfHIbVvjbRA3dH7aKjlnf1Em/rNiBl8uB48+hh3arc8jW15XR9FdgrLR
         lKntK1BqZgEsSPfmyqR7ToFCjf4BG38pveItfrVoKT7E4tUw48is/688hg5NeOMkNr44
         tD8hg26hGqjUXQZs21za9y5vQz+fMGbQ1hN/WVmBFxR52R+PuIRlgch/gBrSsAYLc0vz
         EHxjtfVZiRxaXTBcgwDPmP5VzEc1tAemZkTj2wZ7YWz1BKhaF2o62srwItnMKcIF5e8S
         Jcu8T4hbSuS3txWArZWsQcXK+2PzwkH0xzijjHXQkfo87k3kfuD+lvz60/E2Wq4ZrhcW
         6e8w==
X-Gm-Message-State: AFqh2krXoChxWIE4zF2FYojcOKPgoTMOPQlWuBolvbQ/nCZcd8rHI8cR
	ZEpSLojeHSQPUrnN09bEMGApYXTLYVc=
X-Google-Smtp-Source: AMrXdXvYI7L7qZNcaPjkYe7v0mVOc6FHu4GlSD8gGjcRLPVnFP2B3X7UYAdre2zq/qSBShqfqEwyHQ==
X-Received: by 2002:a05:6a00:1787:b0:588:e132:a2f8 with SMTP id s7-20020a056a00178700b00588e132a2f8mr7028678pfg.23.1673340618286;
        Tue, 10 Jan 2023 00:50:18 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b00574ebfdc721sm7783030pfo.16.2023.01.10.00.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:50:18 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Tue, 10 Jan 2023 16:49:59 +0800
Message-Id: <20230110084959.1955-2-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110084959.1955-1-zbestahu@gmail.com>
References: <20230110084959.1955-1-zbestahu@gmail.com>
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

Diretly call {z_}erofs_read_{raw_}data_mapped() to avoid duplicated
code. Accordingly, fragment and partial-referenced plusters are also
supported after this change.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: parameter '0' -> false and update commit message

 fsck/main.c | 57 +++++++++++------------------------------------------
 1 file changed, 11 insertions(+), 46 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..4dfab29 100644
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
@@ -427,54 +426,20 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
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
+			ret = z_erofs_read_data_mapped(inode, &map, raw,
+						buffer, 0, map.m_llen, false);
+		} else {
+			ret = erofs_read_raw_data_mapped(&map, raw, 0,
+							 map.m_plen);
 		}
+		if (ret)
+			goto out;
 
 		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
 					map.m_llen) < 0) {
-- 
2.17.1

