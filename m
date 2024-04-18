Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11F8A929F
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:53:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=KhOEwPWQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKn4W36LZz3cTv
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:52:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=KhOEwPWQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKn4G23nkz3cJW
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:52:46 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1e5b6e8f662so4534385ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713419564; x=1714024364; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNSL+SwpuCMSDUk8cbJ/4zy4sFXbVB0ATSPoAtMnndA=;
        b=KhOEwPWQBNP7RhY5ypKcf4KKd2r7MxyfWLQ1c7JDFEK+gVWskhRkkxYOaSkT+wXGi2
         hWtCSaj/39XMB9s+ojyBGjXfmvxROLgQVXUl6I+RTAP4sepY91xaIIYfDlPWWlG7AijC
         /i7R1KBWlN40b3D99b1vk3ib0Ihjy/pyHsgjb9ZhCA+Ah13TTsWBD/xxOxqY2SoeKV1P
         lWN2sCG1yxapn3GQptEMHZvSRtu1wouRE3CEOFeBK39KFtFO9HBhEW9fHB9BfFkfZ+Hc
         RRQNEyUhuBei3io+Sso1eJlquz0uFrNInCdE9aLPmU7nWh4T+coBZfIroHLtSeSBKcbh
         f5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419564; x=1714024364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNSL+SwpuCMSDUk8cbJ/4zy4sFXbVB0ATSPoAtMnndA=;
        b=obG9O805ULJ8aZZ5xwCAtEKyDMC/csIttr2cGCywzDrM7IB4TzEp6B6z3aAdY5ryIt
         QuKKZq2clGhAfzYdIZ6wZJLLArT91CoFsWa9kjGMWAv1uMIxQoGKFSA+UmltX8np/H9D
         VldMlhUB0+2hYgPexm+tVMDX2DR4RbqwSUhaLe1v2rycMZAWbB+IhRO8opPKMuemW1Nq
         I/q/V+DKEeTwVJOLvDURSI5j5PtIQf0eM0h+UrqZwOOBTnYPc4gfYGk7bd+Ou4AQiFBc
         Oz9iyy+MWuzcTxyHr5rUmOaMEZ3uPZLXlAJf+9Dc+OjIqw3W2PCw3A76b/6B57kngOev
         mfRQ==
X-Gm-Message-State: AOJu0Yxq4WM34TQbAuq6JA2cqLdBVAJcMXDE9JUmkJ5cC2k1ntDyxIjI
	u28TGzQKnog05f3obtxW0wFBkIE+hF8xXq0E6qT9zzkSHsvbEVEnBR01SsHY0ot1uSoiCNVmtwn
	N4F4=
X-Google-Smtp-Source: AGHT+IGrie98Roiv3E0oWALKxMH4KiOEFKOSsaOYv0FMRgGw+KKFg5mLXKIWFsk7q3SuOJoPY+5v/g==
X-Received: by 2002:a17:902:7295:b0:1e5:2885:2 with SMTP id d21-20020a170902729500b001e528850002mr1509210pll.68.1713419563932;
        Wed, 17 Apr 2024 22:52:43 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e4ea358407sm642991plg.46.2024.04.17.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:52:43 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn
Subject: [PATCH 2/3] erofs-utils: skip the redundant write for ztailpacking block
Date: Thu, 18 Apr 2024 14:52:30 +0900
Message-ID: <20240418055231.146591-2-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418055231.146591-1-asai@sijam.com>
References: <20240418055231.146591-1-asai@sijam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_merge_segment() doesn't consider the ztailpacking block in the
extent list and unnecessarily writes it back to the disk. This patch
fixes this issue by changing compressdblks to 0.

And the value of blkaddr corresponding to the ztailpacking block
in the extent list is handled in z_erofs_write_extent function.

* legacy:   0 (fragmentoff >> 32)
* compact: -1 (EROFS_NULL_ADDR)

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index dfe59da..d745e5b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -555,24 +555,19 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 		if (may_inline && (erofs_get_lowest_offset(inode) + len < blksz)) {
 			ret = z_erofs_fill_inline_data(inode,
 					ctx->queue + ctx->head, len, true);
+			e->compressedblks = 0;
 		} else {
 			may_inline = false;
 			may_packing = false;
 nocompression:
 			/* TODO: reset clusterofs to 0 if permitted */
 			ret = write_uncompressed_extent(ctx, len, dst);
+			e->compressedblks = 1;
 		}
 
 		if (ret < 0)
 			return ret;
 		e->length = ret;
-
-		/*
-		 * XXX: For now, we have to leave `ctx->compressedblk = 1'
-		 * since there is no way to generate compressed indexes after
-		 * the time that ztailpacking is decided.
-		 */
-		e->compressedblks = 1;
 		e->raw = true;
 	} else if (may_packing && len == e->length &&
 		   compressedsize < ctx->pclustersize &&
@@ -601,7 +596,7 @@ frag_packing:
 				compressedsize, false);
 		if (ret < 0)
 			return ret;
-		e->compressedblks = 1;
+		e->compressedblks = 0;
 		e->raw = false;
 	} else {
 		unsigned int tailused, padding;
@@ -1151,6 +1146,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		if (ei->e.blkaddr != EROFS_NULL_ADDR)	/* deduped extents */
 			continue;
 
+		if (!ei->e.compressedblks)
+			continue;
+
 		ei->e.blkaddr = sctx->blkaddr;
 		sctx->blkaddr += ei->e.compressedblks;
 
@@ -1358,10 +1356,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		compressed_blocks = sctx.blkaddr - blkaddr;
 	}
 
-	/* fall back to no compression mode */
-	DBG_BUGON(compressed_blocks < !!inode->idata_size);
-	compressed_blocks -= !!inode->idata_size;
-
 	/* generate an extent for the deduplicated fragment */
 	if (inode->fragment_size && !ctx.fragemitted) {
 		struct z_erofs_extent_item *ei;
-- 
2.44.0

