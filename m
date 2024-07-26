Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388493CC9E
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 04:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721959305;
	bh=G90gV5zP5qUtBN8fY4+7Wa3m6K8IkI8vt/VNMLQahDM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=UE5+VxnrWBTkWQPBO6FQCeDAFQJ9BK8tEvqUcMAY6xr6ck2qgdoyRCiusnRxU3x1h
	 U3G9R/z3BVJhd/t7mGZ4t7OpC/MlUIegChogGWjID3fZIHCr/u2E5SN9/LnotXmkPe
	 v+dC2Ffkm9/rYJXstFINvQzc1X3A3HfSk7u2dKwiwvZZgCinI9YelizI/x0Z53IJxW
	 z64nUTWg03IGmZX0mVw66pYpu8JOdZp3z9F4UBqBReTudqPzckxJncVPwBRrR8KFjT
	 FY5Zbth7PQ83YIzHsd1WOM5TFGvABMgQT1rlW56Ge5XM7S6I57x9teXsKwGDPbS/IU
	 nzTdU3DpeDqvQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVWG15Hqlz3d9s
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 12:01:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVWFv17YQz30Wg
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 12:01:36 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WVWF42tGWzxTwk;
	Fri, 26 Jul 2024 10:00:56 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E5BED18009F;
	Fri, 26 Jul 2024 10:01:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 10:01:00 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
Subject: [PATCH v2] erofs: support direct IO for ondemand mode
Date: Fri, 26 Jul 2024 10:06:27 +0800
Message-ID: <20240726020627.2873693-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs over fscache cannot handle the direct read io. When the file
is opened with O_DIRECT flag, -EINVAL will reback. We support the
DIO in erofs over fscache by bypassing the erofs page cache and
reading target data into ubuf from fscache's file directly.

The alignment for buffer memory, offset and size now is restricted
by erofs, since `i_blocksize` is enough for the under filesystems.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - Change the directIO helper name to erofs_fscache_direct_io
  - Add some io interception when begin direct io
  - Optimize the direct io logical in erofs_fscache_data_read_slice

v1:
  - https://lore.kernel.org/linux-erofs/6f1a5c1c-d44d-4561-9377-b935ff4531f2@huawei.com/T/#t
---
 fs/erofs/data.c    |  3 ++
 fs/erofs/fscache.c | 84 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..dbfafe358de4 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -391,6 +391,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     iov_iter_alignment(to)) & blksize_mask)
 			return -EINVAL;
 
+		if (erofs_is_fscache_mode(inode->i_sb))
+			return generic_file_read_iter(iocb, to);
+
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, NULL, 0);
 	}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..e3e6c579eb81 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -35,6 +35,8 @@ struct erofs_fscache_io {
 
 struct erofs_fscache_rq {
 	struct address_space	*mapping;	/* The mapping being accessed */
+	struct iov_iter		*iter;		/* Destination for direct io */
+	struct completion	done;		/* Sync for direct io */
 	loff_t			start;		/* Start position */
 	size_t			len;		/* Length of the request */
 	size_t			submitted;	/* Length of submitted */
@@ -76,7 +78,11 @@ static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
 {
 	if (!refcount_dec_and_test(&req->ref))
 		return;
-	erofs_fscache_req_complete(req);
+
+	if (req->iter)
+		complete(&req->done);
+	else
+		erofs_fscache_req_complete(req);
 	kfree(req);
 }
 
@@ -88,6 +94,7 @@ static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *ma
 	if (!req)
 		return NULL;
 	req->mapping = mapping;
+	req->iter = NULL;
 	req->start = start;
 	req->len = len;
 	refcount_set(&req->ref, 1);
@@ -258,6 +265,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	struct address_space *mapping = req->mapping;
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
+	struct iov_iter *dest_iter = req->iter;
 	struct erofs_fscache_io *io;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
@@ -270,33 +278,45 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	if (ret)
 		return ret;
 
+	count = req->len - req->submitted;
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		struct iov_iter iter;
-		size_t size = map.m_llen;
+		struct iov_iter *iterp;
+		size_t size = min_t(size_t, map.m_llen, count);
 		void *src;
+		ssize_t filled = 0;
 
 		src = erofs_read_metabuf(&buf, sb, map.m_pa, EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
-		if (copy_to_iter(src, size, &iter) != size) {
+		iterp = (dest_iter) ?: &iter;
+		if (copy_to_iter(src, size, iterp) != size) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
-		iov_iter_zero(PAGE_SIZE - size, &iter);
+
+		filled += size;
+		if (!dest_iter) {
+			iov_iter_zero(PAGE_SIZE - size, iterp);
+			filled += (PAGE_SIZE - size);
+		}
+
 		erofs_put_metabuf(&buf);
-		req->submitted += PAGE_SIZE;
+		req->submitted += filled;
 		return 0;
 	}
 
-	count = req->len - req->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		struct iov_iter iter;
 
-		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
-		iov_iter_zero(count, &iter);
+		if (!dest_iter) {
+			iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
+			iov_iter_zero(count, &iter);
+		}
+
 		req->submitted += count;
 		return 0;
 	}
@@ -315,9 +335,17 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	io = erofs_fscache_req_io_alloc(req);
 	if (!io)
 		return -ENOMEM;
-	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
+
+	if (dest_iter)
+		iov_iter_ubuf(&io->iter, ITER_DEST,
+			dest_iter->ubuf + dest_iter->iov_offset, count);
+	else
+		iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
+
 	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
 			mdev.m_pa + (pos - map.m_la), io);
+	if (dest_iter)
+		iov_iter_advance(dest_iter, io->iter.iov_offset);
 	erofs_fscache_req_io_put(io);
 
 	req->submitted += count;
@@ -373,6 +401,43 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 	erofs_fscache_req_put(req);
 }
 
+static ssize_t erofs_fscache_direct_io(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	size_t count = iov_iter_count(iter);
+	size_t i_size = i_size_read(file->f_inode);
+	struct erofs_fscache_rq *req;
+	struct completion *ctr;
+	ssize_t rsize;
+	int ret;
+
+	if (unlikely(iov_iter_rw(iter) == WRITE))
+		return -EROFS;
+
+	if (unlikely(iocb->ki_pos >= i_size))
+		return 0;
+
+	if (count + iocb->ki_pos > i_size)
+		count = i_size - iocb->ki_pos;
+
+	if (!count)
+		return 0;
+
+	req = erofs_fscache_req_alloc(file->f_mapping, iocb->ki_pos, count);
+	if (!req)
+		return -ENOMEM;
+
+	req->iter = iter;
+	init_completion(&req->done);
+	ctr = &req->done;
+	ret = erofs_fscache_data_read(req);
+	rsize = (ret == 0) ? (ssize_t)req->submitted : ret;
+	erofs_fscache_req_put(req);
+	wait_for_completion(ctr);
+
+	return rsize;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
 	.read_folio = erofs_fscache_meta_read_folio,
 };
@@ -380,6 +445,7 @@ static const struct address_space_operations erofs_fscache_meta_aops = {
 const struct address_space_operations erofs_fscache_access_aops = {
 	.read_folio = erofs_fscache_read_folio,
 	.readahead = erofs_fscache_readahead,
+	.direct_IO = erofs_fscache_direct_io,
 };
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
-- 
2.34.1

