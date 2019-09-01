Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDEA47B4
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7C55yKzDqlr
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317191;
	bh=leehfY0w7Sm5V210KeoIUcvw63cDKldZTUWE06V1Ods=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f5r1ChixpOFq4gasWrVkskdnwBakOHNrCTJSJszAyx7R4y/R1pQZBT3z1QA+ecNm/
	 AD90f+O601WIFX7KrrhgxucUmiUPqw2PeAVr1DF8tNOEuMbK+ezcGHYve2Q2Yfcg+/
	 2ZmtlnU3wgn0oJ0bYhL1nKLYAUoR+4EQp7Fy9blWz3LCPheSH6VE0E2oju/7/p3tEd
	 vuBaO1AxMzWwq289eVGbLBXgzv4mEtUts+EhTCKx2Y7ZWj3z53o8eqz69oJPkfSsjQ
	 SMNjjjQZE8HjmOugNYmqtPPjsS3INfgUBM++T+5C2Ep+MXjPqThpu7g9ROt3jaC41V
	 p5lfiXKyVav/g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.32; helo=sonic307-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="q+MeV2ah"; 
 dkim-atps=neutral
Received: from sonic307-8.consmr.mail.gq1.yahoo.com
 (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6h0YtfzDqlr
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317159; bh=f05SOMjhcbrllSkIEXOI4eRR/x6TrSdhoBITnwjaQY0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=q+MeV2ah9X/xMnfHbHWejNVpqJ0n1Pot/QtnxizQW7z3YeaPC7ounQjdo6lP/n754/1GSxw/IYc+ITIUic5kiGY4tsWH8NFA5hKOzQjEiXvQuSPCLHMSQedxtdetNnJNxd/TnrrIKkXBM6S3Um04JzeKzpWHAiy3mYL1NjAhtOB9ZJtmWATWtydtQHZfnkv74rIsSUTgEDlATY4eUxx4NL7ItVta3Cchll1T49b5zvyECSyZHTbOvrOBSNRalXl+hiCqsA+LCQX+MLKKtHbuCzRv8vxaiRSzDi1Ppvt26tFe6hO6l4BiuILG+WZuJ6PlB5S19OU5kaAh7oWmQwzz/w==
X-YMail-OSG: 3OgvbfcVM1m.J9qM0HpXLxrcKXINJlnPJ7PNZ4hqbBeAmGwoLwx6qbstNjAc0EG
 AUAbS5ZwM0l9wQRfcyV_msAVm5XUcG6mlIJAD7q34CZyJIpKr7iMTlwjVCCgFNU_Tz5ma424Xr8W
 Mm6de3ZKqLNRpMbNuMasHAJ1EK3yA5skDN10jBPzITd4uypFvM0ki5Rg8hTfc3_zeFpWY0kR6PIj
 S.22fH9dQPHRMi23WVzTLTQPfUAAeoa5whlgF7SgmNJhjcIce7nn0vydJ8RHmtkWuSb_oYOKC3AX
 FAdMZUP17tijU4g981P4b9z1_SQSF5xeDSlvrL1eblj21G0EsGbToYRm6RWCg.iI_gljVexK1HrC
 g89ZE3eF3HgOdSJC4a61pzDNt13TuPzn__m.xskI6L4Ac9Ko5wModz8NZ9BNx_JVEcUJ9ft9fWMO
 .F4fhlS._f7WBDZz2ef_3bUfi1lYm0j.3C1ahpTNbbEJs4bCQ768NRgQQBLjYxXLjkI1Mo7mUPhZ
 SlEgubBACKU3TKCl0Auc3soLYX25KPc83IRU4r8Ft9Pkg1iQ_TQzpb.411uEDygvImnfXXdbUAOr
 ieiz4Qw4Y6sup8fm_dgl5a0srmwTmDt1pNkklUlIrYaJCYJ2fGZZR4_vxbB1s.m4v_kgPPB3NDeK
 w4C8KsLPJGNI9FASs7xSXLATNRMJtWCepaAY7ovkv881ZulqPFDbUYejwndWree6aFVO7lQWPNp4
 O1rKdK09s5rkbWgVTCitWGZQ95Iy2Ma.5duWMwbDTBas_.ZFBksS40GIlVC0_6Bj7QW_MdTiuAiu
 kZ84drzYplODx2PKf5vI9bZ0etbh3GzCMX4WD0Ogq3__PzmN5UfWgSeqDTO1u9Qobv9KIcOvzX8y
 KGgZTN_G2dDw6HunTGapzsXWJDlFMlM4Jdxt0GVYJa_1di61O.mYxx2OOErF6jU3zQcBXUD2Q9yI
 6su_HtEiLVmoAgYtbtjRJ4f7EMw.FDwnRWsaiiPxRg7O5sstrctqS2uaH6sDHFRzxX1u.G6MKaMh
 7_dz23L8oQpofzjCmpvDN2oXjl9DnHdiTZMLKV2b6Hktm4qW5ftqdQFt8EWR3dD5f7bqTB8.x5Zm
 DC1aRh8SF4I7a76nna_rdY6fHvFHGD5_2TMpKz5Ye43clJXVp.lY83_Sj2whgk_2HlQFoWZDgLFy
 t0O8io_sdtDXRaxlMiHe3MovujHltXa_khQbsKRuh9IN97tYIKUtePoOO75mg7uvIqscwtfKshcw
 WrIuLGSvdSAvQxIo_s77.iPqN47euyW3w.IgO.B6EFWdy
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:39 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:39 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/21] erofs: kill is_inode_layout_compression()
Date: Sun,  1 Sep 2019 13:51:19 +0800
Message-Id: <20190901055130.30572-11-hsiangkao@aol.com>
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

As Christoph suggested [1], "The name of this helper
is a little odd.  But I think just opencoding it seems
generally cleaner anyway. "

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 2 +-
 fs/erofs/inode.c    | 8 ++++----
 fs/erofs/internal.h | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index d736d2e551a1..e2e40ec2bfd1 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -169,7 +169,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags)
 {
-	if (is_inode_layout_compression(inode)) {
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datamode)) {
 		int err = z_erofs_map_blocks_iter(inode, map, flags);
 
 		if (map->mpage) {
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 29a52138fa9d..d501ceb62c29 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -56,7 +56,7 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_size = le64_to_cpu(v2->i_size);
 
 		/* total blocks for compressed files */
-		if (is_inode_layout_compression(inode))
+		if (erofs_inode_is_data_compressed(vi->datamode))
 			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
 	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
@@ -87,7 +87,7 @@ static int read_inode(struct inode *inode, void *data)
 			sbi->build_time_nsec;
 
 		inode->i_size = le32_to_cpu(v1->i_size);
-		if (is_inode_layout_compression(inode))
+		if (erofs_inode_is_data_compressed(vi->datamode))
 			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
 	} else {
 		errln("unsupported on-disk inode version %u of nid %llu",
@@ -204,7 +204,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			goto out_unlock;
 		}
 
-		if (is_inode_layout_compression(inode)) {
+		if (erofs_inode_is_data_compressed(vi->datamode)) {
 			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
@@ -283,7 +283,7 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *const inode = d_inode(path->dentry);
 
-	if (is_inode_layout_compression(inode))
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datamode))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4442a6622504..6bd82a82b11f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -327,11 +327,6 @@ static inline unsigned long inode_datablocks(struct inode *inode)
 	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 }
 
-static inline bool is_inode_layout_compression(struct inode *inode)
-{
-	return erofs_inode_is_data_compressed(EROFS_I(inode)->datamode);
-}
-
 static inline bool is_inode_flat_inline(struct inode *inode)
 {
 	return EROFS_I(inode)->datamode == EROFS_INODE_FLAT_INLINE;
-- 
2.17.1

