Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9459FAC17
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 10:41:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YGtLh23skz3029
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 20:41:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734946858;
	cv=none; b=gskTvrPev1nC6jU8rgaEedSER2cxx09rOfFCS78GAPJpb2bFhYu9yzgtvRhvlmXJW/fkzDrUNCgBCQbfJTzKViC8+wJIt6JGja0RZDTU7vHoEmq6vwHscCB7h6wTlegZajOJCjxHPbrEB5zkooV3U67uy4Rbu9z8EWMcSJbt3QQsM1DzaO8GIsqyoSQtcTpb4JbmsEPbKjwEd0yfJOH4YDIDBV6cgWU0a7M4rn4Wg4L8H9XsM/qmZQlHnT/mYwbCBG3mJaFCEKmvgtatshN66CjWw4B5bfLyRnGY5xLKeAB4/PDpFgxdC8pUMWOV2znINjQnsH0VLRQQ5PuHIIgCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734946858; c=relaxed/relaxed;
	bh=b/hRYQ7wo+ldh3WG3TSMA7E08lXTVEuykbmR8bvzyls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuK/I1UKW8TV5YoLllNWyE5Th8avPqoJOvM9WOfAtWGcVMPaRz7jcphPstBO1LZduwaMeXoo9FBzCIobWZ3Gto3B3UyK9TiB1d0JagxyjiJYYxr3OBqH08iHHy2OyJihi45b8ZAhNd4cHoarOfkiHSQDjMGETkLhC2H9lJ0ylMZhdO4w3vUzYSzh1jEi6Y8OsUbBP2/WcNIbCf57j+qi14fh/viQUja/krcrpyMCN+9GGtQjxh55+f6/34CWtdaQ4k1r2pyhezFulkZ+/+vLPNb2JZ9HxBam5Zvv2XD/qVaKm9i41X9VaBkyxZJUUkHldeVim09MH8FASyt8lqm46g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MY061uie; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MY061uie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YGtLY4bJSz2yjV
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Dec 2024 20:40:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734946846; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=b/hRYQ7wo+ldh3WG3TSMA7E08lXTVEuykbmR8bvzyls=;
	b=MY061uiec373yMDOoW59JxsGoi/htxD0+Wn9/OHrhbrFkSXWMTFrz910chsQUcK47JGuW9tAABBlq8AKI6fk+BzCk1risaGvl3tEnJaBmVAVi8zHPBNI4YCESnfPSbKSONymalPc0vvZexjpPb7lPJuTWxPyzpFqhbaho5Etx9k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WM2Leqe_1734946840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Dec 2024 17:40:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: allow disabling fragment deduplication
Date: Mon, 23 Dec 2024 17:40:31 +0800
Message-ID: <20241223094031.1534175-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Neal Gompa <ngompa13@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, although fragment compression is already multi-threaded,
the data parts of inodes prior to their own fragments are still
single-threaded if fragment deduplication is on.  This can greatly
slow down `-Eall-fragments` image building at least for the current
mkfs codebase.

Let's add an extended option `-E^fragdedupe` to explicitly disable it.

After this commit, the Fedora Kiwi builds I'm testing can be reduced
from 1148s (3,096,842,240 bytes, 2.9G) to 137s (2,969,956,352 bytes,
2.8G) with `-Eall-fragments,^fragdedupe -C524288 -z lzma,level=6,
dictsize=524288` on Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz with
32 cores.

Cc: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Anyway, it's just a quick fix for faster image builds, but I think
`-E^fragdedupe` is also useful in the future, since it may produce
smaller builds if `-Ededupe` is off.

 include/erofs/config.h |  1 +
 lib/compress.c         |  3 ++-
 mkfs/main.c            | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index bb03e70..47e4d00 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_fragments;
 	bool c_all_fragments;
 	bool c_dedupe;
+	bool c_nofragdedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
diff --git a/lib/compress.c b/lib/compress.c
index 917916e..6ac9c75 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1527,7 +1527,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * Handle tails in advance to avoid writing duplicated
 	 * parts into the packed inode.
 	 */
-	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+	    !cfg.c_nofragdedupe) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
 			goto err_free_ictx;
diff --git a/mkfs/main.c b/mkfs/main.c
index 1f4b7c6..7d559d9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -306,6 +306,15 @@ static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
 	return 0;
 }
 
+static int erofs_mkfs_feat_set_fragdedupe(bool en, const char *val,
+					  unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+	cfg.c_nofragdedupe = !en;
+	return 0;
+}
+
 static struct {
 	char *feat;
 	int (*set)(bool en, const char *val, unsigned int len);
@@ -315,6 +324,7 @@ static struct {
 	{"fragments", erofs_mkfs_feat_set_fragments},
 	{"all-fragments", erofs_mkfs_feat_set_all_fragments},
 	{"dedupe", erofs_mkfs_feat_set_dedupe},
+	{"fragdedupe", erofs_mkfs_feat_set_fragdedupe},
 	{NULL, NULL},
 };
 
-- 
2.43.5

