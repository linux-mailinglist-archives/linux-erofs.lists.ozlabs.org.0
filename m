Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A144AE9C0
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:01:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5N2C7Jz3cN3
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:01:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq56668mz2yfc
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zflly_1644386476; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zflly_1644386476) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:17 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 06/22] erofs: use meta buffers for erofs_read_superblock()
Date: Wed,  9 Feb 2022 14:00:52 +0800
Message-Id: <20220209060108.43051-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The only change is that, meta buffers read cache page without __GFP_FS
flag, which shall not matter.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 915eefe0d7e2..12755217631f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -281,21 +281,19 @@ static int erofs_init_devices(struct super_block *sb,
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
-	struct page *page;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	void *data;
 	int ret;
 
-	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
-	if (IS_ERR(page)) {
+	data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
+	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
-		return PTR_ERR(page);
+		return PTR_ERR(data);
 	}
 
 	sbi = EROFS_SB(sb);
-
-	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -365,8 +363,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (erofs_sb_has_ztailpacking(sbi))
 		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 out:
-	kunmap(page);
-	put_page(page);
+	erofs_put_metabuf(&buf);
 	return ret;
 }
 
-- 
2.27.0

