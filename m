Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083971F8A9
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 05:02:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXSVG6sQMz3dwy
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 13:02:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXSV82QmFz3dvr
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 13:02:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vk87tDO_1685674946;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk87tDO_1685674946)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 11:02:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: don't allocate/read too large extents
Date: Fri,  2 Jun 2023 11:02:25 +0800
Message-Id: <20230602030225.113085-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Chaoming Yang <lometsj@live.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since some crafted EROFS filesystem images could have insane large
extents, which causes unexpected bahaviors when extracting data.

Fix it by extracting large extents with a buffer with a reasonable
maximum size limit and reading multiple times instead.

Note that only `--extract` option is impacted.

CVE: CVE-2023-33552
Closes: https://nvd.nist.gov/vuln/detail/CVE-2023-33552
Reported-by: Chaoming Yang <lometsj@live.com>
Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 62 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ad40537..6f89a1e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -392,6 +392,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	}
 
 	while (pos < inode->i_size) {
+		int alloc_rawsize;
+
 		map.m_la = pos;
 		if (compressed)
 			ret = z_erofs_map_blocks_iter(inode, &map,
@@ -420,10 +422,27 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
 			continue;
 
-		if (map.m_plen > raw_size) {
-			raw_size = map.m_plen;
-			raw = realloc(raw, raw_size);
-			BUG_ON(!raw);
+		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
+			if (compressed) {
+				erofs_err("invalid pcluster size %" PRIu64 " @ offset %" PRIu64 " of nid %" PRIu64,
+					  map.m_plen, map.m_la, inode->nid);
+				ret = -EFSCORRUPTED;
+				goto out;
+			}
+			alloc_rawsize = Z_EROFS_PCLUSTER_MAX_SIZE;
+		} else {
+			alloc_rawsize = map.m_plen;
+		}
+
+		if (alloc_rawsize > raw_size) {
+			char *newraw = realloc(raw, alloc_rawsize);
+
+			if (!newraw) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			raw = newraw;
+			raw_size = alloc_rawsize;
 		}
 
 		if (compressed) {
@@ -434,18 +453,25 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			}
 			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
 						    0, map.m_llen, false);
-		} else {
-			ret = erofs_read_one_data(&map, raw, 0, map.m_plen);
-		}
-		if (ret)
-			goto out;
+			if (ret)
+				goto out;
 
-		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
-					map.m_llen) < 0) {
-			erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
-				  inode->nid | 0ULL);
-			ret = -EIO;
-			goto out;
+			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
+				goto fail_eio;
+		} else {
+			u64 count, p = 0;
+
+			do {
+				count = min_t(u64, alloc_rawsize, map.m_llen);
+				ret = erofs_read_one_data(&map, raw, p, count);
+				if (ret)
+					goto out;
+
+				if (outfd >= 0 && write(outfd, raw, count) < 0)
+					goto fail_eio;
+				map.m_llen -= count;
+				p += count;
+			} while (map.m_llen);
 		}
 	}
 
@@ -460,6 +486,12 @@ out:
 	if (buffer)
 		free(buffer);
 	return ret < 0 ? ret : 0;
+
+fail_eio:
+	erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
+		  inode->nid | 0ULL);
+	ret = -EIO;
+	goto out;
 }
 
 static inline int erofs_extract_dir(struct erofs_inode *inode)
-- 
2.24.4

