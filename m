Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8F77B03E
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKxD4JYdz3c3t
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKws5Cv4z2yVg
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpepBJk_1691984566;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpepBJk_1691984566)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:47 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 06/13] erofs-utils: lib: make erofs_get_unhashed_chunk() global
Date: Mon, 14 Aug 2023 11:42:32 +0800
Message-Id: <20230814034239.54660-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

... so that it could be called from outside blobchunk.c later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/blobchunk.h | 2 ++
 lib/blobchunk.c           | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 010aee1..fb85d8e 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -14,6 +14,8 @@ extern "C"
 
 #include "erofs/internal.h"
 
+struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
+		erofs_blk_t blkaddr, erofs_off_t sourceoffset);
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd);
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index cada5bb..07f18bd 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -38,7 +38,7 @@ struct erofs_blobchunk erofs_holechunk = {
 };
 static LIST_HEAD(unhashed_blobchunks);
 
-static struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
+struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 		erofs_blk_t blkaddr, erofs_off_t sourceoffset)
 {
 	struct erofs_blobchunk *chunk;
-- 
2.19.1.6.gb485710b

