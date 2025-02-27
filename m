Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EBCA4733C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Feb 2025 03:57:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3GG33tQrz3bqm
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Feb 2025 13:56:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740625017;
	cv=none; b=dmvQguWuLMpUKSOGBCR26A3fEb25knmBXZ/T0+4ZpaiJDBOtROBJ6QHvo4GiUQIxL3FVbl/Ih8mcKobkepcqsr2SZO/c5+4G0gaVPm6XEj+tLWjEMVSN0mJu4TlLBQo10B59HX0Q0nqYNqhuAKThyZtar5jrnWF4MP3JEXwMgkCYCaVGDJNeVAYc30GSvGpMtdq+1BbkcBXAib4MHc8kK2E7RZpNlfIOnGQpS56lBrDh5UiLE1TSpwjUxqyynOwF5WknjMU5cy32lgZVfbJp+varzjp/dpNar4ScjfNHZVPbrG1Moz9g81eQJw03Q84OVHVOLi0INrPpmFTwxk7t1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740625017; c=relaxed/relaxed;
	bh=faUOxaRmu7Pyukacn3nymJoIlhUioLGoapAxacVNFTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elGHhFDdv8ioyoepXsj3VN0aYXPbSeY1neIfRKYoZT81OV57lMt+D/Jw8tn9rSsP/8Y4+fqin1sMGRCYgLMNHFkqeC8Xbq5ycS/tbQIx6L86ufB1vlL7RPp4NXqJprxJnFh8qbnCM/qD3pMV1/IWCQ5w3W0g4nDGaWmEv3s1W30ijcBQmx/CSwVwIvH26cNpisakdLTWnq9ijNYCh4dDIRkHUkFsUH69PuuzSvXKJZaYFfaKAg387RmSy3Oi5vtMZ1rqFe6yE+om9GP9Kojs45UfBVSoZWCGirIgrzn7MxWzX4b87GRAot4418M36/OyPa6toZai72Z0DeaB+wVvhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rDL0DQHI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rDL0DQHI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3GFz5mP0z2xjQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Feb 2025 13:56:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740625009; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=faUOxaRmu7Pyukacn3nymJoIlhUioLGoapAxacVNFTE=;
	b=rDL0DQHIFs7VSfq2HWRtjsLp9yqHyEvkhjL5Fqi0lrHJnT9pni0y/kXLzCS2JeaefU8D00KP+WcbUgd9X5Stz1/QpRAjhovSytcasHlfhHdSAC0Uf2MZBph5Uw3OzK0QkCkO38G5duQo4KGSNksbnx3EbXtfsTzszCVHBH9JJfc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQKbOa7_1740625000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Feb 2025 10:56:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix stack-overflow due to directory loops
Date: Thu, 27 Feb 2025 10:56:39 +0800
Message-ID: <20250227025639.2160988-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,PDS_OTHER_BAD_TLD,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URI_NOVOWEL,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled
	version=4.0.0
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

Just record all parent directories to address this issue as
a trivial solution for now.

Closes: https://github.com/erofs/erofs-utils/issues/15
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 17 +++++++++++++++--
 lib/dir.c   |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 372fee6..0e8b944 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -20,7 +20,13 @@
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
+struct erofsfsck_dirstack {
+	erofs_nid_t dirs[PATH_MAX];
+	int top;
+};
+
 struct erofsfsck_cfg {
+	struct erofsfsck_dirstack dirstack;
 	u64 physical_blocks;
 	u64 logical_blocks;
 	char *extract_path;
@@ -967,7 +973,7 @@ verify:
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 {
-	int ret;
+	int ret, i;
 	struct erofs_inode inode;
 
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
@@ -999,7 +1005,6 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			return ret;
 	}
 
-	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
 			.flags = EROFS_READDIR_VALID_PNID,
@@ -1008,7 +1013,15 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			.cb = erofsfsck_dirent_iter,
 		};
 
+		/* XXX: support the deeper cases later */
+		if (fsckcfg.dirstack.top >= ARRAY_SIZE(fsckcfg.dirstack.dirs))
+			return -ENAMETOOLONG;
+		for (i = 0; i < fsckcfg.dirstack.top; ++i)
+			if (inode.nid == fsckcfg.dirstack.dirs[i])
+				return -ELOOP;
+		fsckcfg.dirstack.dirs[fsckcfg.dirstack.top++] = pnid;
 		ret = erofs_iterate_dir(&ctx, true);
+		--fsckcfg.dirstack.top;
 	}
 
 	if (!ret && !erofs_is_packed_inode(&inode))
diff --git a/lib/dir.c b/lib/dir.c
index 1223cbc..d786a5b 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -179,7 +179,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 	}
 
 	if (fsck && (ctx->flags & EROFS_READDIR_ALL_SPECIAL_FOUND) !=
-			EROFS_READDIR_ALL_SPECIAL_FOUND) {
+			EROFS_READDIR_ALL_SPECIAL_FOUND && !err) {
 		erofs_err("`.' or `..' dirent is missing @ nid %llu",
 			  dir->nid | 0ULL);
 		return -EFSCORRUPTED;
-- 
2.43.5

