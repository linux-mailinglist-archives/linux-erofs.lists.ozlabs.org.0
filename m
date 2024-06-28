Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 758AC91B70C
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 08:31:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9QYw32cVz3ck4
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 16:31:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9QYk37Pdz3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 16:31:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9QYQ0s4Yz4f3l1s
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:30:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5D4931A0170
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 14:31:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgBXwIWfWH5mZZVAAg--.52859S8;
	Fri, 28 Jun 2024 14:31:02 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: [PATCH v3 4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
Date: Fri, 28 Jun 2024 14:29:25 +0800
Message-Id: <20240628062930.2467993-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBXwIWfWH5mZZVAAg--.52859S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrCw4xuryruryfCFykKrg_yoW8ZrWkpF
	Wa9F18Ary8ur48Gr1kAFs8Jw1F934UJ3Wqvw1UW34Ivw1kX34rXry3tr1YvF1UCrW8twsr
	ta15CFy3try5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkH-xJQAAsJ
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, libaokun@huaweicloud.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr()
is not passed to ret, so it ends up returning -ESTALE, which leads to an
endless loop as follows:

cachefiles_acquire_volume
retry:
  ret = cachefiles_check_volume_xattr
    ret = -ESTALE
    xlen = vfs_getxattr // return -EIO
    // The ret is not updated when xlen < 0, so -ESTALE is returned.
    return ret
  // Supposed to jump out of the loop at this judgement.
  if (ret != -ESTALE)
      goto error_dir;
  cachefiles_bury_object
    //  EIO causes rename failure
  goto retry;

Hence propagate the error returned by vfs_getxattr() to avoid the above
issue. Do the same in cachefiles_check_auxdata().

Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
Fixes: 72b957856b0c ("cachefiles: Implement metadata/coherency data storage in xattrs")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..4dd8a993c60a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -110,9 +110,11 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	if (xlen == 0)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
-		if (xlen < 0)
+		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
 						   cachefiles_trace_getxattr_error);
+		}
 		if (xlen == -EIO)
 			cachefiles_io_error_obj(
 				object,
@@ -252,6 +254,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 		xlen = vfs_getxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache, buf, len);
 	if (xlen != len) {
 		if (xlen < 0) {
+			ret = xlen;
 			trace_cachefiles_vfs_error(NULL, d_inode(dentry), xlen,
 						   cachefiles_trace_getxattr_error);
 			if (xlen == -EIO)
-- 
2.39.2

