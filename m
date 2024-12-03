Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908429E0FB1
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 01:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733185656;
	bh=42RSYcChDXnrNIN2WkJ8/T64hjguvI9l07kJT+flFBE=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=dW1K6CZSEy13ttl7u0nF6xeHo9vmleJuHOR8hZ+80uwBIkCstA7hTGxUrMaTebNaP
	 wDSnmTVVr1Wd2EmclJQ9wP2HbTJE+b1PSpbtbwyQP2TuWyqdNFfusBrynioHEsYxk+
	 JyrukeceuuJuI+OyxdW9ul1x/wZgQWFsm6tCXBOWpz3swhU/hYMlhjQLhdnXfXs/2H
	 0UuesKcR712wKa7fjucie/TGZ9cBxKgt0Xi4S+U+PmAUV4gpTfjGr6aNbDRCTFsfi2
	 qLnA8qfx/YqzwnbwtKHbdukE3G/krpdGYt0RkWzxyw8c7v/ImiRfN9qnp5/utjHCRT
	 dr3Gy7A/Rl5rA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2M1N50Hvz2ywq
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 11:27:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733185655;
	cv=none; b=K32leyEz22WowpF4kUV000Ium5pthSWSGbirw73mJKm8J+JUylVIlBm4x5HTRS1fBPW1XlTIqciVOP1K+yzyByHDNC3b32OfV1793fUIlH++RX3zL5kvNkfByorLQxrE59ryvL6h4wIlqlXxtXxz5uIKerJXXitwGYpcZwOmu5gL2d2A/m+tZtvgLZiekEKUBtddvZCduuaIL4xpcsmmjhPN7G+HhiPGMjyh2BPIIxEk2yVCPZk0xQxYu4+BqqLYIkISU10hqr5PJ+LFB43lVPTKDHcBttRm02hbLDhdOLLD9DABTk+u1gcsjiVoMxbh6eAdYycu9xaZcbX11+ZgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733185655; c=relaxed/relaxed;
	bh=42RSYcChDXnrNIN2WkJ8/T64hjguvI9l07kJT+flFBE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MT2XTJ7j2539Y6rrmK0/txIIV9RYm7HLL/vNKWeTLbueWik1n1vDe9v1O3t7ioZ78VBbRsiF5ZYlY1XAeADYbmSNrqLigb5PzgsmPJuEvdICqHV9Q7eFmgFP4o7kgEnrVi+fldSQbaP0DmYb86kmbQ/TdlvBRlwK6yJjLpqvrr4Qn6f/2SNc64igTXPMWZzanU6EPshdR4HVd35PiALyj9GJX1P/c0+WNQBX/7jLWESG16fV1vv0DtxWCPE4aL/C0ubfnM38SRU70qgRPYyOmKJYGRAi/AuNwFvX9ZggT5L3QpjqXn7CmzlmF2nm7lSx1vKqDNbMQ4z5OCd1+0yF/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KO1o9KZd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3cfbozwckc4sy33d92vv33v0t.r310x29c-t63u70x787.3e0pq7.36v@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--jooyung.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KO1o9KZd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--jooyung.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3cfbozwckc4sy33d92vv33v0t.r310x29c-t63u70x787.3e0pq7.36v@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2M1L0XHTz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 11:27:32 +1100 (AEDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-20d15285c87so49316245ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733185648; x=1733790448; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=42RSYcChDXnrNIN2WkJ8/T64hjguvI9l07kJT+flFBE=;
        b=KO1o9KZdHRTXEXyFGkMWBO6TRtlvy5qCGWKhTCrSLqu2zNVLUbLs4QvJ5oI8+uj13C
         exTkCQxW54kMhVv6t94Jzu3xDN7aCjHW9cDVIWIwBw5yfzh7AdN58r5Hfi/g9+a8M4Yv
         BUDpUQfSp31zEuiskeCP8GkdhiNzMRzqMX5slwgC52PklQaCJDap0/eDRRx8gvMUx7pE
         WGiFhW5uCAyuu7F9WSq+B9uFB8RAe3SbkmiBpVoX8oQ8KzJ3+1uhCKLrmi3TYz99yc/Z
         ZebetSvB1i5PFFWsQxl2LjBu/JbT4yTTgb7xsI5CYG+Yi+h2Z8PS/rrMbb6VzPL2u93b
         0wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185648; x=1733790448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42RSYcChDXnrNIN2WkJ8/T64hjguvI9l07kJT+flFBE=;
        b=vWUjc5W1zWdX4n+aHVTCguV0+Xv1UZzlVMvMWmnUDXL+ToIY3jcGKUzWcgZ3tdiuXE
         PdvT/lxBWVsGqvEdxwN1YMK9SZfkfpRsUhOHo1/3dyQbxag8e7iqmCN4eN8EWgXV1/Xl
         UQAkrkbqd9rGWP12gcLt9QecX1sfy7bb0+Y5tqdw763CmD62V1NUCW7X/IjxHfpKaT76
         Do9tbNlLKZ1VElLVIu8arYicadZtUy6c4/pTsA6Ic1jMVtQeM2WxgTRjOoBt+GLD7MHk
         0aXAgeNxYbOKlc14ZkLg0Bz7NW3FYLpHqPIo5v3BZu3+moH6QFpgor1bxaKgwIUgV+Z/
         KWYQ==
X-Gm-Message-State: AOJu0YxKR2ZFNqjg/XN4tqeCj8nxc7FoScLNV0Mo4e8Q4P8wJW0rYgu6
	jNlMSv+z6LFVm7Y98yXe6tFliCC+CTZTBMzr3uXmxFuPuUbOP8mUeCCkg5DPjELjSkPNZMRTJgI
	P/qBLVtBc78LcubrVT49OEfo8H3o0Es3mYKwSM2JQgAglo9G2NN3n4cilURqOqdeC/57V23O/aO
	o4TIKcknGlpevqC9gYbWybZcGtGMdmVJjoZH5KXkwT5cyxZg==
X-Google-Smtp-Source: AGHT+IGwWjHTd3uWG2T5LfMT/+If/qN3Tu280C1RZ+dEl6gaeeNizRVqXCxzfgySPbdNmQQD5AH1yys9vHDy
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:212:c8b:c0e6])
 (user=jooyung job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:183:b0:215:acb3:375d
 with SMTP id d9443c01a7336-215bd1ce3a6mr6470045ad.18.1733185648385; Mon, 02
 Dec 2024 16:27:28 -0800 (PST)
Date: Tue,  3 Dec 2024 09:27:20 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203002720.3634151-1-jooyung@google.com>
Subject: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.0
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
From: Jooyung Han via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jooyung Han <jooyung@google.com>
Cc: hsiangkao@linux.alibaba.com, Jooyung Han <jooyung@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The iteration order of opendir/readdir depends on filesystem
implementation. Hence, even with the same contents, the filesystem of
the input directory affects the output.

In this change, opendir/readdir is replaced with scandir for stable
order of iteration. This produces the same output regardless of the
filesystem of the input directory.

Test: mkfs.erofs ... inputdir(ext3)
Test: mkfs.erofs ... inputdir(tmpfs)
  # should generate the same output
Signed-off-by: Jooyung Han <jooyung@google.com>
---

v1: https://lore.kernel.org/linux-erofs/20241202232620.3604736-1-jooyung@google.com/
change since v1:
 - modify commit msg (no change-id/bug/typo)
 - rename the label to err_cleanup

 lib/inode.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index f553bec..097deef 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1422,37 +1422,25 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 {
 	struct erofs_sb_info *sbi = dir->sbi;
-	DIR *_dir;
-	struct dirent *dp;
+	struct dirent *dp, **dent;
+	int i, num_entries;
 	struct erofs_dentry *d;
 	unsigned int nr_subdirs, i_nlink;
 	int ret;
 
-	_dir = opendir(dir->i_srcpath);
-	if (!_dir) {
-		erofs_err("failed to opendir at %s: %s",
+	num_entries = scandir(dir->i_srcpath, &dent, NULL, alphasort);
+	if (num_entries == -1) {
+		erofs_err("failed to scandir at %s: %s",
 			  dir->i_srcpath, erofs_strerror(-errno));
 		return -errno;
 	}
 
 	nr_subdirs = 0;
 	i_nlink = 0;
-	while (1) {
+	for (i = 0; i < num_entries; free(dent[i]), i++) {
 		char buf[PATH_MAX];
 		struct erofs_inode *inode;
-
-		/*
-		 * set errno to 0 before calling readdir() in order to
-		 * distinguish end of stream and from an error.
-		 */
-		errno = 0;
-		dp = readdir(_dir);
-		if (!dp) {
-			if (!errno)
-				break;
-			ret = -errno;
-			goto err_closedir;
-		}
+		dp = dent[i];
 
 		if (is_dot_dotdot(dp->d_name)) {
 			++i_nlink;
@@ -1466,17 +1454,17 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		d = erofs_d_alloc(dir, dp->d_name);
 		if (IS_ERR(d)) {
 			ret = PTR_ERR(d);
-			goto err_closedir;
+			goto err_cleanup;
 		}
 
 		ret = snprintf(buf, PATH_MAX, "%s/%s", dir->i_srcpath, d->name);
 		if (ret < 0 || ret >= PATH_MAX)
-			goto err_closedir;
+			goto err_cleanup;
 
 		inode = erofs_iget_from_srcpath(sbi, buf);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
-			goto err_closedir;
+			goto err_cleanup;
 		}
 		d->inode = inode;
 		d->type = erofs_mode_to_ftype(inode->i_mode);
@@ -1484,7 +1472,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		erofs_dbg("file %s added (type %u)", buf, d->type);
 		nr_subdirs++;
 	}
-	closedir(_dir);
+	free(dent);
 
 	ret = erofs_init_empty_dir(dir);
 	if (ret)
@@ -1506,8 +1494,9 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 
 	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
-err_closedir:
-	closedir(_dir);
+err_cleanup:
+	for (; i < num_entries; free(dent[i]), i++);
+	free(dent);
 	return ret;
 }
 
-- 
2.47.0.338.g60cca15819-goog

