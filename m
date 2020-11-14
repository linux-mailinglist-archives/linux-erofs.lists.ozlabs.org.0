Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934642B2FAB
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1h5GqRzDqST
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378408;
	bh=j+Xz4ZQHgrqVDTYBB08rPgVbPqewBox6irPiRas48dk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oFT5vJegtZ707rdX5goC1Pnujhv1ppEaBMH3RquI5cF4pBxSt+clg4M17oeZz4hfk
	 ytDOrkFWiS9zResU/fgcGU7PL+BGgIr59Z+s1ITRnWBmN3qhp7QGA0DYc7BMyxC0Mo
	 PGOXzuQH8Yn2OaYPJrmEvl5kc6WPmbJjrxmfm5Ye0S/4QiHVBphAJEnD0fbGbjRI7m
	 +avzOL4vo4PR8OG7Yk7gscglAiEDmiidligveCMUHnS9qzTQi6zs4xQvYnHhqgeMIC
	 a7E9krlp2UzuSYj3grQQQNUvArqHwhBeiEspUpQ1JleMG00n7RFZAgGUx6s1lY5lSQ
	 6phWvzx74yGdw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.147; helo=sonic309-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Se4YBrnD; dkim-atps=neutral
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP164fW3zDqRs
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378374; bh=58NdWgrVQERik7KEWL3BAIfaYyGIemxIy0sQ++YBWtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Se4YBrnD5/0DoAPi2jU+nftAbTAg1PsW7c7a9GbMXFVYmPGRCoMIcAvrN0sbyJF3pzZWMj3FViV1hIlNXJCCYWIZat1xnkCK1PdG3/lXNx5ZB77niCqwFJsGaJ1OdVkfkOOwNHWhrpqsTmVBR9gRJLKz+wTJfKahm0GCXXHO+aZld2LP5fAWD0i7WBVevN1GLdSk786YGpQuLZ+17Urtz1qq606Apuj3hxxLhPFAEt4dMYtilao8Lp2GI/N0QNjN6EfI65GcjBXmHRiYWSZEdq2gBqZhY/LgHd2GRnq/Vb9n5Axvqwzc1wbxP/AlDj3acC4/9tHUVzFLOkbFRu2JyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378374; bh=4ewUBSY9B34oY4XlsUJGaU5bJHqEyM5Ac9cjQr/tRgp=;
 h=From:To:Subject:Date:From:Subject;
 b=jwdBVPgXMj7cAph1HWqmi5PzltklcNgMX9awSmC7pDlIbKb5q720aWBDX+Ofo2rlZRYeIwQ8RWRlS+trMNG5C5PPNNlKaH7Z61zHQ0bPHj62fG2ff6ylYOtyKgreO6WfpsgQKZN3ghKH6cTVqbi/oL60BwDmdohK9pHOhFI9kz1R6Naxkq6sPqjq9vDMtDHqafdSb81z41ylzjsx+eqNAzY7xa9ONRhQP02NjdPrWqBrSCWLOJ8LLwDJfY9ryFq04RleC2KUX92N/T9OJCazvBNpl9vuXdi/V2Q3PSTGKDaSW8BzZjvkRVwE4iDEuUC/e83Odhhn3fOq5br7mgIpog==
X-YMail-OSG: G0_r1MoVM1klZ5IjdDWiUynBu22lD.WFcWSzAsZZ5anJ5Si5RKu.iJOQ.ANEacZ
 QbT6HLZtL9ZYRr1tYksig1Exw1afuTthIz89.TsSNHxY_0xebN2AE4KAMhJWzcrpCvev5zB0AvpQ
 Vh682vLWe6f2__QIq8H5Oo80RdA_F_4RAwZqLcAGdJVthbrtBBTrTOXJfGRyKDfcelk1Ih91BxjM
 xJ0Z2Quh9qJjpcOosDzStmPV6pQZWS7UUqUQVsg7EBncu_lUyFWolHI1qOA9lI.PPL9sJUjtV1AB
 2A0MwTRtUAMMJ4GUqqU0lUTFP.4ie74d3HCn6Pa4RHeWcj13.WcXnfrOO.W4ACb36zPiSyMnTzle
 3MDoRb0J6sCOJfgqzxwJcTNs5O7dD_DjJuHC_mhm1SHv2zJLujwnR1c4uOQZAu1luBzAJ8tjQngg
 TJ6Ml2q5CZY8R6NMQBleSwN8kzcvaC6rXi.2RiO5vl3O3mSDFHfiKy6GcsDgZ2JVccF_eNX_57Lo
 RwYECJCqejk.wWhGVaqtGkE6YvSfc7ladiysecEsWSEKIUHTRpvdZyH1xKzztntKGgrRD3sNUp9p
 56InH9Q4CYYzFUsgRJQNduSYW4irQKy0_dKMSyiZ2G3UHPm_FIKd57GYUGyZz7jz_fmuEsY7fw8y
 0moYxuATAAoD_rL91JjTPBchoYOJwJj6p1QmCiJp1tA691SIVR39Yd9CVu748SNEKXJ__aXk_wK_
 a2AzNh3ABrE4pVTFFwsUEUe4iPcPrSjhOEj8AtaQZ5W8RDXQzRlRY969coWvo1o2o5vSmqd5uIpo
 DwikJ5HtUN03EEykOSlHhp4_0dqDAwubfhT8HSfr4p0.IvaUC171QxpJsWWMUNnM_IHXztyo_5oI
 OxF.eodEn6XG0TgEz9mtSvrsvQpeEPsS693UV6vcrGf_tWv4N3Pjqwy7pmBZlzBsbfbagFnuYDYh
 EJK14K.OWfK7wdsqR77B_SGE.EoaOZKqvek87P.n4uF8LCSFNgkUthY91NocGkiwbcFy6poaA3pN
 awb4AzRkk5W3dtZiV_oMoPPoOBEJfutbqiYkrymR2CTu.32hVhzIJKgmO7dgJNBsQr8jpn.z1WcS
 OVLbxWmrqJMaBiUf86LByFdtA38MljcTnsEdA7Jx2w82xC2QSD1JoHDM7dd7LrPLcfQdd0vABk7s
 vjjH6wS_y.mhl7u83WH.jDFKlyGKjgqvdRbF4bSQDZiwRc_UtBa6k6ef2Lb6GzSEprHUzgetIIOq
 BF5Gi5I4qAueNNK0PiMwTRyJtV3KQs4kjqDiBRhq9tvnfLCxOIVJrIlb0T0rEpxsZLSx6uhEa.0U
 Ro.2Pnp5_pZuKOKKEiBHk9RJQKIheNVL_D9II7NfKAJ2aRk0.XTvFIkcuq.h5Ov4w54AsECrllQw
 2KMeQIzaLqAJv4wOqacivHe.8FA7GbA9KjpV1kA36uJ_Tdv6jv5IkOo6tLaUb_1cNT39b5H64heL
 s.qooUlOiX78Z2zUr6NNRWCql3gGBc433dJ2XMw9dCg_TR76wDS0BO91EDZjP0JY_MSoIiqXszgx
 7vhSTzBWP9MRd1f0dkzkv4ec6X6noUrBpd8qKf7A8C0RWqm87Bw7d8Y43PslfDMeqhgU_th8Uy4F
 3F4TrE7tbjTjkA5UOlsMwETgyqgg3tNuSG4FVra519ftzSHK8zxaYIo.moVlH2K7hSCRKjPZvre1
 XSE4nAQF1yv04_Lw9rMplDJeXrG2xwikguKrXBOVqi4O_4ER3jBvn.u3Fuc4848qtmJMkX_3wH7f
 xDfgFK_gNfrhikrsw4MPzGuEHNB.7jxtVih9_ngg53wqxG6rCiqd.nqchywx6PNC94xOnjt.IkAg
 zlW6L78N.Zg9MQl_Pni1ShAxIhiFJg.ucp4SakMc1bA3nhYp_Uao1m9w47LL9JFDu.QNbThso6UZ
 _IgS2mPPgPE_RT46QD10XwHAYWhQ2NC6ZCY4O0xXyWb7gehDBUePDOElRWeBxm3I5I_85CmRmEhM
 qusrbVSOu9G0hN.Px2LY7vHkaT9mAiQwUngV435Uo7Ks_7RxhtYgKXPClEf56_V8bjIticxXxVFT
 nW8ZldEkkL09gu0wCISe7luPRqpZiYTHkp_dLMvjmXxxo1SYGbuEG0MClL_gZTNqSGbWSJRcsnzH
 68kqLDF7JtE6XYj8mCz4cZUecg6iex3Kv16mZNFNYpZODKc1igos4Rud6hLniD6krUCUI14.jdVJ
 JRYYnfn6v0agYWyp8qTvupOiPImQ3qW5j5FvEmD.vPFwEr3G8JY_JlMXnTI8DOIEzrGwjck0rwrc
 ZZxcob2Q4_AWF6Lu97Oy6eMNe5Ehr_7YHf2x0TginET_NnGhRWhGjgOz9.wRDEhOXgJ9o9ZrJKbB
 0luojob_Epj3pPSXaPwL1w4DQX7L8cDSrs9vj8T6WH9F.cl.SRz6JeZGcP15AXwVVB4BBERn.7ZV
 WmbeY19S4wgyXK7cnh4UGj3.DlzOcfwg9fjXd5X4v3BdD4qvwTBixRzeOGLBGhvOoHlcmnHtuTaD
 DUgIkXmm1bQd3MN309Hlazj0tIFbYWVMMOHq3zVUEWlOKc8.RBxyN7LUsQmFKZZGD_aIculwM6k6
 9jyJ4XpFJ_sc1JKuwierF5oVO58bhXjtDBLbA2i3pB0pSPLD3BWaJPvohXyEF5byd9JOOBKmQOCB
 Vf8RWWr4jdHRUjiY6QiiARzXKboAhZakuAXedNUI4f.c0_.w-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:14 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:26:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 06/12] erofs-utils: fuse: get rid of erofs_vnode
Date: Sun, 15 Nov 2020 02:25:11 +0800
Message-Id: <20201114182517.9738-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201114182517.9738-1-hsiangkao@aol.com>
References: <20201114182517.9738-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c              |   7 ++-
 fuse/namei.c             | 110 +++++++++++++++------------------------
 fuse/namei.h             |   3 +-
 fuse/read.c              |  86 +++++-------------------------
 fuse/readir.c            |   9 ++--
 include/erofs/internal.h |  34 ------------
 6 files changed, 63 insertions(+), 186 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 563b2c378952..6176e836c2f1 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -131,12 +131,11 @@ int erofs_open(const char *path, struct fuse_file_info *fi)
 
 int erofs_getattr(const char *path, struct stat *stbuf)
 {
-	struct erofs_vnode v;
+	struct erofs_inode v = { 0 };
 	int ret;
 
 	erofs_dbg("getattr(%s)", path);
-	memset(&v, 0, sizeof(v));
-	ret = erofs_iget_by_path(path, &v);
+	ret = erofs_ilookup(path, &v);
 	if (ret)
 		return -ENOENT;
 
@@ -146,7 +145,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
 	stbuf->st_uid = v.i_uid;
 	stbuf->st_gid = v.i_gid;
-	stbuf->st_rdev = v.i_rdev;
+	stbuf->st_rdev = v.u.i_rdev;
 	stbuf->st_atime = sbi.build_time;
 	stbuf->st_mtime = sbi.build_time;
 	stbuf->st_ctime = sbi.build_time;
diff --git a/fuse/namei.c b/fuse/namei.c
index fd5ae7bfc410..326ea85809bb 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -13,7 +13,6 @@
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
 
-#include "erofs/defs.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
 
@@ -24,12 +23,12 @@ static inline dev_t new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-static int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
+static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode_compact *v1;
-	const erofs_off_t addr = iloc(nid);
+	const erofs_off_t addr = iloc(vi->nid);
 	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
 
 	ret = dev_read(buf, addr, size);
@@ -50,41 +49,28 @@ static int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	vi->i_uid = le16_to_cpu(v1->i_uid);
 	vi->i_gid = le16_to_cpu(v1->i_gid);
 	vi->i_nlink = le16_to_cpu(v1->i_nlink);
-	vi->nid = nid;
 
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
-		vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		vi->u.i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
-		vi->i_rdev = 0;
+		vi->u.i_rdev = 0;
 		break;
 	case S_IFREG:
 	case S_IFLNK:
 	case S_IFDIR:
-		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		vi->u.i_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
 		break;
 	default:
 		return -EIO;
 	}
 
-	vi->z_inited = false;
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		struct erofs_inode ei = { .datalayout = vi->datalayout };
-
-		z_erofs_fill_inode(&ei);
-
-		/* XXX: will be dropped after erofs_vnode is removed */
-		vi->z_advise = ei.z_advise;
-		vi->z_algorithmtype[0] = ei.z_algorithmtype[0];
-		vi->z_algorithmtype[1] = ei.z_algorithmtype[1];
-		vi->z_logical_clusterbits = ei.z_logical_clusterbits;
-		vi->z_physical_clusterbits[0] = ei.z_physical_clusterbits[0];
-		vi->z_physical_clusterbits[1] = ei.z_physical_clusterbits[1];
-		vi->z_inited = (ei.flags != 0);
-	}
+	vi->flags = 0;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		z_erofs_fill_inode(vi);
 	return 0;
 }
 
@@ -137,55 +123,42 @@ int erofs_namei(struct nameidata *nd,
 	erofs_nid_t nid = nd->nid;
 	int ret;
 	char buf[EROFS_BLKSIZ];
-	struct erofs_vnode v;
+	struct erofs_inode vi = { .nid = nid };
+	erofs_off_t offset;
 
-	ret = erofs_iget_by_nid(nid, &v);
+	ret = erofs_read_inode_from_disk(&vi);
 	if (ret)
 		return ret;
 
-	{
-		unsigned int offset = 0;
-
-		struct erofs_inode tmp = {
-			.u = {
-				.i_blkaddr = v.raw_blkaddr,
-			},
-			.nid = nid,
-			.i_size = v.i_size,
-			.datalayout = v.datalayout,
-			.inode_isize = v.inode_isize,
-			.xattr_isize = v.xattr_isize,
-		};
-
-		while (offset < v.i_size) {
-			int maxsize = min(v.i_size - offset, EROFS_BLKSIZ);
-			struct erofs_dirent *de = (void *)buf;
-			unsigned int nameoff;
-
-			ret = erofs_read_raw_data(&tmp, buf, offset, maxsize);
-			if (ret)
-				return ret;
-
-			nameoff = le16_to_cpu(de->nameoff);
-
-			if (nameoff < sizeof(struct erofs_dirent) ||
-			    nameoff >= PAGE_SIZE) {
-				erofs_err("invalid de[0].nameoff %u @ nid %llu",
-					  nameoff, nid | 0ULL);
-				return -EFSCORRUPTED;
-			}
-
-			de = find_target_dirent(nid, buf, name, len,
-						nameoff, maxsize);
-			if (IS_ERR(de))
-				return PTR_ERR(de);
-
-			if (de) {
-				nd->nid = le64_to_cpu(de->nid);
-				return 0;
-			}
-			offset += maxsize;
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					    vi.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		unsigned int nameoff;
+
+		ret = erofs_read_raw_data(&vi, buf, offset, maxsize);
+		if (ret)
+			return ret;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+
+		de = find_target_dirent(nid, buf, name, len,
+					nameoff, maxsize);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+
+		if (de) {
+			nd->nid = le64_to_cpu(de->nid);
+			return 0;
 		}
+		offset += maxsize;
 	}
 	return -ENOENT;
 }
@@ -218,7 +191,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	return 0;
 }
 
-int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
+int erofs_ilookup(const char *path, struct erofs_inode *vi)
 {
 	int ret;
 	struct nameidata nd;
@@ -227,6 +200,7 @@ int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
 	if (ret)
 		return ret;
 
-	return erofs_iget_by_nid(nd.nid, v);
+	vi->nid = nd.nid;
+	return erofs_read_inode_from_disk(vi);
 }
 
diff --git a/fuse/namei.h b/fuse/namei.h
index bd5adfda2969..730caf0085f7 100644
--- a/fuse/namei.h
+++ b/fuse/namei.h
@@ -8,8 +8,7 @@
 #define __INODE_H
 
 #include "erofs/internal.h"
-#include "erofs_fs.h"
 
-int erofs_iget_by_path(const char *path, struct erofs_vnode *v);
+int erofs_ilookup(const char *path, struct erofs_inode *vi);
 
 #endif
diff --git a/fuse/read.c b/fuse/read.c
index 21fbd2eea662..4e0058c01e81 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -18,105 +18,43 @@
 #include "erofs/io.h"
 #include "erofs/decompress.h"
 
-size_t erofs_read_data_wrapper(struct erofs_vnode *vnode, char *buffer,
-			       size_t size, off_t offset)
-{
-	struct erofs_inode tmp = {
-		.u = {
-			.i_blkaddr = vnode->raw_blkaddr,
-		},
-		.nid = vnode->nid,
-		.i_size = vnode->i_size,
-		.datalayout = vnode->datalayout,
-		.inode_isize = vnode->inode_isize,
-		.xattr_isize = vnode->xattr_isize,
-	};
-
-	int ret = erofs_read_raw_data(&tmp, buffer, offset, size);
-	if (ret)
-		return ret;
-
-	erofs_info("nid:%llu size=%zd done", (unsigned long long)vnode->nid, size);
-	return size;
-}
-
-size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
-				   erofs_off_t size, erofs_off_t offset)
-{
-	struct erofs_inode tmp = {
-		.nid = vnode->nid,
-		.i_size = vnode->i_size,
-		.datalayout = vnode->datalayout,
-		.inode_isize = vnode->inode_isize,
-		.xattr_isize = vnode->xattr_isize,
-		.z_advise = vnode->z_advise,
-		.z_algorithmtype = {
-			[0] = vnode->z_algorithmtype[0],
-			[1] = vnode->z_algorithmtype[1],
-		},
-		.z_logical_clusterbits = vnode->z_logical_clusterbits,
-		.z_physical_clusterbits = {
-			[0] = vnode->z_physical_clusterbits[0],
-			[1] = vnode->z_physical_clusterbits[1],
-		},
-	};
-
-	if (vnode->z_inited)
-		tmp.flags |= EROFS_I_Z_INITED;
-
-	int ret = z_erofs_read_data(&tmp, buffer, offset, size);
-	if (ret)
-		return ret;
-
-	return size;
-}
-
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	       struct fuse_file_info *fi)
 {
 	int ret;
-	struct erofs_vnode v;
+	struct erofs_inode vi;
 
 	UNUSED(fi);
 	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
-	ret = erofs_iget_by_path(path, &v);
+	ret = erofs_ilookup(path, &vi);
 	if (ret)
 		return ret;
 
-	erofs_info("path:%s nid=%llu mode=%u", path, v.nid | 0ULL, v.datalayout);
-	switch (v.datalayout) {
+	erofs_info("path:%s nid=%llu mode=%u", path, vi.nid | 0ULL, vi.datalayout);
+	switch (vi.datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
-		return erofs_read_data_wrapper(&v, buffer, size, offset);
-
+		ret = erofs_read_raw_data(&vi, buffer, offset, size);
+		break;
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		return erofs_read_data_compression(&v, buffer, size, offset);
+		ret = z_erofs_read_data(&vi, buffer, offset, size);
+		break;
 
 	default:
 		return -EINVAL;
 	}
+
+	return ret ? ret : size;
 }
 
 int erofs_readlink(const char *path, char *buffer, size_t size)
 {
-	int ret;
-	size_t lnksz;
-	struct erofs_vnode v;
+	int ret = erofs_read(path, buffer, size, 0, NULL);
 
-	ret = erofs_iget_by_path(path, &v);
-	if (ret)
+	if (ret < 0)
 		return ret;
-
-	lnksz = min((size_t)v.i_size, size - 1);
-
-	ret = erofs_read(path, buffer, lnksz, 0, NULL);
-	buffer[lnksz] = '\0';
-	if (ret != (int)lnksz)
-		return ret;
-
-	erofs_info("path:%s link=%s size=%llu", path, buffer, (unsigned long long)lnksz);
 	return 0;
 }
 
diff --git a/fuse/readir.c b/fuse/readir.c
index 1d28016a8900..510aa7ebaf11 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -66,14 +66,14 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		  off_t offset, struct fuse_file_info *fi)
 {
 	int ret;
-	struct erofs_vnode v;
+	struct erofs_inode v;
 	char dirsbuf[EROFS_BLKSIZ];
 	uint32_t dir_nr, dir_off, nr_cnt;
 
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 	UNUSED(fi);
 
-	ret = erofs_iget_by_path(path, &v);
+	ret = erofs_ilookup(path, &v);
 	if (ret)
 		return ret;
 
@@ -89,11 +89,12 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	dir_off = erofs_blkoff(v.i_size);
 	nr_cnt = 0;
 
-	erofs_dbg("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
+	erofs_dbg("dir_size=%llu dir_nr = %u dir_off=%u",
+		  v.i_size | 0ULL, dir_nr, dir_off);
 
 	while (nr_cnt < dir_nr) {
 		memset(dirsbuf, 0, sizeof(dirsbuf));
-		ret = blk_read(dirsbuf, v.raw_blkaddr + nr_cnt, 1);
+		ret = blk_read(dirsbuf, v.u.i_blkaddr + nr_cnt, 1);
 		if (ret < 0)
 			return -EIO;
 		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 98e1263fa19c..573ebfc298b5 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -164,40 +164,6 @@ struct erofs_inode {
 #endif
 };
 
-struct erofs_vnode {
-	uint8_t datalayout;
-
-	uint32_t i_size;
-	/* inline size in bytes */
-	uint16_t inode_isize;
-	uint16_t xattr_isize;
-
-	uint16_t xattr_shared_count;
-	char *xattr_shared_xattrs;
-
-	union {
-		erofs_blk_t raw_blkaddr;
-		struct {
-			uint16_t z_advise;
-			uint8_t  z_algorithmtype[2];
-			uint8_t  z_logical_clusterbits;
-			uint8_t  z_physical_clusterbits[2];
-		};
-	};
-	erofs_nid_t nid;
-	uint32_t i_ino;
-
-	uint16_t i_mode;
-	uint16_t i_uid;
-	uint16_t i_gid;
-	uint16_t i_nlink;
-	uint32_t i_rdev;
-
-	bool z_inited;
-	/* if file is inline read inline data witch inode */
-	char *idata;
-};
-
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
 	return erofs_inode_is_data_compressed(inode->datalayout);
-- 
2.24.0

