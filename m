Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A689568114
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2019 21:30:52 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45mxbF3gG2zDqW2
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 05:30:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u4fFnlVL"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45mxb955fCzDqVk
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2019 05:30:42 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id c73so6418311pfb.13
 for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jul 2019 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=eUgOsSoDwxIlF0H3cgK6Fynb3DsymiiOqY9RE3kZjDc=;
 b=u4fFnlVLQkUDCYQBgO25nNHnj/6vilfjPXVM7saSf1Zm1BnOec5dLP9xjE3qjeK8a+
 bRYCLUt+EUSXB4j+QURWtsRcIWEUZu+R8j2Pxx0wdIg+QMvGrXjBhJhZgxYp9xi8InEV
 1+07rxwfdJmDS7xA3zcil2jZf0AcBeeGnv1xEuJQxLb/cgaMShCOEcvfajd/hhf+27x0
 aoaxhvkRshfjwjWEwB+oVLvl3CB+LLjhwGwE3r7JMqWhcHNIICWlVIoxX/i0ITxlAp7k
 hPAurV3KUCh7cEBtKcwAGq/uIObov3V6aUuHCtpYGOrwgJ64NzLkz6Wb0RMdRi9pAf9u
 avtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eUgOsSoDwxIlF0H3cgK6Fynb3DsymiiOqY9RE3kZjDc=;
 b=n1ykP7DRQeFgdpXw3pGlSa1PONGUqwsJH2HZO4I+ekjIP038AHH3IN9UDq/PpAOu8R
 XsJ6w+CvVO5OjnTYbIpEDN+TcEUf9p+GpzoF1zZZUxKqQwnA5mRJKhbWYhvp5KtBeq6b
 2nSM6MYEdNafYsVZyEf1zL/u8PTtC74eUvdumJi8OweGFc/euNv/wF29p3UZMGnPhv4r
 b7s2X70TDKYrEL1msur+P9PgY8AfwPXeYOqKEEzdnfY6L/LwdBKSfLs5vd49UlA+IQjn
 gRp1C2gXPoPxjaQwYSUT0R3AYZuSL2Wa0/HcwPUW61JQ97A+Cq5KQjh5BPMz87U51mkm
 Mgcg==
X-Gm-Message-State: APjAAAU2jF6HtDqPfSC22fyP/IBK5ZOG++O8z/Crk5zyVAx5sKxyBuET
 5vyUau1lGc+gqCnUXWJ+Miw=
X-Google-Smtp-Source: APXvYqxZ4bVQgmQFTCyI9NWYkn43zoV+ipmcEAfetoTHL+1/AWb0tE2Z8ysQS8Y2j634+HQSruLv+g==
X-Received: by 2002:a63:455c:: with SMTP id u28mr2741201pgk.416.1563132638780; 
 Sun, 14 Jul 2019 12:30:38 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.10])
 by smtp.gmail.com with ESMTPSA id c98sm15029005pje.1.2019.07.14.12.30.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 12:30:37 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: gaoxiang25@huawei.com,
	linux-erofs@lists.ozlabs.org,
	yuchao0@huawei.com
Subject: [PATCH] Staging: erofs:converting all 'unsigned' to 'unsigned int'
Date: Mon, 15 Jul 2019 01:00:19 +0530
Message-Id: <20190714193019.9816-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Pratik Shinde <pratikshinde320@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fixing checkpath warnings : converting all 'unsigned' to 'unsigned int'

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 drivers/staging/erofs/internal.h      |  6 +++---
 drivers/staging/erofs/unzip_pagevec.h | 10 +++++-----
 drivers/staging/erofs/unzip_vle.h     |  8 ++++----
 drivers/staging/erofs/xattr.h         | 10 +++++-----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 963cc1b..daae90b 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -359,8 +359,8 @@ struct erofs_vnode {
 	unsigned char inode_isize;
 	unsigned short xattr_isize;
 
-	unsigned xattr_shared_count;
-	unsigned *xattr_shared_xattrs;
+	unsigned int xattr_shared_count;
+	unsigned int *xattr_shared_xattrs;
 
 	union {
 		erofs_blk_t raw_blkaddr;
@@ -510,7 +510,7 @@ erofs_grab_bio(struct super_block *sb,
 	return bio;
 }
 
-static inline void __submit_bio(struct bio *bio, unsigned op, unsigned op_flags)
+static inline void __submit_bio(struct bio *bio, unsigned int op, unsigned int op_flags)
 {
 	bio_set_op_attrs(bio, op, op_flags);
 	submit_bio(bio);
diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index 7af0ba8..198b556 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -54,9 +54,9 @@ static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
 
 static inline struct page *
 z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
-			       unsigned nr)
+			       unsigned int nr)
 {
-	unsigned index;
+	unsigned int index;
 
 	/* keep away from occupied pages */
 	if (ctor->next)
@@ -64,7 +64,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
 
 	for (index = 0; index < nr; ++index) {
 		const erofs_vtptr_t t = ctor->pages[index];
-		const unsigned tags = tagptr_unfold_tags(t);
+		const unsigned int tags = tagptr_unfold_tags(t);
 
 		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
 			return tagptr_unfold_ptr(t);
@@ -91,8 +91,8 @@ z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
 }
 
 static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
-					     unsigned nr,
-					     erofs_vtptr_t *pages, unsigned i)
+					     unsigned int nr,
+					     erofs_vtptr_t *pages, unsigned int i)
 {
 	ctor->nr = nr;
 	ctor->curr = ctor->next = NULL;
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index ab509d75..df91ad1 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -34,7 +34,7 @@ struct z_erofs_vle_work {
 	unsigned short nr_pages;
 
 	/* L: queued pages in pagevec[] */
-	unsigned vcnt;
+	unsigned int vcnt;
 
 	union {
 		/* L: pagevec */
@@ -124,7 +124,7 @@ union z_erofs_onlinepage_converter {
 	unsigned long *v;
 };
 
-static inline unsigned z_erofs_onlinepage_index(struct page *page)
+static inline unsigned int z_erofs_onlinepage_index(struct page *page)
 {
 	union z_erofs_onlinepage_converter u;
 
@@ -164,7 +164,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
 	}
 
 	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
-		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned)down);
+		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
 	if (cmpxchg(p, o, v) != o)
 		goto repeat;
 }
@@ -172,7 +172,7 @@ static inline void z_erofs_onlinepage_fixup(struct page *page,
 static inline void z_erofs_onlinepage_endio(struct page *page)
 {
 	union z_erofs_onlinepage_converter u;
-	unsigned v;
+	unsigned int v;
 
 	DBG_BUGON(!PagePrivate(page));
 	u.v = &page_private(page);
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 35ba5ac..2fc9b43 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -20,14 +20,14 @@
 /* Attribute not found */
 #define ENOATTR         ENODATA
 
-static inline unsigned inlinexattr_header_size(struct inode *inode)
+static inline unsigned int inlinexattr_header_size(struct inode *inode)
 {
 	return sizeof(struct erofs_xattr_ibody_header)
 		+ sizeof(u32) * EROFS_V(inode)->xattr_shared_count;
 }
 
 static inline erofs_blk_t
-xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)
+xattrblock_addr(struct erofs_sb_info *sbi, unsigned int xattr_id)
 {
 #ifdef CONFIG_EROFS_FS_XATTR
 	return sbi->xattr_blkaddr +
@@ -37,8 +37,8 @@ xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)
 #endif
 }
 
-static inline unsigned
-xattrblock_offset(struct erofs_sb_info *sbi, unsigned xattr_id)
+static inline unsigned int
+xattrblock_offset(struct erofs_sb_info *sbi, unsigned int xattr_id)
 {
 	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
 }
@@ -49,7 +49,7 @@ extern const struct xattr_handler erofs_xattr_trusted_handler;
 extern const struct xattr_handler erofs_xattr_security_handler;
 #endif
 
-static inline const struct xattr_handler *erofs_xattr_handler(unsigned index)
+static inline const struct xattr_handler *erofs_xattr_handler(unsigned int index)
 {
 static const struct xattr_handler *xattr_handler_map[] = {
 	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
-- 
2.9.3

