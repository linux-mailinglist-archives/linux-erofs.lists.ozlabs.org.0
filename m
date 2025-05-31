Return-Path: <linux-erofs+bounces-375-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A4AC98A2
	for <lists+linux-erofs@lfdr.de>; Sat, 31 May 2025 02:30:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b8Lbj43Fqz2xRw;
	Sat, 31 May 2025 10:30:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748651409;
	cv=none; b=WLByxT53a4woaANznXjlJhpcJqjfKc+K9ztIxrKyxlK/yw/zNLh0w78zXnnoqLLuMgFCHNagIT1HtYuJPekbzC9syrKrdJ3cSGfM/2IO4F9JUcbe4hOXHVeT7oNWsd6UyBOEfRif80XtiCHvS8VlTY6i1n6/UcSWhkf5PvN7Wfk7yjjYIVFkdB4wj59OenZfnVDwToBEQn+rr72cEOVUw5uGUH1+Sc+RFnS7NdpfXDmpw0MzCvVSEdTeKV7M4U3TjmZFTNthAsr7Zx1GRhBQ6/0ZSVgOwev35tQlIJ5Wojx1LduZoVNx2ymXJCoN7eZAmNIotEA2UwUsJbiD3PlLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748651409; c=relaxed/relaxed;
	bh=ynUwbxwZCBi44II3zgNAzut1A5rLCUEQyC8e+ANTAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1namMHXf0UKU5OadtAd25+sol2p2Dk+0+3xAG+1dv+wEloMHI/476L0u1iAwHdjypa3Ft03TRiyBEvwDirhwaTQgwI3VqwyjdH5VmVGMM5eaeZDKe/hcsbKaOFN3H6/qwshS3OJe8Hz3gBrDF8L7uEBVIxa3uv/zb5mD7ctCAFXvOwgnG2k9IRn3PNbDOWkBhFF7nu1GGziEYJtUST6dlRNZexqIxHnd12Im197vA236sYVh7BIRXQXBwN/jFPP1rMEePv0zUu3uFl0zzgAT1r86271KSLArCX0Yhajko8GWY2A8/zn/vDwFDXNuSFL0k5+RBGdVVA5o2w90UzAcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bDj4uR+J; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bDj4uR+J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b8Lbg2YGHz2xKh
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 May 2025 10:30:05 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748651401; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ynUwbxwZCBi44II3zgNAzut1A5rLCUEQyC8e+ANTAaI=;
	b=bDj4uR+JcHS/b1lFQoojgjXPITKRVwlNZc76GwVGLBAiCPy1sh0lv0HiF9rV0rdRXAxSUSzRLm/ILr0g3z3TJK5+mNcrfSvgUn+fKiA1WNdmprk/DedyVx/2oW6rbBBdxxgZCL8yhLveVvmDJJ6wIMX4eAxXRX1aek9N6d53Y4Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WcMrz4N_1748651395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 May 2025 08:29:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: fix image reproducibility of `-E(all-)fragments`
Date: Sat, 31 May 2025 08:29:54 +0800
Message-ID: <20250531002954.432151-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

The timestamp of the packed inode should be fixed to the build time.

Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7a10624..ca49a80 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -910,7 +910,8 @@ out:
 	return 0;
 }
 
-static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
+static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
+					    const char *path)
 {
 	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
 		return true;
@@ -924,7 +925,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != inode->sbi->build_time ||
+	if (path != EROFS_PACKED_INODE &&
+	    (inode->i_mtime != inode->sbi->build_time ||
 	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
@@ -1016,6 +1018,10 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		erofs_err("gid overflow @ %s", path);
 	inode->i_gid += cfg.c_gid_offset;
 
+	if (path == EROFS_PACKED_INODE) {
+		inode->i_mtime = sbi->build_time;
+		inode->i_mtime_nsec = 0;
+	}
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
@@ -1065,7 +1071,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	if (!inode->i_srcpath)
 		return -ENOMEM;
 
-	if (erofs_should_use_inode_extended(inode)) {
+	if (erofs_should_use_inode_extended(inode, path)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
@@ -1610,7 +1616,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	erofs_update_progressinfo("Processing %s ...", trimmed);
 	free(trimmed);
 
-	if (erofs_should_use_inode_extended(inode)) {
+	if (erofs_should_use_inode_extended(inode, inode->i_srcpath)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
-- 
2.43.5


