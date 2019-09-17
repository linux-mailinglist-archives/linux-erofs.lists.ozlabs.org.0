Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8219B470F
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 07:50:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46XXJC3B63zF453
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 15:50:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1568699403;
	bh=0pGRMXJVLCNEfRpO1AoyiMHriQQrPUWnqhfx/ElEcBk=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=M5j0TrXBebPsWDrR0d3a0wImeH9n4rZ1hg7+MHfGS5CnK8359+aU6jRTIfn/izJQQ
	 yvTZkTy1f9tgzmzuOX0vypGea7ShsDht/9F6oXKOSV+/zlpSpfiI5LhNR4nxzLHPJS
	 HWDIDceI89/MUEcCgI1zmZOx/gzY8Iz3QmiWI3tZO1p6d+aba5WSHqk5Y7wek0MvpB
	 cUWsOGD2rFblDin/DdH3tIIQ0xsz0U4EJ1ntjGjj1gEK0dFHQ+0CSiw0mBCNZaTWmQ
	 MrtpSfBMYxJyjpmViThvTGjy6z91OgUIUkxvNG2Uk7YqnOcGjk6SHnyJ7jZwBo36vJ
	 2+PHqEnoKYLjA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rPNzEBL4"; 
 dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46XXHm1s3YzDqfB
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2019 15:49:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1568699372; bh=meKByR0AbMJ3VTi5/TxqaQIVVAS6oSWuF9nXMvcZYlw=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=rPNzEBL4Tef9tiwMGJGqaOfbDL2aKExvZLNwGcXgnhN9fCC5GjcWstXIiMzLDvq5O7NTZBgDrczA8p4E08S7U2lN3jwuUYZI8N2tmSTHnt2mXlYesIaSTaQoemYsDac05hExFWrSyhasdRKQYg8Hhk7wHCaOod0Ec5DQbWxYxIyVXGBZ0n6DAzUWTVBWYOF3H+Qg2DvqPFOs5IvZGfXK06oGU+01XKNmL0GjV4Bjh8prP9Hawo93e3/JcYyF58cXjt2onC0HjH4HftzLHrswJ3IA3/l+ltmBTx8+I8rOxEILQJYfGCzX2rzHX2UMM5+sFkmfk/dBVSvsg8bT2JoDfg==
X-YMail-OSG: .wLnJnMVM1m9qRbVPQlblkuKuR6D2mYrDHvMicd4aUp0ynqcyspYJhOTg77p4in
 CqRCALySnl1xZk7tLfoIXEWn1vdKR_OhxISzojcsWz9tOFdsWf8wYxTeRPLCFzhNlXe0JUcePUXd
 RMYAsqNgaaJrOnGkoKJdohZCCEFxeNN1hFVY6PpFT.Sb5lFrgcMHHyNhTYJ5Xjg.LtfjN3OeWzDP
 85kIfUcG7ddx.SR8Wrz7OSi7usoMpQKZJ7r3kp12q8VhZ.QA5VnGaDvsMO7pQIaTjs1YCTojtPXc
 dMWBN.IEnToGMMre84dKeGyE0SPHbqkqjZDFuFvlQg7cGkhXrvQuNtXKMGaLwMadLlDM87_f6WKN
 NY7GcSqSCUI2JM8eP1XXHB21fmvvaKn79RX3Ipt0zYiN9P62Frio_pBVntzSMIKIOEPbT4qgRhwG
 cICXPh06eMLS_.JJE62fECMkyozkD93n2oAPhphktXOSe3EJMa7BDT1PAvE3Hm8u4t1fogebtmXg
 5OwxToucXc_6SRnp.hrGayijRpgCuqJOdxh2r0740wUe1rohzRSA7VJDtb5UCcBwunSy3anIkuqo
 WNpJhGuBfbaE0YvyvrhVUOli9ltIoIVVbTjufFYVKC3TORmENrPo66Pw30fL_3ZRtU.YHGbFi23C
 Cd2ToOON.nkX4avmjjKnfPzyeMnf7uRU_H_sbQ13jbixveNkBumfGLdp_gOmEeinlS0H8196DH_A
 77h0BgULSNxWUur..dRjGtoYXJdstFjB6dEp_eJPEdsq.oxQkM5GHZGpPb_Zj1xlHhZbnwin1XcM
 AGuh14DEZwYO2noS7AeJueVcYSucQzsepwqIGzArlvFqAZwrlYNnzrJRzz_P7pJjHyPClLsGK8nQ
 Wo0azldiKAxWbnzjeaTNpS.kEO4_Zs8RUrql_J9nVaCnOFKNJ.xk7F.nLPfwCRbV2JPbDw.Pk5HX
 4i8ViUq8lhdibfAIwFsNctbfY_o8oJ103sMF1yRci.K8ItGIPrb8nzPFWz9BntHHuccmUwVccSEB
 E9SLqM8PeFmymMjaopRTqFimzVh.9QifuUSe1f.b96b_w7.SzRj6u5IQKFkkBh70TWsyAiRtJSk_
 7cD0IaLKxYcyuBLEylqOi2bNeGRmZuT0eCGyba22FiV2MDnhHCW8GlVpK277uR_iOVbg22V6CBmr
 KzQrgsBeytRHaNhiavN9mhWz4u4yQA7mOOQfhaS8cmL4wrt0U164avx3p841Kk8Yxsn1iiJ0CVfv
 beJL.xhqRVZG.ZvkkwvJSG8RnOyC5KvgDSPnpMT5UkRMyCXIdiO2QKJ_wPF9BZm4blAJZsbT0omH
 kcB1apkbQ5FGf38P3Jd32YpACOFIQ3be9ZRn5q5kj3RfBI03mj0I63sw-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 17 Sep 2019 05:49:32 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0ca914cfda0cd9061c391ed841b64b5d; 
 Tue, 17 Sep 2019 05:49:30 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH 1/3] erofs-utils: complete special file support
Date: Tue, 17 Sep 2019 13:49:11 +0800
Message-Id: <20190917054913.24187-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
References: <20190917054913.24187-1-hsiangkao.ref@aol.com>
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

From: Gao Xiang <gaoxiang25@huawei.com>

Special file was already supported by obsoleted_mkfs,
let's complete it for new erofs-utils now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Hi Guifu,
Could you kindly take a look of these patches?

Thanks,
Gao Xiang

 configure.ac |  1 +
 lib/inode.c  | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index fcdf30a..07e034e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -82,6 +82,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	string.h
 	sys/ioctl.h
 	sys/stat.h
+	sys/sysmacros.h
 	sys/time.h
 	unistd.h
 ]))
diff --git a/lib/inode.c b/lib/inode.c
index e3495f4..c8cf847 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <dirent.h>
 #include "erofs/print.h"
 #include "erofs/inode.h"
@@ -128,7 +129,6 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	int ret;
 
 	if (!nblocks) {
-		inode->bh_data = NULL;
 		/* it has only tail-end inlined data */
 		inode->u.i_blkaddr = NULL_ADDR;
 		return 0;
@@ -302,6 +302,11 @@ int erofs_write_file(struct erofs_inode *inode)
 	unsigned int nblocks, i;
 	int ret, fd;
 
+	if (!inode->i_size) {
+		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
+		return 0;
+	}
+
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode);
 
@@ -573,6 +578,14 @@ out:
 	return 0;
 }
 
+static u32 erofs_new_encode_dev(dev_t dev)
+{
+	const unsigned int major = major(dev);
+	const unsigned int minor = minor(dev);
+
+	return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
+}
+
 int erofs_fill_inode(struct erofs_inode *inode,
 		     struct stat64 *st,
 		     const char *path)
@@ -582,10 +595,22 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_gid = st->st_gid;
 	inode->i_nlink = 1;	/* fix up later if needed */
 
-	if (!S_ISDIR(inode->i_mode))
-		inode->i_size = st->st_size;
-	else
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->u.i_rdev = erofs_new_encode_dev(st->st_rdev);
+	case S_IFDIR:
 		inode->i_size = 0;
+		break;
+	case S_IFREG:
+	case S_IFLNK:
+		inode->i_size = st->st_size;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
@@ -613,6 +638,7 @@ struct erofs_inode *erofs_new_inode(void)
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
+	inode->idata_size = 0;
 	inode->xattr_isize = 0;
 	inode->extent_isize = 0;
 
-- 
2.17.1

