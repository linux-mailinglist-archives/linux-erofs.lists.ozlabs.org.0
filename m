Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99349C9660
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 00:47:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqGz13hPwz30Vs
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 10:47:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731628027;
	cv=none; b=aeBa1KHSJfcRW74zvGnKc3BFqcTPM0RwDr1Fv9pCxf42svdzqsGvpdC7SZxecUMEsh9//cSr2J0quefB/0NAFyC4rffak+7kJM7v4M108vlj/+eErLBKUK+lL8x+FN8Jjgq8fB6Gff5qhNhcZfVBlmQdykOS6FYiUQh1xEbDGMtf3TFaI4k8wMQc2eUpQd8WIs5yHgF8jOTn7AEq7DlJT3sw/DhIflE8oBNTg1Yd9hXTruCdwrSSMOzERWfhZ9dhZI+dH8M8sNbcStvdn/fjQ4O4UASBWtiXVPA0NFyQEZj+HSYCmzkCTKLBHV8RnYxuMjFj4mKlI9dS5BXoxOL2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731628027; c=relaxed/relaxed;
	bh=NBLWn+9ZRmZh4zgtQxM7V9zX0Xit4je+p0sF89bHnbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QubgD3jb9llsb7mc3wYhvcHoElSK9/AyjYXcMrntuom73VqSuWTSJsSHGa27fwFRRhZs5ki3sHz7sOEeH/39hsTWNjU0gFQw2JY45qA4Gm0TvU8Tfn90OB+BktqaKD1nxb5Zltf1u56bfpmA4TOsapJP22sPOaWPMvTPt6mrAqE1ZLHQdcC6uQfAiZFMDe/pJshIf1qEQnQBnV2Akui57Jb/xzJR1Buy90OS18pSAWgVnEeIWTqtl5r1MAuIJMrNsSh8+BhsFj7zue/P7XEzNoj6qEerGE+TUx5DBUWZaMkPxsvYi6oc17lmU5STtkJfnp0ZdsVPltPqtlp+Jh2Zbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fi1ViBQX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fi1ViBQX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqGys4Br5z2ykx
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 10:46:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731628014; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NBLWn+9ZRmZh4zgtQxM7V9zX0Xit4je+p0sF89bHnbk=;
	b=Fi1ViBQXNObtUxQFHZEaE/0weMndoMzYIQ16Bv+pDE8BERXO+eUf7NH7vJcUH+G5eGAY362yb/H3X4e+niNo+/ftm2v9rfZXB6VBhaH82BUTyFqgfjwrX+27/KBfDLrADafesqgljrkCUTBmkC6ocW8AiZ0nP1Xg75Q4DWv6ACs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJQR2BP_1731628007 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 07:46:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix file-backed mounts over FUSE
Date: Fri, 15 Nov 2024 07:46:46 +0800
Message-ID: <20241114234646.1870545-1-hsiangkao@linux.alibaba.com>
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
 fs/erofs/data.c     | 10 ++++++----
 fs/erofs/internal.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..db4bde4c0852 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,7 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = read_mapping_folio(buf->mapping, index, buf->file);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,9 +61,11 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
-	else if (erofs_is_fscache_mode(sb))
+	buf->file = NULL;
+	if (erofs_is_fileio_mode(sbi)) {
+		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->mapping = buf->file->f_mapping;
+	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
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

