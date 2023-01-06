Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E406600BD
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 13:59:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NpNh44Ckdz3cB7
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 23:59:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.6; helo=out30-6.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NpNgk1VXBz3c63
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 23:58:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-Jgw5_1673009614;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-Jgw5_1673009614)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:35 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 4/6] erofs: implement .read_iter for page cache sharing
Date: Fri,  6 Jan 2023 20:53:28 +0800
Message-Id: <20230106125330.55529-5-jefflexu@linux.alibaba.com>
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

When page cache sharing enabled, page caches are managed in the address
space of blobs rather than erofs inodes.  All erofs inodes sharing one
chunk will refer to and share the page cache in the blob's address
space.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ea276884f043..1f2a42dd1590 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -320,6 +320,70 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static const struct file_operations erofs_fscache_meta_fops = {};
 
+static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct inode *inode = file_inode(filp);
+	/* since page cache sharing is enabled only when i_size <= chunk_size */
+	struct erofs_map_blocks map = {}; /* .m_la = 0 */
+	struct erofs_map_dev mdev;
+	struct folio *folio;
+	ssize_t already_read = 0;
+	int ret = 0;
+
+	/* no need taking (shared) inode lock since it's a ro filesystem */
+	if (!iov_iter_count(to))
+		return 0;
+
+	if (IS_DAX(inode) || iocb->ki_flags & IOCB_DIRECT)
+		return -EOPNOTSUPP;
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+	ret = erofs_map_dev(inode->i_sb, &mdev);
+	if (ret)
+		return ret;
+
+	do {
+		size_t bytes, copied, offset, fsize;
+		pgoff_t index = (mdev.m_pa >> PAGE_SHIFT) + (iocb->ki_pos >> PAGE_SHIFT);
+
+		folio = read_cache_folio(mdev.m_fscache->inode->i_mapping, index, NULL, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		fsize = folio_size(folio);
+		offset = iocb->ki_pos & (fsize - 1);
+		bytes = min_t(size_t, inode->i_size - iocb->ki_pos, iov_iter_count(to));
+		bytes = min_t(size_t, bytes, fsize - offset);
+		copied = copy_folio_to_iter(folio, offset, bytes, to);
+		folio_put(folio);
+		iocb->ki_pos += copied;
+		already_read += copied;
+		if (copied < bytes) {
+			ret = -EFAULT;
+			break;
+		}
+	} while (iov_iter_count(to) && iocb->ki_pos < inode->i_size);
+
+	file_accessed(filp);
+	return already_read ? already_read : ret;
+}
+
+const struct file_operations erofs_fscache_share_file_fops = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_fscache_share_file_read_iter,
+};
+
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
 	mutex_lock(&erofs_domain_list_lock);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 24d471fe2fa4..386e2fd4c025 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -617,6 +617,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
+extern const struct file_operations erofs_fscache_share_file_fops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-- 
2.19.1.6.gb485710b

