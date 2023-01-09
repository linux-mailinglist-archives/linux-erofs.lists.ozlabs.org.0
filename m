Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EE6623CB
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 12:06:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrB325kXnz3c95
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 22:06:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UvbAcsZZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UvbAcsZZ;
	dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrB2s3T4Xz3bXQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 22:06:29 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id d10so5580408pgm.13
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Jan 2023 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BP7zrO74OqZZWqNs7Y2p0BDoUyLH8o/d5nF0Iuyj7Y0=;
        b=UvbAcsZZKd7xyG0TiyDLH5Om3a0y+lENJULmQ4hzABGS+52wL/sHBQECA2CddjVV+2
         GqSH8fnBWuQaBHrQ4fUFbcBxrrSb4Ed4PVGtM41x7MelMmuwwJi+mHjr5Dn53EKN0d1c
         ZMYUMoJgsnmH5NowhOIWT0ZABqwTyFMTQX+x8M5Jt+IlkOzvq9ljQXYeKXGfeK2QgMXI
         vZpoL2tLp3eMwsSPsOdU1UNd8RDCmgJOk/2Y7KQf1ZA9vAZoI28hoceux79fTb0/YLlU
         A7reFbL7LPnMs4TL+tOEH4ZznbdkQb6u3VbZJ8cB20q/bOs5ZEnUbkyai52Kfmq3I30Q
         DPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP7zrO74OqZZWqNs7Y2p0BDoUyLH8o/d5nF0Iuyj7Y0=;
        b=MUqPTXR0ZVuYygBdoGHq1/az9l7/WdkIWzMJtMYRCCMTR18zAzZiuHlj29P8gJKqNp
         GI30vyJmQfAW6KFlAzFOqROaXk/OuAWz73a/klyJ8A+0VIy0OMZnK6U0Zhn2hYyJDFB5
         ZVuGuWV7aZCivXurcnfluIErvdzNBAxaAT4eAkkORwz/o0/IsgjpsX5IGzAVPF5UPijF
         rl2xiSjWreUq1LG7XEo8f4M5txnoRV27cSeLREE/DWLxJFkNETP3pWWTmIMs7DMpDkLZ
         SJpsPsmDfMbWAlcvQDabilI3fItAC2URDFxmRzR5Xwt1HoqBklOSLfEwIxZFeuYhsLbd
         KBGA==
X-Gm-Message-State: AFqh2krtywjXF65P8GduTVFUUsjDHxUXBc6hWfzF/Ld5Wtt6gRNW9V/d
	ce116vT1UU7nhnQom5GiJqSt+ZB4y5g=
X-Google-Smtp-Source: AMrXdXuzQPYMOv22HDba4LqH125afeA3jJG/sMz/wOcFAmcwF6CNaND820hmg3bsxL5rg2VqYRVQxw==
X-Received: by 2002:a05:6a00:f92:b0:582:a224:e740 with SMTP id ct18-20020a056a000f9200b00582a224e740mr24679628pfb.27.1673262387026;
        Mon, 09 Jan 2023 03:06:27 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b0056bcb102e7bsm5790134pfq.68.2023.01.09.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:06:26 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Mon,  9 Jan 2023 19:06:11 +0800
Message-Id: <83f2c7ab9a89f7114cef6ca3a224873fb2a28397.1673260541.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
References: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
In-Reply-To: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
References: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
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
code. Accordingly, fragment is supported as well after this change.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 57 +++++++++++------------------------------------------
 1 file changed, 11 insertions(+), 46 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..71abbdb 100644
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
+						buffer, 0, map.m_llen, 0);
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

