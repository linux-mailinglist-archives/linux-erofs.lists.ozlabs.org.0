Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2655F4D6A
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:36:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhxxY4wFWz30Lb
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 12:36:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LrG6uiVK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.181.12.12; helo=m12-12.163.com; envelope-from=zbestahu@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LrG6uiVK;
	dkim-atps=neutral
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhxxP6qFpz2xJF
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 12:36:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SHxla
	DnKLdEJkzD0nfI8r5ojeqLZ2V176ymnKnXKjHI=; b=LrG6uiVKaoKSJF5lRSxBO
	q2Cfq40t9DRJdxeMg7AWAjHzBFkdJYfaw2bwvD+v8Chn04X4jlgAs6ak6h0cu4hb
	y/L1c3u7ziogeV0ckDXcVYCVQ5WNdYz4r8+ye2Ds0zhCEBcRHxZjCe/bOwwCoaem
	da43TwffRR1ZM4ZSVIoREo=
Received: from localhost.localdomain (unknown [112.22.168.233])
	by smtp8 (Coremail) with SMTP id DMCowAAHjAqE3zxjEBBHew--.16506S2;
	Wed, 05 Oct 2022 09:36:07 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] erofs: fix invalid unmapped accesses in z_erofs_fill_inode_lazy()
Date: Wed,  5 Oct 2022 09:35:28 +0800
Message-Id: <20221005013528.62977-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAHjAqE3zxjEBBHew--.16506S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryUCr43tF45CF4rur4fuFg_yoW5ur4rpF
	429rWSkryrtrn7CrWIkF1jqryakay8Gw4DG34fG34fZas0gw1vgFyrtF9rAFW5G3s5JrZY
	qF1Iva4DurWIk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3OzsUUUUU=
X-Originating-IP: [112.22.168.233]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBPRCQEWAZCmC3NgABs-
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
after calling erofs_put_metabuf(), that is not correct. Fix it.

Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: refine the subject, jump label naming, code style (Xiang)

 fs/erofs/zmap.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 44c27ef39c43..0bb66927e3d0 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -57,8 +57,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
-				   EROFS_KMAP_ATOMIC);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out_unlock;
@@ -73,7 +72,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
 		vi->z_tailextent_headlcn = 0;
-		goto unmap_done;
+		goto done;
 	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
@@ -85,7 +84,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
 			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
 		err = -EOPNOTSUPP;
-		goto unmap_done;
+		goto out_put_metabuf;
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
@@ -95,7 +94,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto unmap_done;
+		goto out_put_metabuf;
 	}
 	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
@@ -103,12 +102,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid);
 		err = -EFSCORRUPTED;
-		goto unmap_done;
+		goto out_put_metabuf;
 	}
-unmap_done:
-	erofs_put_metabuf(&buf);
-	if (err)
-		goto out_unlock;
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
 		struct erofs_map_blocks map = {
@@ -127,7 +122,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			err = -EFSCORRUPTED;
 		}
 		if (err < 0)
-			goto out_unlock;
+			goto out_put_metabuf;
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
@@ -141,11 +136,14 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 		if (err < 0)
-			goto out_unlock;
+			goto out_put_metabuf;
 	}
+done:
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+out_put_metabuf:
+	erofs_put_metabuf(&buf);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
 	return err;
-- 
2.25.1

