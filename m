Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D454A2DAB7
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Feb 2025 04:51:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YrDKR5BJfz30WX
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Feb 2025 14:51:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739073098;
	cv=none; b=NTQZAsVM2PjE5d5HD/94ej/tMtJOqE0HVDRiepysuBi+wKf/7Ev44T4LathdExwlz+IpGdIP+47npW88s7NhyJLtO6V48e0TQTs6/07XJDI/zgCyqf1sDMdDZPNRhyntkVMnTIzk4qBLa9spX8YgHQjjoSjC7Ku/lo9aLzh0duJgY3hSpA1R1WqLU6FXMsk1AlMq06aMD/7a3WwjbLj+YrEVpoUkpTiVRqs+e0ea0py7gTwzzJ0YI666uK43nnpa4iLDoBR/sQSSrb7HL8uqxqq6+Pi1Brb4rrjNHybaF6R8WQdS2r9alT/gPE6TMIKiBadmALLEoxUswhcCcnH0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739073098; c=relaxed/relaxed;
	bh=757u6rpYy331fbM23d8iKOHXwMyk/X8lusARiPUkO+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avWswRHX1+W+9y4QOL3pRXR2f6DvMDeN7xorX+wkBCrHUF94L7AREy/kEtnaKn+cPw73K93X7aaWcdHAhV1p+9N7LXZwh2wkYDYKZF7vzowvYTO5lrGdsuf7Droh2YFbc5foWD3Gza/jCFugkwHB4yjMmRiwkxofo3v3J0YbtpThKIb0T3DgYHRCllOCXnzEAu74/e/Xmpq5ZJXSsCTlIwqApGBvljMVCRGySOoqVPrInfff4Yzlp2iPoPpPfKbaPFDzFpvZb/ZqDDDnJZ01pMTZ5c2jSB3eU8WluCOEZbJXV54rqGaWhzzMVF/k34b/tgQsL29Y8FeHr795JcHIqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RXGN1uVI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RXGN1uVI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YrDKN5MP6z2y34
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Feb 2025 14:51:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739073091; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=757u6rpYy331fbM23d8iKOHXwMyk/X8lusARiPUkO+Y=;
	b=RXGN1uVIOEJdwAmHxQ+hwrJw2dX8jj9SnPAO+5XxxDgUWuBo/LHg88PHz81MzdZxMMwqXSSzBRYS+nbBXhs3Vw3ZlQxG5aY5au64k3EqAV99V8OLv/QstReP0Yj/5pyaAsgjwGHgPgh+g4prqkHKs7u2KLT+9yOYT85V61Wyd9w=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WP2.oVx_1739073085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Feb 2025 11:51:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: tar: keep non-existent directories with their parents
Date: Sun,  9 Feb 2025 11:51:24 +0800
Message-ID: <20250209035124.2168333-1-hsiangkao@linux.alibaba.com>
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

To avoid lack of basic permissions for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 3e58f00..5787bb3 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -25,6 +25,14 @@
 #define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
 #endif
 
+/*
+ * These non-existent parent directories are created with the same permissions
+ * as their parent directories.  It is expected that a call to create these
+ * parent directories with the correct permissions will be made later, at which
+ * point the permissions will be updated.  We handle mtime in the same way.
+ * Also see: https://github.com/containerd/containerd/issues/3017
+ *           https://github.com/containerd/containerd/pull/3528
+ */
 static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 						const char *s)
 {
@@ -41,11 +49,15 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 		return ERR_PTR(-ENOMEM);
 	}
 	inode->i_mode = S_IFDIR | 0755;
+	if (dir->i_mode & S_IWGRP)
+		inode->i_mode |= S_IWGRP;
+	if (dir->i_mode & S_IWOTH)
+		inode->i_mode |= S_IWOTH;
 	inode->i_parent = dir;
-	inode->i_uid = getuid();
-	inode->i_gid = getgid();
-	inode->i_mtime = inode->sbi->build_time;
-	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
+	inode->i_uid = dir->i_uid;
+	inode->i_gid = dir->i_gid;
+	inode->i_mtime = dir->i_mtime;
+	inode->i_mtime_nsec = dir->i_mtime_nsec;
 	inode->dev = dir->dev;
 	erofs_init_empty_dir(inode);
 
-- 
2.43.5

