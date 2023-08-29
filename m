Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5978CBB7
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 20:07:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YxtfCmyF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZwPw3SDNz3bYc
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 04:07:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YxtfCmyF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZwPr2WBfz2ygT
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 04:07:44 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 15F5E63CA3;
	Tue, 29 Aug 2023 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800F5C433C9;
	Tue, 29 Aug 2023 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693332460;
	bh=1CDXNyUw4y5DM7LJfAZa2+z3r8AtGNR77PlV9HtaVY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxtfCmyFcqxOrS5csGoLeHwtQZZi0BTPHpiieEle6peAvLC34LtDBRtsZbOE5Z2tV
	 4J6HB2yhwNgWmoXi1CMJv4kKvd0/yR49rTUsQFN0vHTYJUSLNd1MYeksal5779NifC
	 KEr2rSt2PkX25Mi/4ZXOZdNJ/oU7aUwVO5ETn9pzPMgcpkJsIDDktFWMqHvAobQ5PO
	 7HpjoU4VXRhSJofe76+R/0CfCQ9kvYlvlPNGRL5xIamzQAG59LnSwzqIqQxSQnKp1E
	 tTYTnzLpScWVTUqsLNWWI2lrWS0pSeBuTwTwTalbw9b+1AwTGxH1Om05rAROHKldph
	 zKGVeqs4GroAQ==
Date: Wed, 30 Aug 2023 02:07:35 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v7 0/3] erofs-utils: introduce xattr name bloom filter
Message-ID: <ZO4z5/l3bVC6aE+8@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230829145504.93567-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829145504.93567-1-jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 29, 2023 at 10:55:01PM +0800, Jingbo Xu wrote:
> changes since v6:
> - patch 1: polish license disclaimer; tweak included headers (Gao Xiang)
> - patch 2: drop unused `EROFS_XATTR_NAME_LEN_MAX`; polish commit message
>   (Gao Xiang)
> - patch 3: add warning when failed to calculate hashbit; tweak code of
>   assigning `header->h_name_filter` (Gao Xiang)
>

Applied with several update by hand, also I tend to append the following
patch:

From 3142cab6c82a779096abbd24d8bd1b9b555997ac Mon Sep 17 00:00:00 2001
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Wed, 30 Aug 2023 01:54:46 +0800
Subject: [PATCH] erofs-utils: mkfs: enable xattr name filter feature by
 default

Turn it on by default since it's a compatible feature.  Instead,
it can be disabled explicitly with "-E^xattr-name-filter".

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/xattr.h |  2 +-
 lib/inode.c           |  4 ++--
 lib/xattr.c           |  6 +++++-
 mkfs/main.c           | 13 +++++++++++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 748442a..cf02257 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -76,7 +76,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
-char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
+char *erofs_export_xattr_ibody(struct erofs_inode *inode);
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path);
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
diff --git a/lib/inode.c b/lib/inode.c
index d54f84f..85eacab 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -574,8 +574,8 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	off += inode->inode_isize;
 
 	if (inode->xattr_isize) {
-		char *xattrs = erofs_export_xattr_ibody(&inode->i_xattrs,
-							inode->xattr_isize);
+		char *xattrs = erofs_export_xattr_ibody(inode);
+
 		if (IS_ERR(xattrs))
 			return false;
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 65dd9a0..0cab29f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -843,8 +843,10 @@ static u32 erofs_xattr_filter_map(struct list_head *ixattrs)
 	return EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
 }
 
-char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
+char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 {
+	struct list_head *ixattrs = &inode->i_xattrs;
+	unsigned int size = inode->xattr_isize;
 	struct inode_xattr_node *node, *n;
 	struct erofs_xattr_ibody_header *header;
 	LIST_HEAD(ilst);
@@ -860,6 +862,8 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	if (cfg.c_xattr_name_filter) {
 		header->h_name_filter =
 			cpu_to_le32(erofs_xattr_filter_map(ixattrs));
+		if (header->h_name_filter)
+			erofs_sb_set_xattr_filter(inode->sbi);
 	}
 
 	p = sizeof(struct erofs_xattr_ibody_header);
diff --git a/mkfs/main.c b/mkfs/main.c
index fad80b1..1d136a9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -145,6 +145,7 @@ static int parse_extended_opts(const char *opts)
 
 	value = NULL;
 	for (token = opts; *token != '\0'; token = next) {
+		bool clear = false;
 		const char *p = strchr(token, ',');
 
 		next = NULL;
@@ -168,6 +169,14 @@ static int parse_extended_opts(const char *opts)
 			vallen = 0;
 		}
 
+		if (token[0] == '^') {
+			if (keylen < 2)
+				return -EINVAL;
+			++token;
+			--keylen;
+			clear = true;
+		}
+
 		if (MATCH_EXTENTED_OPT("legacy-compress", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -249,8 +258,7 @@ handle_fragment:
 		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_xattr_name_filter = true;
-			erofs_sb_set_xattr_filter(&sbi);
+			cfg.c_xattr_name_filter = !clear;
 		}
 	}
 	return 0;
@@ -695,6 +703,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
+	cfg.c_xattr_name_filter = true;
 	sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
-- 
2.30.2

