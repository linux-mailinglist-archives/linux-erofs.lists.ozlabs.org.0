Return-Path: <linux-erofs+bounces-297-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A7AAE0B0
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 15:26:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZswyC3ttpz2y34;
	Wed,  7 May 2025 23:26:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746624371;
	cv=none; b=nd1R9w2TulYx78L/hys2O7GsUCUQRtFVosxnqf9E/mqijGQKYsCeMQIOlxwTOwMMGgW8NN9C4yudpjKMy45176MEhIrMR9ZflQmKTZcYC0xG81SBKS10eDD8QdsIORM/I05vdAvTkNLfaryUKrZX4R6zYXn2ZR8lrxN/BUnTQe6vcDxSSPra6xSJVsETqanometZLjjU2jR9FteEN/o80ijUApac7mjMBvFfq6+Qs4ozTc1m3prJwxRRx6HsDmAMwWNdXWsRVYA80IuFJyWW57mAAElqcwH8+syx/Hnr7PPbPoB8iIcFQZ73q5RbX6ne8z0/ofpZuo4SLuE/unPaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746624371; c=relaxed/relaxed;
	bh=IgdKi+bf1U8BATTtdEZw3uRgVwTX3tuSOZclul7Qts0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoIMlVp/XvTU9uzq4X2DaPFT5k9ZcaC8ZW460FvFZGNIgcqdbmsMnd4HDcOLb8yp3tH0xiwSTAkEztQgqkRsVJsogTTDMAt8QtE5LQJ/OE9w198MrUDBlueKy3UOd5AjCTI3TITn8wwIgH6mHZRU1BlMhH5NkNLvL+o+0q0DCb2tgzDuf6PX4MuGttN7z07CQqOWCmN/kgQu3yNzfEwQjCbf6Kr811KglFUUKReHPMwMPRmM7XSq4t5N1sCBN3mX9V3wQ3q/8oE6do0PkKZ7BzS86BWB4tjnZQXYZxf2LcsJIu9pwXgcPpyytxmPggCLLYn4SjsFry3N3Bw6Vz+SPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPts3qjY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPts3qjY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zswy80nQSz2xrL
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 23:26:05 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746624360; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=IgdKi+bf1U8BATTtdEZw3uRgVwTX3tuSOZclul7Qts0=;
	b=dPts3qjY+QdauQC5qC+EmwbuGPXYckLXa/Y8+3RcGCEzkzxFWacER1aYRnD22lnlDD9xGxvjVDgsV4IAldnPQePt6XJ0IxGpwrpCPnfat5faxuJxOhA1tf3sHKOW3iuEbeBUyoaxLvyhR1s87clUVlCnFbOHGj7V88S01C3QsJ4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZrIxg._1746624351 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 21:25:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Natanael Copa <ncopa@alpinelinux.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	=?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>
Subject: [PATCH v2] erofs-utils: fix build failure with musl libc
Date: Wed,  7 May 2025 21:25:48 +0800
Message-ID: <20250507132548.2293699-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506121102.GA15164@m1pro.arvanta.net>
References: <20250506121102.GA15164@m1pro.arvanta.net>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

because musl use readdir, pread and lseek instead of readdir64,
pread64 and lseek64.

Reported-by: Milan P. Stanić <mps@arvanta.net>
Thanks-to: Natanael Copa <ncopa@alpinelinux.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
(Fix wrong email address typo..)

Hi,

Due to the original patch lacks of the commit message and
SOB, so I revised myself.

I add "_FILE_OFFSET_BITS 64" in the top since "contrib/stress.c"
can be compiled individually.

Feel free to repost a formal patch if inappropriate.

Thanks,
Gao Xiang

 contrib/stress.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/contrib/stress.c b/contrib/stress.c
index d8def6a..0ef8c67 100644
--- a/contrib/stress.c
+++ b/contrib/stress.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2019-2025 Gao Xiang <xiang@kernel.org>
  */
+#define _FILE_OFFSET_BITS 64
 #define _GNU_SOURCE
 #include "erofs/defs.h"
 #include <errno.h>
@@ -271,7 +272,7 @@ static int __getdents_f(unsigned int sn, struct fent *fe)
 	}
 
 	dir = fdopendir(dfd);
-	while (readdir64(dir) != NULL)
+	while (readdir(dir) != NULL)
 		continue;
 	closedir(dir);
 	return 0;
@@ -428,7 +429,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 
 	printf("%d[%u]/%u read_f: %llu bytes @ %llu of %s\n", getpid(), procid,
 	       sn, len | 0ULL, off | 0ULL, fe->subpath);
-	nread = pread64(fe->fd, buf, len, off);
+	nread = pread(fe->fd, buf, len, off);
 	if (nread != trimmed) {
 		fprintf(stderr, "%d[%u]/%u read_f: failed to read %llu bytes @ %llu of %s\n",
 			getpid(), procid, sn, len | 0ULL, off | 0ULL,
@@ -439,7 +440,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 	if (fe->chkfd < 0)
 		return 0;
 
-	nread2 = pread64(fe->chkfd, chkbuf, len, off);
+	nread2 = pread(fe->chkfd, chkbuf, len, off);
 	if (nread2 <= 0) {
 		fprintf(stderr, "%d[%u]/%u read_f: failed to check %llu bytes @ %llu of %s\n",
 			getpid(), procid, sn, len | 0ULL, off | 0ULL,
@@ -477,14 +478,14 @@ static int read_f(int op, unsigned int sn)
 	if (ret)
 		return ret;
 
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= 0) {
 		if (!fsz) {
 			printf("%d[%u]/%u %s: zero size @ %s\n",
 			       getpid(), procid, sn, __func__, fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}
@@ -504,7 +505,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
 	for (pos = 0; pos < filesize; pos += chunksize) {
 		ssize_t nread, nread2;
 
-		nread = pread64(fe->fd, buf, chunksize, pos);
+		nread = pread(fe->fd, buf, chunksize, pos);
 
 		if (nread <= 0)
 			return -errno;
@@ -515,7 +516,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
 		if (fe->chkfd < 0)
 			continue;
 
-		nread2 = pread64(fe->chkfd, chkbuf, chunksize, pos);
+		nread2 = pread(fe->chkfd, chkbuf, chunksize, pos);
 		if (nread2 <= 0)
 			return -errno;
 
@@ -547,14 +548,14 @@ static int doscan_f(int op, unsigned int sn)
 	if (ret)
 		return ret;
 
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= 0) {
 		if (!fsz) {
 			printf("%d[%u]/%u %s: zero size @ %s\n",
 			       getpid(), procid, sn, __func__, fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}
@@ -576,7 +577,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
 	ret = tryopen(sn, __func__, fe);
 	if (ret)
 		return ret;
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= psz) {
 		if (fsz >= 0) {
 			printf("%d[%u]/%u %s: size too small %lld @ %s\n",
@@ -584,7 +585,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
 			       fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}
-- 
2.43.5


