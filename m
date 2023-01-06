Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89BE6600BB
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 13:58:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NpNgy55sSz3c9r
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 23:58:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NpNgh3w22z3c63
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 23:58:39 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-H5YK_1673009611;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-H5YK_1673009611)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:32 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 1/6] erofs: remove unused device mapping in the meta routine
Date: Fri,  6 Jan 2023 20:53:25 +0800
Message-Id: <20230106125330.55529-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
References: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently there're two anonymous inodes (inode and anon_inode in struct
erofs_fscache) may be used for each blob.  The former is only for
bootstrap and used as the address_space of page cache, while the latter
is used for both bootstrap and data blobs when share domain mode enabled
and behaves as a sentinel in the shared domain.

In prep for the following support for page cache sharing, following
patch will unify these two anonymous inodes.  That is, the unified
anonymous inode not only acts as the address_space of page cache, but
also a sentinel in share domain mode.

However the current meta routine can't work if above change applied.
Current meta routine will make a device mapping, and superblock of the
filesystem is required to do the device mapping.  Currently the
superblock is derived from the input meta folio, which is reasonable
since the anonymous inode (used for the address_space of page cache) is
always allocated from the filesystem's sb.  However after anonymous
inodes are unified, that is no longer always true.  For example, in
share domain mode, the unified anonymous inode will be allocated from
pseudo mnt, and the superblock derived from the folio is actually a
pseudo sb, which can't be used for the device mapping at all.

As for the meta routine itself, currently metadata is always on
bootstrap, which means device mapping is not needed so far.  After
removing the redundant device mapping logic, we can derive the required
fscache_ctx from anonymous inode's i_private.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 014e20962376..03de4dc99302 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -164,18 +164,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	int ret;
-	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
 	struct erofs_fscache_request *req;
-	struct erofs_map_dev mdev = {
-		.m_deviceid = 0,
-		.m_pa = folio_pos(folio),
-	};
-
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret) {
-		folio_unlock(folio);
-		return ret;
-	}
 
 	req = erofs_fscache_req_alloc(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
@@ -184,8 +174,8 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 		return PTR_ERR(req);
 	}
 
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-				req, mdev.m_pa, folio_size(folio));
+	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
+				folio_pos(folio), folio_size(folio));
 	if (ret)
 		req->error = ret;
 
@@ -469,6 +459,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 		inode->i_size = OFFSET_MAX;
 		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+		inode->i_private = ctx;
 
 		ctx->inode = inode;
 	}
-- 
2.19.1.6.gb485710b

