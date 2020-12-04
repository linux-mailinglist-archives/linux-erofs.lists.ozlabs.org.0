Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBB2CF36C
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Dec 2020 18:57:16 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CngQK2CZYzDrS7
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 04:57:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607104633;
	bh=pUGqOwHjzD2Tpnt8+mwlDmkuSamYZClWBcqz2tM7NJo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ZW0xdLQT8Triebl/XFBr3yymM3FIx8XvOqR5/+cjAY1Ri0vGx5roafoUmjbwo/NpT
	 tPcPYvRIjsezCb+gCt2qrzxaW5ytlsR9KJYbwWNWMTWX+l4oBpvfpfe+OySUAy0Q1f
	 p0HoION2vVFbPiV0hMIUPEBaaqXieXlNuuoXGCO9AjQhbNoLw0x//2AVc0CsCA153n
	 0UsWs7ePLDN3NYU0jtmGIYEyOlchTMaMC/6Pwp/FgRU0luVJ+eyxlSMGaS3awywwBd
	 uJwfbRHFuAse5RYl7SXgFgG3MzqmNuaTDw8VEgX02QeXdYydgGl9bcRWX2dOC4KP37
	 FSATZcK7YJINw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.83; helo=sonic305-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=CpKMYXzA; dkim-atps=neutral
Received: from sonic305-20.consmr.mail.gq1.yahoo.com
 (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CngQC0D0CzDrDX
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 04:57:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607104620; bh=7vPJ3lZnqV+N96N19iorxPnjzeD1++MeZq5guvWHnfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=CpKMYXzAUuWwSr4lzrqVnHorq4mhSus63K6XD8eRuqGZSgjiPp+ZFpBdw89A5LaFxmzRTyNtrnrDo2J1doPG5XKNerunFVhba3ExZnIQt/tZyGwSH+BlnLgXug4MspkKmob864kbzN0ROCXdhb8IyqtBFbyA8ncJA4W9SohvvmTlWlRg9VmXB/ff8ek0Etqo5E4gmLV83WryA1QXVfCVoIZ78bnx7cb0YJJYmfMXN3vtzyknpXVU29sb1+QW1bl1TJ9/CE1Vru20i7kDpkCzWdREa36M/CZyhA3hzkn0s5jKvueYsIpQMCcu7GFREe56RYOUGFBQhmOy/1DLbJGLWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607104620; bh=Rt5m/RAcnwjdl4F9epuAw55IdyjzaHS5qZSAQ3/7UeR=;
 h=From:To:Subject:Date:From:Subject;
 b=b79iCV1zeNKGy41gx2WlchrmaH8FmD4rZu0RhklA4UtXh+jWPXhk6WJ37wcj/299zJ69dIVuDJwqdtwbGgBWERT/VOTSyBFsvZpLyqCsoTUj6Z21DX7tym6+yJoH7E/dmcNhps2jsTAyg1VxpMiCAum2OmGrQjnEC3dCuT/gEgnP7/4/R5HKGIpNjR12FlEp1kzJBiqSQ7MsUmw0kCQXO+siE6d0nvMSMmb23TkVaKfxWdfgEKKB6PrvVOJb6JlTxYDhTFYCyPyMiuSSugMpl6yOR9qjbwWgEC1DxmYo6nIHjw1Dlw1Cj/oTTf3rBLmGRUqF2r5FV/eGnfUOUWimQg==
X-YMail-OSG: 9ttOO5wVM1ndo_OiqFeLAgCT3rUJiL9kMy21Rvgh0n3x7CcY8c5scuYIaD2lJfq
 oGgdp0zrqAgjveFGWn0zFfOPGrE7N9Yt.tdqnBAz.87kafxRi63kn5rSrFT7eF7vTQUXn9nBI2hE
 W077JfcVS0fIvWrSWZTNNLkcAlSdZQehvOYOjnwp_zXiDRKz8LMyP.xYZBb0gbpiA2rD8fF_9Ixs
 qCZvjxLI_EPJntUMaZBGUHqZE1sCh4dgJkRv3yd23PLTh_utkMO549P42QDOGd.xIgfaLoNVD61n
 MqJAR9O2XLo.YxYDhyyaKrvmiGW56Xb7oY4gH4T2hgsn_qaaWwXOu6_npuwsAB.XZFDbaxKJ1V79
 xiz1ZCIy1f.mbRFFI8BqiH1Ym4qiruiaxUkn1ps9xNNGdtP5zm_Hov4t.mPAGMOBIEGjahXWc3xq
 GCJunD6NHNK4IbWG2rgZJmjkpqjwNQOTi.bYEkVM9vsPD3t1uqsDReyXiBaUu1VRtPEOa_4hktuj
 QDKwjIeiY_3W1OnPcekHPAVHZ4XO76V9zfwDZ_dAMCg_fMl2yxdlmlzW_26O4XdYwboVegCoZCoa
 DMY9CXJH7szvRG97WNmLRb9k9jv..3I.PAkVby6HqcNuf3HKnl6RLGUJPeZW0fV08FnYEWTZunGW
 IsCcOSSAaciq44AqhJ1Tnjar97vLsq7geqvoNSXUVJrH0gloYRA.FJPTxrdQ2m2JRLkRoozabdHP
 pGPtrt5i21oHErbyZvSNh9QWz3wjbGKVpEmc1WhwslBObQRqyEftPfc1h8RwKrcOozaLCV6BaeK5
 voMMTD1eS0jZAkMWHawRGKeV06zMhebiJ.Nzg3OxIXu1O5etsHVj0ug.E3sJGQ29FRZXdyD7O_IO
 UnUr3S..uCrJNv1gKvZLj2uygtUqCaWUXv0J37ZxxycbyBJXVSF_C58JyzETmV0M2T2LSMvD0kH9
 ZekODx6d6rjYUe1TyAImSNxZSUzKS6va9Bj84wOsdPbcAxL5Ym6Bs5wbQT_7SiOzyoIW3GvioETX
 djr46gzd8aTf1QCZwiouShJNPI5pqCrIk4ee66NF1Dw5dSfRAQ3bkGoWrX7t39iimW2ehEvzLDhV
 _L2QmIxyOu_di7UEmDkdAWiIE.OISdnObPMXHRsWFoOJNxT.D4iHA3SPm01TGL2Zc2qDbKkO0FRL
 hu5W1yClXK2rWKKjRqdb_XVCNT4on3fVnv3x8RNwv6X2V3_ZCSqynYReF2tggv4qb_ke3XKufDPl
 TDhp6n4leijjSIxvsqk2cxb6JFfIhXzTkKR9yZOnmF3cRXvGw2yqGSR0Y8yImK9lXmFzag7azbwk
 01XRDn3whSVtfMB1gbFzWxWmLGpoIIOgMx3xAKRSi7TqCwCtHXe9WfAqDXsQTcjUeBG8zhSPgJme
 CO7QxPuRoLLWeSGbWMZQTCsp8IOwGvg5i.0lOK5kOu.z9RXUaj6IBO_Vl_GumRSSyg1ZrTepHhva
 QwbDShrhlXa9C8QhtpTfanqeTchfapWypEH2Qs0Gn0OjHlOpmjHFK80jaOphp5vrWmOEo98WSgv2
 vwqrXRbjI8HLC_0mGe8IHpQkJGlraHge8agG01wGwomPSJDpCMigU2DaTqYsZDVWdUFXUD6u6Wn4
 zeMLU4UkjZUQ8tBiGRYK0fKOk8AD7iEmcNMKRrbKvGNzc7LXl97N28sWlLUPQsMQkdgcAwdH3EEA
 vZWuPTFYf0PQAUF7QcG6yVhq_B.JMOvjeX2Rt0zpC.8Vxy8jIMqOkjCJUMWVVIXm_r1SZpub_dYm
 DYGpRkXW72v8CdG1QJjJRPWy.Mtq23UxCeczt0T11EJ0eATRt7vmNsHsa1cROJBL5nqxOuEFy_cK
 Krx6G9A0I0RADOy06k8Bs92hBQssIkpTiNOnFujw40Ltj0tZzYGHaMnpLCSK23.vFOYvdMuZg.7F
 0nbfRwB3r52Kiw6eEg9IEFycnrXjVmCdfSOilttKOz4oUernKPYhyovX2eGXqecKnoYYC9duSGh5
 uOyeNsgTs.j7cEnnYzJ1DHvFtKSNlj4RCPJtFmfwucKlhwJ_Xwf07In5xHUEwI_PzgFGQ1gC9Iop
 844fRvhlBhao84kEpThRNdntXP0ti.PMh8MtKxAV_PDUtCiaYa4u1gjJdI29Ua4IasAqYs._enqL
 b5vS0jRus7Gkw_9TCGdRYJ280sTX_bkyCYuOW4oSOHD0mfNzD2mzK05myhtuAlYXH0onxKiTuL.R
 kcwTt.tVObsMueJuw8_jBXl4j5uMcopgDmG9c9CuI7qzghlzMt68dTbZdlHpJvurKLMuUcIHdMF_
 vi55jdKNefbRBBwH59DHsfPsOwcMnpDiQdBvnviSQ9AA75h6VkdJrPfKkFWIjrpyaBRPcIqe6eLf
 S0XZL7GfAWv9SormKdvBIPzdw93hmq0nNmoWlSKy5bAbMaDiaIkt.
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 4 Dec 2020 17:57:00 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID a3d4890ee4470c265d95966fea2b66bd; 
 Fri, 04 Dec 2020 17:56:55 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: fix cross-device submounts
Date: Sat,  5 Dec 2020 01:56:42 +0800
Message-Id: <20201204175642.3231-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201204172042.24180-2-hsiangkao@aol.com>
References: <20201204172042.24180-2-hsiangkao@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

Use device ID and inode number to identify hardlinks
rather than inode number only.

Fixes: a17497f0844a ("erofs-utils: introduce inode operations")
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - fix improper inline comment update;

 include/erofs/internal.h |  7 ++++++-
 lib/inode.c              | 14 ++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index bf13c166ba16..ac5b270329e2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -112,7 +112,12 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
-	unsigned int flags;
+	union {
+		/* (erofsfuse) runtime flags */
+		unsigned int flags;
+		/* (mkfs.erofs) device ID containing source file */
+		u32 dev;
+	};
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
 
diff --git a/lib/inode.c b/lib/inode.c
index 1cf813daa396..618eb284550f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -35,7 +35,7 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFLNK >> S_SHIFT]  = EROFS_FT_SYMLINK,
 };
 
-#define NR_INODE_HASHTABLE	64
+#define NR_INODE_HASHTABLE	16384
 
 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
 
@@ -54,14 +54,14 @@ static struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
 }
 
 /* get the inode from the (source) inode # */
-struct erofs_inode *erofs_iget(ino_t ino)
+struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 {
 	struct list_head *head =
-		&inode_hashtable[ino % NR_INODE_HASHTABLE];
+		&inode_hashtable[(ino ^ dev) % NR_INODE_HASHTABLE];
 	struct erofs_inode *inode;
 
 	list_for_each_entry(inode, head, i_hash)
-		if (inode->i_ino[1] == ino)
+		if (inode->i_ino[1] == ino && inode->dev == dev)
 			return erofs_igrab(inode);
 	return NULL;
 }
@@ -764,6 +764,7 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
 
+	inode->dev = st->st_dev;
 	inode->i_ino[1] = st->st_ino;
 
 	if (erofs_should_use_inode_extended(inode)) {
@@ -778,7 +779,8 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	}
 
 	list_add(&inode->i_hash,
-		 &inode_hashtable[st->st_ino % NR_INODE_HASHTABLE]);
+		 &inode_hashtable[(st->st_ino ^ st->st_dev) %
+				  NR_INODE_HASHTABLE]);
 	return 0;
 }
 
@@ -829,7 +831,7 @@ struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	 * since hard-link directory isn't allowed.
 	 */
 	if (!S_ISDIR(st.st_mode)) {
-		inode = erofs_iget(st.st_ino);
+		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
 	}
-- 
2.24.0

