Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45722868793
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 04:11:51 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iRQ8uDs6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkMw50FmZz3cgJ
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 14:11:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iRQ8uDs6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkMvx1Q4Mz3c5J
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 14:11:39 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1dc0e5b223eso31466865ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 19:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709003497; x=1709608297; darn=lists.ozlabs.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYW+OiY7hrg9hJJVMV23BArQpEp+Mbu+faqphSzehlI=;
        b=iRQ8uDs6ORCQ3upAu0st+vnbA/qKkp1JDuenWDX9ihCOilVLs1Z/ZpaIX89jq1pNo7
         816co5epvb9MuAcpVlzyzAxvElOgUJbnoZe3vDr6LQLtcFJVARfG4y3gOkWjUTYrMlyo
         8V42xfLUxZSQTkQhJjnK2cdxSreJJz8UzW6qCYpDf/zm9MjmNodkuG6/Cb8e/kojfYak
         0qAWCjG68tGSvvX3X5wzgZUcBnMeXjKr6LSHFQ/a5mumcTPUiQDpxOdqa3iCD4RQ7n/B
         2CqI21Rb0g8uf9gn7mU3INA7/Uyelbr+J3co5tL3V5iq7XmM9ZV1AnFh4PKRVlsHFKxM
         Myrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003497; x=1709608297;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYW+OiY7hrg9hJJVMV23BArQpEp+Mbu+faqphSzehlI=;
        b=od036qEJ/HGZkfJGQelZq0dw0ODPJP0oains2wxUMI1yKtIIaUpTM4Cgcw5Qj4x/nu
         ON9AoJ1ye3CUWxwyhutYtV57Q+JDcrNzfuJf4LbY+6rGb1ZbrLbhXT1BUD4SDGvWkhAO
         a0PT05ibqFXh+mUNLhHqN60kHiHKPQABjsHF49LUDlaVnFbgpVPRxZV4XJKsO7q4IC3N
         3eDIE6/zuvh2t9n2q4j5JM0nxvxwPu7QNyJ11P4eyBIJROu5VTxv1eV5itUP+PoKjD8b
         oBuPnD7uL74pge3ugeurGNBZ/Bok+PQ1vuciJoFqjRtbhZzLSokh+8oW3YIMj7GyWcfA
         /1/w==
X-Gm-Message-State: AOJu0YxipI2IyNr2pY2nSYGiMpSL+iSoc3+7JF1rbnbN9ZvRl8YHKtOH
	Lhz2txdln7GurxmnnqdGDxhXYNdffSxXg+BXIm/dKyccESiOE0nH
X-Google-Smtp-Source: AGHT+IG5TwA92YjHC6YzSfesOetS4sm25SxEZk8Cc+fmnvspNDF82viDZx2QNhdLGC+3FYFEbJKJPA==
X-Received: by 2002:a17:903:246:b0:1dc:1e7c:cd3 with SMTP id j6-20020a170903024600b001dc1e7c0cd3mr9637251plh.47.1709003497035;
        Mon, 26 Feb 2024 19:11:37 -0800 (PST)
Received: from localhost.localdomain ([218.94.48.179])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001d7057c2fbasm402527plg.100.2024.02.26.19.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:11:36 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 6.1.y 2/2] erofs: fix inconsistent per-file compression format
Date: Tue, 27 Feb 2024 11:11:12 +0800
Message-Id: <c8c7503a90e89f6595205be21bfbda0cdfcb3a30.1709000322.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 118a8cf504d7dfa519562d000f423ee3ca75d2c4 ]

EROFS can select compression algorithms on a per-file basis, and each
per-file compression algorithm needs to be marked in the on-disk
superblock for initialization.

However, syzkaller can generate inconsistent crafted images that use
an unsupported algorithmtype for specific inodes, e.g. use MicroLZMA
algorithmtype even it's not set in `sbi->available_compr_algs`.  This
can lead to an unexpected "BUG: kernel NULL pointer dereference" if
the corresponding decompressor isn't built-in.

Fix this by checking against `sbi->available_compr_algs` for each
m_algorithmformat request.  Incorrect !erofs_sb_has_compr_cfgs preset
bitmap is now fixed together since it was harmless previously.

Reported-by: <bugreport@ubisectech.com>
Fixes: 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
Fixes: 622ceaddb764 ("erofs: lzma compression support")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Link: https://lore.kernel.org/r/20240113150602.1471050-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zmap.c         | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index ae3cfd018d99..1eefa4411e06 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -396,7 +396,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	int size, ret = 0;
 
 	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0337b70b2dac..abcded1acd19 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -610,7 +610,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		.map = map,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff;
+	unsigned int lclusterbits, endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
@@ -700,17 +700,20 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_INTERLACED;
-		else
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_SHIFTED;
-	} else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
-		map->m_algorithmformat = vi->z_algorithmtype[1];
+		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
+			Z_EROFS_COMPRESSION_INTERLACED :
+			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		map->m_algorithmformat = vi->z_algorithmtype[0];
+		afmt = m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2 ?
+			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
+		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
+			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+				  afmt, vi->nid);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	}
+	map->m_algorithmformat = afmt;
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
-- 
2.17.1

