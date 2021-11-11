Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC644CF54
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 02:56:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqPvr3Bw6z2yYS
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 12:56:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636595784;
	bh=qCJBcNXTQfZTRgQCH6pycsXkaeYAcsKSEsGRLoa/NHQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VebQTHRGOmRN/kuMLMOxpUS9PuFwZpjPODQ3rZdBw2u1AGAxO4z8d+XXW0Qavno+R
	 spF3QgxdqCVoAcIv9gmdPWnC6+w9IfoPowUvofoXiYdw5pdmAe3g4y91nkwwzlWFsK
	 9y8AVqHyZsHs9PfOWU1yTzETkQ08M8xIYsnyc2eAKD9uvTqb9pJIWOMF8O+6S7IGL7
	 X0ULNSpIC+NXCec814kyjV32Idcwpku6vF0S7y4OUpdODN9dAlbmStdnqmUhRvZ2b0
	 HMLeGqWC+ltWOvv3tCtoSdcnbb3ixp/bX+x2k3MfRDwkDCOB9YWf/fhbYWy2ttarla
	 wIkceY9RsSAeQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3hximyqckc1ixfu7xyb08805y.w86527eh-yb8zc52cdc.8j5uvc.8b0@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=BuDMm2aZ; dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqPv56QsHz2yPS
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 12:55:44 +1100 (AEDT)
Received: by mail-qt1-x849.google.com with SMTP id
 k1-20020ac80c01000000b002a79e319399so3580351qti.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 17:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=qCJBcNXTQfZTRgQCH6pycsXkaeYAcsKSEsGRLoa/NHQ=;
 b=fSh9mSgOi9S+X0o7RYL2Gax33Di/gcyOxlafD5OSYDErS9owNZIcYpk+N3/SYwW9sZ
 3+fwE2EFpS0U5AKWz7EA4Urv0lXUC1W3jYiXGORSZqq4dyUY3Ttdy66X05pwnvXNj/Oa
 60U5SuITMLRsdrNmAbDSnTptH+DpFGEwG7Nq69MRC1Ql5PiPo9qpQyRyMAi/EzfsfX5s
 wGkto1Vi4sq4hVPSJOFlEHd7GyN67dca1muZhw4j13pMYPc574t27W4itNdkblIqQ2qC
 qM2TAQCwXlmIm+ftruXE+xiYQJYYLyX45DBiu4ZK+tyX0UVZdzlrbjfzUDxlvF5ddCbK
 Ytjg==
X-Gm-Message-State: AOAM531+tthUZEENwmATNDsV2E+gNOTfrvpOfA24S4yXthB5IwoBXREL
 I0dOZuQuFpFrStLonOQNG0BaOjyArJK0mTt1y7N0CpvPOu1nxP7VpVJ2Cu3Kak/DqxGuBfyxzHh
 uxO6mhgmUap0RDyigAKgJvEAOs4PEg++R3J/89qvCl/Jjc4q45iYFDlSmV/5Rr3ANUr85blH/
X-Google-Smtp-Source: ABdhPJwoIHjS0i9uYdKhFlbB80hlM9nKVOHorqrNp3x00Nx3mp6yzZ29bXNtGZByokgnS6SvNGIM8MVrhWqL
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a05:622a:3ca:: with SMTP id
 k10mr3844555qtx.198.1636595741148; Wed, 10 Nov 2021 17:55:41 -0800 (PST)
Date: Thu, 11 Nov 2021 01:55:27 +0000
Message-Id: <20211111015527.2717076-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] erofs-utils: mkfs: fix integer overflow in erofs_blob_remap
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using --chunksize, partitions greater than 2GiB can fail to build
due to integer overflow in erofs_blob_remap.

Signed-off-by: David Anderson <dvander@google.com>
---
 include/erofs/io.h |  6 +++---
 lib/blobchunk.c    |  2 +-
 lib/io.c           | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 2597c5c..9d73adc 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -27,9 +27,9 @@ u64 dev_length(void);
 
 extern int erofs_devfd;
 
-int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-                          int fd_out, erofs_off_t *off_out,
-                          size_t length);
+ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+			      int fd_out, erofs_off_t *off_out,
+			      size_t length);
 
 static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			    u32 nblocks)
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 661c5d0..a0ff79c 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -179,7 +179,7 @@ int erofs_blob_remap(void)
 	struct erofs_buffer_head *bh;
 	ssize_t length;
 	erofs_off_t pos_in, pos_out;
-	int ret;
+	ssize_t ret;
 
 	fflush(blobfile);
 	length = ftell(blobfile);
diff --git a/lib/io.c b/lib/io.c
index cfc062d..279c7dd 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -259,9 +259,9 @@ int dev_read(void *buf, u64 offset, size_t len)
 	return 0;
 }
 
-static int __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-				   int fd_out, erofs_off_t *off_out,
-				   size_t length)
+static ssize_t __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+				       int fd_out, erofs_off_t *off_out,
+				       size_t length)
 {
 	size_t copied = 0;
 	char buf[8192];
@@ -331,9 +331,9 @@ static int __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 	return copied;
 }
 
-int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-			  int fd_out, erofs_off_t *off_out,
-			  size_t length)
+ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
+			      int fd_out, erofs_off_t *off_out,
+			      size_t length)
 {
 #ifdef HAVE_COPY_FILE_RANGE
 	off64_t off64_in = *off_in, off64_out = *off_out;
-- 
2.34.0.rc0.344.g81b53c2807-goog

