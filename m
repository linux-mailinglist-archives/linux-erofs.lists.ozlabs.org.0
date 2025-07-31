Return-Path: <linux-erofs+bounces-730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCEB16ABD
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 05:16:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvQ04FZ9z305v;
	Thu, 31 Jul 2025 13:16:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753931816;
	cv=none; b=keED3xaDAlC7cWfMnOjb4EuzfWSq7egtSOsb+ID7p4gk6Z9FThKd9c5m+dUfmCx3uU/Eip+dAiVfgcwGyZ/7pS99G7W6KwqAvVzQeCqms+xBXOjy/VCRmkRQDVH//5MuCH711qfSlgdMPtlrGzli0g2MojbzntePnNLO7/WeGtRclNfNKaCSBWgVL8D7E/cc3IhvGed6DCFXHrvOas/LDk7wq+eu6+3MGJoGTTIJ4rzDKDSBw8ecBG75aanNJU97vgOqgJEK/AsM8gF0T9IfmobySji8stlsHnc1J7NnJiHJU+9pmBLXkG3xjcNl5kY0zheRIyYPBCBT99Q/NPwDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753931816; c=relaxed/relaxed;
	bh=6EcR3moSvTqpQ0lJaGVrWZFAImWGpFOco0AlAHrf/Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAOd7kuTQZpz+v42hrV5KavA56qq1lDRs59RB2StcnVVscO+1Pwup4M+piMNxDbA92++weM9Z/wWGjgOo3heXYqKpiOeQx36QhNde86BxkcJ86kglUAMOkyRGJm9fhuLwXFwrEIDVEFNSt/rXPS/3Pj+G4NdExwZtWkZFSo73SOtBkKpvl8fL2gaxYNWBIvSP3rx9Tt8YIXLlox1Xv0wOi2C1BpiaZ7FIznrsktxXYOGg0XQm7M3zYYApTUM3C5ofWyqV4kSE25EiJ51/hXQ9dGBdF49C0/u9hY1DYyZOHm/ShJiHIfFhekbFEsfoiz3y92bk6ekq3EJIqTfIqw3LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Za6+JJNc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Za6+JJNc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvPy75d6z2yLB
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 13:16:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753931809; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6EcR3moSvTqpQ0lJaGVrWZFAImWGpFOco0AlAHrf/Ak=;
	b=Za6+JJNcR6dG/jzt+sWIsmO5lvEJP4KaLe8rACnm0V8txWc4e9QSy4GFGc070rpGaR+ADlCMQ4WmdaD79Gblzi/ti6TId/a8ODp9g+AgvhtWr4AxMP5tbA/t1PwvCwC2T/V8zkfCXIP/UyIvRPX2V23P2dIxseM2+LrLpR1IZrY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWixEb_1753931807 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 11:16:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: avoid `.` dirent insertion if dot_omitted is enabled
Date: Thu, 31 Jul 2025 11:16:41 +0800
Message-ID: <20250731031642.2139859-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250731031642.2139859-1-hsiangkao@linux.alibaba.com>
References: <20250731031642.2139859-1-hsiangkao@linux.alibaba.com>
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

It's also used for the upcoming sort optimization.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index cbce712b..59031144 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -235,12 +235,15 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 	unsigned int i;
 	unsigned int d_size = 0;
 
-	/* dot is pointed to the current dir inode */
-	d = erofs_d_alloc(dir, ".");
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	d->inode = erofs_igrab(dir);
-	d->type = EROFS_FT_DIR;
+	if (!dot_omitted) {
+		/* dot is pointed to the current dir inode */
+		d = erofs_d_alloc(dir, ".");
+		if (IS_ERR(d))
+			return PTR_ERR(d);
+		d->inode = erofs_igrab(dir);
+		d->type = EROFS_FT_DIR;
+	}
+	dir->dot_omitted = dot_omitted;
 
 	/* dotdot is pointed to the parent dir */
 	d = erofs_d_alloc(dir, "..");
@@ -249,24 +252,17 @@ static int erofs_prepare_dir_file(struct erofs_inode *dir,
 	d->inode = erofs_igrab(erofs_parent_inode(dir));
 	d->type = EROFS_FT_DIR;
 
-	nr_subdirs += 2;
-
+	nr_subdirs += 1 + !dot_omitted;
 	sorted_d = malloc(nr_subdirs * sizeof(d));
 	if (!sorted_d)
 		return -ENOMEM;
 
-	dir->dot_omitted = dot_omitted;
 	i = 0;
 	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
 		list_del(&d->d_child);
-		if (dot_omitted && !strcmp(d->name, ".")) {
-			erofs_iput(d->inode);
-			free(d);
-			continue;
-		}
 		sorted_d[i++] = d;
 	}
-	DBG_BUGON(i + dot_omitted != nr_subdirs);
+	DBG_BUGON(i != nr_subdirs);
 	qsort(sorted_d, i, sizeof(d), comp_subdir);
 	while (i)
 		list_add(&sorted_d[--i]->d_child, &dir->i_subdirs);
-- 
2.43.5


