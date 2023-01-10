Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6D3663CCF
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 10:28:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nrlqf4STjz3cd6
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 20:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pVMFD8oN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=pVMFD8oN;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrlqR47ZYz3c6P
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 20:28:33 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id a184so8320840pfa.9
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 01:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS2twotEf8RIGQv7ZktzMYjKlLNxYtX2mDYr/mgoMX8=;
        b=pVMFD8oNvIY1EqiP5WvdrLH2YRy1jiwRsCgO4M27bSXlv/4r2fa/0lEB/HXKmVgiKA
         X810jqS28bAawv0I8O435xiNupwBy8WwP9eff2jh+2ym83lUZbz0Tccr1hSFgFyK563Q
         sOeEuubLaedTmczZ28iOf7WpKnAme10kbsdUpX7Saws5u/A7vUrppBiJ+ocSeIGLZB8r
         KSa0oARCSOimrL1jBmPdCYnC4K3TQF/aVvUWED829MOytZezST6MokzzZ4J8axxWjfCw
         g8tT2KsVJNye8f2yLMyAP5vcnUE5kwjr7nsXppU3Gr9nDLPSpnmRiq0wS2TxhHULjMG0
         kzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS2twotEf8RIGQv7ZktzMYjKlLNxYtX2mDYr/mgoMX8=;
        b=UqZBHhQN6rrmUKjfjrBs0oWnLOF0FNwP0A3ivYy4XS8PxUm2TT9Zmim2KE/sK7v4K/
         0sSs8Pj6YxDV1rLCTSxKIWvYrHTYru/ldY0OiaEvMjyDB/D1n3wLYS92baasL6Ft6e/8
         pFgGggRF5oBTrvD/IIC38fpQ6spCn3UhHx9lD+TXSxcXv7pFxvprovz8fE+7WkAp2X38
         uNO80Gezwg/Iv052E6jRpLfRC3SUpRv14u/E7+M/XG5bz4iZtoykc4kVGV+UAZhK74qr
         4MT9Y9HthhcUaZM6HGcfnqeVj6WSdoI5M+nOBpcjdL58e+JQQA1Pn1HpHsKYTnZJFIiT
         sm0Q==
X-Gm-Message-State: AFqh2krrgc3jC5cb6eOJrxQYePNOAxer8VWgg+mpsjUrctPYpBIKWt0l
	CrWhB5SQpP9cQJA1mI6qlaSGAMIfIcA=
X-Google-Smtp-Source: AMrXdXsRBe3+1FkAW1tsNFC+LqEZieV3z2Ur7WqMnrS5kTI7uwkMus+EsQfNWunmfrc5OF0eq0cnJA==
X-Received: by 2002:aa7:9732:0:b0:580:d722:10e7 with SMTP id k18-20020aa79732000000b00580d72210e7mr62866680pfg.24.1673342911315;
        Tue, 10 Jan 2023 01:28:31 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 125-20020a620483000000b005817fa83bcesm4866880pfe.76.2023.01.10.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:28:30 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/3] erofs-utils: lib: export parts of erofs_pread()
Date: Tue, 10 Jan 2023 17:28:19 +0800
Message-Id: <2a43acac96332c626483f6320eb0e06aba62c776.1673342258.git.huyue2@coolpad.com>
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
v3: rename the helpers as {z_}erofs_read_one_data

v2: use parameter trimmed instead of partial

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
index 76a6677..c7d08e7 100644
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

