Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6EE124C48
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Dec 2019 16:54:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dKM545J9zDqjd
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2019 02:54:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQ1t9xPh"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dKKN0K75zDqkP
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2019 02:52:52 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id p27so1143389pli.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Dec 2019 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=1yhihVfwuZ8e485HHQqqnzkj0QYBAsgemBaidsjEj0w=;
 b=kQ1t9xPhyUwS37e9NQ5KbZ7MsAzed+WnKewC7DfdeL+8Kcs9Mgjc8+A6JE9GFFyU3z
 v1Q4x2rvsXqqOx6SdCd4H169dl+fm+ISIZ+dzgKHNgc3ukwOpT5lYWGWc3AeEF7KaglK
 Tnm22zBFELGktdUEiqUIpENE/acTeR/fxYR2N5gUQ94q/uaT1B3nhneFNJL1vEV5upl1
 StdchtBQJCfmsdAAUfl+BT4zCaJySCW+eYYB7EGSyJrgruo7+b8XEEfOYV8L9yWTO5Ez
 lYkIKcwcWIH/Pr3A1cdB7swCw65Yim3W6pCTMQgiJSOQUdpLvf5OV1vGHIpb2blEbvQh
 K2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1yhihVfwuZ8e485HHQqqnzkj0QYBAsgemBaidsjEj0w=;
 b=GvotAUrtl6MtbkEOTHIKD4RvLtxFVF4Qhw4EIuokF+xJ0FxBq5x8wh/O9jioLlb5I1
 DB2mMlDmsfBFnKbqtc5zS+0OnJlLCKHdi9Bq9m9NAdWiiOkGG7hBft3wAO8T9BglTThw
 zqU9GO0roEQwLnxmkSl/QRsHsQG5R0WFQ+PsXTQ5G68jjIykAOJIpaFXF7re/j71Z9m9
 pkeZj7U7bvYYn3ncaGRKETsLtHl6toj3+w2MBXbOI1efyIP5zdydbLwnT+rn4CLhOPXm
 QJ8jNdyN0Tlwb/5ZstXxjvrzRVjFFqyxzxtohqiFcUHkSRmYbBX+g0SChXxI7KcAb+an
 muUw==
X-Gm-Message-State: APjAAAVbKPKSOpNSbxKXx8e528A/b75WFNHoDhVAs51Rs0xJ+bEXDmP9
 5/zYQ01D15WBxJUZO/x6+Whg2WEs
X-Google-Smtp-Source: APXvYqybDhHC/vuem/PjqI3LmNUG1gR5Vb3mHVUMg64rkRk6YvaQaWRxouiIhKnmxD7GnCSrH/yDVA==
X-Received: by 2002:a17:90b:3011:: with SMTP id
 hg17mr3601933pjb.90.1576684368614; 
 Wed, 18 Dec 2019 07:52:48 -0800 (PST)
Received: from localhost ([167.172.195.170])
 by smtp.gmail.com with ESMTPSA id b8sm3307009pff.114.2019.12.18.07.52.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Dec 2019 07:52:47 -0800 (PST)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v1] erofs-utils:code clean of write file
Date: Wed, 18 Dec 2019 23:52:37 +0800
Message-Id: <20191218155237.2222-1-blucerlee@gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

Make a code clean at function erofs_write_file() which
has multi jump.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
---
 lib/inode.c | 63 ++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0e19b11..052315a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -302,22 +302,10 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 	return true;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+int erofs_write_file_by_fd(int fd, struct erofs_inode *inode)
 {
+	int ret;
 	unsigned int nblocks, i;
-	int ret, fd;
-
-	if (!inode->i_size) {
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-		return 0;
-	}
-
-	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
-
-		if (!ret || ret != -ENOSPC)
-			return ret;
-	}
 
 	/* fallback to all data uncompressed */
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
@@ -327,47 +315,58 @@ int erofs_write_file(struct erofs_inode *inode)
 	if (ret)
 		return ret;
 
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0)
-		return -errno;
-
 	for (i = 0; i < nblocks; ++i) {
 		char buf[EROFS_BLKSIZ];
 
 		ret = read(fd, buf, EROFS_BLKSIZ);
-		if (ret != EROFS_BLKSIZ) {
-			if (ret < 0)
-				goto fail;
-			close(fd);
-			return -EAGAIN;
-		}
+		if (ret != EROFS_BLKSIZ)
+			return -errno;
 
 		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
-			goto fail;
+			return ret;
 	}
 
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
-		if (!inode->idata) {
-			close(fd);
+		if (!inode->idata)
 			return -ENOMEM;
-		}
 
 		ret = read(fd, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
 			free(inode->idata);
 			inode->idata = NULL;
-			close(fd);
 			return -EIO;
 		}
 	}
-	close(fd);
+
 	return 0;
-fail:
-	ret = -errno;
+}
+
+int erofs_write_file(struct erofs_inode *inode)
+{
+	int ret, fd;
+
+	if (!inode->i_size) {
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		return 0;
+	}
+
+	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
+		ret = erofs_write_compressed_file(inode);
+
+		if (!ret || ret != -ENOSPC)
+			return ret;
+	}
+
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0)
+		return -errno;
+
+	ret = erofs_write_file_by_fd(fd, inode);
+
 	close(fd);
 	return ret;
 }
-- 
2.17.1

