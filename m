Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032B65F9EF
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 04:06:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Np7XX1D2Tz3c1p
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 14:06:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=farADzJc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=farADzJc;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Np7XR5sbpz2ypJ
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 14:06:29 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id y5so211897pfe.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Jan 2023 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjdUxTYyvT21n1mBdG3/8qPlUTlvZ80hSxXGAd1hnqI=;
        b=farADzJcgDKB0XfeJcyOyM7aIYJHLEWHwamidLo2bAEYMaE4wXi+ZzLVBLRm04GH46
         HFdkoIilVjNlxSit4mAbaVZS3ydrBTh8Clgf+wRhU9uF+ktr8ZucULX5NP1SP+g/m4wf
         HkrJu9G/UUWuCdee30HR/XhpvkhHFjXRUb0c+TJOL8J9jr0F5r5vceQKktDSNqpIyk+W
         14D9ZQBYfl3he92KqkoJ9Dnp8waF7b5eNu6YhqOThgvDMdszceXzlbetSbgwmBgPEUHg
         ghGWqDkXbL/nz+a0YLGsRI6/MlUOhIaui2HAmfxH1CHKMMI7rTBiF3ZVrtjYZmEsE7nP
         0Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjdUxTYyvT21n1mBdG3/8qPlUTlvZ80hSxXGAd1hnqI=;
        b=Zn0m5ZgE6yr8rezJjp8Iq0oTd9UAzNNOUVc7glinia/ZnUHt5RVU40uhEXuEzce8T5
         FXpz6rBnG7Ft0nBT8bIsSkROf6yTkiChRyez5alQmtGUJ1hBC9I3wTuYageS6o6b9O/l
         Z9S6XfNsBLi6y3PYiSRdICr0LYlqnFAEI8Z3RF/UKyWftiLHMBc797fqYDecpUAlsn2U
         Sk8tJ3v+Zyj4eZt5Vdr7cz9MFIBxzS8yT77lKy6vLCH8EtwPQO/og4GD7mfIgGN5v4PH
         Jd7yi4FYfZsb5woTgH05Dq8gMQtcSUD/MoEGP5GyzwcC6bV1TYQ+rI2n0IgFbxyGN4Th
         tVVw==
X-Gm-Message-State: AFqh2ko0AEDfuWkpKW8z8lTWgiqJ3ofx91SFhGz+WlHRKLVOofYhtOnK
	dhHGx+bMcXlqr/CANn+u0IijZ4f9Pcc=
X-Google-Smtp-Source: AMrXdXuQfVFfRexbUC5SHzsazpbwNjXj1FYgQf4k1CqtZctNqT4RjBY+2RN2xGCG/MjyqnI+LMhYwA==
X-Received: by 2002:a62:84c9:0:b0:581:1f4b:d1e5 with SMTP id k192-20020a6284c9000000b005811f4bd1e5mr41877840pfd.12.1672974386426;
        Thu, 05 Jan 2023 19:06:26 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g84-20020a625257000000b00580978caca7sm13808pfb.45.2023.01.05.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:06:26 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Fri,  6 Jan 2023 11:06:13 +0800
Message-Id: <afbd9fa557391b23731309f3d5a6be9d9d0de82e.1672972780.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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

We should reuse the main part of erofs_read_raw_data() and
z_erofs_read_data() to avoid duplicated code.

Note that fragment feature is supported correspondingly as well after
this change.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: use erofs_pread() directly

 fsck/main.c | 146 +++++++++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 86 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..0c47d23 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -361,36 +361,14 @@ out:
 	return ret;
 }
 
-static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
+static int erofs_verify_inode_data_mapping(struct erofs_inode *inode,
+					   bool compressed)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
-	struct erofs_map_dev mdev;
 	int ret = 0;
-	bool compressed;
 	erofs_off_t pos = 0;
-	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
-
-	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-		  inode->nid | 0ULL, inode->datalayout);
-
-	switch (inode->datalayout) {
-	case EROFS_INODE_FLAT_PLAIN:
-	case EROFS_INODE_FLAT_INLINE:
-	case EROFS_INODE_CHUNK_BASED:
-		compressed = false;
-		break;
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
-		compressed = true;
-		break;
-	default:
-		erofs_err("unknown datalayout");
-		return -EINVAL;
-	}
 
 	while (pos < inode->i_size) {
 		map.m_la = pos;
@@ -401,102 +379,98 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			ret = erofs_map_blocks(inode, &map,
 					EROFS_GET_BLOCKS_FIEMAP);
 		if (ret)
-			goto out;
+			return ret;
 
 		if (!compressed && map.m_llen != map.m_plen) {
 			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
 				  map.m_la, map.m_llen, map.m_plen);
-			ret = -EFSCORRUPTED;
-			goto out;
+			return -EFSCORRUPTED;
 		}
 
 		/* the last lcluster can be divided into 3 parts */
 		if (map.m_la + map.m_llen > inode->i_size)
 			map.m_llen = inode->i_size - map.m_la;
 
-		pchunk_len += map.m_plen;
 		pos += map.m_llen;
+	}
+	return 0;
+}
 
-		/* should skip decomp? */
-		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
-			continue;
+static int erofs_do_verify_inode_data(struct erofs_inode *inode, int outfd,
+				      bool compressed)
+{
+	int ret = 0;
+	erofs_off_t pos = 0;
+	unsigned int buffer_size = 0;
+	char *buffer = NULL;
 
-		if (map.m_plen > raw_size) {
-			raw_size = map.m_plen;
-			raw = realloc(raw, raw_size);
-			BUG_ON(!raw);
-		}
+	/* no option --extract */
+	if (!fsckcfg.check_decomp)
+		return erofs_verify_inode_data_mapping(inode, compressed);
 
-		mdev = (struct erofs_map_dev) {
-			.m_deviceid = map.m_deviceid,
-			.m_pa = map.m_pa,
-		};
-		ret = erofs_map_dev(&sbi, &mdev);
-		if (ret) {
-			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
-				  map.m_pa, map.m_deviceid, inode->nid | 0ULL,
-				  ret);
-			goto out;
-		}
+	while (pos < inode->i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t, inode->i_size - pos,
+					    EROFS_CONFIG_COMPR_MAX_SZ);
 
-		if (compressed && map.m_llen > buffer_size) {
-			buffer_size = map.m_llen;
+		if (maxsize > buffer_size) {
+			buffer_size = maxsize;
 			buffer = realloc(buffer, buffer_size);
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
-		if (ret < 0) {
-			erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
-				  mdev.m_pa, map.m_plen, inode->nid | 0ULL,
-				  ret);
+		ret = erofs_pread(inode, buffer, maxsize, pos);
+		if (ret)
 			goto out;
-		}
 
-		if (compressed) {
-			struct z_erofs_decompress_req rq = {
-				.in = raw,
-				.out = buffer,
-				.decodedskip = 0,
-				.interlaced_offset =
-					map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
-						erofs_blkoff(map.m_la) : 0,
-				.inputsize = map.m_plen,
-				.decodedlength = map.m_llen,
-				.alg = map.m_algorithmformat,
-				.partial_decoding = 0
-			};
-
-			ret = z_erofs_decompress(&rq);
-			if (ret < 0) {
-				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
-					  mdev.m_pa, map.m_plen,
-					  inode->nid | 0ULL, strerror(-ret));
-				goto out;
-			}
-		}
+		pos += maxsize;
 
-		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
-					map.m_llen) < 0) {
+		if (outfd >= 0 && write(outfd, buffer, maxsize) < 0) {
 			erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
 				  inode->nid | 0ULL);
 			ret = -EIO;
 			goto out;
 		}
 	}
-
-	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
-		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
-	}
 out:
-	if (raw)
-		free(raw);
 	if (buffer)
 		free(buffer);
 	return ret < 0 ? ret : 0;
 }
 
+static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
+{
+	int ret;
+	bool compressed;
+
+	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
+		  inode->nid | 0ULL, inode->datalayout);
+
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_CHUNK_BASED:
+		compressed = false;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		compressed = true;
+		break;
+	default:
+		erofs_err("unknown datalayout");
+		return -EINVAL;
+	}
+	ret = erofs_do_verify_inode_data(inode, outfd, compressed);
+	if (ret < 0)
+		return ret;
+
+	if (fsckcfg.print_comp_ratio) {
+		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
+		fsckcfg.physical_blocks += compressed ? inode->u.i_blocks :
+					   BLK_ROUND_UP(inode->i_size);
+	}
+	return 0;
+}
+
 static inline int erofs_extract_dir(struct erofs_inode *inode)
 {
 	int ret;
-- 
2.17.1

