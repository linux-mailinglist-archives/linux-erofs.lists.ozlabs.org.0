Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664B5AC8E5
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 04:52:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLY2x1B8Wz2ywc
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 12:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EojFbPVk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=EojFbPVk;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLY2q6mHwz2xr1
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Sep 2022 12:52:19 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id v4so6937065pgi.10
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Sep 2022 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ijTgJ2/g6444MLkKcXY5Yce5TMee3OWBUpKYURUXRlw=;
        b=EojFbPVkdDRQxuTaV9qCJuJttuXTMRh+R6e3pdNYqDnzdtr+gQYSjIzm12O5u0Gqi1
         c/bcf4RJk7k4sIHXymGMs7cdppNGMVrHSlAJk9BXxfiRCN09yqnWVxXjTWl4mFG7pHKH
         jLi5WT/W9apDysKwOVnVAl0TlC8KxR5E5soTJ1OQvy1OEIkIEOJWYuQeryiP4pDlBnGK
         SyPPA+YX10MOysEqtQJOl5Ti52beHKNWnwp07nJBgfsXcmp5WCVqwRCSikhomMXCBXqm
         z2YhDOiRQmCjgPUMTv4NAvVrSexqg8H8mGmsnTrE7/NIsRQGZxuLVy0Wc+18ZH159pp4
         +D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ijTgJ2/g6444MLkKcXY5Yce5TMee3OWBUpKYURUXRlw=;
        b=egsRCGXkrFI+hZT7FrhepbQ/fzauhcMHAagpJlD3spkeyW5ZN1NtpvqTf2wACLXCz2
         7R6xWx3aS8v4RN1QVoRfz2/3Zz2U6Xws2z+X8AWEnksxl0j4v3A98SzWz5Mz7okURo7d
         0j1BQTnTnblUOCFTKQwOCYFXDSq/OLymAIFccnickByumK/lUFEpIyXYaqRHZOusDvap
         ImKKBVxMqhXYj6YTIOhASv4trXRbKZiN6NUcq/kgbx50eMx4CMXzBObjKcc+3ya3uAiD
         iVSNPsXCCPMlXW5ZXlOPCguJhgLkNs5IYiAhDV82tPa2UJDCFNNSQZeG0Xu5S7SDjQnM
         Yb7w==
X-Gm-Message-State: ACgBeo0WMMH/pxUecC4Yv5iFF08VDQpLz5XvE/vDVr7G4tTW0krhihts
	tc2mEnAEXTOMH4Rrx/xXRBnjKIL+A+0=
X-Google-Smtp-Source: AA6agR7B8ad7vqQRW73LBoA1uvIO9secyGeF+nKdCEQFseMgYvatCcPE67XPmPue0upHP0xYK7jHTA==
X-Received: by 2002:a65:42cc:0:b0:431:af8c:77e1 with SMTP id l12-20020a6542cc000000b00431af8c77e1mr10659486pgp.308.1662346335544;
        Sun, 04 Sep 2022 19:52:15 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i194-20020a6287cb000000b0053788e9f865sm6378729pfe.21.2022.09.04.19.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 19:52:15 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 1/4] erofs-utils: fuse: support interlaced uncompressed pcluster
Date: Mon,  5 Sep 2022 10:51:45 +0800
Message-Id: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662345408.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662345408.git.huyue2@coolpad.com>
References: <cover.1662345408.git.huyue2@coolpad.com>
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
v6: one site code style + minor change of title

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

