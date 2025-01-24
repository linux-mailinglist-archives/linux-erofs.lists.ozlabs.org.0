Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF2A1B253
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 10:06:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfX4N4W80z30TC
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 20:06:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737709602;
	cv=none; b=H/09E21UJiKW6zSJW/lE5TDOXXQ6/pJ9BS7AVzqldQAaBWUHUOO3ade50KB0oBm7w5ksMUNrJtuL3vItHE6IYBXoo03rXH1XpcckaiJpXrZAXHe9nUEDjW5QPJCDDCaQkE/U1f4JO/6eINcnwovoMjnD12vJyKJMQ5udMHOIKaDuP2oarRVGurqVC/GazeTQzoBieM4AdjpxIQ+RAgcznP+HVuPHjtHJJ95DNO5ntWU42VwX7bbqv0kBsdxE/CMFUyoX/VrxVP0c1QUjnah6BiO2+++A8UTYhVl2DDcgiJTI+PnnYh+/73TkgIIRMW1NErCwZQxw2UEM+rh0vCdc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737709602; c=relaxed/relaxed;
	bh=1386E9BvVS5KYLJMRhFT0mXT/XvdPfpozHDvCxuHEuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+t9YS1pB50hATvkp3d+18fDyFVLjXOVhzw0amBP52mXT2yp9wLeGFAuprQhC6tZ5liRusTgbuwSnAdffzzQraQPfIpyXwOxgH05PId/Qa+KIeGNc2V1NJrACokYfsGB3Z5DRMlRgKGhQTtNyUtqTTdABnmqIAt2ayp8y0oFn9vizfHBnR0caoVX0kPTmzwJag1Qf4pESdEsJ3uRViElt4KZbFmuk6bAX7Q42feQWDGGFqoJj4ajVD0W7K2xMYP1MA1ABl5K2NCxqc7dVV01lvOJYbbWno0xU6ZDvqgFUvgYDRPSRAkS2bAZJMv8SO6W4fsLTdXdO9hKC2LpBilM9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CNHLc7xx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CNHLc7xx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfX4K17DQz30NF
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 20:06:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737709595; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1386E9BvVS5KYLJMRhFT0mXT/XvdPfpozHDvCxuHEuk=;
	b=CNHLc7xx/H+MQb8wCKkvq2b65Q71isr+KGaSFx8uLFn1m4XcdWPXcXHx4XxJ5okhZKjlUChA+pwbuvyGLuhknsgjjCGcbg7sRCGfNvlSwed8tWOeMnnbOTZgDGhD+TyrPLOzv0yyoF/Fjtl/K/bKvq64S+HNiI/VZD0Fo2Tevds=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOE.K0g_1737709589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jan 2025 17:06:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fsck: keep S{U,G}ID bits properly on extraction
Date: Fri, 24 Jan 2025 17:06:27 +0800
Message-ID: <20250124090628.2865088-1-hsiangkao@linux.alibaba.com>
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

As chown(2) shown, "
When the owner or group of an executable file are changed by an
unprivileged user the S_ISUID and S_ISGID mode bits are cleared.
POSIX does not specify whether this also should happen when root does
the chown(); the Linux behavior depends on the kernel version."

Fix it by chown() first.

Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index d375835..b1d6214 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -300,6 +300,12 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 #endif
 		erofs_warn("failed to set times: %s", path);
 
+	if (fsckcfg.preserve_owner) {
+		ret = lchown(path, inode->i_uid, inode->i_gid);
+		if (ret < 0)
+			erofs_warn("failed to change ownership: %s", path);
+	}
+
 	if (!S_ISLNK(inode->i_mode)) {
 		if (fsckcfg.preserve_perms)
 			ret = chmod(path, inode->i_mode);
@@ -308,12 +314,6 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 		if (ret < 0)
 			erofs_warn("failed to set permissions: %s", path);
 	}
-
-	if (fsckcfg.preserve_owner) {
-		ret = lchown(path, inode->i_uid, inode->i_gid);
-		if (ret < 0)
-			erofs_warn("failed to change ownership: %s", path);
-	}
 }
 
 static int erofs_check_sb_chksum(void)
-- 
2.43.5

