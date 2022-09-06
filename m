Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD65AE836
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 14:33:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMPtD3tsWz2xGS
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 22:32:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qNrUSyqd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qNrUSyqd;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMPt92C33z2xRq
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 22:32:47 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7302480pjl.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 Sep 2022 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=/up3SkrBIZVFgzZ4e3zYRgkPH915UUyIxAd/J03ekoE=;
        b=qNrUSyqdqkCfHG46iaEfXuJV+rjyr6BaTDRxyvLWD0XUDZD1wvoou7/0LZ21tk17mv
         Se4W0eE8NavmqN2r+ksegYVSfF2JcOzhCw4U5HcjEF2i57JuG5lTM2sKSpfTayx5UdV5
         rKL0O3YyPXsQ67bUSzJ0l/QtlSA8B5lInjqoIqmuwCJ9CcPgALMUhqVa9seA29Gy7m/u
         Etoy1vtBcdlwossx1FdKJcwyuHU7sztvpyanwL2m7+w3reWToS0E09XPVbWbkXdK/H87
         b4M94aSxx0uz5nlBUQrK6vXO6dSHcAePHs/HoTLkuhCFVMzeBHTOhjZqCHuFeqGnuNgx
         WsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/up3SkrBIZVFgzZ4e3zYRgkPH915UUyIxAd/J03ekoE=;
        b=h4IudZV7IvcmOApds+4CZ27i+VZSlkZD+5WBOJxvopFzes4692KMYPol5LQgbqejF3
         r8l16bka/DqRVvSJA07uIDoiGqxpI/KWqH3Eke7v4WMT8AbYFRpz5kQ3G2Ot1S+Qeckz
         kh1TkufC+EpkyNLFf7yU56KrxcVTlonhJmfL2t/3PKSLBIiPzMpxln5Vw12+PGHL0I32
         fOrYQVgYCtpNtBG2fYLH7SyOLi7yeZpU2FOUKrSu/MiaQ8fynJN2RO2sBURnv/DvUURI
         8rJt06ButAda9G01r4kNWHUUbbB18+3x/syX5kOIF3SdZX6VGsol+URQ+ycBBeSY6sUE
         MOrw==
X-Gm-Message-State: ACgBeo3wuKmctWm814dOAPpJqrm6m8iQ9cCNB5FDOyr/4YgYefUyHEeO
	aDyqqdqsIHKA05WiDsFSGsKV1lkr4mE=
X-Google-Smtp-Source: AA6agR60ZWikdOUWTRLWoiWORyCNAoXYHbtVzHIqHo81kOI7Pvopo1AWbxSCIw2uGcsx0PhDzOHhvg==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr24756700pjb.146.1662467565377;
        Tue, 06 Sep 2022 05:32:45 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm3510993pli.284.2022.09.06.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:32:45 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V7 1/4] erofs-utils: fuse: support interlaced uncompressed pcluster
Date: Tue,  6 Sep 2022 20:32:32 +0800
Message-Id: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662460303.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662460303.git.huyue2@coolpad.com>
References: <cover.1662460303.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662460303.git.huyue2@coolpad.com>
References: <cover.1662460303.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Support uncompressed data layout with on-disk interlaced offset in
compression mode for erofsfuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/decompress.h |  3 +++
 include/erofs_fs.h         |  2 ++
 lib/data.c                 |  8 +++++++-
 lib/decompress.c           | 17 +++++++++++++++--
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 82bf7b8..a9067cb 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -23,6 +23,9 @@ struct z_erofs_decompress_req {
 	unsigned int decodedskip;
 	unsigned int inputsize, decodedlength;
 
+	/* cut point of interlaced uncompressed data */
+	unsigned int interlaced_offset;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool partial_decoding;
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..b8a7421 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -294,11 +294,13 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 
 struct z_erofs_map_header {
 	__le16	h_reserved1;
diff --git a/lib/data.c b/lib/data.c
index ad7b2cb..2d76816 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -226,7 +226,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0;
+	unsigned int bufsize = 0, interlaced_offset;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -287,10 +287,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret < 0)
 			break;
 
+		interlaced_offset = 0;
+		if ((inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER) &&
+		    map.m_algorithmformat == Z_EROFS_COMPRESSION_SHIFTED)
+			interlaced_offset = erofs_blkoff(map.m_la);
+
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + end - offset,
 					.decodedskip = skip,
+					.interlaced_offset = interlaced_offset,
 					.inputsize = map.m_plen,
 					.decodedlength = length,
 					.alg = map.m_algorithmformat,
diff --git a/lib/decompress.c b/lib/decompress.c
index 1661f91..39da555 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -132,14 +132,27 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		unsigned int count, rightpart, skip;
+
 		if (rq->inputsize > EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
-		memcpy(rq->out, rq->in + rq->decodedskip,
-		       rq->decodedlength - rq->decodedskip);
+		count = rq->decodedlength - rq->decodedskip;
+
+		if (rq->interlaced_offset) {
+			skip = erofs_blkoff(rq->interlaced_offset +
+					    rq->decodedskip);
+			rightpart = min(EROFS_BLKSIZ - skip, count);
+		} else {
+			skip = rq->decodedskip;
+			rightpart = count;
+		}
+		memcpy(rq->out, rq->in + skip, rightpart);
+		memcpy(rq->out + rightpart, rq->in, count - rightpart);
+
 		return 0;
 	}
 
-- 
2.17.1

