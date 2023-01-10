Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F7663BB0
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 09:50:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrkzN0CKQz3cBy
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 19:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=G3I1Qg20;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=G3I1Qg20;
	dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrkzJ25dhz3c6H
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 19:50:20 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id k19so8238791pfg.11
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XpkBnIdYnJXTp701r+Nh9e/TqX6kKaBRNytoZKiCaU=;
        b=G3I1Qg20m/heouciMNqmH6hpomXGqaVqhiDtSXZlMyGm1JMvUazpT1VTbpX6wm6QZd
         Or4qKCF8OCzsGJa8Mb/QnqK/1CwOw35yf75kE1m/0BrwYmveOIctp0wqQGBC2QnkMI7K
         Qy+Hzft1hYzu0o6ud4Mgg8QLapdlhdJHR7me2XzD1JM/gATSUWIx9HKIN69kNVmIb6z6
         tVQFvLsta+UBeEdZ16tcYZ178p5Pwo02FX6nCFbtONZLbcIWw1c9wpb3I3CanVlKkGyH
         7dqh0qXte6g/VyPDWVFOPvYVKbx3vJlLRdHjyr5B3+rr3UHo2WVuYkKGaR9rQLRw15lq
         zdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XpkBnIdYnJXTp701r+Nh9e/TqX6kKaBRNytoZKiCaU=;
        b=3eoKFNfLsoAyXFdxKDgfaHCCQRwqYP+rKYvG/Kzrf3K0r8H31znM2kzkAJCVgwfhVT
         Wl0MeYl86SaIpr1fLHXOsuWPjqYkd2Puz+XXWAomccXEGDwbwlWI49nW82e1FKkHhEV6
         hQuvEz69aKqgSXe/KWBWmvFNSFK6LKbCKfoVzehU4nrLKEkoi1McY/7eWb1N5uSLXsWM
         thzmuxlyy1QgUQXmML48L9DDNM8M21OaaD3GDVq0vzYhn8n+Z1L9PpDF4v1aoj3lcfgF
         T+7KT/4kyRhjo6Gs2u3aK5GUkbgSQcCTcXzmn5kj5Nz0BjGJg1uA2rAcnBY0vXQPvJxa
         tO7w==
X-Gm-Message-State: AFqh2kpBXikiNSX9ZwuueUcxBPmV7HPgUDw4l5gZlHBMalQZmSDQfTPT
	CsDqNqFOcPCiL14WT6l6iz8HQvEO+NY=
X-Google-Smtp-Source: AMrXdXvSI6uxDwIIS1LnsWplEoXj+4AmwWvkS0/EGOlh3Lx5Z5K3MoWndKY0uzfYn3lzXn7E8WL41g==
X-Received: by 2002:aa7:8692:0:b0:589:a782:470c with SMTP id d18-20020aa78692000000b00589a782470cmr3897516pfo.2.1673340616734;
        Tue, 10 Jan 2023 00:50:16 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b00574ebfdc721sm7783030pfo.16.2023.01.10.00.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:50:16 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/3] erofs-utils: lib: export parts of erofs_pread()
Date: Tue, 10 Jan 2023 16:49:58 +0800
Message-Id: <20230110084959.1955-1-zbestahu@gmail.com>
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
v2: use parameter trimmed instead of partial

 include/erofs/internal.h |   5 ++
 lib/data.c               | 154 ++++++++++++++++++++++-----------------
 2 files changed, 92 insertions(+), 67 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 206913c..47240f5 100644
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
+			erofs_off_t skip, erofs_off_t length, bool trimmed);
 
 static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 					  erofs_off_t *size)
diff --git a/lib/data.c b/lib/data.c
index 76a6677..d8c6076 100644
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
@@ -204,19 +215,74 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
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
@@ -224,9 +290,8 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
 
@@ -238,28 +303,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
@@ -276,25 +330,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
@@ -303,24 +338,9 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+				buffer + end - offset, skip, length, trimmed);
 		if (ret < 0)
 			break;
 	}
-- 
2.17.1

