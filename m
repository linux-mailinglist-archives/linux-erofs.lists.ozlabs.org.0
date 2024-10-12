Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0B99B083
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 05:52:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQV1x3BgWz3c2h
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 14:52:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728705155;
	cv=none; b=DqvUCLiu6SBX6RYI+6PBavQRPwqDW5EpzIhZhLMdiEZXGzDRScDczyAiWyOUE3ootMlJbW5HnomEkEtglL2y+9UFJnhLRGWx+2QzCCQ/O/42PapCpjd/XUwgp8HP1DzVA/+k0uyfiTWTG98Z/x9CY4FUuXeohMp5LQY9636NSOZXmv1zEVSYR79c+JuQfXN+bjmyzkCWJZLz9YN6/mlh8sWITyn5zXGqrkJlTr37L1IoY9HtYCg8/txB5ZtFmwy05v6F7vKXg+Ujr0+AxbnR4c0w6iPpJSD3llfryStfYeAkttMDPy+mbfsT0hGrSQUnD6fcVBQCskBAzrbjt0th7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728705155; c=relaxed/relaxed;
	bh=Jo7isjpeqzJRIkvmSeFj59NCkDEEeLRdOxQn5GhrlCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML8zB/lQyT7YsqDwiQxMWGI5uMIthbST00I2+03zPpMT5jAnS8w5ZLN20K+qXp3YpAq8j/KQbz5PWT5rsQDBHXJ4esNj9+nEDVpGyHkIpfJxQfHrPgopIKW0ZjlaGOKuTmKy56MCwcAqJnFl2aqVQ8+wZ8jbaqgL0eXTLr7yyJ8JYyAzEd54U18hGEFzNYvUCHm0GLHVsL0XDRj2Fq4UQ1a/yCRPhjNN7Y0SPgDuPUo0HROb3qNzk6clEnAgT956AguhB7y/D2a9dIS5Z7AZqQeGMVQAPVNXwNiKm9qhrQdW+iN2I8gvokAwO1lpn9TVUfRzXFZxczG7ToqfQuaSeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FSu1knmH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FSu1knmH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQV1q0j9Bz2yw7
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 14:52:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728705141; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Jo7isjpeqzJRIkvmSeFj59NCkDEEeLRdOxQn5GhrlCY=;
	b=FSu1knmHYjzkF1OF+U2YlnW68+IWs8jTwEBXaBLQ88JWPr8n0bh/Cy6+K2f1xkKhOpa0Ka5PYhxzqAe1ii5kQ3Ej4iVKtlqE3JpCydwoQBTknbWFVhaEPXmqzYsxLgcLuDdw9fY5WauNtxWKdlyzOjMimJis1udNuCUoSAzlUMg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGtwYsA_1728705134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 11:52:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	David Michael <fedora.dm0@gmail.com>
Subject: [PATCH] erofs-utils: mkfs: fix `-Eall-fragments` for multi-threaded compression
Date: Sat, 12 Oct 2024 11:52:13 +0800
Message-ID: <20241012035213.3729725-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
References: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
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

If `-Eall-fragments` is specified when multi-threaded compression is
enabled, it should only apply to the packed inode instead of other
real inodes for now.

Fixes: 10c1590c0920 ("erofs-utils: enable multi-threaded support for `-Eall-fragments`")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 17e7112..f441214 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1453,12 +1453,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
-	if (z_erofs_mt_enabled) {
-		ictx = malloc(sizeof(*ictx));
-		if (!ictx)
-			return ERR_PTR(-ENOMEM);
-		ictx->fd = dup(fd);
-	} else {
+	if (!z_erofs_mt_enabled ||
+	    (cfg.c_all_fragments && !erofs_is_packed_inode(inode))) {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
 		if (g_ictx.seg_num)
@@ -1468,6 +1464,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 #endif
 		ictx = &g_ictx;
 		ictx->fd = fd;
+	} else {
+		ictx = malloc(sizeof(*ictx));
+		if (!ictx)
+			return ERR_PTR(-ENOMEM);
+		ictx->fd = dup(fd);
 	}
 
 	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-- 
2.43.5

