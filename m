Return-Path: <linux-erofs+bounces-671-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4756B09BC4
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s74hZBz30RJ;
	Fri, 18 Jul 2025 16:54:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821675;
	cv=none; b=btJXI1gOqLT49TsGuEhtgImm8q8ypyoXyhD7DL9VU2RdCyf3VD51BT41+r28xJ/dN4anu9DejZKMS1Ez9L3+CSKKp6T7sAz1+nWqxn2TIIBZaK4af6+uCrnUM7iJQRi4qEaYgl/WATxq3gZNksgwUwOekfbSOFUDoWgBsI1iOKrVvSV6e6puXP0uKKK2jWWoFSmKjNEMz9Jp+wOCpQRlwL63tbMQeT9t/T+8HHH6z6lhyIciMdyaKD0rel4VzyC1qlM50pEfLDxpCSaqTAIHM+egkDjOXqZTQCjlORgATNkX5QR81q+E0dZ+KlATg3JyYTHt/gaXvcgs4kjivnDGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821675; c=relaxed/relaxed;
	bh=cO8lkCApRumW3bOuX42v5g50TKO+xNzPByrH2qFf3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiED/PVVTPXSALPJ9pnVYvEIf+kbFMJW0uQCZbXPOGO5FejN1lTR/QFz+6yRTnEuVFZCtHIOuG8vR4M3DMZLf0EadbaFrFuFKD174EuyXJ7wg4TMBhdmtRJsb7xBI4a034AOygGlCg6hGnPFLMUQm2+9fqw8YsQ6goYtkrJ1ONK+he8CbLUuQVyXlS2+hBUrGXcIepSHNQTLHojr1+WfjUAlrserzPfq4L6twZ7gBKEqn5YlvwyxV5hAYWjUeHWKtuXCplQuJlLZICSTxqOBc9nRUYubyLDvH2qUsC8tiLrRvxwVr0fnr29AlTn6EjOhWOSitVzNOlDUdeZ9HU8LnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LrkFtrH8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LrkFtrH8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s62WgNz30Tm
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821670; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cO8lkCApRumW3bOuX42v5g50TKO+xNzPByrH2qFf3RY=;
	b=LrkFtrH8r0ecU7FTrqwNzrhcpci1jLTlZ+lDLiPszYkbA3EEW24wjjuMLuP0l/9nnOsXQIiyghOLLwrBOeo1Up/QBqXAVQxOssmTxSbHu02XBV86XV2kU9OCcEMmuqMqLaXL0Slmmy+r08fPQw9VO95+ca61Ljgj1u5iLt2WMuI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlS5_1752821667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 05/11] erofs-utils: lib: introduce meta buffer operations
Date: Fri, 18 Jul 2025 14:54:13 +0800
Message-ID: <20250718065419.3338307-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: fdf80a4793021c2f27953b3075f401a497519ba4
Source kernel commit: 469ad583c1293f5d9f45183050b3beeb4a8c3475
Source kernel commit: e09815446d6944fc5590a6e5f15dd51697202441

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 14 ++++++++++++++
 lib/data.c               | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1431c16d..b61fe716 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -46,6 +46,14 @@ typedef u64 erofs_blk_t;
 /* global sbi */
 extern struct erofs_sb_info g_sbi;
 
+struct erofs_buf {
+	struct erofs_sb_info *sbi;
+	struct erofs_vfile *vf;
+	erofs_blk_t blocknr;
+	u8 base[EROFS_MAX_BLOCK_SIZE];
+};
+#define __EROFS_BUF_INITIALIZER ((struct erofs_buf){.blocknr = ~0ULL})
+
 #define erofs_blksiz(sbi)	(1u << (sbi)->blkszbits)
 #define erofs_blknr(sbi, pos)	((pos) >> (sbi)->blkszbits)
 #define erofs_blkoff(sbi, pos)	((pos) & (erofs_blksiz(sbi) - 1))
@@ -427,6 +435,12 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi);
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
 
 /* data.c */
+static inline void erofs_unmap_metabuf(struct erofs_buf *buf) {}
+static inline void erofs_put_metabuf(struct erofs_buf *buf) {}
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
+void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi);
+void *erofs_read_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
+			 erofs_off_t offset);
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
diff --git a/lib/data.c b/lib/data.c
index e2d9b5eb..d2558254 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -10,6 +10,42 @@
 #include "erofs/decompress.h"
 #include "erofs/fragments.h"
 
+void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
+{
+	struct erofs_sb_info *sbi = buf->sbi;
+	u32 blksiz = erofs_blksiz(sbi);
+	erofs_blk_t blknr;
+	int err;
+
+	if (!need_kmap)
+		return NULL;
+	blknr = erofs_blknr(sbi, offset);
+	if (blknr != buf->blocknr) {
+		buf->blocknr = ~0ULL;
+		err = erofs_io_pread(buf->vf, buf->base, blksiz,
+				     round_down(offset, blksiz));
+		if (err < 0)
+			return ERR_PTR(err);
+		if (err != blksiz)
+			return ERR_PTR(-EIO);
+		buf->blocknr = blknr;
+	}
+	return buf->base + erofs_blkoff(sbi, offset);
+}
+
+void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi)
+{
+	buf->sbi = sbi;
+	buf->vf = &sbi->bdev;
+}
+
+void *erofs_read_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
+			 erofs_off_t offset)
+{
+	erofs_init_metabuf(buf, sbi);
+	return erofs_bread(buf, offset, true);
+}
+
 int __erofs_map_blocks(struct erofs_inode *inode,
 		       struct erofs_map_blocks *map, int flags)
 {
-- 
2.43.5


