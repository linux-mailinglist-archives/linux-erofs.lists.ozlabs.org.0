Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B89A47AF
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj6z6HWrzDqtk
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:52:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317179;
	bh=Aqrm6rMWJrn6qjY3SuWxDuDHEkiL9BzH9oPfCCg8PyE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lehcTpxM/JfIEllV/kuAgbJTYyafu9XrZ3zJ6OtV1D7y+X7lnZsTHLHfNLwLR8Usg
	 BvcfaJGSl7UKQfhzrt5kIVOEcYwoPiNFXMeLrvlnhgeBRItlt5dNcJ711l617j6vok
	 olwsXjHvKDJ6GZvSvDYXHNvAkU8hlCzpYVSOuSCjnDwnIBRbLXbV/eFf4+sfpGxWqk
	 xVKNJ4+qYRQZUjdouye3UmltV0wZvakeaXi8sdtT16rPFrmu1Nb7BUj8XDz4LgRP67
	 rQW+uaY3yKaHILo/9p5zxivcPusOWrmaScMVfm9lrUk+mKQNE0rN+xpZNkIWoIv3oL
	 ymSBq08hHS1KA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.32; helo=sonic316-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="N+i/cZhT"; 
 dkim-atps=neutral
Received: from sonic316-8.consmr.mail.gq1.yahoo.com
 (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6Y44sBzDqtZ
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317154; bh=FzeNItiene0TBHzyekGv1R2lNe17KNzxF1AaAx9+9Tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=N+i/cZhTNsNwmzZ0LdOKZyO/dY/jBflyfRu6J6kVwgL1YsTQfT2IW2aenms2yXDv5bU0nXum4thMkMB5JRbV2FetvxfGaBvg3DNvRC1G5R0Zk1wzBZvCJ8u4nWL1yJt+FNu2KErLjQ/4k18pWIAlPmC2FJmOcfreR37PkB5TZnVdKEDUnizb5T42sYyVjVIoPPMYlRt6EPK3FvWd5yCbzuHddk6JHGr+KzDsLFpmnrxpT6joONB98kaZF9twDKJjrWgxWMcuWpq2cTKoO79Iy0568i9KBAv2+pe33TdVNsKm/3GQki+YUZefHb2PAG+vCRStRBdp4ibncl7T5bJfbw==
X-YMail-OSG: tJJSDhAVM1nwAZ94SgMfRaI2OS7mUthquNMV3K4p0AnHtEhYYyRBLNURv._gJ6j
 S460wzP1bCv0bBw1zFd_5d1ZpPoeNNyapMByKcN.ixbb0xbVKFoUz4eRw3aP3mPMMXnBIqBBp5Ob
 Fd_qlFy3TZOoXawugio8nq6RDhcfJqya_FPLW48Zrht6KGApll7rLy92r6sV4RwtS2WLcAl7YnAD
 ByssQrHVvn9jU1SA9UIRwCxqe02HaR0kuA.xCc7Avs_3A9wQfCpBwuEo.PYL0mg_dGsSitbp0X2R
 xjUDUNjB16nuQIv3eYB.5b9ZPemL6wF5HFzUFP67TuacEBsN1UH8Lydww1TOjjmumdyxd1f1LoFm
 YYnkrGOZeRn__C9SQxxWDf7DqGFRSDpYYGEjipD88uzUvHgiaCI2AQvjj7jYjdgUhfW78DzN_bcL
 DEPvBfzzQSuSmW2ftOQijf8BnVtE5.pGYa16bjlfH6QkSy9QKgdJgbHY23HZ5428JQ35EhcT0ryo
 OSLgVt7OAdeuzSxtG.JpiBLzFOq8xxyIlCWD3E9nhewOzC2A_U4CtiuIpFolqbsy5GGPzztRm032
 qMGUjb.OSvDBSrGU7fp.IR16xGdP6EVdxTjbPOnNF_OjZ5lP_GAeuny0LZlM7WFFM34IidP_2GkE
 Gjch4yJOjK_.wQC4OX1pKJ_hPVU1DOjwxbTSYd8g8EJIwa58bRBQ_qVXSdSPDVMq3Rkx7VskSrP.
 3d1vDrbyy27GfTZYRh4wDlMTwRArxAlnZwY1HIpOkkcVZF9KfalAGa.X5D9BrQXAYoH5omZgXo21
 hEwdA1mVSMKETkgYAiSa0hXYNr0v29D3ldpkv8wCogu6cIsqrA6t5XGmX5PxJsBb_Cvv2O08gyds
 SAHZ22L_GHdBHA3u4a4sbzHNE7C9LTuCvxehWXD9KnBVdJ_7FpKdbFebGw1enIfku3H1bDSElQt2
 x9ooJTk5LYpSEZV9tfs9k7atMHUCWhh7FOY_X63NGMgIAd_dcykT.0RNnsiXVtdK9qTNQLFkuSVA
 mLv0rAQXNAJjqxxgdbDXVOLzOkA_HMJW5.su4emhuNDSM0_g46eScsEYcjFPmitq69RJlmncawK_
 wSrSo4M8I03hzeDmypAOEZJZFZ05eLL5d_TGM5u0ksude.DS9.XxLapfGIB6LONfG4iuKkyq6lOc
 VPmu.f4ng6NSsWV_O_mrh_oU3NVZQA3TUZUFOqlh88JRCboCZN4DzXwESIDEQnNE9vqnjQ0toEi3
 uTGwsIvG2DIv.FhKlzV3tknbU1ucBB4cFaLlZ4a11h6ud
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:34 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:34 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/21] erofs: update erofs symlink stuffs
Date: Sun,  1 Sep 2019 13:51:18 +0800
Message-Id: <20190901055130.30572-10-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Fix as Christoph suggested [1] [2], "remove is_inode_fast_symlink
and just opencode it in the few places using it"

and
"Please just set the ops directly instead of obsfucating that in
a single caller, single line inline function.  And please set it
instead of the normal symlink iops in the same place where you
also set those."

[1] https://lore.kernel.org/r/20190830163910.GB29603@infradead.org/
[2] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c    | 35 ++++++++++-------------------------
 fs/erofs/internal.h | 10 ----------
 fs/erofs/super.c    |  5 ++---
 3 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 24c94a7865f2..29a52138fa9d 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -109,28 +109,14 @@ static int read_inode(struct inode *inode, void *data)
 	return -EFSCORRUPTED;
 }
 
-/*
- * try_lock can be required since locking order is:
- *   file data(fs_inode)
- *        meta(bd_inode)
- * but the majority of the callers is "iget",
- * in that case we are pretty sure no deadlock since
- * no data operations exist. However I tend to
- * try_lock since it takes no much overhead and
- * will success immediately.
- */
-static int fill_inline_data(struct inode *inode, void *data,
-			    unsigned int m_pofs)
+static int erofs_fill_symlink(struct inode *inode, void *data,
+			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 
-	/* should be inode inline C */
-	if (!is_inode_flat_inline(inode))
-		return 0;
-
-	/* fast symlink */
-	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
+	/* if it can be handled with fast symlink scheme */
+	if (is_inode_flat_inline(inode) && inode->i_size < PAGE_SIZE) {
 		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
 
 		if (!lnk)
@@ -151,7 +137,9 @@ static int fill_inline_data(struct inode *inode, void *data,
 		lnk[inode->i_size] = '\0';
 
 		inode->i_link = lnk;
-		set_inode_fast_symlink(inode);
+		inode->i_op = &erofs_fast_symlink_iops;
+	} else {
+		inode->i_op = &erofs_symlink_iops;
 	}
 	return 0;
 }
@@ -199,8 +187,9 @@ static int fill_inode(struct inode *inode, int isdir)
 			inode->i_fop = &erofs_dir_fops;
 			break;
 		case S_IFLNK:
-			/* by default, page_get_link is used for symlink */
-			inode->i_op = &erofs_symlink_iops;
+			err = erofs_fill_symlink(inode, data, ofs);
+			if (err)
+				goto out_unlock;
 			inode_nohighmem(inode);
 			break;
 		case S_IFCHR:
@@ -219,11 +208,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
-
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
-
-		/* fill last page if inline data is available */
-		err = fill_inline_data(inode, data, ofs);
 	}
 
 out_unlock:
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index e576650bd4f4..4442a6622504 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -480,16 +480,6 @@ extern const struct inode_operations erofs_generic_iops;
 extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
 
-static inline void set_inode_fast_symlink(struct inode *inode)
-{
-	inode->i_op = &erofs_fast_symlink_iops;
-}
-
-static inline bool is_inode_fast_symlink(struct inode *inode)
-{
-	return inode->i_op == &erofs_fast_symlink_iops;
-}
-
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
 int erofs_getattr(const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int query_flags);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b0d318a8eb22..8c43af5d5e57 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -38,10 +38,9 @@ static void free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
-	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
-	if (is_inode_fast_symlink(inode))
+	/* be careful of RCU symlink path */
+	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
-
 	kfree(vi->xattr_shared_xattrs);
 
 	kmem_cache_free(erofs_inode_cachep, vi);
-- 
2.17.1

