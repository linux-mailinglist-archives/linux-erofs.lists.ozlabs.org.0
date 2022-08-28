Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA75A3DDC
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 15:51:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MFw3b1vDfz3bc3
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Aug 2022 23:51:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QSM1mUQN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QSM1mUQN;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MFw3R08chz3bXZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 23:51:46 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id bg22so5692784pjb.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 28 Aug 2022 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=L0po4jYlJataNjsKZ605VvzZzese40vRfz0dAgGX1tw=;
        b=QSM1mUQNfvRhHqP2vuh6Wh6sG25cE2YNak6y76AaSM7twEPYTZzaHkEbN++1u733/D
         LE6VoqjB5TsIO2Q7JbH0SBTvxgYJsRulCVO2mpaZTqnuWDcx+7D5tQ1n3UkVGCIPtLz8
         DOz2g1ktt+QxgsAVWRIdib1g+U7SXNsuKSkxAKEJKGR5MgzD9oQ5KX1EOE54S9tDc5fS
         1Ev6xWyCzFcRAQcEc9FgFAumfKhwCyaqI7Fs4t/vnrROA+6NZYG4SjQPF3So3Xi+2dbn
         ifeuPMDGYljwFENglp3nwPAixgmmIVVGT4Fdaek7VBEYU9L4wOzvsp7YO06ClGEhcntq
         leyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=L0po4jYlJataNjsKZ605VvzZzese40vRfz0dAgGX1tw=;
        b=T+HGHKWSgI4wXpTQZekHWwDyL3AsQV0O1zdFXjxiDzAblzbTRTMnQc1IQEinZOM5qS
         38vtlKySiLT3JriiDdtvk2Z/HaAOjMw6lX6/TPzMfWDLuKf8ghb9i+3DwLa++aKwYcQ0
         Q451TCn9XX8dBh6hqaMYIB359nKYfWtDj2QaC/EzwCdqFWkH5ZAgVV/HiYTkxCO8x3OJ
         Brv1PZIgvOERHPniKsTLiHk8bDUKoLJ3sezhfyW7sdautCkf3UIEiHVsBAut3xPCqKUO
         9JpkFLBWjGEznQ8ySiDPlPczm3hiSDXgbC3m6+6fhd1vmgi1NpFT3QpL3T0XEF20x75Z
         pWXQ==
X-Gm-Message-State: ACgBeo02Ub1SKbEzL3Np/CvZlJ/jkKU8TX7Zm+1+diuBcLAn1Zj6wGK1
	goNE+Cxfc3IUPlND/TchEusEy7LWkc0=
X-Google-Smtp-Source: AA6agR7lL/HIgifh2J+Z1HlLFIxyDh7IvJ1rFY96T7fPvkHZV8WZNbhMPU+/qAjZODs0pU/2FZtvHg==
X-Received: by 2002:a17:902:70c4:b0:172:d8f5:b4bc with SMTP id l4-20020a17090270c400b00172d8f5b4bcmr12132153plt.32.1661694704310;
        Sun, 28 Aug 2022 06:51:44 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a4b4900b001fbb0f0b00fsm4795754pjl.35.2022.08.28.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:51:44 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 1/4] erofs-utils: fuse: support interlaced uncompressed data for compressed files
Date: Sun, 28 Aug 2022 21:51:06 +0800
Message-Id: <06e99409a12d7bb0cb261030b5d9003cc10469d4.1661694414.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661687617.git.huyue2@coolpad.com>
References: <cover.1661687617.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661694414.git.huyue2@coolpad.com>
References: <cover.1661694414.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
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
 lib/decompress.c           | 16 ++++++++++++++--
 4 files changed, 26 insertions(+), 3 deletions(-)

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
index 1661f91..b638396 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -132,14 +132,26 @@ out:
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
+			skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
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

