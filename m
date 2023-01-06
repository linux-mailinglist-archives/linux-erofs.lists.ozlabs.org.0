Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11C6600BE
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 13:59:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NpNh81QKsz3c4Y
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 23:59:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NpNgl0s8Dz3c63
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 23:58:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-H5ZQ_1673009616;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-H5ZQ_1673009616)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:37 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 6/6] erofs: enable page cache sharing in fscache mode
Date: Fri,  6 Jan 2023 20:53:30 +0800
Message-Id: <20230106125330.55529-7-jefflexu@linux.alibaba.com>
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

Erofs supports chunk deduplication to reduce disk usage.  Furthermore we
can make inodes share page cache of these deduplicated chunks to reduce
the memory usage.  This shall be much usable in container scenarios as
deduplication is requisite for container image.

This can be achieved by managing page cache of deduplicated chunks in
blob's address space.  In this way, all inodes sharing the deduplicated
chunk will refer to and share the page cache in the blob's address
space.

So far there are some restrictions for enabling this feature.

The page cache sharing feature also supports .mmap().  The reverse
mapping requires that one vma can not be shared among inodes and can
be linked to only one inode.  As the vma will be finally linked to the
blob's address space when page cache sharing enabled, the restriction of
the reverse mapping actually requires that the mapped file area can not
be mapped to multiple blobs.  Thus page cache sharing can only be
enabled for those files mapped to one blob.

The chunk based data layout guarantees that a chunk will not cross the
device (blob) boundary.  Thus in chunk based data layout, those files
smaller than the chunk size shall be guaranteed to be mapped to one
blob.  As chunk size is tunable at a per-file basis, this restriction
can be relaxed at image building phase.  As long as we ensure that the
file can not be deduplicated, the file's chunk size can be set to a
reasonable value larger than the file size, so that the page cache
sharing feature can be enabled on this file later.

The second restriction is that EROFS_BLKSIZ mus be multiples of
PAGE_SIZE to avoid data leakage.  Otherwise unrelated data may be
exposed at the end of the last page, since file's data is arranged in
unit of EROFS_BLKSIZ in the image.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/inode.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..8fe9b29422b5 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -241,6 +241,29 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	return 0;
 }
 
+static bool erofs_can_share_page_cache(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	/* enable page cache sharing only in share domain mode */
+	if (!erofs_is_fscache_mode(inode->i_sb) ||
+	    !EROFS_SB(inode->i_sb)->domain_id)
+		return false;
+
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
+		return false;
+
+	/* avoid crossing multi devicces/blobs */
+	if (inode->i_size > 1UL << vi->chunkbits)
+		return false;
+
+	/* avoid data leakage in mmap routine */
+	if (EROFS_BLKSIZ % PAGE_SIZE)
+		return false;
+
+	return true;
+}
+
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -262,6 +285,10 @@ static int erofs_fill_inode(struct inode *inode)
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		else if (erofs_can_share_page_cache(inode))
+			inode->i_fop = &erofs_fscache_share_file_fops;
+#endif
 		else
 			inode->i_fop = &erofs_file_fops;
 		break;
-- 
2.19.1.6.gb485710b

