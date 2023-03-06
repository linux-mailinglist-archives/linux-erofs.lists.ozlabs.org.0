Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5B6AB9A6
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:23:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVY645gBrz3c4x
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:23:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lt7i/K2m;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lt7i/K2m;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVY603CWBz3bym
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:23:20 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so8260767pjp.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 01:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094597;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOqxIPhy/N2tW+T/NRnCoKUxLQm8JedR3c87fRlRcrY=;
        b=lt7i/K2mf+v2FCbezsNPzQ06BuvB/np/HqIXyr95BYvCsn1YoMQtUhSIHmnBgVtuRa
         Sn0hSEqZYOXneJzp/KarmQZLLwKAN7ntvWRfYTA3OL/skcLyAUx5bQDHPpe3qbmPMUz/
         lftG5AD69lpc/1U/fgMtqXUg+0zVGMIOo4V5OfqFnvWdjFdeoa/oWv/0B57CbCOwXsez
         5KRZIb6bQMGk28VZeg0lGiVCCM7WWRS4zOZ/Pe1dG4deIYJ3XiP6YdOfvHwilWnTVUTw
         mkCX+tu2D7DMILuUzV/QS15+AhCkkK0wW9GN/xVckTXOZJtO5ositUyr2JqB5T9zLvFD
         al8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094597;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOqxIPhy/N2tW+T/NRnCoKUxLQm8JedR3c87fRlRcrY=;
        b=ImNn4xcj4U2EShpLThnsiuNnqRUpEfEL31PMxxR+UYcjFPToqMKMntJbha3vgE0afj
         7EZYqfb3IvnRIyCsgMySupxdk6zdhnfc1Fw8IiImyVipLcb9jNIqll9tDCfp2HBUUSA2
         3SaOjVR4GuTJYokG7SjLnVVL/l/iBS+gd+mzJh1YhW2b17oWeUc7hGbXbDhMX1EitUNH
         pkSg9vsGiWCd55X0tm74Mnz4BgvQ9gqHsZyuQ7iAcD1hhEeoKhkgZbOOrACzTCw9nblX
         tJi70PnWT1/k2+W3Dqfjn3HKwdz9geQFtCVbefiO4yHyPFIlol0DycfvrnoDF03cXb+P
         5YNg==
X-Gm-Message-State: AO0yUKXeOMlbSbkDPIizms3pTtK30XIA7G4NJe38AtodVrZAz5ihVLzu
	B8ABdp862q6toPKPSLPamffrPmNc6jQ=
X-Google-Smtp-Source: AK7set+5Mv4j5XK4dZY0oGT1F/EnAPwPnOdT5QW9juW8IK1YmDLiqWdBD4thcwvr7m4jSrE1kczIfw==
X-Received: by 2002:a17:902:ab98:b0:19e:7628:8bfc with SMTP id f24-20020a170902ab9800b0019e76288bfcmr9330258plr.27.1678094597158;
        Mon, 06 Mar 2023 01:23:17 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id kb12-20020a170903338c00b0019607984a5esm6203832plb.95.2023.03.06.01.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:23:16 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: get rid of z_erofs_do_map_blocks() forward declaration
Date: Mon,  6 Mar 2023 17:23:04 +0800
Message-Id: <b0b44543873032aebb2029d8d09e53ca37b2d512.1678094473.git.huyue2@coolpad.com>
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

Reorder code to avoid this declaration just like kernel commit
999f2f9a63f4 ("erofs: get rid of z_erofs_do_map_blocks() forward
declaration").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/zmap.c | 156 ++++++++++++++++++++++++++---------------------------
 1 file changed, 76 insertions(+), 80 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 69b468d..3c665f8 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,10 +10,6 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
-static int z_erofs_do_map_blocks(struct erofs_inode *vi,
-				 struct erofs_map_blocks *map,
-				 int flags);
-
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
@@ -29,82 +25,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
-{
-	int ret;
-	erofs_off_t pos;
-	struct z_erofs_map_header *h;
-	char buf[sizeof(struct z_erofs_map_header)];
-
-	if (vi->flags & EROFS_I_Z_INITED)
-		return 0;
-
-	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = dev_read(0, buf, pos, sizeof(buf));
-	if (ret < 0)
-		return -EIO;
-
-	h = (struct z_erofs_map_header *)buf;
-	/*
-	 * if the highest bit of the 8-byte map header is set, the whole file
-	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
-	 */
-	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
-		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
-		vi->z_tailextent_headlcn = 0;
-		goto out;
-	}
-
-	vi->z_advise = le16_to_cpu(h->h_advise);
-	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
-
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err("unknown compression format %u for nid %llu",
-			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
-		return -EOPNOTSUPP;
-	}
-
-	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-			  vi->nid * 1ULL);
-		return -EFSCORRUPTED;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
-
-		vi->idata_size = le16_to_cpu(h->h_idata_size);
-		ret = z_erofs_do_map_blocks(vi, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
-			erofs_err("invalid tail-packing pclustersize %llu",
-				  map.m_plen | 0ULL);
-			return -EFSCORRUPTED;
-		}
-		if (ret < 0)
-			return ret;
-	}
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
-
-		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		ret = z_erofs_do_map_blocks(vi, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (ret < 0)
-			return ret;
-	}
-out:
-	vi->flags |= EROFS_I_Z_INITED;
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct erofs_inode *inode;
 	struct erofs_map_blocks *map;
@@ -675,6 +595,82 @@ out:
 	return err;
 }
 
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[sizeof(struct z_erofs_map_header)];
+
+	if (vi->flags & EROFS_I_Z_INITED)
+		return 0;
+
+	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+	ret = dev_read(0, buf, pos, sizeof(buf));
+	if (ret < 0)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto out;
+	}
+
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err("unknown compression format %u for nid %llu",
+			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid * 1ULL);
+		return -EFSCORRUPTED;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->idata_size = le16_to_cpu(h->h_idata_size);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (!map.m_plen ||
+		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+			erofs_err("invalid tail-packing pclustersize %llu",
+				  map.m_plen | 0ULL);
+			return -EFSCORRUPTED;
+		}
+		if (ret < 0)
+			return ret;
+	}
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret < 0)
+			return ret;
+	}
+out:
+	vi->flags |= EROFS_I_Z_INITED;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map,
 			    int flags)
-- 
2.17.1

