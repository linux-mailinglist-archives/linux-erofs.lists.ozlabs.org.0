Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016A688DB2
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:02:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7L6b6Nfkz3f8H
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:02:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7L6B3hb4z3f5w
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:01:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vamlo-T_1675393309;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vamlo-T_1675393309)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:50 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
Date: Fri,  3 Feb 2023 11:01:41 +0800
Message-Id: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
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
 fs/erofs/fscache.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bdeb048b78b5..af6ba52bbe8b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -432,9 +432,36 @@ static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
 	return res;
 }
 
+vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
+{
+	struct erofs_fscache_finfo *finfo = vmf->vma->vm_file->private_data;
+
+	if (unlikely(vmf->pgoff >= finfo->max_idx))
+		return VM_FAULT_SIGBUS;
+	return filemap_fault(vmf);
+}
+
+static const struct vm_operations_struct erofs_fscache_share_file_vm_ops = {
+	.fault = erofs_fscache_share_fault,
+};
+
+static int erofs_fscache_share_file_mmap(struct file *file,
+					 struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
+	struct erofs_fscache_finfo *finfo = realfile->private_data;
+
+	vma_set_file(vma, realfile);
+	vma->vm_pgoff = (finfo->pa >> PAGE_SHIFT) + vma->vm_pgoff;
+	vma->vm_ops = &erofs_fscache_share_file_vm_ops;
+	file_accessed(file);
+	return 0;
+}
+
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_fscache_share_file_read_iter,
+	.mmap		= erofs_fscache_share_file_mmap,
 	.open		= erofs_fscache_share_file_open,
 	.release	= erofs_fscache_share_file_release,
 };
-- 
2.19.1.6.gb485710b

