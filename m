Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA62CF9EB
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 06:58:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnzQ32c6tzDqgx
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 16:58:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607147883;
	bh=5R+E8S3XAhxyvDJ0cfbA3WcadtgA677sqTXzfwHPExg=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=AfAnFDbcdAe5/rWhQGHb/8DwGudQjOY6zFSVktn6c/1idpIzorOkkznuTwADg32ne
	 s+blx1sl+aQrBQAzW3SYdx7QGW7xtsoOhFkYEv+RlPC4VUMoVVkb3DrwjRNdEAZsm6
	 8k3bB5a1za9fWpAOp4yIgu1qo3m7KpzgtEjfrZpbwiBhj0Sy+JdvyJZW3SoD8xsEXx
	 eJY9P0cg4f+9UHCeK780g16tD96StCtuu5GC5W54FTvHXnIQY6D9lkDZqA0KiJ0oiZ
	 4ApxlqUv69vgnKi9jKGlAstZl8St7qOHX54h+uzzezv6v+PBLTHg/0q2s6hZejZ80S
	 7bOH9EwrIbEvA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.206; helo=sonic312-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=gbq6Jioa; dkim-atps=neutral
Received: from sonic312-25.consmr.mail.gq1.yahoo.com
 (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CnzPq0mRlzDqfW
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 16:57:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607147864; bh=LQmBJHDb84anTzmkVtvWHBYbY8KUi6nmURHfbbOoWjI=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=gbq6JioaqrfVfCmLY/ygbv3+j7r3S2JkpbDMAAYoWR8huudw05WI/wZwE8d8DM92eMCugAk941UlgYgRLgnnk4rCJkfhmQRbfJKvrwmzwvEZw6YcuVj8F8SCKKZhzosDlNzPgLUHoTJBiE245On30NyiGxngmRSNj+K9WVtK7ZfTWGEtqxtrjfsyze8ab0Nyl4/e43c4hT6o1liB69rymNwRsO+5O8/iNS4a0a3ftOIvGQh4VBugaufcp5OZ0gBWKnCGmNzuDw9TPGmk/VWr/IvV7eKImTfUR4gds09aGHtbroo71apbRLQ0nFhCcZuajKkxahQ7mXy39QhwlyCYvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607147864; bh=pQ5xXDynLy4pUjaehuAR8JqRlKjBk5Ex8dicjRv5bbp=;
 h=From:To:Subject:Date:From:Subject;
 b=fQH5fT+6j0PzNwml7VGaVyIS2I/Lem4keQ+ZcoTnK1JvVCfkQDi0BBeKI6NE1+euomOh61XR+vweoSYXySRvynPaavSVV8AMh7JWHUt4aqqD/slTGScyjD9k9JrS74LZkZS+TQqReB9713++MYxTLyChetjxaLZLZso0qJOvjb3nih6wLm3vMkhr66tXiM2GQHfpMkhpaAgoBNkrjUPD96jCL8IkwYOO8VIhl1Qn15NyRC4z4ME+4wTAAHjBQBtQ+WDeyKK6RVfT/EhDjxOuUbzn9Xc6eloFDCa1yP6Mr7TRLP2dZo9iwqzthLy9X6nsVlr7MjHrDepZ7TSO8+mcuw==
X-YMail-OSG: FnKIaYkVM1kp_wI1YHO015whC25bG5GXaxL.ickczSRXhHHye5EnnP0XaMkQyQI
 npEtzh3yDi7I0YdKV1.KqlRYBeuChkrG4psAi4h7QaeZw.P6GYzUSFQF_KcCJQYIz7Z7kYX_Vu2R
 fhwhQ0MqA_TYissJ4GSrCsE4q.zD.EipfZoAZDahYa64IZSy0Ydx0SyvQW_e52nuyLQheZIDqdxa
 7Qz2Po8W8oc8w9IR6c2i1nIeenGPH6pxRIUPuTL46AdHb8SEA.DlKcQ9pF.pWLHlz5ERyRlnvr11
 4t6.e3URxBzzK8PVJJkzITQMm01pA4hV3gw9eyKooUXwuBM69C5GsR8xHbygQpW1S89m0KUcOnRE
 0BnabdQCJb0S0Bb.jRdhun66hnW1HnoRlx5xh5DOTaqHJHYdPibV1dVtGGzqcn62OX76dtZp8kMh
 kAyhFwalHy4fZi3.XQ0iIGRlB1aNXQ3kut_kXNx52Dm09NO.Vqw3Fo_34sWz_GR7UX.BrHUuxTUy
 pCrB23yXoolNfrp9CU05XWVI2tK1XcTzr.0PodyPLtCa2PBaiXOmNhHP9rTt66wlB6JgaTsCGX3s
 b.5n05NnmU4VARBQymW8ZlJVZbWPPUf1NJnxDhyi74lQK4GdtNDmpW6.RUyH873ynK7UuKReg0dE
 VExLY8ERr9U3qNnim_RDnqvP7yEZcn0oWKoA27G7H_cmjstiX57DVP42C3HT5eCYGzauPpqgWZKI
 sHgByd32gb32mL4gZwklzV9z2H482ip0h.2mQ8DnrgumTkUf_t0aF3omyqIhtQiXm30Qvh2ecuMa
 xXd7icTN_JJGW6qKr9NjcsJJ8G0PHtsFnqyKHOTtVayrZFbXVGwpXEImexc7KFFmIPHJF4pT1rUq
 ByIKz5mcwoh_0b7wO5qxLLKoQmgFOFHuERjoml1rYndqk4QrQP_RGKtbD9bA0gN1qqkZ1kuJDZtM
 GfjbuOSDtIsuUfpjly_oUqPh7znPwapBfjW4GXmIrdHIMfb1CoK7ehDgqmCRqoKVswbo7AtEwMRN
 68XvH2UHjVcqCHk8swz_Ja8Z20kGqn9LoxC9kfHCKA9hcR62WhNGVyx0KoZtpzDnVhXDoW8fPiw3
 lMa7nZ3XVDUBBhgutNs7l5urdqEOQ1Zmb.PC_sVmjrqH.88R2gKlfOEEAVqu.Q_jvfhOCMVLaOG9
 p6evAIzNL7ABNUSsT7eJ3PStCxI4flXjvXPLsL4vX1DvyMXqbob6Thnpawxk7ecXdbfIVl_tLsuV
 pyNqQfmlZPWn6g7xI0OCeH2e6dWOIiFDLo8MVa7wSIG6P6JxI_uI1M5BYR933xRb4FStFZpytOwJ
 bahuwuf45pngbZOC5qaAh.1NZx.BlrYhzIWUsfK4_jGoa1VBkKBtIZC2fGhkiPLrXkfQ6eJZJ21X
 1GpphmeTdxGgxMwrW7pa.Vah9QGUMSp_77DAx5LARhwE5.UYzQf67lWBhDDRlpL4BPm4zDdUFehe
 S9RCKlWG.tNsWJUEBufwpk8uMUxbzUnE1PF1qtNIKbmhqdo_DWxDgpxYjkTbegUkSQKMn5XApH29
 UoGNBI1ovOfxJqbvGoaRXwTApCuH81VmZkUN_e5AUn9y3i2IczolcuZyApJXCBCPVAZ1Rjw8ib6C
 GT3C9pG6fcYyi5H_zFIZTw56ZSdqfgWlyoSGUKUqAO91Q8sFmIFs8mCgf7fDBIVfox7_ZFBSWFOm
 fa8A1dC6IfHNUiZPrWw2U1Z5ekdsIMUts2v8yvs3mby5b2I96qkm0pswG_S68OiuYpqKvnldMqlv
 645EceJKrY__9L78kgZ1f.R_ds2571KeZihSnHSq48AbXK5nP3OeBoG8xxRZKAjiSwgI0Jwry3Ft
 uw81byDdYgst5ukHnf7xoXcgB6INSyBLNTrSsp5gLKFK44H97qNcpANT7MoLFG5jDm3x7BAl3EzX
 DjafafU9wu2Uc95XQkSRwXiYfQ5DpRP.hTXAk4eJiZUwYrsvNc..wgfW6UCIaIwKhD7y.XDB9AR9
 85Hg6K4.pk7G4Zu5CsTQTJtaWkkNm96X5pMgVCNlXDVtBMOHy_TfVcKHyNGkzuNIrPbp3mybXTU8
 GfGV6JrR1W6l.4TcFVGJNs00L3psDgv2JwplUbSd.v_NP9lN12l1ueER33HuFQman.YPnh2S.1EH
 .ERyNbAoBQRFS9Bv0lejsCK_rT4kZxJZy9haGVswV.yr_yHpDc_2KHSE4QH1KAoTlGwIToPevFgG
 1yznBI_3O6cVzrZT9bh4PUpiPmUJI0N8G.PhpIfapy_EnIPulSmmf4ARc13u_uP5VrJXH.D8he0S
 PCIokG2UsvdllO1S2QdnUW0IOFE4F4TWB5cgf1MUIQ1A1iIAg2eLLT0yRzG_KhDFvbmPU5Hrn4qj
 ZsfSkoNVoTEkIu9BqKi1shaveuY2OMeQ7AkkTigWsgD5aSFrTkvgkIjADsK98L8HoVUyAf06RKlz
 xZ81ZNm7mYTH8I8.9_mw1Cclewn5SnAtHlA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 5 Dec 2020 05:57:44 +0000
Received: by smtp405.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 79ee4771f967474ebbbdb5c1a23e0637; 
 Sat, 05 Dec 2020 05:57:39 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: update i_nlink stat for directories
Date: Sat,  5 Dec 2020 13:57:32 +0800
Message-Id: <20201205055732.14276-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201205055732.14276-1-hsiangkao.ref@aol.com>
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

Previously, nlink of directories is treated as 1 for simplicity.

Since st_nlink for dirs is actualy not well defined, nlink=1 seems
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
 lib/inode.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 618eb284550f..357ac480154a 100644
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
+		DBG_BUGON(d->type != EROFS_FT_UNKNOWN && d->type != ftype);
+		d->type = ftype;
+
 		erofs_d_invalidate(d);
 		erofs_info("add file %s/%s (nid %llu, type %d)",
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
-- 
2.24.0

