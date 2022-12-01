Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC463EE93
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 11:58:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNCjs12rRz3bXR
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 21:58:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.6; helo=out30-6.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNCjl5gTrz30Qq
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 21:58:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=0;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW8aXKh_1669892309;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW8aXKh_1669892309)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 18:58:30 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: split inline data reading and tail zeroing in fscache mode
Date: Thu,  1 Dec 2022 18:58:29 +0800
Message-Id: <20221201105829.90692-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Prior to this patch, the INLINE routine will also zero the tail part of
the folio.  This is reasonable since currently for each file, only the
tail part over EROFS_BLKSIZ boundary is stored as tail packing format,
and thus the tail part in the same folio is treated as EOF and shall be
zeroed.

Since we have supported large folios now and
erofs_fscache_data_read_slice() can be called multiple times for each
folio or folio range, for tail packing format, we can defer zeroing the
EOF part to the UNMAPPED routine in the next calling of
erofs_fscache_data_read_slice().  This cleanup makes the INLINE routine
focusing on reading inline data, while zeroing is left to the UNMAPPED
routine.

Besides, make the naming consistent among INLINE/UNMAPPED/MAPPED
routines.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2: rename 'size' to 'count' to make git diff statistics more cleaner,
while v1 renames 'count' to 'size'

v1: https://lore.kernel.org/all/20221201075018.27925-1-jefflexu@linux.alibaba.com/
---
 fs/erofs/fscache.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f14886c479bd..c9bf59aac5ac 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -214,35 +214,32 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		erofs_blk_t blknr;
-		size_t offset, size;
+		size_t offset;
 		void *src;
 
 		/* For tail packing layout, the offset may be non-zero. */
 		offset = erofs_blkoff(map.m_pa);
 		blknr = erofs_blknr(map.m_pa);
-		size = map.m_llen;
+		count = map.m_llen;
 
 		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
-		if (copy_to_iter(src + offset, size, &iter) != size) {
+		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
+		if (copy_to_iter(src + offset, count, &iter) != count) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
-		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		primary->submitted += PAGE_SIZE;
-		return 0;
+		goto out;
 	}
 
 	count = primary->len - primary->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		primary->submitted += count;
-		return 0;
+		goto out;
 	}
 
 	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
@@ -263,6 +260,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
 			req, mdev.m_pa + (pos - map.m_la), count);
 	erofs_fscache_req_put(req);
+out:
 	primary->submitted += count;
 	return ret;
 }
-- 
2.19.1.6.gb485710b

