Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152028F381
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:40:50 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr5V6FftzDqQv
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:40:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=C5QiyAUI; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr500TWszDqLK
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:40:16 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id j8so2072946pjy.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Oct 2020 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=snVDJlr5muvehAJbMd5bPbJtmPH7BkOBy/67p/b2N7g=;
 b=C5QiyAUIPhGFXxjS053Z1cP2gBMNRqfD+rMqf7Ravg7v8RO6MWFKVan51sU6KVjf7D
 AbF+CTwgfjO/bqj9vxcTW8/Q/MqSelc1j1w3+SG+faPYAOdUDYeFOGQJK6ugg9oF+QjJ
 CMWmNQTxyDtiuc/32Iv2ZYiG0Qc2yAZKzC8LUAoJITXBYETZ9VCIZkvvjMVObwri1x6w
 M4atu1Lwok209rQxj0gGrAMzzHWKjjNk6QCvhm7kmx0dnL9vJY+jjxMtPLRUqyRy3oI9
 3I29JKuaNCKtB+DV2DVpfJt93dvkE8tk5gsBmg0HsV4Lu94cU77AOMg8xnei3nHvboxh
 V48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=snVDJlr5muvehAJbMd5bPbJtmPH7BkOBy/67p/b2N7g=;
 b=aEjfUzU98Vh8sxyf7SPSbyU/TQ11jsIgATZ4eBwRpjcWxvAQCzqYqoyPnOw3RWnTux
 h5kZEAr9oPt1tmTWpe/riY/2A3aUl/S4k3LhtfPK7/1803sdyl5QFOTqBkEyMPw++MJy
 DMfgNPC1Deg5i7B/sSkpgsYYPvJ1c3oLuQ87Grsza557Cpf04sT5pg4nQ9Ivl5eZQOLn
 XN9f70DJyJ/h8U/8tJv4xQk9OfWibPKet9AE7xeaQsDDyIscL3tXWKoPl1oCg/RqWVgx
 L7CuzqLbnTpHY9G7xKhRmuWZnkn7iB6ctz+qohmoSJ8+viYb6onxUvrAd0Sgkk6bH3ay
 WVXA==
X-Gm-Message-State: AOAM5317vVwq3FLUGa2vInXnCpN82y28escvy9XDcak08vtP84eN0+Cw
 IGA6em5ynscd6tfQyGVUdXHQqDO1GMOlUGGr
X-Google-Smtp-Source: ABdhPJyrb5mpWowGvR0Cmd+ZC7PWtD8lfuRol3N0xwwyxNSmNSVEzgH1EEE+hqDWkOyCByB/FXoDhA==
X-Received: by 2002:a17:90a:1050:: with SMTP id
 y16mr4648305pjd.164.1602769214051; 
 Thu, 15 Oct 2020 06:40:14 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id a19sm3426058pjq.29.2020.10.15.06.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:40:13 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs-utils: fix the conflict with the master branch
Date: Thu, 15 Oct 2020 21:39:55 +0800
Message-Id: <20201015133959.61007-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The current fuse branch is quite different from the master branch.
So fix the conflict with the master branch to support the upcoming patch.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fuse/init.c              |  4 ++--
 fuse/namei.c             | 16 ++++++++--------
 fuse/read.c              |  6 +++---
 fuse/readir.c            |  4 ++--
 include/erofs/internal.h |  6 +++---
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fuse/init.c b/fuse/init.c
index 885705f..8198fa7 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -41,7 +41,7 @@ int erofs_init_super(void)
 	}
 
 	sbk->checksum = le32_to_cpu(sb->checksum);
-	sbk->features = le32_to_cpu(sb->features);
+	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
 	sbk->blkszbits = sb->blkszbits;
 	ASSERT(sbk->blkszbits != 32);
 
@@ -56,7 +56,7 @@ int erofs_init_super(void)
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
 	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
-	logp("%-15s:0x%X", STR(features), SUPER_MEM(features));
+	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
 	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
 	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
 	logp("%-15s:%ul",  STR(inos), SUPER_MEM(inos));
diff --git a/fuse/namei.c b/fuse/namei.c
index ab497e8..ded9207 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-fuse\inode.c
+ * erofs-fuse\namei.c
  * Created by Li Guifu <blucerlee@gmail.com>
  */
 
@@ -43,7 +43,7 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret;
 	char buf[EROFS_BLKSIZ];
-	struct erofs_inode_v1 *v1;
+	struct erofs_inode_compact *v1;
 	const erofs_off_t addr = nid2addr(nid);
 	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
 
@@ -51,10 +51,10 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	if (ret != (int)size)
 		return -EIO;
 
-	v1 = (struct erofs_inode_v1 *)buf;
-	vi->data_mapping_mode = __inode_data_mapping(le16_to_cpu(v1->i_advise));
-	vi->inode_isize = sizeof(struct erofs_inode_v1);
-	vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
+	v1 = (struct erofs_inode_compact *)buf;
+	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
+	vi->inode_isize = sizeof(struct erofs_inode_compact);
+	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
 	vi->i_size = le32_to_cpu(v1->i_size);
 	vi->i_mode = le16_to_cpu(v1->i_mode);
 	vi->i_uid = le16_to_cpu(v1->i_uid);
@@ -153,10 +153,10 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 		++nr_cnt;
 	}
 
-	if (v.data_mapping_mode == EROFS_INODE_FLAT_INLINE) {
+	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		uint32_t dir_off = erofs_blkoff(dirsize);
 		off_t dir_addr = nid2addr(dcache_get_nid(parent))
-			+ sizeof(struct erofs_inode_v1);
+			+ sizeof(struct erofs_inode_compact);
 
 		memset(buf, 0, sizeof(buf));
 		ret = dev_read(buf, dir_off, dir_addr);
diff --git a/fuse/read.c b/fuse/read.c
index b2bfbd3..ffe976e 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -64,7 +64,7 @@ size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
 	if (!suminline)
 		goto finished;
 
-	addr = nid2addr(vnode->nid) + sizeof(struct erofs_inode_v1)
+	addr = nid2addr(vnode->nid) + sizeof(struct erofs_inode_compact)
 		+ vnode->xattr_isize;
 	ret = dev_read(buffer + rdsz, suminline, addr);
 	if (ret < 0 || (size_t)ret != suminline)
@@ -97,8 +97,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	if (ret)
 		return ret;
 
-	logi("path:%s nid=%llu mode=%u", path, nid, v.data_mapping_mode);
-	switch (v.data_mapping_mode) {
+	logi("path:%s nid=%llu mode=%u", path, nid, v.datalayout);
+	switch (v.datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 		return erofs_read_data(&v, buffer, size, offset);
 
diff --git a/fuse/readir.c b/fuse/readir.c
index 7fc69f4..367f935 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -103,10 +103,10 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		++nr_cnt;
 	}
 
-	if (v.data_mapping_mode == EROFS_INODE_FLAT_INLINE) {
+	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		off_t addr;
 
-		addr = nid2addr(nid) + sizeof(struct erofs_inode_v1)
+		addr = nid2addr(nid) + sizeof(struct erofs_inode_compact)
 			+ v.xattr_isize;
 
 		memset(dirsbuf, 0, sizeof(dirsbuf));
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2316d01..cba3ce4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -135,7 +135,7 @@ struct erofs_inode {
 };
 
 struct erofs_vnode {
-	uint8_t data_mapping_mode;
+	uint8_t datalayout;
 
 	uint32_t i_size;
 	/* inline size in bytes */
@@ -171,8 +171,8 @@ static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 			EROFS_I_VERSION_BITS)
 
 #define __inode_data_mapping(advise)	\
-	__inode_advise(advise, EROFS_I_DATA_MAPPING_BIT,\
-		EROFS_I_DATA_MAPPING_BITS)
+	__inode_advise(advise, EROFS_I_DATALAYOUT_BIT,\
+		EROFS_I_DATALAYOUT_BITS)
 
 #define IS_ROOT(x)	((x) == (x)->i_parent)
 
-- 
2.25.1

