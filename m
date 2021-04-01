Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BC5350D0F
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbN4xtKz30C9
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VVWs+e23;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VVWs+e23; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbJ0l7Mz2yZK
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:03 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4894960FE8;
 Thu,  1 Apr 2021 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247801;
 bh=Zet8Tm3N3uiZMBlSsOQQx1HmGHuxiMEJLG2i+ggysv8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VVWs+e23LTSrQU2JYGYrd5SCShIAzQNbVjdUymAb+YNg1WwOq1tan6FLACYIQYpHf
 LCNzJCyfWus+9Xy6x3elmJ5CjOYi1z0atMbSkul2Mmm5qs3pWQWwjUf0lngi6UfLAj
 zpTV34eCes8EqEG2NDqUC0EqKKE/Ief9bLyf9ysDDNyUyndOrZYUuKV4XOoPBhNSua
 7XE5dTtELqInQQY3uec6kwtFb8yj58CsSNi6qFaYQxQgfXPq5ACd5OLXZ5A2PHp/QA
 OGiB3Xia3Z9CL11zXpM+US7EXLhJMo3o7w4xV40V1SKBAT0G6lzNyH4dGsog61gakL
 JRqFsicyyaQag==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 01/10] erofs: reserve physical_clusterbits[]
Date: Thu,  1 Apr 2021 11:29:45 +0800
Message-Id: <20210401032954.20555-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Formal big pcluster design is actually more powerful / flexable than
the previous thought whose pclustersize was fixed as power-of-2 blocks,
which was obviously inefficient and space-wasting. Instead, pclustersize
can now be set independently for each pcluster, so various pcluster
sizes can also be used together in one file if mkfs wants (for example,
according to data type and/or compression ratio).

Let's get rid of previous physical_clusterbits[] setting (also notice
that corresponding on-disk fields are still 0 for now). Therefore,
head1/2 can be used for at most 2 different algorithms in one file and
again pclustersize is now independent of these.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h |  4 +---
 fs/erofs/internal.h |  1 -
 fs/erofs/zdata.c    |  3 +--
 fs/erofs/zmap.c     | 15 ---------------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 17bc0b5f117d..626b7d3e9ab7 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -233,9 +233,7 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-4 : (physical - logical) cluster bits of head 1:
-	 *       For example, if logical clustersize = 4096, 1 for 8192.
-	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 * bit 3-7 : reserved.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 60063bbbb91a..05b02f99324c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -266,7 +266,6 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
-			unsigned char  z_physical_clusterbits[2];
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cd9b76216925..eabfd8873e12 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -430,8 +430,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	else
 		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
-	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
-	pcl->clusterbits -= PAGE_SHIFT;
+	pcl->clusterbits = 0;
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = clt->owned_head;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14d2de35110c..bd7e10c2fdd3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -17,11 +17,8 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
-		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
-		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
-
 	inode->i_mapping->a_ops = &z_erofs_aops;
 	return 0;
 }
@@ -77,18 +74,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 3) & 3);
-
-	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
-			  vi->z_physical_clusterbits[0], vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_done;
-	}
-
-	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 5) & 7);
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-- 
2.20.1

