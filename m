Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD26AAC44
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 20:58:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PTbHr6YfDz3cMR
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Mar 2023 06:58:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PTbHg0BmXz3cCF
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Mar 2023 06:58:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vd47EU._1677959898;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd47EU._1677959898)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 03:58:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: handle mmap failure when packing a whole file
Date: Sun,  5 Mar 2023 03:58:11 +0800
Message-Id: <20230304195812.120063-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
References: <20230304195732.119053-1-hsiangkao@linux.alibaba.com>
 <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Directly read/write if mmap failure.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index ebff4b5..30e9ba6 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -223,14 +223,39 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 	if (offset < 0)
 		return -errno;
 
-	memblock = mmap(NULL, inode->i_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (memblock == MAP_FAILED)
-		return -EFAULT;
-
 	inode->fragmentoff = (erofs_off_t)offset;
 	inode->fragment_size = inode->i_size;
 
-	if (fwrite(memblock, inode->fragment_size, 1, packedfile) != 1) {
+	memblock = mmap(NULL, inode->i_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (memblock == MAP_FAILED || !memblock) {
+		unsigned long long remaining = inode->fragment_size;
+
+		memblock = NULL;
+		while (remaining) {
+			char buf[32768];
+			unsigned int sz = min_t(unsigned int, remaining,
+						sizeof(buf));
+
+			rc = read(fd, buf, sz);
+			if (rc != sz) {
+				if (rc < 0)
+					rc = -errno;
+				else
+					rc = -EAGAIN;
+				goto out;
+			}
+			if (fwrite(buf, sz, 1, packedfile) != 1) {
+				rc = -EIO;
+				goto out;
+			}
+			remaining -= sz;
+		}
+		rc = lseek(fd, 0, SEEK_SET);
+		if (rc < 0) {
+			rc = -errno;
+			goto out;
+		}
+	} else if (fwrite(memblock, inode->fragment_size, 1, packedfile) != 1) {
 		rc = -EIO;
 		goto out;
 	}
@@ -238,10 +263,12 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
 		  inode->fragmentoff);
 
-	rc = z_erofs_fragments_dedupe_insert(memblock, inode->fragment_size,
-					     inode->fragmentoff, tofcrc);
+	if (memblock)
+		rc = z_erofs_fragments_dedupe_insert(memblock,
+			inode->fragment_size, inode->fragmentoff, tofcrc);
 out:
-	munmap(memblock, inode->i_size);
+	if (memblock)
+		munmap(memblock, inode->i_size);
 	return rc;
 }
 
-- 
2.24.4

