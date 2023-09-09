Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE38799806
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 14:37:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RjXYX5sVbz3bqW
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 22:37:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjXYQ14VWz2yW0
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Sep 2023 22:37:12 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 530B71008AC1C
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Sep 2023 20:36:59 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6CEF537C922;
	Sat,  9 Sep 2023 20:36:57 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: error return if meets an unknown extended option
Date: Sat,  9 Sep 2023 20:36:50 +0800
Message-ID: <20230909123650.2184838-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.42.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently mkfs would ignore any unknown extended option, which keeps
silent if a mistyped option is given. Return failure in this case allows
users to catch their errors more easily.
---
 mkfs/main.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 607c883..4caf267 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -186,55 +186,55 @@ static int parse_extended_opts(const char *opts)
 			cfg.c_legacy_compress = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
 			cfg.c_ignore_mtime = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
 		}
 
-		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			erofs_sb_clear_sb_chksum(&sbi);
 		}
 
-		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_noinline_data = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
 		}
 
-		if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
 		}
 
-		if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_ztailpacking = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
 			cfg.c_all_fragments = true;
 			goto handle_fragment;
 		}
 
-		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
 			char *endptr;
 			u64 i;
 
@@ -251,17 +251,22 @@ handle_fragment:
 			}
 		}
 
-		if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_dedupe = true;
 		}
 
-		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
+		else if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
 			cfg.c_xattr_name_filter = !clear;
 		}
+
+		else {
+			erofs_err("unknown extended option %s", token);
+			return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.42.0

