Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1389BB6B
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 11:17:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BEF21qsL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VCk4d5WNwz3dV4
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 19:17:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BEF21qsL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VCk4V3SSCz3cZM
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Apr 2024 19:16:56 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ed112c64beso1174907b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 08 Apr 2024 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1712567812; x=1713172612; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3Uj5FAC+M61l3oHE7fpClKyiFL3IdZumwvb6S11Osc=;
        b=BEF21qsL3RyRbuRkZbilvEH6RqMqcw1Cp9Gn2gVsZYcxsgqSo9OEZ26H6O2dIa425X
         X6Q1OAt0u0nbH+KDmGAMwAZiOcwvc2bCwLttXeAkYsrFCS6OVqb7BhUhAZ1DjJYbxqTj
         Rk41XcMQPtPCgkFeUdNkxDaVR8sJRNdEDgGqYgiWMRBtjkNaecSp4TJA20VOmG7T5wjI
         YHwf3C1iKq41r6OJ7wlJ5E85GlWI/RtmZp8u7Kk2OZRIM8JeZb7wSg848T/qHkJx6QIG
         xHdBiYO9EWtDDPnDi4//3hBtYAVI6cFi6RGd4sqA8XkVcHvTHd6JwrZ66QKkbdcbTd7E
         G1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567812; x=1713172612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3Uj5FAC+M61l3oHE7fpClKyiFL3IdZumwvb6S11Osc=;
        b=vJXPsS+RHXn+v0Xom+gjE55DA0FIvl/CWAR6wcYkbN/wzmm2b3IHO96qGZrta+CD07
         r5uaVyNbquywGYIYlEXid5NlSAZQXhCeOafLIHcXyrOjJeWxorUe5WJNkGU7dbpbHhII
         LanL3OXdo99ACyXLNIV7pcei/i6AxHIUdm4JSy4Kl+c09Vgb5aaFEiMoVEB1qDLWordx
         1jdGO6T+77JPng3uHHH/2eGYMM7u1emQJbwnIMqk94aEEq86EnZin2vq/yvqGF7O5aMX
         RsXxC69OITYIWM7tG+zhVyIP5nzQ/xyn3EVughvOoQ6vmaz5/XNk8mxuF1ESMb+IwsQE
         CsNw==
X-Gm-Message-State: AOJu0YzLgHgC3vJ0rNbe3iMo8GlfAQeGFF4xKHOO1DOs+CXzrNY9JJx7
	kbXE2CCTE4g2cnrwnmyX/X4G8c2pbR5imz1zA3TsjF7MKNZ/FiUqaetmdew+5WI=
X-Google-Smtp-Source: AGHT+IHE0R3VD460o9YUHtJahMaIb6+HCjwi81hh0BNLOPWTw7ZBS3I5KR7u9EVjufB5WOPaUl/bXA==
X-Received: by 2002:a05:6a20:3d95:b0:1a3:bd98:c4af with SMTP id s21-20020a056a203d9500b001a3bd98c4afmr8205790pzi.48.1712567811881;
        Mon, 08 Apr 2024 02:16:51 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b001e0b3c9fe60sm6456844plg.46.2024.04.08.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:16:51 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn
Subject: [PATCH] erofs-utils: change temporal buffer to non static
Date: Mon,  8 Apr 2024 18:16:26 +0900
Message-ID: <20240408091627.336554-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In multi-threaded mode, each thread must use a different buffer in tryrecompress_trailing
function, so change this buffer to non static.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 641fde6..7415fda 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -447,7 +447,7 @@ static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
 				   void *out, unsigned int *compressedsize)
 {
 	struct erofs_sb_info *sbi = ctx->ictx->inode->sbi;
-	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
+	char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
 
-- 
2.44.0

