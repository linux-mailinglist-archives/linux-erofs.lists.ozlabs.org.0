Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80C65E7AE
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 10:23:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nngy32s4Vz3bPT
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 20:23:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ayUerhva;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ayUerhva;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nngxv4VJZz2xY3
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Jan 2023 20:23:29 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1486785pjd.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Jan 2023 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqdCSG6esSia8a8nNER46R3I2k1JXGYlTwxz1fGKOiE=;
        b=ayUerhvaiW0WtjHYf5jTvzze/U57xmWv8iySxdpFJgoEudMnHNRoLdlP+q1JqanKEe
         h0XpgvI1OroP5zEMpcGP7McM5t1G36FnIbETwkoLaTHvIHrzdikbiDGKzjXz91DQfPTY
         iMtXMelDNh3FY5MOJP58kvMOC8DvQuR9Q7N/BXWBR/sXEObO67oHcinhgS/vvJgtOcbM
         wAdIItPddKMY2xaT0aXukPzAXeq56o1VKAnKB6Ct73JP+h4Cggl0ulJb7/sUcZusnGml
         ir7vOCgYp1+d+BHBX1k2aia36NJC9GXq4S0TYvqLzsf2MVXsejbp2/AVbvgAh6tgasRZ
         Tl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqdCSG6esSia8a8nNER46R3I2k1JXGYlTwxz1fGKOiE=;
        b=3gQlfGcYiD8sovEboko1WJVF1eAjxsVdBb7/nGVpZkKMBVGNTWmw277l5fLot0Rmrv
         pRIR7JTT2lgS2H82ERCRa1glNHHTlDUKIYWG7zq0PuqGF19fpDmlE2IW6MbFszqPVEiZ
         xll9hwbFSP94BsJSPgX81kKxI1ozJuNt/Ur7U3eLf69YP6fOtwhVeMdmfOVdVH7TiiL3
         9bl7RBFFLQ3WbYnm1KRoX3jldAa2CAKiZioxJY5xFBUUDVAItIUiY13R4LC2XvVuhl9U
         8EO11fBsmDJqFyvXv09uLVtLEyNWiKZ5Gqsmp/fHk/5MqkMnIr6umI1xhv2yf2keKsJr
         HQPQ==
X-Gm-Message-State: AFqh2kovsxdzlrroZ0VtchxObugmtp2PJMX0D9YDAQb+/yjqY5dV3jxO
	oS7vLFzHM9HbSqjrLjjNr1TJoCfcwmw=
X-Google-Smtp-Source: AMrXdXu/RGh/wgksFkJul+NEJ02bvB/OPwecMrxy5MtCHK9XQFBu40Tu2M0Hov02o3QtF7QRzObxqw==
X-Received: by 2002:a05:6a21:1691:b0:a3:9f32:a9d1 with SMTP id np17-20020a056a21169100b000a39f32a9d1mr56703896pzb.31.1672910605647;
        Thu, 05 Jan 2023 01:23:25 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a626202000000b00576145a9bd0sm23847285pfb.127.2023.01.05.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:23:25 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fsck: cleanup erofs_verify_inode_data()
Date: Thu,  5 Jan 2023 17:21:56 +0800
Message-Id: <9d6764beb664af4cbe70869e7e45bdab57357e59.1672909705.git.huyue2@coolpad.com>
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
 fsck/main.c              | 149 +++++++++++++++++----------------------
 include/erofs/internal.h |   4 ++
 lib/data.c               |   8 +--
 3 files changed, 71 insertions(+), 90 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..6c43816 100644
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
@@ -401,102 +379,101 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
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
+		if (compressed)
+			ret = z_erofs_read_data(inode, buffer, maxsize, pos);
+		else
+			ret = erofs_read_raw_data(inode, buffer, maxsize, pos);
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
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 947894d..4b962af 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -352,6 +352,10 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi);
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+                        erofs_off_t size, erofs_off_t offset);
+int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+                      erofs_off_t size, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
diff --git a/lib/data.c b/lib/data.c
index 76a6677..a9b2240 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -158,8 +158,8 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 	return 0;
 }
 
-static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
-			       erofs_off_t size, erofs_off_t offset)
+int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -217,8 +217,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
-static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-			     erofs_off_t size, erofs_off_t offset)
+int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+		      erofs_off_t size, erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
-- 
2.17.1

