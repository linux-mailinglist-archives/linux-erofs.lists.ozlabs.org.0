Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9B6623CA
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 12:06:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrB2w0Xy2z3c7S
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 22:06:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aSHC1ZSw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aSHC1ZSw;
	dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrB2r6h96z3bXQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 22:06:28 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id b12so5598170pgj.6
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Jan 2023 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+JKV92c6kcYjPUChV1gpRP2CfTzLu97HneHSFqdqGg=;
        b=aSHC1ZSwnQPUCjPQe49cQL25zrjgdh8Vyd16FLsDjC3+p2/N7tzgSaMc/ZoK5nhHK0
         Gh2ZSVCI5hWkqYp0UEJQ6Hp7rZC/AylGJzDJuUYAfp39BiqrQ7CvuMufwzfg5kMCCt3w
         Ei1hKRu10n6IL1KN0gAzfwHILyVXTlvkQu9ujrJmZWVyXlWa+lFxV8tnrgd4KyIxoNET
         bArAvoQMfCPY2B38JFdYCHJiVi6/7T9puG4AQKac6cyDB72n2kC8Rp9BRn3DH00/RZeH
         YwV6Oy/iThiStkCgPZWyZgUNDa9N6M2f+dXWa45PyU9TSEKxScf5vlXrrNHjWXMDqgEC
         nSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+JKV92c6kcYjPUChV1gpRP2CfTzLu97HneHSFqdqGg=;
        b=bg0YDHYB+krcK7Y9s4udm2eY/HD5WIkUagwLK4JcZz/a9ggoYdtlAvLKSGbDUfvclr
         89KXVlb4NQusXqzf+hPv+2BviBKBjdvvvaLwR0Houk8GoccMr+CdOkscFw8QKkI/D1hy
         xLXO8K1BQH1Vt7+6XUawEvcKrTieoCjbSzlalnGZJ1VOFmN3pW6QT5+Fce455iwap9+6
         8bBRjdOwLNKsW5TZkgKtu7ObUq1ZPThtTvPWEq4ymkP24E/eR+1uxSyIlm1yI8nTNXaK
         nDOpdAPDW4bhlu0pGiIfoWi2y6cUkwfkfHPKWUYqrQrruE7OCpIHbGc/CYvI8HG3/RHW
         VfAQ==
X-Gm-Message-State: AFqh2kqQUTxo6d4T6coGXCRqYlSp6xNyFywnXOiJDu2sfasl9bv7jM7V
	TNCIRZBuiF0aKze/cDnSPCj7wvuyahc=
X-Google-Smtp-Source: AMrXdXuFEq09zRNZCaJakiv79XTYCFMxeTnSN7xt1j52Hq7WJYIeem2rZVNnhEL23IqlKW0iw7v1fA==
X-Received: by 2002:a62:8412:0:b0:587:df0a:804d with SMTP id k18-20020a628412000000b00587df0a804dmr4608055pfd.27.1673262385514;
        Mon, 09 Jan 2023 03:06:25 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b0056bcb102e7bsm5790134pfq.68.2023.01.09.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:06:25 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: export parts of erofs_pread()
Date: Mon,  9 Jan 2023 19:06:10 +0800
Message-Id: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
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

Export parts of erofs_pread() to avoid duplicated code in
erofs_verify_inode_data(). Let's make two helpers for this.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/internal.h |   5 ++
 lib/data.c               | 148 ++++++++++++++++++++++-----------------
 2 files changed, 90 insertions(+), 63 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 206913c..2381d4c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -355,6 +355,11 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,
+			       u64 offset, size_t len);
+int z_erofs_read_data_mapped(struct erofs_inode *inode,
+			struct erofs_map_blocks *map, char *raw, char *buffer,
+			erofs_off_t skip, erofs_off_t length, bool partial);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 					  erofs_off_t *size)
diff --git a/lib/data.c b/lib/data.c
index 76a6677..09e42aa 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -158,19 +158,38 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 	return 0;
 }
 
+int erofs_read_raw_data_mapped(struct erofs_map_blocks *map, char *buffer,
+				u64 offset, size_t len)
+{
+	struct erofs_map_dev mdev;
+	int ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map->m_deviceid,
+		.m_pa = map->m_pa,
+	};
+	ret = erofs_map_dev(&sbi, &mdev);
+	if (ret)
+		return ret;
+
+	ret = dev_read(mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
+	if (ret < 0)
+		return -EIO;
+	return 0;
+}
+
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
-	struct erofs_map_dev mdev;
 	int ret;
 	erofs_off_t ptr = offset;
 
 	while (ptr < offset + size) {
 		char *const estart = buffer + ptr - offset;
-		erofs_off_t eend;
+		erofs_off_t eend, moff = 0;
 
 		map.m_la = ptr;
 		ret = erofs_map_blocks(inode, &map, 0);
@@ -179,14 +198,6 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 		DBG_BUGON(map.m_plen != map.m_llen);
 
-		mdev = (struct erofs_map_dev) {
-			.m_deviceid = map.m_deviceid,
-			.m_pa = map.m_pa,
-		};
-		ret = erofs_map_dev(&sbi, &mdev);
-		if (ret)
-			return ret;
-
 		/* trim extent */
 		eend = min(offset + size, map.m_la + map.m_llen);
 		DBG_BUGON(ptr < map.m_la);
@@ -204,19 +215,75 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (ptr > map.m_la) {
-			mdev.m_pa += ptr - map.m_la;
+			moff = ptr - map.m_la;
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(mdev.m_deviceid, estart, mdev.m_pa,
-			       eend - map.m_la);
-		if (ret < 0)
-			return -EIO;
+		ret = erofs_read_raw_data_mapped(&map, estart, moff,
+						 eend - map.m_la);
+		if (ret)
+			return ret;
 		ptr = eend;
 	}
 	return 0;
 }
 
+int z_erofs_read_data_mapped(struct erofs_inode *inode,
+			struct erofs_map_blocks *map, char *raw, char *buffer,
+			erofs_off_t skip, erofs_off_t length, bool partial)
+{
+	struct erofs_map_dev mdev;
+	unsigned int interlaced_offset;
+	int ret = 0;
+
+	if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		struct erofs_inode packed_inode = {
+			.nid = sbi.packed_nid,
+		};
+
+		ret = erofs_read_inode_from_disk(&packed_inode);
+		if (ret) {
+			erofs_err("failed to read packed inode from disk");
+			return ret;
+		}
+
+		return erofs_pread(&packed_inode, buffer, length - skip,
+				inode->fragmentoff + skip);
+	}
+
+	/* no device id here, thus it will always succeed */
+	mdev = (struct erofs_map_dev) {
+		.m_pa = map->m_pa,
+	};
+	ret = erofs_map_dev(&sbi, &mdev);
+	if (ret) {
+		DBG_BUGON(1);
+		return ret;
+	}
+
+	ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
+	if (ret < 0)
+		return ret;
+
+	interlaced_offset = 0;
+	if (map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
+		interlaced_offset = erofs_blkoff(map->m_la);
+
+	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+				.in = raw,
+				.out = buffer,
+				.decodedskip = skip,
+				.interlaced_offset = interlaced_offset,
+				.inputsize = map->m_plen,
+				.decodedlength = length,
+				.alg = map->m_algorithmformat,
+				.partial_decoding = partial
+				 });
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			     erofs_off_t size, erofs_off_t offset)
 {
@@ -224,9 +291,8 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
-	struct erofs_map_dev mdev;
 	bool partial;
-	unsigned int bufsize = 0, interlaced_offset;
+	unsigned int bufsize = 0;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -238,16 +304,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret)
 			break;
 
-		/* no device id here, thus it will always succeed */
-		mdev = (struct erofs_map_dev) {
-			.m_pa = map.m_pa,
-		};
-		ret = erofs_map_dev(&sbi, &mdev);
-		if (ret) {
-			DBG_BUGON(1);
-			break;
-		}
-
 		/*
 		 * trim to the needed size if the returned extent is quite
 		 * larger than requested, and set up partial flag as well.
@@ -276,25 +332,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		if (map.m_flags & EROFS_MAP_FRAGMENT) {
-			struct erofs_inode packed_inode = {
-				.nid = sbi.packed_nid,
-			};
-
-			ret = erofs_read_inode_from_disk(&packed_inode);
-			if (ret) {
-				erofs_err("failed to read packed inode from disk");
-				return ret;
-			}
-
-			ret = z_erofs_read_data(&packed_inode,
-					buffer + end - offset, length - skip,
-					inode->fragmentoff + skip);
-			if (ret < 0)
-				break;
-			continue;
-		}
-
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
 			raw = realloc(raw, bufsize);
@@ -303,24 +340,9 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
-		if (ret < 0)
-			break;
 
-		interlaced_offset = 0;
-		if (map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
-			interlaced_offset = erofs_blkoff(map.m_la);
-
-		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
-					.in = raw,
-					.out = buffer + end - offset,
-					.decodedskip = skip,
-					.interlaced_offset = interlaced_offset,
-					.inputsize = map.m_plen,
-					.decodedlength = length,
-					.alg = map.m_algorithmformat,
-					.partial_decoding = partial
-					 });
+		ret = z_erofs_read_data_mapped(inode, &map, raw,
+				buffer + end - offset, skip, length, partial);
 		if (ret < 0)
 			break;
 	}
-- 
2.17.1

