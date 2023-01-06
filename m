Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C26600BC
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 13:59:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NpNh22F79z3c9S
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 23:58:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NpNgk0x57z3c4Y
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 23:58:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-Iakh_1673009615;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-Iakh_1673009615)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:36 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 5/6] erofs: implement .mmap for page cache sharing
Date: Fri,  6 Jan 2023 20:53:29 +0800
Message-Id: <20230106125330.55529-6-jefflexu@linux.alibaba.com>
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

In mmap(2), replace vma->vm_file with the anonymous file associated with
the blob, so that the vma will be linked to the address_space of the
blob.

One thing worth noting is that, we return error early in mmap(2) if
users attempt to map beyond the file size.  Normally filesystems won't
restrict this in mmap(2).  The checking is done in the fault handler,
and SIGBUS will be signaled to users if they actually attempt to access
the area beyond the end of the file.  However since vma->vm_file has
been changed to the anonymous file in mmap(2), we can no way derive the
file size of the original file.  As file size is immutable in ro
filesystem, let's fail early in mmap(2) in this case.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 1f2a42dd1590..98341d4d9c0d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -379,9 +379,46 @@ static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
 	return already_read ? already_read : ret;
 }
 
+static const struct vm_operations_struct erofs_fscache_share_file_vm_ops = {
+	.fault = filemap_fault,
+};
+
+static int erofs_fscache_share_file_mmap(struct file *file,
+					 struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	/* since page cache sharing is enabled only when i_size <= chunk_size */
+	struct erofs_map_blocks map = {}; /* .m_la = 0 */
+	struct erofs_map_dev mdev;
+	int ret;
+
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
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
+	vma_set_file(vma, mdev.m_fscache->file);
+	vma->vm_pgoff = (mdev.m_pa >> PAGE_SHIFT) + vma->vm_pgoff;
+	vma->vm_ops = &erofs_fscache_share_file_vm_ops;
+
+	file_accessed(file);
+	return 0;
+}
+
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_fscache_share_file_read_iter,
+	.mmap		= erofs_fscache_share_file_mmap,
 };
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
-- 
2.19.1.6.gb485710b

