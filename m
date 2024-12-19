Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949C9F74F3
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 07:43:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDLc92y1Xz3c6y
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 17:43:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734590631;
	cv=none; b=XgeNr6w606ZYoXOUAjNaT2Bz1+aPSfjce2NSzLZ7iXfdBO/X8nImvrPJB84aJp+wnzIUv8k+hgYbQJoncLZTiwWxzNhdTo8+7w4+ZbKM5yg7eDAC+Bx4oK4C8wuzIgjCQ7g0mp3y2YlrxgpywK41MkOIH31PVVi3V2nqcNW0U5+4kqne9h3BdMBcUfCZqaRgCrf/Zf6/we3bCHjk+3QIVkUKNjmvwn+5KjR8Mmi8xG4bfWLmfMxloH1T0BCvMabGXHx9lIulr+WwO2Pb3OGhxtlzrxmmXV0JyXwuqg5u8xFcfKMvxL6QGcBLO4IPL4QessGYd15CigmAbjTHuVftxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734590631; c=relaxed/relaxed;
	bh=LxrH7tM1uJF9Nok9485ITyIfY2terkm7c/7hcWreI8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWxYRONOnDqcNlSsBoaC/FeWeaiNVy2Z/Uu5+BPakYcDJlczv/tUKGCJHbiuv+lZlSAZJUIaCt2hFFizdh0UpJJWvEBMtGhqZO0x/05wjVcfq2ycBEf/2aZLhWDCY8KR/4PsYMsetDUo7uLSYoGyG5VdoccXYKzNENVv8j7o8oB7PFSA0zeg9J0w65/bU0NfzQsf4CGgYz7SgQLqnglH/XbU4iTe/LL3Fl9GPcELtuzM7iKtNeG1jxU7x1ZZBcPXaiFqcKwO2VaHG2WJ+QJbdi7YQdSPNZkMce53jwM1Mj5oPAtbU1yeQ5D9Js4+HK/26kviK9kKkMlNl65yIdRjeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ot6aukL4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ot6aukL4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDLc41JPCz2yD8
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2024 17:43:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734590624; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LxrH7tM1uJF9Nok9485ITyIfY2terkm7c/7hcWreI8Y=;
	b=Ot6aukL4jPpoaBvdVwcsweWKDB60TD1p9S8FM6bWUHlPHe1H/Weocqy1oUpTXt2eMXbor28dL4d4ouF1h1KNuq8ljxTZFXwrlI3jNttH4NqlJKA3sjTNYdjilauPLWTfJITanjqNn6ov/veOTNHxMWKBIKXpRLkbtw5KrAqYgNk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLpMVL._1734590622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 14:43:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/4] erofs-utils: mkfs: support data alignment
Date: Thu, 19 Dec 2024 14:43:31 +0800
Message-ID: <20241219064331.2223001-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
References: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

The underlay block storage could work in a stripe-like manner to improve
performance and space efficiency.

EROFS on-disk layout is flexible enough for such use cases.

Cc: Changpeng Liu <changpeliu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  3 +++
 lib/cache.c           | 25 ++++++++++++++++++++-----
 man/mkfs.erofs.1      |  3 +++
 mkfs/main.c           | 11 +++++++++++
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index d8559a8..6ff80ab 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -67,6 +67,9 @@ struct erofs_bufmgr {
 
 	/* last mapped buffer block to accelerate erofs_mapbh() */
 	struct erofs_buffer_block *last_mapped_block;
+
+	/* align data block addresses to multiples of `dsunit` */
+	unsigned int dsunit;
 };
 
 static inline const int get_alignsize(struct erofs_sb_info *sbi, int type,
diff --git a/lib/cache.c b/lib/cache.c
index cb05466..d3e2e62 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -156,10 +156,15 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 	bb = NULL;
 
 	/* try to find a most-fit mapped buffer block first */
-	if (size + inline_ext >= blksiz)
+
+	if (__erofs_unlikely(bmgr->dsunit > 1)) {
+		used_before = blksiz - alignsize;
+	} else if (size + inline_ext >= blksiz) {
 		goto skip_mapped;
+	} else {
+		used_before = rounddown(blksiz - (size + inline_ext), alignsize);
+	}
 
-	used_before = rounddown(blksiz - (size + inline_ext), alignsize);
 	for (; used_before; --used_before) {
 		struct list_head *bt = bmgr->mapped_buckets[type] + used_before;
 
@@ -181,7 +186,7 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      inline_ext, true);
 		if (ret < 0) {
-			DBG_BUGON(1);
+			DBG_BUGON(!(bmgr->dsunit > 1));
 			continue;
 		}
 
@@ -324,10 +329,20 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 static void __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
-	erofs_blk_t blkaddr;
+	erofs_blk_t blkaddr = bmgr->tail_blkaddr;
 
 	if (bb->blkaddr == NULL_ADDR) {
-		bb->blkaddr = bmgr->tail_blkaddr;
+		bb->blkaddr = blkaddr;
+		if (__erofs_unlikely(bmgr->dsunit > 1) && bb->type == DATA) {
+			struct erofs_buffer_block *pb = list_prev_entry(bb, list);
+
+			bb->blkaddr = roundup(blkaddr, bmgr->dsunit);
+			if (pb != &bmgr->blkh &&
+			    pb->blkaddr + pb->buffers.nblocks >= blkaddr) {
+				DBG_BUGON(pb->blkaddr + pb->buffers.nblocks > blkaddr);
+				pb->buffers.nblocks = bb->blkaddr - pb->blkaddr;
+			}
+		}
 		bmgr->last_mapped_block = bb;
 		erofs_bupdate_mapped(bb);
 	}
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 0093839..ee84163 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -149,6 +149,9 @@ the given primary algorithm, alternative algorithms can be specified with
 are extended regular expressions, matched against absolute paths within
 the output filesystem, with no leading /.
 .TP
+.BI "\-\-dsunit=" #
+Align all data block addresses to multiples of #.
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple
diff --git a/mkfs/main.c b/mkfs/main.c
index 9ca7dad..1f4b7c6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -86,6 +86,7 @@ static struct option long_options[] = {
 	{"all-time", no_argument, NULL, 526},
 	{"sort", required_argument, NULL, 527},
 	{"hard-dereference", no_argument, NULL, 528},
+	{"dsunit", required_argument, NULL, 529},
 	{0, 0, 0, 0},
 };
 
@@ -162,6 +163,7 @@ static void usage(int argc, char **argv)
 		" --blobdev=X           specify an extra device X to store chunked data\n"
 		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
 		" --clean=X             run full clean build (default) or:\n"
+		" --dsunit=#            align all data block addresses to multiples of #\n"
 		" --incremental=X       run incremental build\n"
 		"                       (X = data|rvsp; data=full data, rvsp=space is allocated\n"
 		"                                       and filled with zeroes)\n"
@@ -243,6 +245,7 @@ static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
+static unsigned int dsunit;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -856,6 +859,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 528:
 			cfg.c_hard_dereference = true;
 			break;
+		case 529:
+			dsunit = strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid dsunit %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1318,6 +1328,7 @@ int main(int argc, char **argv)
 		}
 		sb_bh = NULL;
 	}
+	g_sbi.bmgr->dsunit = dsunit;
 
 	/* Use the user-defined UUID or generate one for clean builds */
 	if (valid_fixeduuid)
-- 
2.43.5

