Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E39E0F48
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 00:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733182097;
	bh=rkvR5FpsafRd5Z4YbbpQzrlWkSs6CCaGMomyDg4XCEQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ReEQMyoPlNts6NFL2CCT1E5K8b+uX/8EZv+eT7dzC6Z9C9aRr5J07MMGDESrVHqqt
	 B1gxuxGhj3dLLnPU8WdpS6y9s4tnk/Xoq1FOix+RVr4dqFju53CfgfEoP/EGx2iIFJ
	 CYlCnkyf1cIqkAhiIAcp+WSiBLn9OHO+yToWkh3NEKMSkJkMdlgnIOdN7rioIYKgYS
	 5fe1XvADPC5V9IympRijzcHKmGRxoWHw4CF2WaH+3XLSdywfsHXOc71g/L0E6qYEEx
	 ofZ6IYQsVKezTvtQ7RvW9NERwBcl+vpri3hH8Lx5LNQKOSI3x9291IP7gAT3YDwgbs
	 /2nGxx2C1rxFg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Khx1phqz300V
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 10:28:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733182095;
	cv=none; b=N7A0DJOpp8oQB/tdFk0w1R5FHBOuPyjk1v5PZZGnGYSvZ19CQWU3tOTZC0pRPvASpnZ3BfJYLZn3+32NdJsfeiGFn1KZ9JH2mB/tV3GpBuTX/InVqVBJVMmuRFzY6z1jld9bBUIcMHsSSWReUIQvZgubFUjnokVhXmBzNK3RBcuBHOPJ/y9aEdJvz2IdyKWmTfCCMOcWTfZU5cikNkV1BhTCQxrbQtBpf9IrYNSV5P0FsvNhnLj9fUE3/uS51IgxsxUHs7dQ7l6TMiC7WwqY9sVj/OQj1t4UgyOWzFKcHqlJZoHsjqyHaanTHnGgfZdiKMFtA+mNkOAB37zlS5O7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733182095; c=relaxed/relaxed;
	bh=rkvR5FpsafRd5Z4YbbpQzrlWkSs6CCaGMomyDg4XCEQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hXYyYipWoUYy3ms/dIZ9AIGmqrpXgoy8bBX2rtDmw7biyKnRzZQZcDiy38g0pG4dxnlIXo0DBI+2NESU42o6+EPvmq93rkWH/sHk5e4Ss490XSTuMATL0H53yZcbA2ULr+r3JpdjUj668CRps3RAlWL0e+cB34smDEM1cE9uiFkWHOznyJ4uh0ko5UuE+/d7Sn4HR572Vpx4BY9+vR/GVwGISXDiVxNTqBwRN2Q+psAr+vWkQRSyBdKoBnHUEDlS/b+gmtX7Rdts8ZItGhvXzHrDbZGlU6kBf2o53IRbKvdddRQmGPEwDw+z68LqhV4nMCx0UT2764xGV3DlewhhUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Poy1vgsN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3iujozwckc4gv00a6zss00sxq.o0yxuz69-q30r4xu454.0bxmn4.03s@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--jooyung.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Poy1vgsN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--jooyung.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3iujozwckc4gv00a6zss00sxq.o0yxuz69-q30r4xu454.0bxmn4.03s@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Khs6FN9z2xGw
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 10:28:12 +1100 (AEDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2156cb2c3d2so28904965ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 15:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733182089; x=1733786889; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkvR5FpsafRd5Z4YbbpQzrlWkSs6CCaGMomyDg4XCEQ=;
        b=Poy1vgsNOoY7yBubR30gvjqGBLbKREnuIYwgg9PY6PqyYkmn2i4t5L/eVLR+DEhkZI
         0BAkB1RN8+5lGAapvrpMh2akZxMaFEvmt1DtwGg2VarvEpFyrpgU395OOY8IhOzNcO1R
         KQS72IhFr+UKLrcewIJu1RyBuIxnqQ2zXsSNHV8R9doAO0J+2O4XI7xDUipOIECqz9Sp
         zeH5KD6iXfCmUdL9PsKnh7EgzfALzsk+01Vnsgp5IF1M4KScCyoSAyecsKHOI+MMbqD1
         4hGS97rojxr68cEtLjoEvkukLXV7m77FTwsqwYzpWWRmhR5PG1Wn/RmzDcvD4V2L/H2f
         UgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182089; x=1733786889;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkvR5FpsafRd5Z4YbbpQzrlWkSs6CCaGMomyDg4XCEQ=;
        b=vs7t5Nci1USCsG3XVittvS3lxIfG0VrvH6aHslhVVaaljzaPvEBRYBeRuUktxMU1MA
         sUmMHnuyz/0abKQmiLu/6FZfgPSUBW5r2GTRD/cD2Mgn8NTd0Du6MzYL1SDHWyMG0Jae
         3o7M1y4d//5kz2Ky0VJYLjw53rigES8CUPi3xLtweX3B3VVH/6yhuiTmJhFN2piOXUOE
         0CPxWynUl/MgUrYEz15ug6o8U4i9rJ/OyyO1avF+FD3qVOgfJFsbi5NoJ2TFYWajulZP
         Qhja5GY1cxR3iFGznGrX/wInNGlTCdWpwIcdN03Nc9tzAeOaBcM5m/epQuu306mjuugl
         wY0Q==
X-Gm-Message-State: AOJu0YwUR04Vzmj816yu72dI/Hy52i/uQHHJ/SxV7L2ZZo7pV/MZpwUS
	Cde0d4STjU1E8cHX8Z8ZXSOBccVa2S6IDllb/hCQ+SdRNAHpz01XxO0kHdInlfBsG/KpP4xLfw/
	jWVqhUn3z/xzjNOfSYmM4A6OWcpvKln71m3CQnJKyELVIt6xR/W0gXNd5bffZzFOZK7973j9M1C
	o/5N238L51c1JpN7e/GcGMstn1zA55Y7sZLM1ARQ6IOUKb8A==
X-Google-Smtp-Source: AGHT+IHEODJPG2o1XnWhy0quJ0hFz9XyeAC2SRBg1p/L8uHIfftpyk/ViBC3sTxiyf1Gx6nBxQw+1XblHifh
X-Received: from plhk16.prod.google.com ([2002:a17:902:d590:b0:215:b086:b20e])
 (user=jooyung job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:183:b0:215:acb3:375d
 with SMTP id d9443c01a7336-215bd1ce3a6mr4472565ad.18.1733182089259; Mon, 02
 Dec 2024 15:28:09 -0800 (PST)
Date: Tue,  3 Dec 2024 08:26:20 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202232620.3604736-1-jooyung@google.com>
Subject: [PATCH] erofs-utils: mkfs: use scandir for stable output
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
Cc: Jooyung Han <jooyung@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The iteration order of opendir/readdir depends on filesystem
implementation. Hence, even with the same contents, the filesystem of
the input directory affects the output.

In this change, opendir/readdir is replaced with scandir for stable
order of iteration. This produces the same output regardless of the
filesystem of the input directory.

Bug: 381793828
Test: make_erofs ... inputdir(ext3)
Test: make_erofs ... inputdir(tmpfs)
  # should generate the same output
Change-Id: I629834031634e3575490e3ded4385f666ee4fde9
---
 lib/inode.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index b9dbbd6..a460a8f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1413,37 +1413,25 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
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
@@ -1475,7 +1463,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		erofs_dbg("file %s added (type %u)", buf, d->type);
 		nr_subdirs++;
 	}
-	closedir(_dir);
+	free(dent);
 
 	ret = erofs_init_empty_dir(dir);
 	if (ret)
@@ -1498,7 +1486,8 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
 err_closedir:
-	closedir(_dir);
+	for (; i < num_entries; free(dent[i]), i++);
+	free(dent);
 	return ret;
 }
 
-- 
2.47.0.338.g60cca15819-goog

