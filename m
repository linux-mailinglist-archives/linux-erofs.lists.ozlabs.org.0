Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D00547469
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 14:02:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKxKC5FjJz3bsK
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 22:02:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gRVZ7uiR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gRVZ7uiR;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKxK80dmXz3bpw
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 22:02:19 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 76C15B80B4D
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 12:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB6C34116;
	Sat, 11 Jun 2022 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654948936;
	bh=OfVEk1+55vCPCgAZlhVLafSMvBIkuEzPvNLbBDWHWms=;
	h=From:To:Cc:Subject:Date:From;
	b=gRVZ7uiRwezrWIQ1a4kb0sGTnmZdBuv5aFFFSi85KVBhdXgppPA/dqIqLJXQboDXZ
	 iEkbrLjMhtIS5P1KIvUpDLxHBBHrrVK+45VTveWZhV8avxO4JiZnWHqJzLp8OVQW8s
	 N3y8Usbbz/OUvknnHLFw8m9SC5Z1U/ePHW5jVXkrsyyAsrqEoWCj8Ev9dnBCtlMa/j
	 c4nqYEwsErV6AfCDiT6gPd6T93/Qg/VATW7SaqH6Hhx7WRyGCgDhKJ1Y+lGo0nGdft
	 cYcTFZcjEGjaBl8KLr5pocxK5ZQCa2sOXfNzX6zFbxPlq/RvCWKRMt9po9iKBsvvMn
	 kafoobsQR1/fw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use EROFS_BLKSIZ unconditionally
Date: Sat, 11 Jun 2022 20:01:35 +0800
Message-Id: <20220611120135.363323-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Use EROFS_BLKSIZ only in the codebase and just warn potential
incompatible PAGE_SIZE.

It fixes,
http://autobuild.buildroot.net/results/2daa0f7a7418f7491b8b4c5495904abb86efa809/build-end.log

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/internal.h | 2 +-
 lib/compressor.c         | 4 ++--
 lib/data.c               | 6 +++---
 lib/dir.c                | 2 +-
 lib/namei.c              | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2686570..6a70f11 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -36,7 +36,7 @@ typedef unsigned short umode_t;
 
 /* no obvious reason to support explicit PAGE_SIZE != 4096 for now */
 #if PAGE_SIZE != 4096
-#error incompatible PAGE_SIZE is already defined
+#warning EROFS may be incompatible on your platform
 #endif
 
 #ifndef PAGE_MASK
diff --git a/lib/compressor.c b/lib/compressor.c
index 3666496..a46bc39 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -76,8 +76,8 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 	c->compress_threshold = 100;
 
 	/* optimize for 4k size page */
-	c->destsize_alignsize = PAGE_SIZE;
-	c->destsize_redzone_begin = PAGE_SIZE - 16;
+	c->destsize_alignsize = EROFS_BLKSIZ;
+	c->destsize_redzone_begin = EROFS_BLKSIZ - 16;
 	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
 
 	if (!alg_name) {
diff --git a/lib/data.c b/lib/data.c
index e57707e..6bc554d 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -22,7 +22,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
-	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 	lastblk = nblocks - tailendpacking;
 
 	/* there is no hole in flatmode */
@@ -37,8 +37,8 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 			vi->xattr_isize + erofs_blkoff(map->m_la);
 		map->m_plen = inode->i_size - offset;
 
-		/* inline data should be located in one meta block */
-		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+		/* inline data should be located in the same meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
 			erofs_err("inline data cross block boundary @ nid %" PRIu64,
 				  vi->nid);
 			DBG_BUGON(1);
diff --git a/lib/dir.c b/lib/dir.c
index 8955931..e6b9283 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -148,7 +148,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
+		    nameoff >= EROFS_BLKSIZ) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
 				  nameoff, dir->nid | 0ULL, lblk);
 			return -EFSCORRUPTED;
diff --git a/lib/namei.c b/lib/namei.c
index 8e9867d..7b69a59 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -212,7 +212,7 @@ int erofs_namei(struct nameidata *nd,
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
+		    nameoff >= EROFS_BLKSIZ) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
 			return -EFSCORRUPTED;
-- 
2.30.2

