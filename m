Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F5590BB9
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 08:02:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M3tPJ0VNYz3bXZ
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 16:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Q49esEub;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Q49esEub;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M3tPD5Zkhz2xjr
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Aug 2022 16:02:22 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d20so93496pfq.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Aug 2022 23:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=LGB0WFClYhcqqe+YL7LSXVJfO1SXGUU9W/Gp8VSqST4=;
        b=Q49esEubX0ROqAm9EfEJiMjDXGIKOSdrQ+32dsHJAMyc7cO3cIFgclS3aTKmpJdi4j
         Ei4mQ+QIMU/oMd9+Fmf9+s4IH2yoBmiGWV4FipurmPbMYNJv7tDomANzDmdBgmdFFD7C
         xCzyE1TqJcAmmve7sHdhYaVnPUlSc/VL8orkGPQmmsBQ/1zlxKBI6EDoHfH9tsi0rnLK
         GEKF9OQILyRW/lbRLahujxk5y2LkfkigoF+NO5R1LxDgEdYU5QdNa0+XAc9QcFo5CcmN
         Z3jU9hX0UNXTFTm4RD/Oyu8LoNZjRgJEF2RRJxUnRzu9ILrMIYCLJfzHC6gJXQ7NQ/ga
         nsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LGB0WFClYhcqqe+YL7LSXVJfO1SXGUU9W/Gp8VSqST4=;
        b=5RNMPLYtAuxBxr6MxLKbP5gEAf8Z+ZxxcZkc9lxyKXFK2IjNYT19RlHCyzGbZAFCzM
         RBjSgQskUptnlHvthoUnBAn6R/f8Za7I6n/K1C9XrRF8uZfj+W9tQvH55YhOGrV3xreO
         w1EL8jcZFEAwfRilL7y0Bv8Au1RaplKWV8MAtJSxVmr6SxkaKJrrQzJAPr4cSFtR+iTc
         dCGnPh2JPBDIgZVjG9HMZlsDjpXwTfl9HOsQN8IJD11a0OMXmqhw0X0pMJ6Lsw1M7iOb
         Txo62kR/ikNNXSutRXthK9WeFkvj8xceD6uds0q/W77RZfnpf52pcit4FisqhbWzcKmJ
         VO8A==
X-Gm-Message-State: ACgBeo0HkrAyI+uUT0+8NkxgrTAP/8ciGj/54WcaI4hQ024bS0N/LTi4
	8AQALoayNBmydlVv1QIuDmE=
X-Google-Smtp-Source: AA6agR5rBczvnAzYLabH3mHMNCmt0pTO71n0M2QUKwFWtNWRVx2VFRqIHJQafTFPqUGunw0wo6WvDg==
X-Received: by 2002:aa7:8289:0:b0:52c:e97c:dbe4 with SMTP id s9-20020aa78289000000b0052ce97cdbe4mr2461650pfm.49.1660284140428;
        Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001708b189c4asm740020plg.137.2022.08.11.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 23:02:20 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: avoid the potentially wrong m_plen for big pcluster
Date: Fri, 12 Aug 2022 14:01:50 +0800
Message-Id: <20220812060150.8510-1-huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Actually, 'compressedlcs' stores compressed block count rather than
lcluster count. Therefore, the number of bits for shifting the count
should be 'LOG_BLOCK_SIZE' rather than 'lclusterbits' although current
lcluster size is 4K. The value of 'm_plen' will be wrong once we enable
the non 4K-sized lcluster.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 572f0b8151ba..d58549ca1df9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -141,7 +141,7 @@ struct z_erofs_maprecorder {
 	u8  type, headtype;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk, compressedlcs;
+	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
 };
 
@@ -192,7 +192,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = m->delta[0] &
+			m->compressedblks = m->delta[0] &
 				~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
@@ -293,7 +293,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -497,7 +497,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return 0;
 	}
 	lcn = m->lcn + 1;
-	if (m->compressedlcs)
+	if (m->compressedblks)
 		goto out;
 
 	err = z_erofs_load_cluster_from_disk(m, lcn, false);
@@ -506,7 +506,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	/*
 	 * If the 1st NONHEAD lcluster has already been handled initially w/o
-	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
 	 * an internal implemenatation error is detected.
 	 *
 	 * The following code can also handle it properly anyway, but let's
@@ -523,12 +523,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
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
 		fallthrough;
 	default:
@@ -539,7 +539,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = (u64)m->compressedlcs << lclusterbits;
+	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(m->inode->i_sb,
-- 
2.17.1

