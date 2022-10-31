Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51061612EFE
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Oct 2022 03:29:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N0xt40dMMz3cBX
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Oct 2022 13:29:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bvSMafPB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bvSMafPB;
	dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N0xst3hRsz2yyZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Oct 2022 13:28:48 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14668915pjc.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Oct 2022 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XntVPS/3cNMuveEY33+jFzn0g4VoT8brbN5SO1btriw=;
        b=bvSMafPBj48Gm0Trs3/k/qTo1k1IP6JWcvJXsZOJor66P5UJPkZEJww8g1dvefRV2C
         ItciYk5B2p1qwGnICOQ0sVqFQG4ML52GPGcQj2iLgmiaMY7atf1HCJVybzwfDRo9sdXl
         iG5zLVk7+vZIQC0eVrKW7pClCTpjYQcQGk/2IUd7kQ3W+0CjphqKiIbguSknxQ+Q+YO0
         RFO7XhyCVqRSCXN62dY5iRpV1Xlyj3mTacLIXTtzoLXVyaYDLuZErsWDDji1mKNAJdq9
         yh4O+KIkQOp9nzU6vg9XgxnCpQLpERJBeMImyfs0c13WyBEGH1aNoftcIVI7kMOEIc5A
         TFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XntVPS/3cNMuveEY33+jFzn0g4VoT8brbN5SO1btriw=;
        b=nTsbxfN/knDidTwcOxSaOEM8si7zboirJ9VZoSgVvtBpgkxGueIMh5VgIBqBcsY+gy
         VEt6Snyz4I9s2WWDq1kyxbcTZWYSXgqnLaOnxFJYCVawMs/6GXmXgmGu+76DF7rzXu1A
         YuyAgr6LhVTjXaJXhpBQ3tDp+jGESxoXaVz2N9MK/Ag0uC0+S5Lwu0cTYDJZW5pe1ysW
         /OlBCJnvobaaNBNKY+G/jYlVyZwzKPsnZS2Notaht68E0vIvSlYHD+vVK0OFqa+hWAre
         2AJ1n/gqEAEmN4jReXZ7N2MeEgxU64Yfeu0avAQf92I2nMW1q3INhREGZ5bZNyAg1xf3
         4PNw==
X-Gm-Message-State: ACrzQf3bhSxzhw20H/QIwwBTahIoUqXRiCcev6nM+pNJsB7rTzMVVrEp
	DLGxqM7sGtNoOMZ+iemHARlrenEnkeY=
X-Google-Smtp-Source: AMsMyM6PljfiRAY9ty9iv3kZlht3ZqXtO1oupel4qSdgz9mqwJxr/ZlNYG76sBXO1VCPBrSnXZFxfQ==
X-Received: by 2002:a17:902:820a:b0:178:456e:138 with SMTP id x10-20020a170902820a00b00178456e0138mr11918395pln.145.1667183324658;
        Sun, 30 Oct 2022 19:28:44 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a16-20020aa794b0000000b005627d995a36sm3289669pfl.44.2022.10.30.19.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 19:28:44 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: avoid the potentially wrong m_plen for big pcluster
Date: Mon, 31 Oct 2022 10:26:53 +0800
Message-Id: <20221031022653.14981-1-zbestahu@gmail.com>
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

Keep in sync with the kernel commit 0d53d2e882f9 ("erofs: avoid the
potentially wrong m_plen for big pcluster").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: rebase on latest dev branch

 lib/zmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 1c6706a..89e9da1 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -115,7 +115,7 @@ struct z_erofs_maprecorder {
 	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk, compressedlcs;
+	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
 	bool partialref;
 };
@@ -172,7 +172,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = m->delta[0] &
+			m->compressedblks = m->delta[0] &
 				~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
@@ -274,7 +274,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -471,7 +471,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	}
 
 	lcn = m->lcn + 1;
-	if (m->compressedlcs)
+	if (m->compressedblks)
 		goto out;
 
 	err = z_erofs_load_cluster_from_disk(m, lcn, false);
@@ -480,7 +480,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	/*
 	 * If the 1st NONHEAD lcluster has already been handled initially w/o
-	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
 	 * an internal implemenatation error is detected.
 	 *
 	 * The following code can also handle it properly anyway, but let's
@@ -496,12 +496,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedlcs = 1;
+		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
-		if (m->compressedlcs)
+		if (m->compressedblks)
 			break;
 		/* fallthrough */
 	default:
@@ -511,7 +511,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedlcs << lclusterbits;
+	map->m_plen = m->compressedblks << LOG_BLOCK_SIZE;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
-- 
2.17.1

