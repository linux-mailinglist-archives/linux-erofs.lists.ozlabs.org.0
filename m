Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FB9FC804
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 05:58:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YJbxF0RZ3z30WT
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 15:58:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735189102;
	cv=none; b=Z9g8IFQGOCjy6Lc49GE9M+uXpEmWvvZ+/WYFq7LHvC0I4mGzxOeQYtdufPqaBfI7KkQwzOfq4Oap6S9YTfGUC+d1wuAw6Dvalsunme/pgR7PPLZYscvbhRttIqDPyf2P9rswnM4MGmii4+P6M8HmxrqsXLYRX3tBy/rcyO4jPGH4OZI+yM6agLSix90XKT7hpZeZWfm1U05cxEXqXweX3sOxhaBZKn4rqfm02BIxK7l0ZtY39iKMamOk6WmhaCBB/MXzIG3ArB/0WBDOByFqsI7M3d95iL26BIXpNeF2iXShZgFC94q0m4Z4za/4HTkOMSS7h6ZdCSes7jrojFCozw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735189102; c=relaxed/relaxed;
	bh=G3fs7SUDv8MG7QnslAHPPZ6F538gPWi8xg0PWMB+iws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ne6vzAMVcYL1CRgZaeVQ8G1xeraCIXC2IL7cIoZp9+LbRhLUf6yHy0wtEoHN8sqUFFXDis0yMBM/Q6QUeTP7oSVUonMUNf8HthLcEkyFH9sMOcSLSGc30rP9aZ+UhbrsYfCDI1b+vUklvFq0JCqyrtt+1E5BtmvaBk2FGRkTwPzNKk6MXjPvHIHIugHYqgv044TO1brgoof9RDEsTZzyWvh5TZ97GpwYjKR9HvPBtqTIQmV6jzyr7HVG5Zt4FvK25qFbmWZ+/zEJKkohjPdGfNwSTatgAZlDmSD9t1EYLm2hSUdmwIFStP94Sh6Z7TKnuxmmqI5lqkQmYXzzXrJATg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CJ0Yfq0W; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CJ0Yfq0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YJbx80PWJz2y66
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2024 15:58:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735189092; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=G3fs7SUDv8MG7QnslAHPPZ6F538gPWi8xg0PWMB+iws=;
	b=CJ0Yfq0WsKmmoyAv6m+uoT/KkqlMLxXO2+Jy+Ag0COqvDLENqbJhO5BXOz2EQL7bzABNOpyEU7TMfVRxyRsHB/oEqPoAP1HGeVpgobPxKylE0EVvvK1y8o5GzFo50i8O3911Fb6xYTD6s7tTWz7YwWxX25ZH7HYXp7s0xqS6Iwo=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMH.Xv-_1735189090 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 12:58:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: tar: ignore useless fields of PAX extended headers
Date: Thu, 26 Dec 2024 12:58:06 +0800
Message-Id: <20241226045808.95101-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

Since some unknown writer just leaves zero-filled mtime, e.g.
registry.k8s.io/pause:3.6  --platform windows

Layer sha256: bc8517709e9cfff223cb034ff5be8fcbfa5409de286cdac9ae1b8878ebea6b84

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 78 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 0dd990e..12bf595 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -659,6 +659,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	struct erofs_sb_info *sbi = root->sbi;
 	bool whout, opq, e = false;
 	struct stat st;
+	mode_t mode;
 	erofs_off_t tar_offset, dataoff;
 
 	struct tar_header *th;
@@ -751,26 +752,6 @@ out_eot:
 		goto out;
 	}
 
-	st.st_mode = tarerofs_otoi(th->mode, sizeof(th->mode));
-	if (errno)
-		goto invalid_tar;
-
-	if (eh.use_uid) {
-		st.st_uid = eh.st.st_uid;
-	} else {
-		st.st_uid = tarerofs_parsenum(th->uid, sizeof(th->uid));
-		if (errno)
-			goto invalid_tar;
-	}
-
-	if (eh.use_gid) {
-		st.st_gid = eh.st.st_gid;
-	} else {
-		st.st_gid = tarerofs_parsenum(th->gid, sizeof(th->gid));
-		if (errno)
-			goto invalid_tar;
-	}
-
 	if (eh.use_size) {
 		st.st_size = eh.st.st_size;
 	} else {
@@ -779,16 +760,6 @@ out_eot:
 			goto invalid_tar;
 	}
 
-	if (eh.use_mtime) {
-		st.st_mtime = eh.st.st_mtime;
-		ST_MTIM_NSEC_SET(&st, ST_MTIM_NSEC(&eh.st));
-	} else {
-		st.st_mtime = tarerofs_parsenum(th->mtime, sizeof(th->mtime));
-		if (errno)
-			goto invalid_tar;
-		ST_MTIM_NSEC_SET(&st, 0);
-	}
-
 	if (th->typeflag <= '7' && !eh.path) {
 		eh.path = path;
 		j = 0;
@@ -810,28 +781,29 @@ out_eot:
 
 	dataoff = tar->offset;
 	tar->offset += st.st_size;
+	st.st_mode = 0;
 	switch(th->typeflag) {
 	case '0':
 	case '7':
 	case '1':
-		st.st_mode |= S_IFREG;
+		st.st_mode = S_IFREG;
 		if (tar->headeronly_mode || tar->ddtaridx_mode)
 			tar->offset -= st.st_size;
 		break;
 	case '2':
-		st.st_mode |= S_IFLNK;
+		st.st_mode = S_IFLNK;
 		break;
 	case '3':
-		st.st_mode |= S_IFCHR;
+		st.st_mode = S_IFCHR;
 		break;
 	case '4':
-		st.st_mode |= S_IFBLK;
+		st.st_mode = S_IFBLK;
 		break;
 	case '5':
-		st.st_mode |= S_IFDIR;
+		st.st_mode = S_IFDIR;
 		break;
 	case '6':
-		st.st_mode |= S_IFIFO;
+		st.st_mode = S_IFIFO;
 		break;
 	case 'g':
 		ret = tarerofs_parse_pax_header(&tar->ios, &tar->global,
@@ -876,6 +848,40 @@ out_eot:
 		goto out;
 	}
 
+	mode = tarerofs_otoi(th->mode, sizeof(th->mode));
+	if (errno)
+		goto invalid_tar;
+	if (__erofs_unlikely(mode & S_IFMT) &&
+	    (mode & S_IFMT) != (st.st_mode & S_IFMT))
+		erofs_warn("invalid ustar mode %05o @ %llu", mode, tar_offset);
+	st.st_mode |= mode & ~S_IFMT;
+
+	if (eh.use_uid) {
+		st.st_uid = eh.st.st_uid;
+	} else {
+		st.st_uid = tarerofs_parsenum(th->uid, sizeof(th->uid));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (eh.use_gid) {
+		st.st_gid = eh.st.st_gid;
+	} else {
+		st.st_gid = tarerofs_parsenum(th->gid, sizeof(th->gid));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (eh.use_mtime) {
+		st.st_mtime = eh.st.st_mtime;
+		ST_MTIM_NSEC_SET(&st, ST_MTIM_NSEC(&eh.st));
+	} else {
+		st.st_mtime = tarerofs_parsenum(th->mtime, sizeof(th->mtime));
+		if (errno)
+			goto invalid_tar;
+		ST_MTIM_NSEC_SET(&st, 0);
+	}
+
 	st.st_rdev = 0;
 	if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
 		int major, minor;
-- 
2.39.3 (Apple Git-146)

