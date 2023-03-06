Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C796AB8DF
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 09:55:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVXTq4RTwz3cBp
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 19:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=d7hu7u3y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=d7hu7u3y;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVXTl5pRtz3bjv
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 19:55:22 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id y2so9035333pjg.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678092920;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knZAbQaYs666EedBa96k97QZ0HqgOGTkT2SSyOKhD9c=;
        b=d7hu7u3y+NJfLXsi3FNCouS5A7uUXrjv3IfDKE05+FwdWvhrXlS7CekwT9RPa0PiAZ
         IWBa2+SjJDbn2lAPSlx0d9AIKdRbIT5DCZIUDfLK93lIErp2qChvNFPnSEYIJiIiptVk
         KrkJTXHCi/aOK/712FxdJ8Or1aCgkBaey/ozu9xeu8KlXLhZ3l6lUW0W4/hP5dUVYrqs
         BSRzLGJLOhD9DBh6LG40xOGlOLQeindkX0XbmI+tG6VdET90Doee4GOZoRSpQrncy4BR
         Z44m4ZUE3V2frfGfyzrTj6gIRxkrXFKF8DmVYkVTk+kzLHi9fs6GCRqwEF+LfQod25M6
         mi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092920;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knZAbQaYs666EedBa96k97QZ0HqgOGTkT2SSyOKhD9c=;
        b=o3/eK89ZtgPvAoCUtB/ko0YjpuLbq3sPbJT3SL+AJsNg0UX3yqwJJn3cL4fYrxZ3Jx
         0kPZlpx1xCNW6i6fijExPhSfyC7iJQyT41HZGOhVnn1vub6mqcmWM98YakVHbE5oRLIm
         R2qJ98JzccBsWAqghy2+jm1NLA0BjQrnY2B5doGLglPT7U53xK3+Lw6PLbOtxPTEhgyy
         poF/c864J34Z8I8St0H1H9ViRsZ33rgxVruvbqD71/CuuyRugeR49dlnsXK89i12q3PU
         Xlmf60WHJXj+06DndJ2UHHCJVQNLW7s9kDzGqAE+97Jd5QQfJgQUBRVezzu5mRy2qQvp
         vneg==
X-Gm-Message-State: AO0yUKUVGLJOkwTtlT1gKmC+9pbIPRGxYs21yluDBSmfVSZg54UbHxMi
	l854No4LiefHl/FPPb1hdT8N4I9UVIg=
X-Google-Smtp-Source: AK7set8vh9c7zlrHeoW2W4otzs2MoEa1tP5m6Zh1ABag2lZDpz0gNqoR21Tc9PRnqchw1GwRl3hwTw==
X-Received: by 2002:a17:90b:4a8a:b0:237:b121:670b with SMTP id lp10-20020a17090b4a8a00b00237b121670bmr11224705pjb.7.1678092919658;
        Mon, 06 Mar 2023 00:55:19 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a4e4a00b002371e2ac56csm5315013pjl.32.2023.03.06.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:55:19 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: get rid of z_erofs_do_map_blocks() forward declaration
Date: Mon,  6 Mar 2023 16:54:58 +0800
Message-Id: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Keep in sync with the kernel commit 999f2f9a63f4 ("erofs: get rid of
z_erofs_do_map_blocks() forward declaration").

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

