Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BE64549D
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 08:32:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRprz5nmHz3bdS
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 18:32:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRprq3YnVz30RJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 18:32:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWkgY0j_1670398323;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWkgY0j_1670398323)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 15:32:05 +0800
Date: Wed, 7 Dec 2022 15:32:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v6] erofs-utils: mkfs: support fragment deduplication
Message-ID: <Y5BBcie3vNZ7arc2@B-P7TQMD6M-0146.local>
References: <20221207054743.15069-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207054743.15069-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 07, 2022 at 01:47:43PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Previously, there's no fragment deduplication when this feature is
> introduced.  Let's support it now.
> 
> Fragments are deduplicated before compression, so that duplicated
> parts will not be written into the packed inode.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>


I'd like to submit it with minor update:

diff --git a/lib/compress.c b/lib/compress.c
index 6b79096..b205aa6 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -349,8 +349,8 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 	inode->fragmentoff += inode->fragment_size - newsize;
 	inode->fragment_size = newsize;

-	erofs_dbg("Reducing fragment size to %u at %lu",
-		  inode->fragment_size, inode->fragmentoff);
+	erofs_dbg("Reducing fragment size to %u at %llu",
+		  inode->fragment_size, inode->fragmentoff | 0ULL);

 	/* it's the end */
 	ctx->head += newsize;
diff --git a/lib/fragments.c b/lib/fragments.c
index e855467..e69ae47 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -22,10 +22,10 @@ struct erofs_fragment_dedupe_item {

 #define EROFS_TOF_HASHLEN		16

-#define FRAGMENT_HASHTABLE_SIZE		65536
-#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
+#define FRAGMENT_HASHSIZE		65536
+#define FRAGMENT_HASH(c)		((c) & (FRAGMENT_HASHSIZE - 1))

-static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
+static struct list_head dupli_frags[FRAGMENT_HASHSIZE];

 static FILE *packedfile;
 const char *frags_packedname = "packed_file";
@@ -98,8 +98,8 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	inode->fragment_size = di->nr_dup;
 	inode->fragmentoff = di->pos + di->length - di->nr_dup;

-	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
-		  inode->fragmentoff);
+	erofs_dbg("Dedupe %u tail data at %llu", inode->fragment_size,
+		  inode->fragmentoff | 0ULL);
 out:
 	free(data);
 	return ret;
@@ -156,7 +156,7 @@ static void z_erofs_fragments_dedupe_init(void)
 {
 	unsigned int i;

-	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
+	for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
 		init_list_head(&dupli_frags[i]);
 }

@@ -166,12 +166,9 @@ static void z_erofs_fragments_dedupe_exit(void)
 	struct list_head *head;
 	unsigned int i;

-	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
+	for (i = 0; i < FRAGMENT_HASHSIZE; ++i) {
 		head = &dupli_frags[i];

-		if (list_empty(head))
-			continue;
-
 		list_for_each_entry_safe(di, n, head, list)
 			free(di);
 	}

