Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A018769DCB3
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Feb 2023 10:17:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PLYbL3mDyz3c5D
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Feb 2023 20:17:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PLYbB5HTpz30Jy
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Feb 2023 20:17:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcBkPn9_1676971040;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcBkPn9_1676971040)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 17:17:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: pass accurate blob size to prepare_ondemand_read()
Date: Tue, 21 Feb 2023 17:17:18 +0800
Message-Id: <20230221091719.126127-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
References: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

To make fscache mode support PAGE_SIZE larger than 4KB, the blob image
size may be small than the multiples of PAGE_SIZE (as erofs block size
is no larger than 4KB), while the file range of the blob requested to
read is multiples of PAGE_SIZE and may be larger than the blob image
size.

Therefore we need the accurate blob size, so that the EOF part could be
distinguished and zero-filled then.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 87ff35bff8d5..f7a1e147d0f4 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -125,7 +125,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 	DBG_BUGON(len > req->len - req->submitted);
 
-	ret = fscache_begin_read_operation(cres, cookie);
+	ret = fscache_begin_wait_operation(cres, cookie, FSCACHE_WANT_READ);
 	if (ret)
 		return ret;
 
@@ -134,8 +134,17 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 		size_t slen = len - done;
 		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
 
+		if (sstart >= cookie->object_size) {
+			iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
+					lstart + done, slen);
+			iov_iter_zero(slen, &iter);
+			done += slen;
+			continue;
+		}
+
+		slen = min_t(size_t, slen, cookie->object_size - sstart);
 		source = cres->ops->prepare_ondemand_read(cres,
-				sstart, &slen, LLONG_MAX, &flags, 0);
+				sstart, &slen, cookie->object_size, &flags, 0);
 		if (WARN_ON(slen == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-- 
2.19.1.6.gb485710b

