Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC979C8255
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 06:20:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XppPx4xjQz2ytJ
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 16:20:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731561619;
	cv=none; b=CUcNleeqkAtTXLRXr4DSkOWVPhBzsFr1tIi/UfWM5XuUFiE1ZsCsR5F/vzbuPk9SIQ53a3AsgmUKaWNYIAWAdn+rCk2mIBXO2bEor6DwoBZY8KQK/2l1c7DXNYv3heB4osCAxihoGhY94QYmCmr7NMDv64cisufJJ+rT5qt7sdhh9DRusWR3Guwsv7O6snpnnThaWUKETw0Bg3YMQTeTAU6BqsntSm495d64r8p6wQJCSl+XcQNNk4hilzXeNmYjtXeCFHBxO4dcH8Qvlz18Vt6bMo28xIdY67wLsQ7qV9VD/5ciXZyPwGXnRo2maRCLsjlTxytFf9Y/gvsnFKZfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731561619; c=relaxed/relaxed;
	bh=LBovoTp6LXztaTEv4dhpi+GGkF4r/KEIcGS31ovBYVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9vX3mLoACGVSBcvrf969oIitj/Fdgrg6MXDYMi1nK9PRM/YVyHzy6JI2LLo21WHnmSrkpRGfQ7YE/DSVLW1geV9pkzK5qgwHwENi17PuG94U+xb/EF1V2X2PbEfB80KzIxIXswiKvdS2R3zGq+/RlTaquk7EFFtAsxvYjU+rs1AYaUpCYq+JXxGDWxsCbSVcqEU6YE9GniCSQ+1H2ZRBUBZTHuKrJCN4IbRnnGBxjp7f/eA/yHFPjUlg5twi4sMbDeK9yBwa/QV2sEQWjN0i/X0372h/j9yf5RzgeS31bfeEtHgxe/eSOuQcZ6l/5gurhqOygPMv1wiC5fqKBDbfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZeOt3Pg/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZeOt3Pg/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XppPr65wgz2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 16:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731561609; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LBovoTp6LXztaTEv4dhpi+GGkF4r/KEIcGS31ovBYVk=;
	b=ZeOt3Pg/2ejsxCwBIVv4LHu2b3KvCdh655MK+Gd6r+azsuYRpxCBCA1uprhrWPl5ffGx1QwfWJj6sltlp5RdG5VM3KetnO6hJvCJKCr5JU/WfyST/gbINleTvMNAiNQShIR+o5yTNMNJzu9a0RP8G5lm4rY+mlIFYdyRtTLyAjk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNFjtS_1731561599 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 13:20:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix file-backed mounts over FUSE
Date: Thu, 14 Nov 2024 13:19:57 +0800
Message-ID: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
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
Fixes: fb176750266a ("erofs: add file-backed mount support")
Closes: https://lore.kernel.org/r/6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 10 +++++++---
 fs/erofs/internal.h |  6 +++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6355866220ff..43c89194d348 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,7 +38,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 	}
 	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
-		folio = read_mapping_folio(buf->mapping, index, NULL);
+		folio = buf->use_fp ?
+			read_mapping_folio(file_inode(buf->filp)->i_mapping,
+				index, buf->filp) :
+			read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
 	}
@@ -61,8 +64,9 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fileio_mode(sbi))
-		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	buf->use_fp = erofs_is_fileio_mode(sbi);
+	if (buf->use_fp)	/* some fs like FUSE needs it */
+		buf->filp = sbi->fdev;
 	else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5459d0b39415..df67a1980ada 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -208,10 +208,14 @@ enum erofs_kmap_type {
 };
 
 struct erofs_buf {
-	struct address_space *mapping;
+	union {
+		struct address_space *mapping;
+		struct file *filp;
+	};
 	struct page *page;
 	void *base;
 	enum erofs_kmap_type kmap_type;
+	bool use_fp;
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-- 
2.43.5

