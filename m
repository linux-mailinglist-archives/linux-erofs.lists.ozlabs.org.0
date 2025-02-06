Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F4A2A8CE
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR43zvxz30Qb
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846252;
	cv=none; b=hM1iHp9E8Jv/cjHHZGIKzLTMIe8jbjibLWgSVj+eXWlWxNATtIYgfSJZYLyhnJYf9HvIy8TP6MbnQlHhgYvUin85B31O+hwCpiLkpBwsem0EW37EiXuYUzEpjQJj5Mba13zMqAmosh9RkBNqw0gDwlpfVzNrKAIE3kjDCXwFZ6gjcpYSSOBpgrujuaXd37JjrouASUGKLJajDS4SC9wg3OeT+VX+vcw4Zpmu5kzjffiy+nHRB9+IyuPoxwA4y3T548tazJ/lSEMPkwJevMZ2bvZomNfuXh/axDyKgypBrl73HYNFR9NgWgYgXh4AszgZ/O3oViiJtR/WE8dRmsp7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846252; c=relaxed/relaxed;
	bh=Gqx1VajamrFp2+gY3FZS/oR9qd+H8IK8fbtwaLDBvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpxbPlGVRBEI2eYLKkPDb+2aX/ztjvmAzZvYUHotMrAivKgsZjIBxLYNkP7Mv6clFa5aZnUhMXUKHc78HPU9NOGLoBbS1B4p0IR91vo0BUwjvjIkU2jGt6ZrdA8ECCo521G8NiAIz2IPSGbHubT6Sb+OulRu42MyLbFXICh9ikV8qL2ei3FNKmYq0ad8pTlt2IAN6t6VHKD/rDGscbAhrjnGppEHNsju/Kduo7pCJdqB8ItoVIWF1h3ev5i5kqaeAzzRFvnwwdGwQOQ9TA00QNzkFlurNebJrWVITpEn3j2nGVh6I5zMqLNpykWwTDn+exaKft5BCLy8BtnQzt8yIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xqmzg7hf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xqmzg7hf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcQz0xSDz30Ds
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846247; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Gqx1VajamrFp2+gY3FZS/oR9qd+H8IK8fbtwaLDBvWw=;
	b=Xqmzg7hfu11P02O82OB4ef+ugDeY7dQTV9m+jn//CzXa/EzElgEapLD7ZJHIlITYy9AJTjuQG2Lqsl5MOhtw7FPcX8Vb/bwcQ/RVTeEGIN2eLBGdtL3ZE3USZBmVergCvHt88psphCDGgtEjccOFk2WzaZFC2pVyx/PmEiz02gc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl4t_1738846244 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/9] erofs-utils: lib: get rid of z_erofs_fill_inode()
Date: Thu,  6 Feb 2025 20:50:28 +0800
Message-ID: <20250206125034.1462966-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
References: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Source kernel commit: 4fdadd5b0f0c723c812842454f8cca1619f2e731
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 -
 lib/namei.c              |  2 --
 lib/zmap.c               | 17 -----------------
 3 files changed, 20 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 7f01782..5f5bc10 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -455,7 +455,6 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
 
 /* zmap.c */
-int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map, int flags);
 
diff --git a/lib/namei.c b/lib/namei.c
index 6f35ee6..eec1f5c 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -143,8 +143,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		}
 		vi->u.chunkbits = sbi->blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
-	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		return z_erofs_fill_inode(vi);
 	}
 	return 0;
 bogusimode:
diff --git a/lib/zmap.c b/lib/zmap.c
index 74c0033..0a9bc6a 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,23 +10,6 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 
-int z_erofs_fill_inode(struct erofs_inode *vi)
-{
-	struct erofs_sb_info *sbi = vi->sbi;
-
-	if (!erofs_sb_has_big_pcluster(sbi) &&
-	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		vi->z_advise = 0;
-		vi->z_algorithmtype[0] = 0;
-		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = sbi->blkszbits;
-
-		vi->flags |= EROFS_I_Z_INITED;
-	}
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct erofs_inode *inode;
 	struct erofs_map_blocks *map;
-- 
2.43.5

