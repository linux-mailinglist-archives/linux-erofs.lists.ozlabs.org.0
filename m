Return-Path: <linux-erofs+bounces-992-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3CB4A851
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Sep 2025 11:40:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLf240YLTz3cYx;
	Tue,  9 Sep 2025 19:40:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757410827;
	cv=none; b=LkXQePSAjR7FCLOB++Kf5p+nFNISFyAvpTDzcFL+/AkRzllV++FGQe5il6dlGViwPUVlJYhU0Lgffo9CWmdfV9ZWYPWuwH3fWKwOnqkQb3Y7IXodHpLGjsItY2QZh4iF5NUnVj82vAX16UMuBrZnUxBsbXtNo/CV/+ZELWYsTeXXEU75rBBctfXnxDMVSXvkmZ3ErhHtKz4gyoJgec229TgO2ep/219PvHhNvoC/UMMZayIrRusKUQWBTR9jzmGKnD53fUc7ZW05PHG4SX80rL2F8U6zga5/3pcKQpW28uvruUss5ZC1yeT3sdP3TUMZHd45T4cRnmThU2fRDgFH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757410827; c=relaxed/relaxed;
	bh=ZNfEDEpbZjrhKSXaAMHJxzrNbYPRB5zhRbWsjv79Hl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkTEDz/S4y6XERHODvzvWPEPmvBX3YdrayN6RQcZBFyO8yx/vJaUb8ghTYSSsV93dg+EtJZ6vKjpxQzJFUqHsgQEt5lF7SYFKK85oQfIc61QnVi2gbORFTCaz+fyh6SN3EMMvodnf/+X/oJ2vab4z6RAV+eqUefzHEc1IJ7xpIFYdckNRZUcgUfO1pHJUZ6RiSieeax/PoAOJfk/IqEkXPtFFFLoCg966Iu/8Jqmh8EJWiHmOKk3OcdtEMwDZZ8JvqTCTXtIVVwq9O4CYlgBfysYYy/IK6QCHL1oTAn7D884n6Ibi7k1OtlLWgYZNSKe++qS/ABw0SwGCFfUwncJxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NS/zePXn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NS/zePXn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cLf2175Fqz3cYR
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Sep 2025 19:40:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757410821; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZNfEDEpbZjrhKSXaAMHJxzrNbYPRB5zhRbWsjv79Hl0=;
	b=NS/zePXnpzV/IZobrFjfKrJ4m9QXICb8I+MzKEsyMhvZ7WAzrKC+g67TjzfvfSEq1J8jRdqIWM1wNJTFa/GmNF5BdTp+YEPSY6CMk+/PzNcexW9MdkvE2T7pyrWGBJiSF9FTs4dkT5Kz/8mAREMJbg5U5qZLuR7hSOjettcg3/I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WndX0hl_1757410818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 17:40:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: lib: migrate `c_ignore_mtime`
Date: Tue,  9 Sep 2025 17:40:13 +0800
Message-ID: <20250909094014.875652-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250909094014.875652-1-hsiangkao@linux.alibaba.com>
References: <20250909094014.875652-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |  1 -
 include/erofs/importer.h |  1 +
 lib/config.c             |  1 -
 lib/inode.c              | 18 +++++++++++-------
 mkfs/main.c              |  6 +++---
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 6554ad2..67f5aa3 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,7 +53,6 @@ struct erofs_configure {
 	bool c_all_fragments;
 	bool c_dedupe;
 	char c_fragdedupe;
-	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 85e3a50..a5a4c8c 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -26,6 +26,7 @@ struct erofs_importer_params {
 	u32 gid_offset;
 	u32 fsalignblks;
 	char force_inodeversion;
+	bool ignore_mtime;
 	bool no_datainline;
 	bool hard_dereference;
 	bool ovlfs_strip;
diff --git a/lib/config.c b/lib/config.c
index 28bfc2f..b1d076d 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -29,7 +29,6 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
-	cfg.c_ignore_mtime = false;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
diff --git a/lib/inode.c b/lib/inode.c
index 0bb82f8..75a0b4d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -717,7 +717,7 @@ int erofs_iflush(struct erofs_inode *inode)
 	    inode->u.i_blocks > UINT32_MAX) {
 		nb.blocks_hi = cpu_to_le16(inode->u.i_blocks >> 32);
 	} else if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
-		 inode->u.i_blkaddr > UINT32_MAX) {
+		   inode->u.i_blkaddr > UINT32_MAX) {
 		nb.startblk_hi = cpu_to_le16(inode->u.i_blkaddr >> 32);
 		if (inode->u.i_blkaddr == EROFS_NULL_ADDR) {
 			nlink_1 = false;
@@ -744,8 +744,7 @@ int erofs_iflush(struct erofs_inode *inode)
 
 		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
 		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
-		if (!cfg.c_ignore_mtime)
-			u.dic.i_mtime = cpu_to_le64(inode->i_mtime - sbi->epoch);
+		u.dic.i_mtime = cpu_to_le64(inode->i_mtime - sbi->epoch);
 		u.dic.i_u = u1;
 
 		if (nlink_1) {
@@ -1076,7 +1075,9 @@ out:
 static bool erofs_should_use_inode_extended(struct erofs_importer *im,
 				struct erofs_inode *inode, const char *path)
 {
-	if (im->params->force_inodeversion == EROFS_FORCE_INODE_EXTENDED)
+	const struct erofs_importer_params *params = im->params;
+
+	if (params->force_inodeversion == EROFS_FORCE_INODE_EXTENDED)
 		return true;
 	if (inode->i_size > UINT_MAX)
 		return true;
@@ -1088,10 +1089,13 @@ static bool erofs_should_use_inode_extended(struct erofs_importer *im,
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if (!erofs_is_special_identifier(path) && !cfg.c_ignore_mtime &&
+	if (!erofs_is_special_identifier(path) &&
 	    !erofs_sb_has_48bit(inode->sbi) &&
-	    inode->i_mtime != inode->sbi->epoch)
-		return true;
+	    inode->i_mtime != inode->sbi->epoch) {
+		if (!params->ignore_mtime)
+			return true;
+		inode->i_mtime = inode->sbi->epoch;
+	}
 	return false;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 4f52656..1b5cb2b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -463,7 +463,7 @@ static int parse_extended_opts(struct erofs_importer_params *params,
 			if (vallen)
 				return -EINVAL;
 			params->force_inodeversion = EROFS_FORCE_INODE_COMPACT;
-			cfg.c_ignore_mtime = true;
+			params->ignore_mtime = true;
 		} else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -1170,10 +1170,10 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			cfg.c_blobdev_path = optarg;
 			break;
 		case 14:
-			cfg.c_ignore_mtime = true;
+			params->ignore_mtime = true;
 			break;
 		case 15:
-			cfg.c_ignore_mtime = false;
+			params->ignore_mtime = false;
 			break;
 		case 16:
 			errno = 0;
-- 
2.43.5


