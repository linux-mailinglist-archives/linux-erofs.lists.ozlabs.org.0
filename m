Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EE2CFAC6
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 10:17:20 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp3qx3n7rzDqjl
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 20:17:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607159837;
	bh=SgsFKlp9NRXZ97YLlToQbmo5zKaz0vhCDKKs7o/8KDA=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WAbcrAzDVTkKBuYHxctA5B2z1i86Xzrug6dgNGAMUNkjRdSO22cpIaLMuIgUYjZ5E
	 gV7uXR5oDFWhpXMaXegdnSpXZhI+4TDo5FIA6D5GkvPN34IzMReLtVPO9r8FpG4l1X
	 0UIzQm0MrqTqQyNMRxrwCoWwFDygMQgJvVnIX6/dY41F12ToUp1dYrjphNj7aZH/fg
	 um1RQL78iOxVUzirgplAP3vPmk+fdvTmGDdbuRN5STUUHJduQzKPnLLd77sjKGBrzT
	 eQz/UF2LRyKBzkjNZkQxmu9at+8uqu5jYFdwR1S18SIIsgXjys2ueo3xA8qCiILckv
	 Hfvb5kWEMennQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Gf4J/9m+; dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp3qq11XjzDqKw
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 20:17:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607159821; bh=eUzDRxadlKO5WfBW8eM1G/FxFoIb0JlvxwZzC9jxlaM=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Gf4J/9m+j4fRoL9+fHfdM/wZV+/3wgBPFMw4dxY7ZNHI3APBms6DJRiCwhfW0OOmsaREnio1zKMAUL4aNS9OIqLB42WdYurtH81llZou64uieH6mektmP1XtUg8iQmuZKMxrS78K7dYYLIi+ySRFqB/VmSO7eT+kQzVTsTy8URg8TR4SS3cLDHp9dN5sCg3mBkJ+Lvu4RkGpPxI3iVn5dTaCIzP8WK1IFPdtPJrv/UFy3NGqoZssqJU5vJoWONPRRSTsykK7Sa5z6IXXY2cyFNLFFn0fAI4/GBLd4bBLwduUmxHohkemm4UAHWsr1kj5hLP7DUthJCxr91wVqTRY8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607159821; bh=gjvazLbotYU1CQzNFnUoCJyBRmZP0D/kJBesW5MHQOh=;
 h=From:To:Subject:Date:From:Subject;
 b=nUsu8Vk7Sk2uJ4lSSd4CtSDPSKayECTJ7Ae0UJkW66LDXlFvRqPxd5t3ybvHXGtFqJ6Z8l89rM4xAv5DvmNalsODDs/H6IvCartiGNOX4i+pWkS7tKwZNjo1FgI7fgknQiZEe3onpVbyq63Rm3UJSl7pGuo0VYmBtfUH2aIf6+JfnY0DoB5kQhe3djIvoNT4YYm8Ff8HaoPBc8nAfA2DapUUK4LVqwkyneclsBLKfSmLP3o6kbfE38oGgCzUit9p95fM0t6jfu6+3Hwsw+afX0ot8qlijRTQjivbyEevgBUedtGblaCj4nvx6P/AVNcP8ft9+6yCeiccEgYKCMiD5Q==
X-YMail-OSG: RvxDGwEVM1mPyW3EexRsm3Q5TbBkLqjd3bRhlhl5RE.Incw92GokxdRMynUZKqa
 GZkcb44qEh7i.70jhuJc2crlSrDDRIKD7YHh500lDYBA..GqE1i_xpItpZSyNZK5PzODb2NxW7rm
 zqO0m86Kg8nzkqLm6EYUqxPsc5XKFeoH21lOLkRzbE62Bvm6ndm392UNMsaHzwnvuUTq53CBKxvy
 .cZulf54ylBQhNjwqRj1L0lqqxy4VZ.2neGmOb6DFNPzIj97r0TRMVWOCWYkK8e52Dz4up5_M8vU
 j_cSsJ148u5tLZ_r066OH2IEXuPsiK4IRPBy.ylUuAykEZvTU0hKBEj5xWurxOmoC5PMMk1Z6mgG
 m5N1e2QoWYlh7.o5R7W2B.6xnx1Tyrzg7Uo7l5hUtG71pE8PO0Mfn.5qcr8i1MXllz._e1CkT656
 5ZNbriXFZHufXgKZmXDWh7Q3TaGAmKl4cDUZ8hUV4ELy1RhdklcQKsPBtvvhnNN0yYFG5gXpWxVz
 gYqvE7reiqyYfM2czOldjpEcihrBuSZxphd_RkLMXLIZhssJT6MtS1ugjpMlbqDa96sikaz6B2CA
 1oq5w_pzoG7r14TvPTit4xZomzjfMCxG.Q8_3Z084sptN4rOECY8L07J0QshW5Lf._EGmaN3TDDs
 yYebdqJ_LIqn8NReWS6_vjPiuok_NGSdoQc2uGLxe.PjgjGSdCioiM6Dp6RdVA6MpIM87PPhb5Yl
 JXP44dTfY7RqumKzObSF1vSzQMWDSYNPgkxcEUBWANej5Gnm3wqW_9a9pg5uZumqIyryhsxxus4D
 WlObl1dzJgWEGueDOEkl_TrJJ_8MkXS9_TazR.B1DjD3MDFW_OzEypsdEwm46QdoNTDezqsIAP_f
 EpR2Ey6LgfALQs4QWCt.6ae.pUcBfvc9Kcn4ERW8uALXRPeB2VK9sGknOtgtpTAtcL7ydRgE8DKS
 QfVU4px4CWICCeHs4ETcSZOg6e4mcHCdhjwn54CK3.Le2xok8CF0u8beKlnWCVaDbuYsNxe3xPGN
 5BA2o.i6j5QpzgyOO8l58laKlYPW5xp_mtnMFGifjP8F0LUHf6_0EskbFH0OrhCyYY66E9gr.pja
 BIemtr6lFbMgyH_ZwKJC2rB_Lkg0ufFVT2UIMmDfFbGbMMeIPlPOmXQ6WwNt8TeL62yuTzsDz0zp
 tbOq0fKYoDsoyR09y1_DjLiangOELpTuzNF01JuVaTup.k69uBz3DKJ0U0yLlFoN9jvHbTGSpIgt
 0yXRQ0aRW5DZ_NxoWppWJ8IEaayQGpDUTurn5vqRh6vKGODk.p5gog.K6Gpy07A4rNPUDXV1BN6.
 JjcLbSShpkUwsQ8UN2eyPH0SZje8O8DO6vhuv.AsXZIMvz1YubVi.32wFodZoXk.w3qnOpvUZNQv
 VUeafIcfcYYaIgV6eK_fcsoG9ie4IN.fPZiNjrcFFAV65.93WZLUIw2Z8Og4qA5VjeWI2HfFzi17
 HIBFZ9tc17AvfF9dikfzui7CmZRprYLArhTpm5wnK4x7j3u94QtPYZw7P7diKCAJEqSrlo37tHP.
 vNsAdNJvheDr6EQtTIRHJZkFW_u2cGFn7HmCEgdrYChqKA4v4iOb5IzQdlCcaoAx3RGhgL7GjIAC
 4FGeamrYzAnsy6EMIkzbkf4gtvCDLxQzC1hzTXoNyBcOGzGatIhYSvQ_hABXG73dr.rD.L_fA40d
 SlJJ3t.USAO0vSb5GF0xghe79iNPhKqB3r2houuAlPOVmbxfYEROFP.FA4DLrxb5gdpM2y7lprMt
 b3ujmiVuGa.p1wd9.V_2lQTWX44QxExNTfzye_jc4sCJsTq1J_sv4CKU6h9dbaIweZVbnjYs5xCh
 yCqulCZDIrJeB.HqdLQkzLnZwFCEefzzCepHNz75OyNrUCwSLwvHzunoyr5yoi4sQaH7CaaznY1B
 lA4U8P6BJxFIzOQXz3NOAbO3pjNmjFmzdPUZTcU7ktmcx8_uMuHAO11UwH6SgP21QumbGeoVUJLh
 sI2irhWhfAe_WlZ7nWVULRqOLZ_6TJgxZ7XcBr0jt3CRkRsBPRO0AspbmYvnXpUhCmCISfhM98k5
 xZLeH0DtYUumE4AcutyOoq7tv6NCs13VpZYnEq2RhBZryjpgT5WxIaOTsxdtTGx99oXCm3rqb7qo
 H.Ikistgm4V1TeLzg7sxk5_ZR5DpfJJjNK1Ve34FceYe3OV_BDIRyAKeDn7NBsxMrTKidOVsO.tv
 miS.2NA08ZJJ0izU8qLBvmBqiuQsaexKqvs4iU_XMyxKgkJ6GsNCCF7PnWWcY7XsGGm9hyplSzaI
 pozsk.7dAvfqo4_dd3bF1NZvCyKPpxgl2o3y44vOP8O29H7HiAxYzZoQkvUlhDlP0Ukqo0xFeWjp
 h_rnnDgGOGqYdgOEH3z3RS3s8vZ.jQm9SIj5FL13SuHychLPuNz6XZ_kBxwCTukr0ihDQQBSxJVk
 Dh5E4OQgzQb4HS3o7c_Tt
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 5 Dec 2020 09:17:01 +0000
Received: by smtp422.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 379f8be4d6592fad39ca33f9b488f5af; 
 Sat, 05 Dec 2020 09:16:57 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.lee@aliyun.com>
Subject: [PATCH v2] erofs-utils: update i_nlink stat for directories
Date: Sat,  5 Dec 2020 17:16:37 +0800
Message-Id: <20201205091637.8944-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201205091637.8944-1-hsiangkao.ref@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Previously, nlink of directories was treated as 1 for simplicity.

Since st_nlink for dirs is actually not well defined, nlink=1 seems
to pacify `find' (even without -noleaf option) and other utilities.
AFAICT, isofs, romfs and cramfs always set it to 1, Overlayfs sets
it to 1 conditionally, btrfs[1], ceph[2] and FUSE client historically
set it to 1.

The convention under unix is that it's # of subdirs including "."
and "..". This patch tries to follow such convention if possible to
optimize `find' performance since it's not quite hard for local fs.

[1] https://lore.kernel.org/r/20100124003336.GP23006@think
[2] https://lore.kernel.org/r/20180521092729.17470-1-lhenriques@suse.com
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
v1: https://lore.kernel.org/r/20201205055732.14276-1-hsiangkao@aol.com
changes since v1:
 - update a DBG_BUGON statement suggestted by Guifu.

 lib/inode.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 618eb284550f..3d634fc92852 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,7 +25,7 @@
 struct erofs_sb_info sbi;
 
 #define S_SHIFT                 12
-static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
+static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
 	[S_IFDIR >> S_SHIFT]  = EROFS_FT_DIR,
 	[S_IFCHR >> S_SHIFT]  = EROFS_FT_CHRDEV,
@@ -35,6 +35,11 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]  = EROFS_FT_SYMLINK,
 };
 
+static unsigned char erofs_mode_to_ftype(umode_t mode)
+{
+	return erofs_ftype_by_mode[(mode & S_IFMT) >> S_SHIFT];
+}
+
 #define NR_INODE_HASHTABLE	16384
 
 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
@@ -156,7 +161,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 int erofs_prepare_dir_file(struct erofs_inode *dir)
 {
 	struct erofs_dentry *d;
-	unsigned int d_size;
+	unsigned int d_size, i_nlink;
 	int ret;
 
 	/* dot is pointed to the current dir inode */
@@ -169,16 +174,28 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
 	d->inode = erofs_igrab(dir->i_parent);
 	d->type = EROFS_FT_DIR;
 
-	/* let's calculate dir size */
+	/* let's calculate dir size and update i_nlink */
 	d_size = 0;
+	i_nlink = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		int len = strlen(d->name) + sizeof(struct erofs_dirent);
 
 		if (d_size % EROFS_BLKSIZ + len > EROFS_BLKSIZ)
 			d_size = round_up(d_size, EROFS_BLKSIZ);
 		d_size += len;
+
+		i_nlink += (d->type == EROFS_FT_DIR);
 	}
 	dir->i_size = d_size;
+	/*
+	 * if there're too many subdirs as compact form, set nlink=1
+	 * rather than upgrade to use extented form instead.
+	 */
+	if (i_nlink > USHRT_MAX &&
+	    dir->inode_isize == sizeof(struct erofs_inode_compact))
+		dir->i_nlink = 1;
+	else
+		dir->i_nlink = i_nlink;
 
 	/* no compression for all dirs */
 	dir->datalayout = EROFS_INODE_FLAT_INLINE;
@@ -957,6 +974,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			ret = PTR_ERR(d);
 			goto err_closedir;
 		}
+
+		/* to count i_nlink for directories */
+		d->type = (dp->d_type == DT_DIR ?
+			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
 	}
 
 	if (errno) {
@@ -978,6 +999,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		char buf[PATH_MAX];
+		unsigned char ftype;
 
 		if (is_dot_dotdot(d->name)) {
 			erofs_d_invalidate(d);
@@ -1000,7 +1022,10 @@ fail:
 			goto err;
 		}
 
-		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
+		ftype = erofs_mode_to_ftype(d->inode->i_mode);
+		DBG_BUGON(ftype == EROFS_FT_DIR && d->type != ftype);
+		d->type = ftype;
+
 		erofs_d_invalidate(d);
 		erofs_info("add file %s/%s (nid %llu, type %d)",
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
-- 
2.24.0

