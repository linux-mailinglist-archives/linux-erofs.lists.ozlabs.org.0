Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B783588618
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 05:52:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyHx50LB7z3056
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 13:52:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=blYRGXaZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=blYRGXaZ;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyHwt6lQKz2xGf
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Aug 2022 13:51:58 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id x10so14552121plb.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Aug 2022 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=1QVHjS/xU+6bNnRoUuHLDo7Vex93yCUf37XSNzOwkUI=;
        b=blYRGXaZTcmFTseqRHMfJTgrApGWbPxJTFA5Z1huv5o/gDv1p2Ge0191cAuIh+2AGW
         QKiOv1D98ZrCfrTLPFTcCg9USH/XnmFYfjt8LdkFcjk+C9r+q4qZIGXR94Moh7LW3+9O
         fMvXu4g3E80zushgg+oQh1AsGdJnHJBnDuE/zjmTAuRLrFKdeJ/SPwTzBAcWaeszjcQm
         nPFZAFx5QcQpxLF8QOp1HPC8exw/I9HNz1dEBhLCSgzEgtzFd4+auPTbyEy9VoFwLDje
         lD1CfiwcLjBICePXGzHu+3GYqBwhiGZNwgtD/RpOk47yG0jsdF2sxh16yPPqT1G2DALx
         HxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1QVHjS/xU+6bNnRoUuHLDo7Vex93yCUf37XSNzOwkUI=;
        b=graqHmTMqQdInhO70HcSGM3OIqoHftzVTcU3HeuxLYGv3jLh6Uo6VrEyRm2vcM5huA
         11EzFtOZbp9J252HU99z0Za/Tm4H1fEpgcHqMFb/KksLZXNjey78yz4V92hs3ZalIQmX
         cITFJ9gAVQupV0PYkw365TP9So6iuvqzY5T/xCHBUSeq934PU5hG1A3ONXm1TX082BYt
         RB4Ke736kh70VczElvD0icpbGef4o149SOwT8U/ptQ6vdTG8T0TDDdmzFUCwxgCRvwW+
         i2DuqWYiqQ1iMkZjTdDoEeiAWR8ruvG+R4/0fA1PXVZACTCgT9ZdtH34AFb149rYvaZ4
         jx0Q==
X-Gm-Message-State: ACgBeo0uTXvqrXL1b48jcGXWRXCdIFEtqU8AOansdfzLkZ0k3ORLuN6Z
	KuT8dgm/Kf/VLLaRKxK/3Z7hR8m0U1U=
X-Google-Smtp-Source: AA6agR51lxKs3QX/n0Jdm9H1M0IYep+DqSsQqAm5PZKaxqMUASKYJxV9/n7yL6uT9c1Vw8eXIWJrvw==
X-Received: by 2002:a17:902:ba83:b0:16a:2917:73de with SMTP id k3-20020a170902ba8300b0016a291773demr23921931pls.2.1659498716358;
        Tue, 02 Aug 2022 20:51:56 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e11-20020aa7980b000000b00528a097aeffsm2464629pfl.118.2022.08.02.20.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 20:51:56 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v3 2/3] erofs-utils: lib: support on-disk offset for shifted decompression
Date: Wed,  3 Aug 2022 11:51:29 +0800
Message-Id: <f8233c40941de1795e770273bcf88bea18fc3451.1659496805.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1659496805.git.huyue2@coolpad.com>
References: <cover.1659496805.git.huyue2@coolpad.com>
In-Reply-To: <cover.1659496805.git.huyue2@coolpad.com>
References: <cover.1659496805.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add support to uncompressed data layout with on-disk offset for
compressed files.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/decompress.h |  3 +++
 lib/data.c                 |  8 +++++++-
 lib/decompress.c           | 10 ++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 82bf7b8..b622df5 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
 	unsigned int decodedskip;
 	unsigned int inputsize, decodedlength;
 
+	/* head offset of uncompressed data */
+	unsigned int shiftedhead;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool partial_decoding;
diff --git a/lib/data.c b/lib/data.c
index b9dd07b..7e2e2cf 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0;
+	unsigned int bufsize = 0, head;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -307,10 +307,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 
+		head = 0;
+		if (erofs_sb_has_fragments() &&
+		    map.m_algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
+			head = erofs_blkoff(end);
+
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + end - offset,
 					.decodedskip = skip,
+					.shiftedhead = head,
 					.inputsize = map.m_plen,
 					.decodedlength = length,
 					.alg = map.m_algorithmformat,
diff --git a/lib/decompress.c b/lib/decompress.c
index 1661f91..08a0861 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -132,14 +132,20 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		unsigned int count, rightpart;
+
 		if (rq->inputsize > EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
-		memcpy(rq->out, rq->in + rq->decodedskip,
-		       rq->decodedlength - rq->decodedskip);
+		count = rq->decodedlength - rq->decodedskip;
+		rightpart = min(EROFS_BLKSIZ - rq->shiftedhead, count);
+
+		memcpy(rq->out, rq->in + (erofs_sb_has_fragments() ?
+		       rq->shiftedhead : rq->decodedskip), rightpart);
+		memcpy(rq->out + rightpart, rq->in, count - rightpart);
 		return 0;
 	}
 
-- 
2.17.1

