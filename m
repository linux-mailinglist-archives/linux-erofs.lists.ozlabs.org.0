Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517D9C8573
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 10:01:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpvKD0bT8z2ywS
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 20:01:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731574894;
	cv=none; b=PRBLLQi3f8oUqwnNyRj7LcvuxFAHAJeJmnZnwAtrsp/BuCdSUibybRRgUPG2Ddn9Z0+7eOxOa0cTfObU6aqwcIikR4AvQ3183sDzgVajMDo/Z1vsfZChH4nQTJd4F8237suFheckknsb6YofCVBZp8m52D3yhAJdxOxTtmiZKbvnPbq6O4TbKiPKEkeD1bejPwmTM9RGnHYIUs0vF5vxpnbf7CD8Nwdn6wOUWjs/TgJTsgjvAYe2n9WuWncSDqUPMH5Aao4M/in5Bh1EmEAYuShiK8gx2eqVWYPYL3UZd9k6PcvOgFRLISm55Eb5jvKVGHfKrpnXBpZoyGk3J4Xueg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731574894; c=relaxed/relaxed;
	bh=lKJhvBz42dMu4u3F31pUKEvxu7rYUsd8zDXVB+ulGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZH27iANU/Z2Z841IlDvc9zlDN/X3ylshkPmrwQi3X2L5kkqNJ/iSVIbW3dssB2BSeBPC+Dc8RlDyjYunILocNHBBAs99yJRLfb3zKGs0cEUecyPhIBAnVLR9M/Nxn6ybTXoeprGYqI4AJR58BomIccvWAbEcDnyZZi9p/3D4VmOPxPVeOiYaMT7ZCR3uyVzrhaO6FMdvimgLUqBbqIxAJFghG8Ocp4GmklN6RVDxeafUDMvQuCj5lvmujz9aNkyqgjKEHhG3BabEk6xqe/7KbbYsTgGySlDwfGPPeob5SVqBiwAqj4MTn/kLjZRg9SHLjWi7yVe9RBVp6z8DFFVFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XII3BJaa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XII3BJaa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpvK41Z64z2ynL
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 20:01:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731574879; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lKJhvBz42dMu4u3F31pUKEvxu7rYUsd8zDXVB+ulGXU=;
	b=XII3BJaanGL4V3+HdIwSFFDH4jGEbNCWqrkwE4oSGptzp5ZVa/K8b3Lpir0oA3CyrVlBbK4Kctajr8ErLsBuaMZgJ/x67l6v1o+Lbn6KVUeo7j7IbN1ooJbBEB/gMH3GDPGkgujVb6j/GKF7oMl4sEfWyIxanxhy8+KXR0aF9BI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJOA42p_1731574872 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 17:01:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix file-backed mounts over FUSE
Date: Thu, 14 Nov 2024 17:01:09 +0800
Message-ID: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzbot reported a null-ptr-deref in fuse_read_args_fill:
 fuse_read_folio+0xb0/0x100 fs/fuse/file.c:905
 filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
 do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 erofs_bread+0x34d/0x7e0 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:281 [inline]
 erofs_fc_fill_super+0x2b9/0x2500 fs/erofs/super.c:625

Unlike most filesystems, some network filesystems and FUSE need
unavoidable valid `file` pointers for their read I/Os [1].
Anyway, those use cases need to be supported too.

[1] https://docs.kernel.org/filesystems/vfs.html
Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com
Fixes: fb176750266a ("erofs: add file-backed mount support")
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20241114051957.419551-1-hsiangkao@linux.alibaba.com
changes since v1 (suggested by Al):
 - rename `filp` to `file`;
 - don't use union for `mapping` and `file`.

 fs/erofs/data.c     | 8 +++++---
 fs/erofs/internal.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..f741c3847ff2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
+					index, buf->file) :
+			read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
+		buf->file = sbi->fdev;
 	else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5459d0b39415..9844ee8a07e5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -209,6 +209,7 @@ enum erofs_kmap_type {
 
 struct erofs_buf {
 	struct address_space *mapping;
+	struct file *file;
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
-- 
2.43.5

