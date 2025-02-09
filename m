Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0846A2DE93
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Feb 2025 15:38:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YrVgh2vmwz3055
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 01:38:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739111902;
	cv=none; b=jWZL/NQ8BlVerW6OBaSS48uZXhycRNoW31jyZ67fne9nG/8o2atnNTFnJzeFlDIhx8waU+XkEFZS7XnlAGi2f+DXzUhVoXNRPd39vIs6Cq6CdGFneYHVI0sO8iGC+v6xtsQZ5XSYCyelMIBcMXeLmWEvTA20vDMWLY3ZyYq2WuQrrUuG88/rSjost7g4qpKoKoAJqjV+c327wTTSUmWbHLwBBBvqxNCsV6n7w1p3YHuDTEI9WQ+BuH2UifjCZJlIr2Ivr3PNAdHXsZoXnkWpIxc8BHnrzAScFV+vchI7XXdz38t1/eV4RE5FxiRgYDmlFESEFIutREFk+e3DUOp0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739111902; c=relaxed/relaxed;
	bh=D8cOupeJg2yf0IYqiUjosEwPBJRBzic2eWeTrPH7EeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekiK7IcDb+2kU47xHxvgCx77Fif8NZY8url6IFqqkWM1XCq8v/I3r7zIuyOJ3yQhUwavA4fyceTfKqLE4WJxmjIX1NLejI0ByfzHGZ75dIC0HMJ70Zsh9ijNUe0MZUZQs26TUhYSE8xZfMtvpyiNDEMPBvtXShzr8CQvvl0Acm4oKHv1GzNsy9qRZbSTcNSUgzQy8QEY7Q4OyFMjuzp15am+oYtHQ23CScjXO3PrxAL+dLLhkvZhVr8P8v5vgRtpIFWz4RuUDFCq1Uow8sZM9YoLywpjZn6TtDWDq2GeELxcEVygLUR5im4Qk0WfBgEvOiShykdmqg4WpvnFdOor3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xb80NwRO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xb80NwRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YrVgd0pn5z2xy0
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 01:38:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739111895; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D8cOupeJg2yf0IYqiUjosEwPBJRBzic2eWeTrPH7EeM=;
	b=xb80NwRO+iIq5CKt3tA2QCn24Gym61ERoBK618mztj4vz98Po9mTTiOZ/9GYQ86uqt8eFE5Y7bey+PEHmMuZR5ljHWRoYsJ10LkWr/OEarFQafGKtxfXBa5MdKM1jGeHk/v6zeWG04rUoMkPaq/ReQgF+R3R223qoLwNADBJS3c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WP37SOX_1739111889 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Feb 2025 22:38:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: restrict pcluster size limitations
Date: Sun,  9 Feb 2025 22:38:08 +0800
Message-ID: <20250209143808.2984785-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 7c3ca1838a7831855cbf2e6927a10e0e4723edf6
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs_fs.h |  5 ++++-
 lib/zmap.c         | 41 ++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 5672c99..269d302 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -297,9 +297,12 @@ enum {
 
 #define EROFS_NAME_LEN      255
 
-/* maximum supported size of a physical compression cluster */
+/* maximum supported encoded size of a physical compressed cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
+/* maximum supported decoded size of a physical compressed cluster */
+#define Z_EROFS_PCLUSTER_MAX_DSIZE	(12 * 1024 * 1024)
+
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
diff --git a/lib/zmap.c b/lib/zmap.c
index b84d214..70ff898 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -633,30 +633,29 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 {
 	int err = 0;
 
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= vi->i_size) {
+	if (map->m_la >= vi->i_size) {	/* post-EOF unmapped extent */
 		map->m_llen = map->m_la + 1 - vi->i_size;
 		map->m_la = vi->i_size;
 		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(vi);
-	if (err)
-		goto out;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
-	    !vi->z_tailextent_headlcn) {
-		map->m_la = 0;
-		map->m_llen = vi->i_size;
-		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
-				EROFS_MAP_FRAGMENT;
-		goto out;
+	} else {
+		err = z_erofs_fill_inode_lazy(vi);
+		if (!err) {
+			if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+			    !vi->z_tailextent_headlcn) {
+				map->m_la = 0;
+				map->m_llen = vi->i_size;
+				map->m_flags = EROFS_MAP_MAPPED |
+					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+			} else {
+				err = z_erofs_do_map_blocks(vi, map, flags);
+			}
+		}
+		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
+		    __erofs_unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+				     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+			err = -EOPNOTSUPP;
+		if (err)
+			map->m_llen = 0;
 	}
-
-	err = z_erofs_do_map_blocks(vi, map, flags);
-out:
-	if (err)
-		map->m_llen = 0;
 	return err;
 }
-- 
2.43.5

