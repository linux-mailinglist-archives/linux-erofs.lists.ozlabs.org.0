Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFCE6AAC45
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 20:58:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PTbHv3Nkwz3cKb
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Mar 2023 06:58:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PTbHg4c13z3cdr
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Mar 2023 06:58:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vd47EUI_1677959899;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd47EUI_1677959899)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 03:58:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: dedupe more in the packed inode if possible
Date: Sun,  5 Mar 2023 03:58:12 +0800
Message-Id: <20230304195812.120063-5-hsiangkao@linux.alibaba.com>
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

In addition to just compare the in-memory data.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c  |  3 ++-
 lib/fragments.c | 25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index f38c795..afa3bf7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -371,7 +371,8 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 		  inode->fragment_size, inode->fragmentoff | 0ULL);
 
 	/* it's the end */
-	ctx->head += newsize;
+	DBG_BUGON(ctx->tail - ctx->head + ctx->remaining != newsize);
+	ctx->head = ctx->tail;
 	ctx->remaining = 0;
 	return true;
 }
diff --git a/lib/fragments.c b/lib/fragments.c
index 30e9ba6..0366c82 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -55,6 +55,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	struct list_head *head;
 	u8 *data;
 	unsigned int length, e2, deduped;
+	erofs_off_t pos;
 	int ret;
 
 	head = &dupli_frags[FRAGMENT_HASH(crc)];
@@ -112,9 +113,31 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 		goto out;
 
 	DBG_BUGON(di->length < deduped);
+	pos = di->pos + di->length - deduped;
+	/* let's read more to dedupe as long as we can */
+	if (deduped == di->length) {
+		fflush(packedfile);
+
+		while(deduped < inode->i_size && pos) {
+			char buf[2][16384];
+			unsigned int sz = min_t(unsigned int, pos,
+						sizeof(buf[0]));
+
+			if (pread(fileno(packedfile), buf[0], sz,
+				  pos - sz) != sz)
+				break;
+			if (pread(fd, buf[1], sz,
+				  inode->i_size - deduped - sz) != sz)
+				break;
 
+			if (memcmp(buf[0], buf[1], sz))
+				break;
+			pos -= sz;
+			deduped += sz;
+		}
+	}
 	inode->fragment_size = deduped;
-	inode->fragmentoff = di->pos + di->length - deduped;
+	inode->fragmentoff = pos;
 
 	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
 		  inode->fragmentoff | 0ULL);
-- 
2.24.4

