Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C93CDA002D6
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 03:40:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPSVR3FxSz30Gm
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 13:40:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735872029;
	cv=none; b=J0wIohED8ZbRas5Y/MryjIKlZVqGOiA3l4cbMTg7QKbPcnmyaDNeS5obhSqexzZxWQzLdpaTYPh2Sv7G+qQnhAvEPVzPHs4+PCgWUMgYMlOuM4UvJddEcMNApKdIDjeQpuLG7STcaHXEJhZWJWegA1CME/8gxB5biCgJ4oexRc0CivDNcbYwfMieWhVPB5QHHmCC7/w0BQT9Y58+Di9ViVng9xTvgliPGLSF7JJorELOBeWr6vXLzugOMLwVd7iKELmlZh+TjLzH/IetxmG+zgG8qqct6AmoA2Y61x2grywTdxXmecpZcgfb2JCy6XW01G51cGdysh/kEJvzl5GFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735872029; c=relaxed/relaxed;
	bh=nJBtudwjMzqmKzc2nFc3ahnJfw7CUVQ2gArtEAl4MB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyXs+/3Qu9VuDgyZ0LOmJEZR34nTwEIdRRpXNVZoU1UbKGLiYx4wwGBY0eCLtRgdUpCwckF9R9yzGhsPFWLO/rooeRc0Uc0Hu/USb9mKvQGNsp5AXQqGc1deXKavKd1qqhgU7U6UdsxAcg21RM6mONuSAacjhPsW6TeFdYSMolYd6wb8PMs89CFFeWifKGWmWM46pl5ZqFyZZowD8vMM3ki/J2aWlPn9k2/DBRC3jHwQc2CCr7p+GOeoLuFnqULdjynMxk8YBMNYz82S1sb2/ful4NzINFI3aTkC4YN8vDynfDmnpoJZYrPbQn+SReqivRM2BxEpgzHTZvJwm2Vh/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ffYksyB0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ffYksyB0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPSVL3rz1z2yVj
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2025 13:40:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735872018; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nJBtudwjMzqmKzc2nFc3ahnJfw7CUVQ2gArtEAl4MB4=;
	b=ffYksyB0dmSeMW5T3vLC/bqq+N7cNDBn0BvvcounoWTg81Rhlkx+kU2u0I27DEkzcETR6k3jzUMgzBJ659zIm9ljEf9T3Jl3aE0kbb/ZFHlQNvSVi554wr/ATD+KUnoCApM1T3SA7oHpvMGJlyF8hxu8WIWvZoX14mJxKGdJdSg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMrYDZv_1735872012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 10:40:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: support `-Efragdedupe=inode`
Date: Fri,  3 Jan 2025 10:40:11 +0800
Message-ID: <20250103024011.198163-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If the entire inode can be deduplicated against an existing fragment,
simply reuse it.

Multi-threading can still be applied for `-Efragdedupe=inode` with
the current codebase:

Fedora Linux 39 (Workstation Edition) LiveCD results:
 -zlzma,level=6,dictsize=131072 -C65536 -Eall-fragments

   `-E^fragdedupe`         2,003,587,072 bytes (1880 MiB)
   `-Efragdedupe=inode`    1,970,577,408 bytes (1911 MiB)

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  8 +++++++-
 lib/compress.c         |  9 +++++++--
 mkfs/main.c            | 14 +++++++++++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 47e4d00..92c1467 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -33,6 +33,12 @@ enum {
 	TIMESTAMP_CLAMPING,
 };
 
+enum {
+	FRAGDEDUPE_FULL,
+	FRAGDEDUPE_INODE,
+	FRAGDEDUPE_OFF,
+};
+
 #define EROFS_MAX_COMPR_CFGS		64
 
 struct erofs_compr_opts {
@@ -53,7 +59,7 @@ struct erofs_configure {
 	bool c_fragments;
 	bool c_all_fragments;
 	bool c_dedupe;
-	bool c_nofragdedupe;
+	char c_fragdedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
diff --git a/lib/compress.c b/lib/compress.c
index fd4c241..b038156 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1527,12 +1527,17 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * parts into the packed inode.
 	 */
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode) &&
-	    !cfg.c_nofragdedupe) {
+	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
 			goto err_free_ictx;
-	}
 
+		if (cfg.c_fragdedupe == FRAGDEDUPE_INODE &&
+		    inode->fragment_size < inode->i_size) {
+			erofs_dbg("Discard the sub-inode tail fragment @ nid %llu", inode->nid);
+			inode->fragment_size = 0;
+		}
+	}
 	ictx->inode = inode;
 	ictx->fpos = fpos;
 	init_list_head(&ictx->extents);
diff --git a/mkfs/main.c b/mkfs/main.c
index 27c333c..7fbbc7e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -309,9 +309,17 @@ static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
 static int erofs_mkfs_feat_set_fragdedupe(bool en, const char *val,
 					  unsigned int vallen)
 {
-	if (vallen)
-		return -EINVAL;
-	cfg.c_nofragdedupe = !en;
+	if (!en) {
+		if (vallen)
+			return -EINVAL;
+		cfg.c_fragdedupe = FRAGDEDUPE_OFF;
+	} else if (vallen == sizeof("inode") - 1 &&
+		   !memcmp(val, "inode", vallen)) {
+		cfg.c_fragdedupe = FRAGDEDUPE_INODE;
+	} else {
+		cfg.c_fragdedupe = FRAGDEDUPE_FULL;
+
+	}
 	return 0;
 }
 
-- 
2.43.5

