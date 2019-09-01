Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243CA47C4
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7r2MBpzDqsp
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317224;
	bh=YWgwmIbxkAoHZ+s0kZ8sgBWXCZFGZgJ/MG0dWsp51T0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iFR4RKP/c1H9TOls7CjYYwow0zOxkufUIKmxTiIY9Z7z93ed+aCQ4WgUSn+4Rq7Xt
	 kmt2ffnqePVuXFJLxa+e/V+h0WTBI7E6660BUHqp7Eb55SpQaPGkR7u6DAsflHNymT
	 NI1xoTHDenxV25z2MwjoCTRgqGqN5vgCgpQhVo3dn5Rf8wuDArGJyYcs5NJioThjfR
	 QpBqFmhC7fNKsliEG7wP4zfYoWt6Py672zGCbp9HbDoNH1IyIHEJ5ISP0+9E3EfKhM
	 ERBG/+9ts6yBJRDTdfrKZxKmX01X54SAo7Oy85jerhDr+oPDwV+g6sAOnRDug0y+yP
	 iKNSIxElzq3Mw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.146; helo=sonic302-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="hzi2iebS"; 
 dkim-atps=neutral
Received: from sonic302-20.consmr.mail.gq1.yahoo.com
 (sonic302-20.consmr.mail.gq1.yahoo.com [98.137.68.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj7D75jMzDqtN
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:53:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317191; bh=do/5RPNfrD0Lp3NVbuZg4ow1onuAYFOW2VlQOz+kvis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=hzi2iebSTtKQ/BqpYJ96U9mRf3g0FqbKuirOzzqYcyL+MNsK1auCJoafXKbVP1mnm+S9i9F8W1TZhj/+wtUl+dXAm09375rbUjo3iP7bFC4rcH+tX6uz+n15oXCuaU16mIwEcJvFSHsYUC/tbuFIZMsygMRHNI8iwpI7pqYCJUTqkVhkTyTG+ig5en1ba6RnBSmHZsuSxK3SG12b0o93D9xVg4+EJE7fDgnJi2ySu6ltAby3HeT2aZKf6zdu/6nX0+6TmtFD0EgawTRxXPi4WggDILlLMNA0ERNzNNM1ZI9grg6ScctNmaOAe97QDCNONnTxFnKM5GQJpHGADfyAYQ==
X-YMail-OSG: mr4XzB4VM1maQtrlLT0tHscNhI3Wcc64WGYEIb7Mcj6jEkJ.Stm_nncgg6Nni.i
 r2qjg9Prqcfy0Zaoio5NsNf8e0ikNwPxo3QDXwWGBzdlOSr_0X.Ri_m0WtodjYeGvMKrrl7LEOk9
 q2th4uvHii_osBWQvq66cBa6BTMax9LUIhymfVe_bD1V7gVH8ksE6CpgRraNKtDsTsTeFa7LLuyk
 U2PHP.v0CdS1q_JMialXa1N01fqavpGHjd2WZqqCucqnTn5vhfZsedHH74.iHtdltqC6VZ47nIdz
 0goqh09cOogkLybZ0cxx8jhOkbVMNMFseT5YV8yT.EHrYAgjmmjWTWZKh8BD1NH315z6eBxskrih
 AlKdOXDTX0rHAn4SiAazo4PxIFvsFOp6CpvgLa3k7ao5naH3Vs1XZuPPje2riTdS7_e8JoybX7Ju
 v.mezk72jmla7GnxnimXGO4Z2hGNK9.2_lGa_NALn.bINXzESpAEMGL_Lr_lq.YuOoZ0i41plbRw
 NKl2XUw9uiWx4PtH26MODcBRHvMMUGrjxanqEFa5Dd4Po7K1qTJS5l_0K2_SFOmiRncBqxJGyYOe
 p4oRj9tycqBQTcZqjDekfwAGXn5vrWnpg1AjjgnnaxhRl1QVjVN6gfGYe1nDHK332NwfZxElcScg
 BH6gfLRWIDrBl3hdh23dStgl6TpO4w9D.vEHlHA4vtvZhp6uG.f7OQNrqjfFOlX6H0ylEVGnu63K
 QEcaGdBAp72TQ3OyczOHWEcwKBptlDxN0NLjvZ.Ka5lLKDLs6R0j1Ey.bs8C1CTd6IPX9oypNzk6
 Qz4DGKZ_VfYtxumjSZHe9JG2JAlJVEbGvvu6R4YriT7xehnyRWBxAHi0DVQbeLbxie1vTqlu2fVk
 FKTJ9ERrUSNhWQ_ulk8Zgu3Cxyda_hl5zNTIq4IFkjH_Vt2H8eaTy8dOBVfajKY_NMFx7M51K60H
 lOViOjHQYW.1MLxI8tIXxXPaNQ74BZjaa9Atu46VWFpUpThCinyI8KlIFms9jsoAhevMz28ndJd0
 NRG6Hd5M3DN.y0H8bdbNmouehTS7iFQ8A4Tkelm_m7TS8LygT0zpi7HL5VXNRbfo24t36PVS.cF1
 55_pN7lBlqihn2wY_UbJb9RwxtKS38VzvGfSFXoUpWUMilm_Fv7xAbUlPqZoQibZkOUFvS8KmvCw
 J7NItqqtbWEZ5bprGnvkxE70IZcNr0tcaews9HIX.v3JdgJpLSddn7IQm7Eiw9hySyF8jSdlpWkZ
 lmsRPP2VTUpl62wrmtHrCMyFURW_BlgJxPmjD1.GJkPnwP71X
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:11 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:53:09 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 16/21] erofs: kill magic underscores
Date: Sun,  1 Sep 2019 13:51:25 +0800
Message-Id: <20190901055130.30572-17-hsiangkao@aol.com>
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

As Christoph said [1], "
> +	vi->datamode = __inode_data_mapping(advise);

What is the deal with these magic underscores here and various
other similar helpers? "

Let avoid magic underscores now...
[1] https://lore.kernel.org/lkml/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c    |  8 ++++----
 fs/erofs/internal.h | 14 ++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 19a574ee690b..2ca4eda6e5bf 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -16,7 +16,7 @@ static int read_inode(struct inode *inode, void *data)
 	const unsigned int advise = le16_to_cpu(v1->i_advise);
 	erofs_blk_t nblks = 0;
 
-	vi->datamode = __inode_data_mapping(advise);
+	vi->datamode = erofs_inode_data_mapping(advise);
 
 	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {
 		errln("unsupported data mapping %u of nid %llu",
@@ -25,7 +25,7 @@ static int read_inode(struct inode *inode, void *data)
 		return -EOPNOTSUPP;
 	}
 
-	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
+	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
 		struct erofs_inode_v2 *v2 = data;
 
 		vi->inode_isize = sizeof(struct erofs_inode_v2);
@@ -58,7 +58,7 @@ static int read_inode(struct inode *inode, void *data)
 		/* total blocks for compressed files */
 		if (erofs_inode_is_data_compressed(vi->datamode))
 			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
-	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
+	} else if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 		vi->inode_isize = sizeof(struct erofs_inode_v1);
@@ -91,7 +91,7 @@ static int read_inode(struct inode *inode, void *data)
 			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
 	} else {
 		errln("unsupported on-disk inode version %u of nid %llu",
-		      __inode_version(advise), vi->nid);
+		      erofs_inode_version(advise), vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 15545959af92..4a35a31fd454 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -308,16 +308,14 @@ struct erofs_inode {
 #define EROFS_I(ptr)	\
 	container_of(ptr, struct erofs_inode, vfs_inode)
 
-#define __inode_advise(x, bit, bits) \
-	(((x) >> (bit)) & ((1 << (bits)) - 1))
+#define erofs_bitrange(x, bit, bits) (((x) >> (bit)) & ((1 << (bits)) - 1))
 
-#define __inode_version(advise)	\
-	__inode_advise(advise, EROFS_I_VERSION_BIT,	\
-		EROFS_I_VERSION_BITS)
+#define erofs_inode_version(advise)	\
+	erofs_bitrange(advise, EROFS_I_VERSION_BIT, EROFS_I_VERSION_BITS)
 
-#define __inode_data_mapping(advise)	\
-	__inode_advise(advise, EROFS_I_DATA_MAPPING_BIT,\
-		EROFS_I_DATA_MAPPING_BITS)
+#define erofs_inode_data_mapping(advise)	\
+	erofs_bitrange(advise, EROFS_I_DATA_MAPPING_BIT, \
+		       EROFS_I_DATA_MAPPING_BITS)
 
 static inline unsigned long inode_datablocks(struct inode *inode)
 {
-- 
2.17.1

