Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9842B2FA9
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:38 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP1R3GmDzDqS5
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378395;
	bh=GyUgcDY/o8AuQnGECdRmwD48oLRNjEB00Saar/OrlYI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=E3emfgHuw/8ukT4SuMtibQ8XyZlB8npbYU3SVRNRYqqITadR7sp9RuTn6va7ttgPV
	 m5G37gLirzuQFNAVuVbKN91u+Lj4xq4TOd7YIud/azZSK83RhKnkPgvaUh7dEOPzqf
	 hVcevqn1UEdZVLMwHT7F6vRshlg8+yd5N/wbW6S2Gmp71mRrqOdDgQ5aqy8709MLZG
	 JPyCTsbgXQjheqtuZVJAWVRvuXE2YBoie0C7MBMZQ7p7Crs+UYkbSg91HEEKb+Ucgd
	 pc4whHpz+7VFFdfASLWx3tFPam7Iol0RjPpCcWQDGS72p/ENPqXlhjkRwDbQW4Ro1c
	 PG+z/hbvJ09CQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.83; helo=sonic306-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=fJ60+ZiG; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.gq1.yahoo.com
 (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP0x3v1fzDqS1
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:26:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378364; bh=MFLFu4s+bEM1glnE/wVKUMsN4CqAgyR/fqVSeWVMA3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=fJ60+ZiGQn68X8KZs14z45rOJupPbhP3z7QqfLa/B0DJKQRSDpAjluGQCMEHMjBSu27xMtDwIn4sBFmEbbtC1gPd/AbQqJAKMp9XOljUJtxFqkFMlOapEhLEVSjcNq9vQL2KygYhPBCyVOby/b3l7F4DvkkL3eSb1NBY0ymdwH+SpG1jnCVGyuNyLvmZwVk7clzA2FrYERcYA0XpvBB/j9AFf3gQRJGwEHyUuD2S++/cANgb7/EtdgxHKNBcbVFnPMIdN9nfkKMlco3TMfRx/zraWkcH+l2Q17qjQdIMG2jdoz+fPk+r4o+/tQI45ovPyencXjRKyq1PFPtRNzq58g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378364; bh=KnvOXWm3Hn6t4nDhrpvRfbFmmcyk41ZYB06NN7zv0/E=;
 h=From:To:Subject:Date:From:Subject;
 b=J9ARO/Rvwp7ImNjER2EjCfK6+It0P8u/q+G0rgB+shrChme37T0+mRaaI4g59jWKnfRaO5ThYvaieR0fWuKXZDst0J3WGXqvh5Pdp6gX5AZdfUgeRbJ/UNmUjhnlmJ/55IlI1xSuPWf3EWJp0tGUwCEMPsJKKqLtVGHaNggGR4XFjpP/mXvA88sgyMvlWNdIC3Ef22iO7w9PmPXED5wO7bzTVe5+GirG6Ni/0bAU32fXJMDdBYFGzOP2ANu/yruDSXj98jtLzAA1s5A5O+FzC6BLi1ZsEviKgOaYXJqJ6opt+Ri9IQfW4pKwQCJHTlXKxqvx2KSMy2zv3IIp8In3dg==
X-YMail-OSG: zhTalYsVM1mcmP7Y6acJ_NQU6xSY7YvNtJbDXjf68h_.Eyj2Y8t9BFgFNRcDUH4
 9DfNLUuIdD.qfz7DBoxxKV4CZ55R3iWgJxzSSjBgXUWakI35HO1h8T9aH4Qt0hYf77eoTSr9Xgmi
 EEqLe6zV7LDp7iCHP9mtOwlA6IexdXc.AasJAiHYZEBPsKgurtbdYWg93wknyWMgc.HtcIcysmGG
 tj7uxsVhHmPafQCDcF_XbfdOGEB0y81H4GONqpz5TKOxzF.HH7x6a83HyurUY9c3kqocFUXAYJXk
 x.GhqyWuve37pcLdkP40UsHUNT_wCLWqK8QApWE5mwNR4PYcyY8ZsdFGhcrLDWWv4TGTly2NQdoK
 DIcIVI81ho6RrVhzZ_1g9UMlHnU91yTjPZwDACsJtLSNUFJBiHevIvtmX9YzNtrjD9n_BsbzJ.aJ
 hESz6xem4WymsZnwFUhKtzpe9Bh0BVUnKZU7k_NrDpbvtQE0rIEKEycI4jdecuS8TVgPUHsXIMlT
 kaBGNqs6FyRXnZJLwXfzve2iEQPNxamFKWr2iyrVKstFhXjCf8nyso8_030MZVFolPoOHpuUEhsI
 yOAXjIXGNJ7ecaM.uI2iCIJb4vXglbvnk3Xi0KJ21l9m8kBnI1V1bxAPGwEF7275uCGzE85ACwP7
 B1hRR6GgZTIKHLtwVPjzpUpMxHkk5FvaYuKg9gUu.rnghXOQ9xABdby9Sl.ifq21S1YTB9La46hQ
 4l1QFv2Bi7btfPSjcWKdC_KZFkxe23bBdsEVxJ5XrOWTwLVsj3lTNCHVtLewS8HDl1Tba1od1ycQ
 s6viY_Q2r3XyPQ2t.Vx1zvjCDt9Kwew3V_NY4laAcirwSJRoo0yA.Iu7k6RFqb6PhwYSDDXjwjGb
 EKIjBVfsyahYigjTZIFOo6Wbm7NtQ6xATF99_hJVqM84TKXChFcDC9MuaGyc1eAm94ya498fgdKW
 0V3zT8Sk6SZadhGbqw3dK3zOqLJWHfJ7kCz3DpD49kQwoORgaqrqj277Q4UqyYGZ7xLVdElUqrej
 G5OsqAlON7LoQjpkuZ4N0I1ePHmc9ZGdaEnXs6ztaKrA6rgxHkqUUDciPpmUlTJOcUqui1hUcArD
 mz3zFjP6kkGl2XPgXrAXlSiRU6L.QiJri5M_wUya1kMr_KVLL2K_5LdZ63U9IccH44I_MqW8OhK5
 sRKRh54bf5_MlWcRV4frH_pPq0W9BGgUCrzOdPxdn3R0V7QVTO87PlCqEB39zu.U9CkeOUypV_pi
 8ENymjxARpt83SjZpVzAHF5Utx1Kp77Wr0McUgtGMYZFw4HNZf_V0eqM64ucgxgcqGrDYi_6s2zf
 .WjrdRslp1ZfXs_X7AkY3oBnHs0gADswKkGwhT0iK5lBJ5d1TQ9eijR0MZ3XbINO9iYX_xiqspni
 vmzndbPCD8vPg6GC1d2.gePq7hY67.vwz5TnFoKtD4MwEeZclncqPMMFeJ_FWaY6G7IRXj9pil0X
 gSg89dYPG3sdEHarezMXA8CPdofdZs4XifGBJj8ivSdfL5Kuy7IjCZkJUH76CMpgYwyiMLRuf3zM
 21bwsx0wpCXzOW.pYCY2Bp7m7JhgFscHyW0uoCHNgZ2zUZDkcLyZHqInMYgRcdT29m6TvGoXP0Je
 Q8auvCmKyQuAVsxzqqz91rMI4nawiKyu9g3Zx8F0rvmXcEyhDL_TXDbPajVOlIQ4yWPeEgmyLvbq
 hlSZM2Yio_e.z4eriKVCu1vjllr.KE7aqqJcjfFbYK3HarjC.UPjHiAYfpRS3OiFJxv7fybbR6JU
 K9DLDyGGbR2EEn549mSApjz651pZg65Wzsncye3y4.rLqvVbdrDu12KLLH0e3mxozXcHqdayvy56
 aMjTT2UEa8ag8p..6Z3LRe8QcXYqekKzJtvHpI1MDhH1Ej1FFcRmwncChI6CGwe_kiTJ1r2g8CeG
 FENUlmdRgBzLQU_atcXH2jCEq6kYoIZSon7K1a6_OvLUgfxF6ZxUF1CzEToA4z3Hfa.yNI1Aco2c
 U4qlXVcC6kfM5IBKdRvHYtVpznOSPXd6BuageuBUtYuSTxLYvgR25ql7HBTvNu1paq0d8E.LbJZz
 dPqmm.y4FVWc8peg.FZ0DgsvUbuae18yHHmn6_rw2pXaCsEHM38Ehbz.rHQz2bC8EVc2VuAelP4z
 d2kGS_GI5ZPCwG7wk6JVMUkYAunAkFqSRQP_vyQU.f6d5O9Rg6ioz_dgfqcCt3PCm1.A9uctM8UK
 VRth2LaqGWOerUnAxG7H4l7KtEBeoeXh_OWxoY0BZ66srOCZwhZ6h4.HK3RqFrJI3Jto2CqSlRk6
 ne.K9p6ihJwRd_ger6xn9uvdPMMduwH3E_I3c2hDBUvkT.0Ls3FfrUri1Dgbwo50PCwGoEvsDI4Q
 rwUv1h3x3bLSYKDOiJ5w5F2ZfHt8FqkKw6DPkkgqd5b70uK.NHfNl2eytzfx3DNwoRj7SFcX.fou
 iyQ0A_yfBvLsZlwuyRvPF_VWYqmO4dZx2Hu5PKq3VipUwK9gwDr.cnpkelVKakivOYKYG._gMk6C
 DfJcjGc7tdThMlBouw0gczpv8vhqU5q6qPT_hoyrfQ3F_TxaqqiZF5apkxUEKbS8rAwM7uaJ_xAk
 nSiPLu2oBy6SnbeCUrAiB8fFaaTeHGIZ9BjNFvypNB3Ekq_u7MJ8U96Gtnh_1PhHBlbCDm11nF7p
 MYLbKalFS40PvBU642jpd63TLzhWbU448AvLDCg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:26:04 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:25:57 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 04/12] erofs-utils: fuse: clean up path walking
Date: Sun, 15 Nov 2020 02:25:09 +0800
Message-Id: <20201114182517.9738-5-hsiangkao@aol.com>
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
 fuse/namei.c  | 82 +++++++++++++++++++++------------------------------
 fuse/namei.h  |  2 --
 fuse/read.c   | 16 ++--------
 fuse/readir.c | 10 ++-----
 4 files changed, 39 insertions(+), 71 deletions(-)

diff --git a/fuse/namei.c b/fuse/namei.c
index 5ee3f8d2a4b6..37cf549cd2a6 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -17,27 +17,6 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
-#define IS_PATH_SEPARATOR(__c)      ((__c) == '/')
-#define MINORBITS	20
-#define MINORMASK	((1U << MINORBITS) - 1)
-#define DT_UNKNOWN	0
-
-static const char *skip_trailing_backslash(const char *path)
-{
-	while (IS_PATH_SEPARATOR(*path))
-		path++;
-	return path;
-}
-
-static uint8_t get_path_token_len(const char *path)
-{
-	uint8_t len = 0;
-
-	while (path[len] != '/' && path[len])
-		len++;
-	return len;
-}
-
 static inline dev_t new_decode_dev(u32 dev)
 {
 	unsigned major = (dev & 0xfff00) >> 8;
@@ -45,7 +24,7 @@ static inline dev_t new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
+static int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
@@ -136,14 +115,20 @@ struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 	return NULL;
 }
 
-int erofs_namei(erofs_nid_t *nid,
+struct nameidata {
+	erofs_nid_t	nid;
+	unsigned int	ftype;
+};
+
+int erofs_namei(struct nameidata *nd,
 		const char *name, unsigned int len)
 {
+	erofs_nid_t nid = nd->nid;
 	int ret;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_vnode v;
 
-	ret = erofs_iget_by_nid(*nid, &v);
+	ret = erofs_iget_by_nid(nid, &v);
 	if (ret)
 		return ret;
 
@@ -154,7 +139,7 @@ int erofs_namei(erofs_nid_t *nid,
 			.u = {
 				.i_blkaddr = v.raw_blkaddr,
 			},
-			.nid = v.nid,
+			.nid = nid,
 			.i_size = v.i_size,
 			.datalayout = v.datalayout,
 			.inode_isize = v.inode_isize,
@@ -175,17 +160,17 @@ int erofs_namei(erofs_nid_t *nid,
 			if (nameoff < sizeof(struct erofs_dirent) ||
 			    nameoff >= PAGE_SIZE) {
 				erofs_err("invalid de[0].nameoff %u @ nid %llu",
-					  nameoff, *nid | 0ULL);
+					  nameoff, nid | 0ULL);
 				return -EFSCORRUPTED;
 			}
 
-			de = find_target_dirent(*nid, buf, name, len,
+			de = find_target_dirent(nid, buf, name, len,
 						nameoff, maxsize);
 			if (IS_ERR(de))
 				return PTR_ERR(de);
 
 			if (de) {
-				*nid = le64_to_cpu(de->nid);
+				nd->nid = le64_to_cpu(de->nid);
 				return 0;
 			}
 			offset += maxsize;
@@ -194,44 +179,43 @@ int erofs_namei(erofs_nid_t *nid,
 	return -ENOENT;
 }
 
-extern struct dcache_entry root_entry;
-int walk_path(const char *_path, erofs_nid_t *out_nid)
+static int link_path_walk(const char *name, struct nameidata *nd)
 {
-	int ret;
-	erofs_nid_t nid = sbi.root_nid;
-	const char *path = _path;
+	nd->nid = sbi.root_nid;
+
+	while (*name == '/')
+		name++;
 
-	for (;;) {
-		uint8_t path_len;
+	/* At this point we know we have a real path component. */
+	while (*name != '\0') {
+		const char *p = name;
+		int ret;
 
-		path = skip_trailing_backslash(path);
-		path_len = get_path_token_len(path);
-		if (path_len == 0)
-			break;
+		do {
+			++p;
+		} while (*p != '\0' && *p != '/');
 
-		ret = erofs_namei(&nid, path, path_len);
+		DBG_BUGON(p <= name);
+		ret = erofs_namei(nd, name, p - name);
 		if (ret)
 			return ret;
 
-		path += path_len;
+		name = p;
+		/* Skip until no more slashes. */
+		for (name = p; *name == '/'; ++name);
 	}
-
-	erofs_dbg("find path = %s nid=%llu", _path, nid | 0ULL);
-
-	*out_nid = nid;
 	return 0;
-
 }
 
 int erofs_iget_by_path(const char *path, struct erofs_vnode *v)
 {
 	int ret;
-	erofs_nid_t nid;
+	struct nameidata nd;
 
-	ret = walk_path(path, &nid);
+	ret = link_path_walk(path, &nd);
 	if (ret)
 		return ret;
 
-	return erofs_iget_by_nid(nid, v);
+	return erofs_iget_by_nid(nd.nid, v);
 }
 
diff --git a/fuse/namei.h b/fuse/namei.h
index 2625ec58d434..bd5adfda2969 100644
--- a/fuse/namei.h
+++ b/fuse/namei.h
@@ -11,7 +11,5 @@
 #include "erofs_fs.h"
 
 int erofs_iget_by_path(const char *path, struct erofs_vnode *v);
-int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *v);
-int walk_path(const char *path, erofs_nid_t *out_nid);
 
 #endif
diff --git a/fuse/read.c b/fuse/read.c
index 10a26d84c37c..aa5221a60d4e 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -116,21 +116,16 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	       struct fuse_file_info *fi)
 {
 	int ret;
-	erofs_nid_t nid;
 	struct erofs_vnode v;
 
 	UNUSED(fi);
 	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
-	ret = walk_path(path, &nid);
+	ret = erofs_iget_by_path(path, &v);
 	if (ret)
 		return ret;
 
-	ret = erofs_iget_by_nid(nid, &v);
-	if (ret)
-		return ret;
-
-	erofs_info("path:%s nid=%llu mode=%u", path, (unsigned long long)nid, v.datalayout);
+	erofs_info("path:%s nid=%llu mode=%u", path, v.nid | 0ULL, v.datalayout);
 	switch (v.datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
@@ -148,15 +143,10 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 int erofs_readlink(const char *path, char *buffer, size_t size)
 {
 	int ret;
-	erofs_nid_t nid;
 	size_t lnksz;
 	struct erofs_vnode v;
 
-	ret = walk_path(path, &nid);
-	if (ret)
-		return ret;
-
-	ret = erofs_iget_by_nid(nid, &v);
+	ret = erofs_iget_by_path(path, &v);
 	if (ret)
 		return ret;
 
diff --git a/fuse/readir.c b/fuse/readir.c
index 5281c8b80e59..1d28016a8900 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -66,7 +66,6 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		  off_t offset, struct fuse_file_info *fi)
 {
 	int ret;
-	erofs_nid_t nid;
 	struct erofs_vnode v;
 	char dirsbuf[EROFS_BLKSIZ];
 	uint32_t dir_nr, dir_off, nr_cnt;
@@ -74,14 +73,11 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 	UNUSED(fi);
 
-	ret = walk_path(path, &nid);
+	ret = erofs_iget_by_path(path, &v);
 	if (ret)
 		return ret;
 
-	erofs_dbg("path=%s nid = %llu", path, (unsigned long long)nid);
-	ret = erofs_iget_by_nid(nid, &v);
-	if (ret)
-		return ret;
+	erofs_dbg("path=%s nid = %llu", path, v.nid | 0ULL);
 
 	if (!S_ISDIR(v.i_mode))
 		return -ENOTDIR;
@@ -107,7 +103,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		off_t addr;
 
-		addr = iloc(nid) + v.inode_isize + v.xattr_isize;
+		addr = iloc(v.nid) + v.inode_isize + v.xattr_isize;
 
 		memset(dirsbuf, 0, sizeof(dirsbuf));
 		ret = dev_read(dirsbuf, addr, dir_off);
-- 
2.24.0

