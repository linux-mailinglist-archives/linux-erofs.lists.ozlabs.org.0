Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8BF688DB0
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:02:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7L6X1j00z3f72
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:02:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7L692LFBz3cf2
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:01:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VamyBZQ_1675393309;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VamyBZQ_1675393309)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:49 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 6/9] erofs: implement .read_iter for page cache sharing
Date: Fri,  3 Feb 2023 11:01:40 +0800
Message-Id: <20230203030143.73105-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
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
 fs/erofs/fscache.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4fe7f23b022e..bdeb048b78b5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -410,8 +410,31 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
+						  struct iov_iter *iter)
+{
+	struct file *realfile = iocb->ki_filp->private_data;
+	struct erofs_fscache_finfo *finfo = realfile->private_data;
+	ssize_t res;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (!is_sync_kiocb(iocb))
+		return filemap_read(iocb, iter, 0);
+
+	iov_iter_truncate(iter, file_inode(iocb->ki_filp)->i_size - iocb->ki_pos);
+	iocb->ki_filp = realfile;
+	iocb->ki_pos += finfo->pa;
+
+	res = filemap_read(iocb, iter, 0);
+	iocb->ki_pos -= finfo->pa;
+	return res;
+}
+
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_fscache_share_file_read_iter,
 	.open		= erofs_fscache_share_file_open,
 	.release	= erofs_fscache_share_file_release,
 };
-- 
2.19.1.6.gb485710b

