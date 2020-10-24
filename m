Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B65E297C8A
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:11:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM1R65yBzDqwP
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:11:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545083;
	bh=nfpE7uuONaXU55yAMO69TSancTSpPidFb+WBUPxJS2o=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f6+P34GaMtvk70QJFXbPkYM7t6iEZKoSN4a+RPXF3eprfTip9Tfhp8YzHiodmSyPD
	 /kNUaJ0Ao7tH/A7ZID5WiVJOjUppgh2laB93mHqcnzHNBkNqvhOiWpkIRQyd5JR1Cv
	 kWRbR/V8Y7o4LsU1ZdPodSEEddrmQFps2fJ1w7JURt3gRV/iJV2kxnU7g7vsxybOwg
	 oJoeIwFZzx0RA6Kw76WPh5s3dkTAOhu4KLtLVpGkU1TkTPezpoPiJmBLjG2mX1Uz5G
	 iw65jBz987EhnswKijy56x7th80PERB+MhAWobc4AfvR05BrlLOgCTP1m7iAilwSrX
	 YfUELadsV6Jtw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=S53x64F1; dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM0f4fYczDqNd
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:10:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545038; bh=nvWv+EDdNgl92p9paKb3lHkGk3O17tJmFpoVgWfjbv4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=S53x64F1neM6mNV50ekBxoZDsFlYeti1Ca4Qjok2ES+tzk8kNqGkgjE4MtqcCg2FfZFUiwaQstzJwu6/sS7hdPTUCU27q8EScQxwaDtPzevnxUNFci0SIE5nzceUeoez5rN1jY7LHeM68YZ2udl7AH2GvC1DU2fXYW2oA5PhDQXHiNsUOW8Y4eXIRblJg2fhc7YuOwJn1810sG2fDhfe/6Bg9cHirbZn66iTtYsa2ySd1f78gMJS+2fFL/XDRuu+iWPTr94mw3Fh17zqaaNhqh8hL9ND8WaIG2f1vKBqt5rrXafnGH9QM64ysCc2wmWS954yV6Oyk/o2VkuDcxe1dg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545038; bh=tqMiQGNkWFwMdYlKzAJsQyTDQC8TITyNA3g7b68i4Sx=;
 h=From:To:Subject:Date;
 b=YiVdc+F9jrK9zq57WdJoY4SShnRyNahP/E8UCjwT+LaV92lKqz5tGaA7PLhEbeYdork8TFiRsgoaqPBy6jcZa/hEYRq/IV5KEo9iQk9MwxX9+2fAnQ+SbTcPRmCky3bhkzlVtrQG51l037fCrZmWtrpwhs/FLbKBPtsv6ipGM85IWVbN2oBW6sdujOxTnMvL5SpcIN8zEvwXZBY4HPMGGEefiMuv2LUl8rOXE7L801bGWxQwWW6ErQASrQiYbvshdcaxqHj/vHLlRHKejOXeh7m3M81JAW+nlG30u/otm710I+sYQQzirHgPD3aFfMSMlDCTRS+D/ScfjMMXPzFjGw==
X-YMail-OSG: dZAyI7sVM1mEDCxeUaqih20YxdtUo6adr.BWpM1_94dzMT74ltuJ3Y56DLjAQQi
 cDZVKCc8Na5OCd6.KLtba_rB0LP9quEx6c7aHQV.hJ7lsySaXS78Y.eVoeO6qWjuehKEVsKo2TMd
 brXgPx2yT5nZnaDzzaERmt6C.c_Cf81MhdzU4tjoKpFsuvyXLQXZUxxlY.iHYBoh_Xaf3AI8Lirn
 t8lkIYh9wRbMGWSVjjlGIBQOhkijFMlcMLcZdkMpJsz0nJhLpOdtG7VsRY4kz2J0CAUqkEfjG6Le
 6hJaTNoENlrwTIcHPpWPQywhuzGj8gbssdxUSrA5DeoPhjRvhuO66s9xKfa1f4aQ3Tg36c1MTflw
 d3IJXkWupbBcEnjGIGr_LPieSEv415E9ayBX4J3KI.gqI.iIzTbpYe_oEzS56QPE1iHMXl8ck7he
 v2q2yUv0.b60WZP3TTtp0d7A2cv_P2Osq.ywYSa2XoKd854EOxPj7wGV78gm5UM3NyDHfnXmwqgk
 N_WkiPAqU5OP3qymKw7Z6b0L960AjmHOgeTRUtt0KjsvsFurr6Pl7v1Bd.gJSFrkGLvSfTvZSskk
 iuplMalcy6H3l0yISZU5J94xgcrNoqESS_YFx4YnfTXgETFqq2z7464S6SJGHasLuuHVHXGvxhm5
 E2coKqSqk37rtgrqg_fKRNnrHST1PzPYSQ4CvhRAnKxnkdJscgNZhXNhERUiK6.xrgL2NQXruj6F
 YC4FIicbVuSoNcK9n3RwEF3PO_lV9wbJa9uPccHpelGwvS0Ck_MSTGVJyX_9ccEZdAw1fRg7EMTO
 O0yoSF34_ijajs5LYfGJE.G5YpAhFUheGPtHspzOVd.bjW9hslDSKteYPgBX083mxMucMKBIBZ09
 DIMOEeyFTD71.YGR7FtYSsUDGaRSs1OtFXikyd.FW4z3mH.wyP.a2gP8rqYpU07rBRviKeCKJRny
 OGlmCDR5kYfZhCxuK7fQuTw7oPkI7Dz50oeC6s3wDKbAcoF7ddP0v3eaqAhXwY73NZ.0.4E4PfJB
 xWW9D.aUP_6UaI0N8N.uyu39OQq9uGjL.nEUnyxh4rLg6R1pWYSTT.1jT5ho5KH3Ns7Xk1QGKWU8
 CWonVsGqSHDZoaBvWpiYyZchTVp2iWNxDnA9TolKuwdRaiyESWQuzEPqwj5WJH1UXnsW6rtwprdh
 WLzcfAEAdGsZ_yaeWgShQQL9pLGCDIrI.67MZkovDiEDAXb6KdG8HMmGe5X.tYumMesGMgGHoPkT
 UYa3H4goDERmu4JUEniKXVoseHlVd7QmLwOI3XmvW04bl.3uT_J1kEQMR0SfEZf2RRoKqlXKNWn_
 Em2VxR9vk4RqIxFnRuVUwMewLR7.vNSXT9ArcUBqiO9bAKwndoPjbiPQxr6MJzaMbjNdX3k5OHFL
 p6CTyu9RBBg9TgeAOG0zuUBX8cODzdtA6h23a3UM6tdbd9wERsvw7W5RQ38fWrz65F2aT4CYpb8y
 R4aFs.zd.1tAsWfVl0C88aUgChbNsd0t5YF9eU1SOdceQBvyUL8F04tNPi1ZA8MeP3yt3HIYcsuR
 ily7z_YHNVRPv_xqoPk8BS1a9dbrWOZlZ.jNfPbko7FQJQvG_fxdmjjlaBGds2gFZL5XeYcwbo76
 B3JFsTK1hClAltD5PZVieH9sqVOtMCHArkfAAvwu5hX2.BXwHt.HmmjB3rmLlwAfamtFFCyQ8xUD
 CWo.Y3C3ibY88BDdXu_yB4w_15uQOiZJKSsXD7375QpzZLSUrUl5R0QcEt2lNJQYjlQXqGsWQMDh
 NSNKZ.gqVT3XSCa8_xLRt6K6ohIUocEs2QPCxQKnjzufSyRx4vgOnJfr6M6T5Gjrq8XOKOe8.7SV
 cYUq5ZtNRjO19fZdlbsS.Kyp0urri9RevDpCUD5hwRaZ1AEmbMzu8yK1aWC1E1LXUeFK9CyvPgzR
 ZUozFoq3g_fOh8cyU0xbUnFA2Zo0k5tLwIBEI8HsJuErY2jUqHdcYPaONT8iMqvUThX7N3RVQgfX
 fkuajbbQvbq_siFiVVDg4KI_S39samWkDuk8SuGvR0ZKWbickxGnfCCb5ktICviOGh5sBth.97pd
 3QB0KA1ZW4N598hIG5PMlrjv4QbcGrmTAEeeT2xBSn9AcE4kkcrrmjHIGSYF9o7cOUoRZ3Ft5mMP
 F4Vogm_YoQqR_uvvT4VqJnI8T5HnlVlmGCdkLaGXRQ6AGJEL54A9.Upz3CVQqTkXiFpCnOb1N54h
 msA59tQHAgjltKOOG0n1jIiXD7zaG3o1NuLJnvdmdEw.wYHK8x5u42cWvlKc_8jXUnULewDWSLgA
 ZtO3Zv42ttb29mW2U0Sh42_zY60mIGVARCO4B_w8.pl0z6_vsyz04CET0xgNPqC6e00_B1dZhYiz
 CyEn39PA.In7oNx1uUy8SYKutrlRJEzyBTnib0RRJyzs_x.I0YWOgQIBz70QhAx2PuPEq2WQwGtx
 _8VzOIzCCxRety92n3E4ETfbGLhnmoh0t_f7FkcNxEQMIV7_a7WM0pxe5xFRnKAsiPT808uqRL.G
 X3WzT14m9ziyA0Y2trp7KSpzFhgUrqR_FMN5UdOMbNJIRA14oJj68tYfOgqhpPViVH4tsy7tJ_2S
 SO_LHENBNpev2hKpUJl_helHYkosjnkV3XPgD78MuEO3QbVpddlzDDNavziYBmOlss75UJupr1kG
 RxkUGXnxpbgOrm6jHN8XXY5anAJmpB8drOb2c.1YLBU9An2c.nCc4naTQuRrIxwuRcLDdHWNnBwX
 qkOQPFVrXMUcxIGeIVZZc5nQWUlbaoirM0CWo69X6JNE5128qP0MKkrFHFhpOJttzKSgm34RLtJ4
 .93GW0jxrENrHAmspaEnIU5oeN6evtcLDyPLPM.DWkvQbrtgAFgWp8EKZDcbzImI04kntOotoTMd
 qeSn2908uBZYCEXrElIelt0kb1IBZBvYU25eQBQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:10:38 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:32 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 2/5] erofs-utils: fuse: add special file support
Date: Sat, 24 Oct 2020 21:09:56 +0800
Message-Id: <20201024130959.23720-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-1-hsiangkao@aol.com>
References: <20201024130959.23720-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/getattr.c           |  1 +
 fuse/main.c              |  1 +
 fuse/namei.c             | 14 ++++++++++----
 fuse/read.c              | 26 ++++++++++++++++++++++++++
 fuse/read.h              |  1 +
 include/erofs/internal.h |  1 +
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fuse/getattr.c b/fuse/getattr.c
index 2518adb8947f..e5200ebeef1a 100644
--- a/fuse/getattr.c
+++ b/fuse/getattr.c
@@ -56,6 +56,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
 	stbuf->st_uid = le16_to_cpu(v.i_uid);
 	stbuf->st_gid = le16_to_cpu(v.i_gid);
+	stbuf->st_rdev = le32_to_cpu(v.i_rdev);
 	stbuf->st_atime = super.build_time;
 	stbuf->st_mtime = super.build_time;
 	stbuf->st_ctime = super.build_time;
diff --git a/fuse/main.c b/fuse/main.c
index edecbed9a65a..9c8169725fa7 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -113,6 +113,7 @@ static void signal_handle_sigsegv(int signal)
 }
 
 static struct fuse_operations erofs_ops = {
+	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
diff --git a/fuse/namei.c b/fuse/namei.c
index 4d162047db15..6917d78d4f22 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
 #include "logging.h"
@@ -39,6 +40,13 @@ static uint8_t get_path_token_len(const char *path)
 	return len;
 }
 
+static inline dev_t new_decode_dev(u32 dev)
+{
+	unsigned major = (dev & 0xfff00) >> 8;
+	unsigned minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+	return makedev(major, minor);
+}
+
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret;
@@ -65,13 +73,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
-		/* fixme: add special devices support
-		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		 */
+		vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
-		/*fixme: vi->i_rdev = 0; */
+		vi->i_rdev = 0;
 		break;
 	case S_IFREG:
 	case S_IFLNK:
diff --git a/fuse/read.c b/fuse/read.c
index 7e8f9516f853..760c9aa37f91 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -111,3 +111,29 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 		return -EINVAL;
 	}
 }
+
+int erofs_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret;
+	erofs_nid_t nid;
+	size_t lnksz;
+	struct erofs_vnode v;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	lnksz = min((size_t)v.i_size, size - 1);
+
+	ret = erofs_read(path, buffer, lnksz, 0, NULL);
+	buffer[lnksz] = '\0';
+	if (ret != (int)lnksz)
+		return ret;
+
+	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
+	return 0;
+}
\ No newline at end of file
diff --git a/fuse/read.h b/fuse/read.h
index 3f4af1495510..e901c607dc91 100644
--- a/fuse/read.h
+++ b/fuse/read.h
@@ -12,5 +12,6 @@
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	    struct fuse_file_info *fi);
+int erofs_readlink(const char *path, char *buffer, size_t size);
 
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1e3c23ae88b6..e2769a6be4c9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -153,6 +153,7 @@ struct erofs_vnode {
 	uint16_t i_uid;
 	uint16_t i_gid;
 	uint16_t i_nlink;
+	uint32_t i_rdev;
 
 	/* if file is inline read inline data witch inode */
 	char *idata;
-- 
2.24.0

