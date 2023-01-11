Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB6665140
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 02:50:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ns9bv4TVkz3c95
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 12:50:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Rjd8Biwf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Rjd8Biwf;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ns9bg35Bxz306l
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 12:49:49 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id 141so9556511pgc.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy1hdelKoqONk+Wvx+XxLh7TycZUcuqF0eNgEM95Ocw=;
        b=Rjd8Biwfj1bpHqgGJcCfn4B+NdYaUpRZMiW1bldhIOtlfkVPKl6D45jTib80HyjR81
         4oS4m+Hd1vkoenKaTUlgCfk2FqCpNldZg/iJL7mvT/vSASrCjazPyMWYgLl6Gp+1FNfM
         W2i5wp68n1t2mmaZEo1SFWa7PCDP0fXcmpciugA+kt2Y7vHChKSch3XXncQ35TLr1EkQ
         qXTG7Yg40YQLt7iwYwH003kHIsdiuDkGB23RhzEkRFVL2H+YjR3GPpJTu5VZ7a167EMi
         tABChC9XEAQpOheRwkzvkrLGiIKdrlVUE8ZJUnp0qOVnIF+VS1QO8/cXTagMA3sU+2e8
         3TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy1hdelKoqONk+Wvx+XxLh7TycZUcuqF0eNgEM95Ocw=;
        b=cBGwtEgAwqsz5aK+0fbwimBb3Xf18THivXw6HB9juYmSTNFoHiWXUdts58Kp6f3gWt
         UhfC8xyBFmyvJlrZzyMhSuHnh6zqA2CBoBmY9bXyfgqQwZBlRjQzWs9wqoad+efri4/X
         bm/wesag0wsPolvWO9yivN1n4Zo9gWWTujuZvtQlS0y8dmETMpefDKQydDYrJepseOx0
         OAO39EUpvk/lYdf9mV3qXGff5y0p0mRt63soIGBZIkBNC9W3agoYAPVBJyOZVGbnwhFm
         FvAgpvbk92SkS2UQtzSLYSfHtdbAbxFG72EbGllDoeklLFRwGztey/LpE1qWpcmollrb
         lwhg==
X-Gm-Message-State: AFqh2kokoP97fi3VSJRDs3lbNUvKbJ2qrhyjbi5npbaKWF9F6wN4uF0X
	TQGBHP6afiBhA77IMrZT83PPO63yYDY=
X-Google-Smtp-Source: AMrXdXsz7gYPp776HGSqUbpS5NwSJ9N6goeIWsxTt4ItB6kvN833mvjYkJHZqd3ib98EaT7GgVtNog==
X-Received: by 2002:a05:6a00:a07:b0:580:9431:1b1a with SMTP id p7-20020a056a000a0700b0058094311b1amr87302606pfh.5.1673401786271;
        Tue, 10 Jan 2023 17:49:46 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a623002000000b0056283e2bdbdsm8669847pfw.138.2023.01.10.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:49:45 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH resend v3 1/3] erofs-utils: lib: export parts of erofs_pread()
Date: Wed, 11 Jan 2023 09:49:26 +0800
Message-Id: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
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
 lib/data.c               | 153 ++++++++++++++++++++++-----------------
 2 files changed, 91 insertions(+), 67 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 206913c..08a3877 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -355,6 +355,11 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
+			size_t len);
+int z_erofs_read_one_data(struct erofs_inode *inode,
+			struct erofs_map_blocks *map, char *raw, char *buffer,
+			erofs_off_t skip, erofs_off_t length, bool trimmed);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 					  erofs_off_t *size)
diff --git a/lib/data.c b/lib/data.c
index fce3da2..c7d08e7 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -158,19 +158,38 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 	return 0;
 }
 
+int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
+			size_t len)
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
@@ -204,19 +215,73 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
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
+		ret = erofs_read_one_data(&map, estart, moff, eend - map.m_la);
+		if (ret)
+			return ret;
 		ptr = eend;
 	}
 	return 0;
 }
 
+int z_erofs_read_one_data(struct erofs_inode *inode,
+			struct erofs_map_blocks *map, char *raw, char *buffer,
+			erofs_off_t skip, erofs_off_t length, bool trimmed)
+{
+	struct erofs_map_dev mdev;
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
+				   inode->fragmentoff + skip);
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
+	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+			.in = raw,
+			.out = buffer,
+			.decodedskip = skip,
+			.interlaced_offset =
+				map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
+					erofs_blkoff(map->m_la) : 0,
+			.inputsize = map->m_plen,
+			.decodedlength = length,
+			.alg = map->m_algorithmformat,
+			.partial_decoding = trimmed ? true :
+				!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
+					(map->m_flags & EROFS_MAP_PARTIAL_REF),
+			 });
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			     erofs_off_t size, erofs_off_t offset)
 {
@@ -224,9 +289,8 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
-	struct erofs_map_dev mdev;
-	bool partial;
-	unsigned int bufsize = 0, interlaced_offset;
+	bool trimmed;
+	unsigned int bufsize = 0;
 	char *raw = NULL;
 	int ret = 0;
 
@@ -238,28 +302,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
 		 */
 		if (end < map.m_la + map.m_llen) {
 			length = end - map.m_la;
-			partial = true;
+			trimmed = true;
 		} else {
 			DBG_BUGON(end != map.m_la + map.m_llen);
 			length = map.m_llen;
-			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED) ||
-				(map.m_flags & EROFS_MAP_PARTIAL_REF);
+			trimmed = false;
 		}
 
 		if (map.m_la < offset) {
@@ -276,25 +329,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
-			ret = erofs_pread(&packed_inode, buffer + end - offset,
-					  length - skip,
-					  inode->fragmentoff + skip);
-			if (ret < 0)
-				break;
-			continue;
-		}
-
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
 			raw = realloc(raw, bufsize);
@@ -303,24 +337,9 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+		ret = z_erofs_read_one_data(inode, &map, raw,
+				buffer + end - offset, skip, length, trimmed);
 		if (ret < 0)
 			break;
 	}
-- 
2.17.1

