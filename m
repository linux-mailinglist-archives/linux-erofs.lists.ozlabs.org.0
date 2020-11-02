Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 596772A2EBD
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyGW49jJzDqNH
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332627;
	bh=/+garz3Tgu2XQ02OGaVyseEag4pEDDaoUgF7BGE9gvw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HYbH6VZNVmtCeryMzoXpK6S7GqgOl3emnxEdil19Cm/1ZzwnhzOLJmkjPfE2hOeUJ
	 42TpQzstb1MKwmHJMJ7TbKt3+TAgLE7uohQB+ayO+VagvfiHSWEkCcRqoEK65d4r1T
	 IGH9BPnZjZwLdf+5rbPz+xmGxWlFfxl87BtY7Kv3K/RgpGiwjJ/jcKqgjcK8lWzjo2
	 hNT+YSt4yoYpxGfOd81wcGE1nhPIgHSvCr/Tr3i0soyfWzwhj7MyMNVsmdNnv3H726
	 Kv1DcGL4PobDL9KcNN33AHqZycwRrdEUc6kueMTgemhD5i6P5biwGpS5nml1VIA7xx
	 B2nbRw2anGk1Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=HyQcx8XK; dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyG163BBzDqRY
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:56:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332598; bh=i/aOFyeaSn0uHx6P5l4JkxdYfk0v9CnQze8bXvhWzqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=HyQcx8XKyWEK/oN3uQCQFJPM4Mzl++ICu8k66RFutFGTxocz9PzJBrHjmoDSh9pGcyFPq4te73BC0B6wEkLNO7V3cpwW9rNhtRK9cMvZ4lvZPwDvSb/Yvs28Xu/LiS/BhKi2NtcyqeDnS8AEAircesgn4Zr4wNvH7lsSwlgf9G1mfuZheA6WN/xmStgcD9RU2Th046fD+8fcowLh0DElEzCU+nLSSIq1DUM47I65z+VlUpUOU689OiS0SHY5PQQJ1nl5b5g079j/eAse1oMZ52musYf3v7mpZKLusgUnR24iuugQAF37epkWZOwZLBE1Q71uSxl2QwWsY8iA1lnaBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332598; bh=JvvPZSSrz/8eFWKt/G23+Z+1o8BhI57uqp603t+Gdu6=;
 h=From:To:Subject:Date;
 b=tDeaIMlWWOZXYPjsoTvKEAnQIGv/EnMxrq7MQWm49Zj4rVW9397lE5SQ7ccvdz6YvLGbZm6FJE/mcAlYEsJfzVDw0EpiGF6HXPAZ/riDr//5eAxd8F16nvmSRI6Wj8nwu3v0gBmmqBf7Tp3fOt8cAAexlTUR4gc566cVtwVjfoCgYfqDX4IE+Qqx/Q0s8sY+n/qx90V1fiobs0DPTTfwuLncORvrXkLdem1kdFYQHa40bqa1lpkPN5c+ij/Bwt1JhzOMt1nbAtmjzgSsgEMByVB7TBGRdX9DJBpkUomj3Ornw4PYwwHV0ivhu6RLN81kXxGvlQGMAz2mnCkAsoNa4Q==
X-YMail-OSG: X90QQ6UVM1lZKfQUE5iGv2g4ioip1VhrPwQcnMz7JG3qxe7HmFNJ3KyJUv0q1EG
 eHgZ9m5HRP.qegyLf35V9K8z761bqOfh47VrZymJ_ug0KR2X0YiDsf8TiYVia1.5UNAVR1f6r_cR
 xCFUm36JVLlPHq3yFt0f7HmktwWtJmZPU7NaqC0Y_JanesAxvHH7Pm0uwWWuyc1wLOPdfjEpcIc2
 _Pjv1iJ04ZC0.fLMglriz7TtUyFQi2MaHxX7HhUlUHi2SyW5XaT0JIwVuNPaIOjlhaTih8DEvJbU
 m1iiK2_1gLQnD2av.9gQS1UMAtYX3aatG05JYpjxrsIw7Eww2pOJXQM8ZvEePaRIDOMRm5_iFCZF
 GNPGCdgT1Sv93nH5X0xCO4_a_8PyKLNhuGitirifSPllF0NhfANwQ15Wvonf6VvA9wtR8Y.cLzRr
 kop44g8AueUGJ3nk8txGxKS3x4e17jeHjX0atjQNHxDroDCQppp5zBPTyy80lRi3mWvME.aRS.Xp
 X8a.ZvSyr1sCJrbc9mqOHpPTFpxZ3KDRPtHd._Bs.6I5YppQ.QSM8IfuZ9jhnT.SykBw.IV8QIf8
 eE10KwmYx2sMAaFa6doIogrLLps_XzWG7UHXvQ5aZwHljUA6V5pb61CN0LSeq7ugTSLqAXaUDb6u
 vOOm3OOwIvmEOz1le_3DUgOb8pRFAJd9cw0JbhhTN4tXnfCX5.p1DEer6A7mL0lr6iZui5VLKo7_
 x9yENtuukC9Qg2W4LKULUEy5x0BEG27w285Y4jdCsilPDMKyyiJ8fw7Qup3B1JFz5.tU5KEJOoVQ
 Oy1SDQJnJSxAyadhhJrDKEWaBmk0cEgKrYYMcypJqmOjQwbE6do8l0IFGiqdUKylYMpLaoU2ELlt
 oDVTDVsOzsf553jtZwI..QU8qU7BSSD1bfH1WtpuuOT7g.iuIVmghdmn78Yo9iGTZb0VxqbVbMXt
 dM4czURAJ3tPmQRaAW5NeSPZVtjl1TVRtB3uZpOVgEBy7P_JuCunvCywF7DMUI9IUs04BdOX.dRC
 Kc78x8y2e2AJN5.GKYfraKh9_.zTiQRCRIYiGrBTHPpjvC_QMfJqfGrjgjbbM.3PeXuwzFh1SvxH
 irJnB4YvDCSCXJJM3WaFgxy7piRFx2OrlKtVvUmxTDb4TRQEBkMsyEj7vdDJLxQk9FK_AKqzTnJb
 l8B2xpQ8iKKmhhxuLQ6esN4HsdAoySKtNDp1Qq_AqWIh6E3jlyQ3HpbMVn.oK_L.ptQwhHD7QcpP
 b8SM0sO4TOFAOeJR5svReR8xmkHNLjA6_VxJv5QnK57A87ji6k6g8vMk6VeARLNUOeQzJzkJp..A
 qFbb4DpWhWWFS2OmNWkGQ4deo4jA_diqXWnVDjt_K4NK_RErsJpbv1qp.pNkvalXM0UMeSk0zGLL
 hbbO56WGhjYTU0YDbl0FO4lXSxHKzjockCtIYq96K7S.BWfUR.wWvkqiCXIhSko6qxgDZsGJ6YYE
 pSdH7WhSk23J0vzC7dMrCvxWdCPo6KJjy2Pem1gpXmf0ugwwzHglGkZIWeFFr7nq1WHxLSBys.N.
 WsIx2_F0PF0ABtIWX16fYd5ukE2yydUNTzd.VFw8Adf8WKVSA.ijytEh2iyhVRo_IbCeRj2ROFPz
 k.b_adOWlPqMdVRXuF3dRdQgmUcfQueJc0TgNK.uIH0q0PrjzGP4M67OtVAwoLKzQenIPrOS0sYM
 nOfJMGs2YCyZPJi5_w1aGtLdxkGfdf4MX3YhHPs8smz9cpikBw8rO8aNQMTWvmtDMapNTWt16sPd
 2N5xFmvLrEVHLGBkhGUHm3RwPG08I_Nwt0D86BxfDFSpJstxPdJQ6ldRUkcMBdH2FwWA0RfVphbE
 BhCE9vEijB7wKM6h1w02jrwkAJ0c1mmiDxnSN74VizTmV1o1Gfe8xMpumookmCkE0YtOQ2K_ECc1
 FPNDdD.0.fTaqNV779mkaeHMD0C9WIfEg98EJ7mzUz5jns2S.qYSVK6zYa1oKdB4L9YjbNX4.f0T
 u675bfojchakZddiXYx1J0tjpkJLijCH8iRv87qLz6o0nUGPwVzGSwtkNOZE.jeekPGJ1w.0oD_a
 6VVQt4JuA9tHY_usJwYhjM6iROJRb7C8zepp3oqENWSJOgsi.XSeAN9wQWNqfyO7292033.q2R0g
 t2rCpwYdwExhs.QXYeCtOm8zB4TGuaK0YvaFJXgAliabj8h.nfhWJnBcKNKIxPOMsVWOd7DsnVkM
 irb8ErclhHt3lfB4HOreSHfvHDJBmnwS1CmZ98d.Hu5OcrzXeGj1ZKTjVG21hsv78AnwNa1xHKcb
 wkRzDqZBYCAybKMTmLIRfpHxGJBbnZuV0jGECyqookSg.SW2_HuvYiIYnBD3R8h2_gbCv7aZ_rRE
 IfDbJuF_uDLSqFEmShfFjeGUdFx0E3uOpKiH4BQLsSqNxTxLjqnJz96T8g8Cd.Fq6NX7EF0W7uuK
 w4n3cO_9Zx_DbSZGG.bwI4K9sjls.wzUcszpZg1s3dE9A4ONVn9WfoD5JEyw10n9k1MTBi3HUkw3
 HrRiPVuy_o_dCXRl3TdddDGJcqYAGISc5nj4wsBczjOHmGASMhfHlbdnR.dIrF8s980JARz1oU1D
 ylMaTRsjnwh.eNIldJ0wxM2rxdC7LcHf9t_QjmBswC6qexVqYPJGAy1JsC24gJSICtKDHwFbChza
 Gmg3pJ4ow.OO6dUUFDgZl3TdRanw072W34riKFN2CGLufsfS4W2Z8cYuGysn0eOMo2F8E.N.jfWy
 WXW1ZfcFM3.QnK0jsg6W1Otx3EdubbZinj32EDX0EahZUHiPlgIU9N4pBW.9WYSRKvVKlwg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:38 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:32 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 02/12] erofs-utils: fuse: add special file support
Date: Mon,  2 Nov 2020 23:55:48 +0800
Message-Id: <20201102155558.1995-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
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
index 8426145a9231..4c5991e7e487 100644
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
index 6fb3f3e42df3..26f49f6fc299 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -116,6 +116,7 @@ static void signal_handle_sigsegv(int signal)
 }
 
 static struct fuse_operations erofs_ops = {
+	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
diff --git a/fuse/namei.c b/fuse/namei.c
index 1564d5853fe6..99e5ffa34858 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
 #include "erofs/print.h"
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
index 58b23783d083..eb771c75baa7 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -111,3 +111,29 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	}
 }
 
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
+	erofs_info("path:%s link=%s size=%llu", path, buffer, (unsigned long long)lnksz);
+	return 0;
+}
+
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

