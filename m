Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA32F9440
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Jan 2021 18:47:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJj6F40l3zDrS9
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 04:47:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610905621;
	bh=JVY7y4ERcR8ISeyMkHlZMcCahLDXO4GIuB/+DNPU0/8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hUqcu6Ahu5Hk4BxxUlcis31wufjlA+gwBqN1rdUey7TjQsRv76MLRiyJp+A0E03nC
	 AinDKYWJOPbakGDynt/aDzRPDkeeyIqA8DKrxsiP0uSjNva4ClYEhJ83MNpzthB+XP
	 opaqZtnpSPPgHFx5H6dqKjKLxn/CTMUNI/tnddIqYiT1a1aXbI99mwVLv4Kv78ZCkr
	 7TXJv3yfCMhoVHo23mt+GnW3mZG+j8zfdCOAtyFJg36QlL2ro6Fe/gW2ceAkzN9eNN
	 DT+zG+QAXpcGUL7lFP6/9FSz2508SAQfzEAHODbJA8mv+S5QKwWBvZQz8iIQehfTJ9
	 d6L/zjPlFcYyg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=OGWlltwP; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJj5g5MBmzDqtt
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 04:46:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610905585; bh=j7FBM5oWDUbZcBhdqLOreqWgb7ZtX8bf7bIyjTOSIY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=OGWlltwP997uBH7S0tQf80IfHusDruggnjZM8c9tn5tumgW83w1sAqwrvBcWpulyFZ04Xs0kn/0tqVh8da7hcefmS1ENs514Ha/ZARMpfeh4Aec7q0TS3SxMc9X3k9LF+A8vxZeUHfW8AhwSD9GPDyyyCFO/1k14RB+zrIq4StNJLgc5StLKueQuu7Ci32aS/vbRDd3Rxgbb/kRfDFEHwoD2HZaiGzA+WNVlv7tHqJpHOrCFVGb2DN8l23eBohYACOx28CxDujf7xOPnnZKrLRcnoDSGHR9Mr/LXN0gVWdc1n6DOKLVjyM1pMoM5rdWg93f/EP6d/U4iHd3WDpP2jw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610905585; bh=O3U4+RZMzOl7E0iukktN4QWNA7wfzWlQ00B3r700xgm=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=KBm/2T6p+KXnyAwRfw4V9Q+PggnNpH5Whc0YCpAUN/ZONo8afzqEcXfmxlj4tnYKTgbyhGTnBQZFtz+0GdkdEn+xMdPn+x09Mnvi3ZMbx9CzQMU4l2CDKXL/Rm0l+9/KdqiKvb22CM+1PU2XTAbGm01hC/aQ1MkG4dWVbwgSQ4TjLakWeETWprMoKZ8ec3mdrW8u705vo6lI5Qq53hXt9J5jQ5ULQLrC5RBFVoU4Yf20ZC3IgMgSfhgwhEq0JimgCvuCVX9gLDlnp4z0Pa3GeZV4YgUFjO31NlqHxTqDy0lZVrDHRV+PXyeowZMdg8KKW+7CWm7xJnol7NJxJ8eDWw==
X-YMail-OSG: TMTuepgVM1lC.Il9wGq2SVbnsnBchacR3qg7WDbkajAgfWIPfDG9T7JFIcK4P4q
 JbwIMdGdu9tleM2fTM9T.XRGskJWv5miZlkYyTidF5g.oUxWOafSclIfjK0YnCHtYph2DzDEVZux
 S.fzwuq3GUO0cQiso41SlMgCcCVxHqAu2Ap4L0LUHuW5gFBKdSV6wjVxG8MxEhcTshzTiSz4cvF9
 KeeILjQuIKPxEEyee70xRqvXwp1jHJ5JXvqQXKwKxXY03YoXm85q0ZVyPjlM2l90vPd6YN5x2Zk8
 8ipaQf_Bkae0W4EPBYgg9783Lc8lUSv8QxP00CnZTubuyia6DXpTeSbSZCGPg_WFMbBe84aIrEqy
 4mAubIFKTlht0UZNBMae3WjlypSw4i5oQ0v5nyFhwz.BSix0rxZUBsccSiCaRmt0Rhzt82DAUCwv
 5hptbYQClBjKY8hdI_tqNvhEMMWOAcRDzBrBLYmoEJAfF5_J7u_QrADm75kc4YIXWoNlU7Kqy2hX
 Jt3AMhcGU.WXg4g0hxOvcwW.zFh3zLYbgG8BsXjrLrb8vXA_1HNiFVLOR8I2CkwF7OIu4tiMjsCg
 W0.bEq7bM31umZqb9Pef860m_9pWAlxA9XZJ2QofsLnCL9y8jT3c3eHlnosv_R8TuoiFAvpuywUP
 wfr5LrUtje7gVt7ien7I9bUAEVUkHL94HeowZy7ROQzAmrHO8eRpPk2nAG4oBreuO_qTU3cMy1v7
 sVJwcgE2ZfLO60OZEYGYEttj55X2QAfOs7VH635czzNOXlFQcg0nAA2MVCX6Kzm89_Fz4QXWrfz7
 NQOBShE4C_d8ZFUZbNlUB_bxrjzf8xXlVZLho0rTEiXSMd.tEfN_yQVF225vZLTLwsFfM_UdAG9v
 a4RFa5NiSDvtvSABaT6C2Ak4aGqTap7XTwZQKdPa5OJU8ZBW23uZGZ4gHEJX9EuP0mSfjmatnAca
 vmCwYCU73Vl.YqFngf0HjHpdTYHm32EgHSQeFLyqXl8UDetd2ODbyGrnQk4QVKuHhCJZzmyR1yqo
 RbcXA6OfWZMg3U5ihAiK2YJwjwNBJCfxYCEQAeoVTsCxSqnsM4j7UDD5lkhY3vrxY8m8NApS0iBi
 _lOOY.NFUrh3Y6bESiN0_urFBTmrBkz9r1fNIuf7.NWRbRKfi0Eb1AQOV0_sFfwxcfZWuIn._hxT
 yX0XoNqLC4thaB3gLaeMGTI3YVqQJ2sQzT8UsSR4bnLgzfyIZGphDF_UBut_4_61YYzhksdgw80o
 lvbz5XD9Gr2AzZ8aQK_4hVsp6jpR.mcJrwjCt0w90d8qlkw_Y.G2pyJLGWRTbLUEQ64onhFmmYZ9
 VUNLssE9RXSwD.Q9amjfcsE4DoGDLteAgpLzQC4Qk8j8tINqhpiLPuBoYvFbJ.pR6Zq.SXGjPkRP
 1XqwnUMWq50TnNRq9Kge2AKOTzdHxfNfCra9cfo8pqQocoBe6gsfS1ju4WKLa49GWZpJEVa2RuEl
 tT4UoHDn81E4VUkAkHmMMP4XqDSvv.vk5IRe_rxSQNpTH2EMIGJCvjPJk5C2j489im9VdCN.nLAv
 4pGs_IUZYiY0Yehar409d1OkvodLKwIlFcoaIe4W9IximvK4n9L4PKkipW5XEynaPiKHG37X2hEF
 93sR5hwr8uqt02oJdFrLyo8miCLMAIrbJsAifFAgbHKs4NjcGFk.ImQUEfOB9MtIO61nClresrU0
 1e4CPFlKHQ3dubwsll_aXgBFWvWUEPenLdHEQQeIeQnwIleH3Ph0Z0YUANaYR68Yp_iSdqEs_Irx
 SeNa5J1xd8Rg_2qtWec.Kf8D6EjsqTbOUrl1d30jxUfQI8cpJWGZMcOfYulLwNFsSHEqczDFtbo8
 eNsOL08Bi0j3GtAnbmU4gMTu51NZx9EkoZvg5KG69FsXGq6BiyFGCb5KYc7BNz.4XABOShdnzCRR
 7j_vAb_gYPgYed8rvU1Vfx44LdNZ2NRfixOmqUx8ADo_ymNFYkSaE0cB5TIjM2rLxa3At_j_cuT0
 P5386qL7qfWxR40pOuh_NV1d1HxR9w41QDHBh2oZi3OpZ.__F5tDo1j.dII4Yhoq_5zpmEWAKbS8
 rc4C6KsJeYm6r3ZIRHV7.FFK4eBqTcJpRzbVqsIFumVi6JCWjkDjZLwKn8LJIvt10J64a30vYJxq
 2APXiErtyoICrnfFlD.SFPRkZHAlopswfRjfiq1JoILIhX_OL_FUSSgVAn0kOxcdVtOuvOU03MzW
 vof1uQadKu9Gpi29nXepcnk9gegTFEJejWT9H40hSGzsxf3v32rnSmsCRJ1Aix3S4_v8IKnMX0_y
 MbWg9x.lv1ejJ_MVWEOwFPpyuc.7EXJ79roZRahq6x9VN3_bQ4Z4Rq9yaaGY8YTHjZR5UmXL4h0x
 23jWx.uQFCtlTW4OE5LVM1cSCttoyRbhYSsxAD0XQEGLzF4qnm.rgoam1gjmdt3hdBYUYt.M.kgy
 9LE_jB3GD3F7OHGJMpUWLAV67UpNLix31T7.izIb25imqqjNsVyMK
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Jan 2021 17:46:25 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 84aafc302758bb6691fa0c94699b2296; 
 Sun, 17 Jan 2021 17:46:21 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 1/4] erofs-utils: clevel set up as an individual
 function
Date: Mon, 18 Jan 2021 01:46:00 +0800
Message-Id: <20210117174603.17943-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210117174603.17943-1-hsiangkao@aol.com>
References: <20210117174603.17943-1-hsiangkao@aol.com>
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

Compression level passed in can be verified then. Also, in order for
preparation of upcoming LZMA fixed-sized output compression.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/compress.c         | 11 ++++++-----
 lib/compressor.c       | 22 +++++++++++++++-------
 lib/compressor.h       |  6 ++++--
 lib/compressor_lz4.c   |  1 -
 lib/compressor_lz4hc.c | 21 +++++++++++++++------
 5 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 86db940b6edd..2e8deaf81907 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -20,8 +20,6 @@
 #include "compressor.h"
 
 static struct erofs_compress compresshandle;
-static int compressionlevel;
-
 static struct z_erofs_map_header mapheader;
 
 struct z_erofs_vle_compress_ctx {
@@ -165,8 +163,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		}
 
 		count = len;
-		ret = erofs_compress_destsize(h, compressionlevel,
-					      ctx->queue + ctx->head,
+		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
@@ -520,7 +517,11 @@ int z_erofs_compress_init(void)
 	if (!cfg.c_compr_alg_master)
 		return 0;
 
-	compressionlevel = cfg.c_compr_level_master < 0 ?
+	ret = erofs_compressor_setlevel(&compresshandle, cfg.c_compr_level_master);
+	if (ret)
+		return ret;
+
+	compresshandle.compression_level = cfg.c_compr_level_master < 0 ?
 		compresshandle.alg->default_level :
 		cfg.c_compr_level_master;
 
diff --git a/lib/compressor.c b/lib/compressor.c
index b2434e0e5418..e28aa8f934c0 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -22,11 +22,8 @@ static struct erofs_compressor *compressors[] = {
 };
 
 int erofs_compress_destsize(struct erofs_compress *c,
-			    int compression_level,
-			    void *src,
-			    unsigned int *srcsize,
-			    void *dst,
-			    unsigned int dstsize)
+			    void *src, unsigned int *srcsize,
+			    void *dst, unsigned int dstsize)
 {
 	int ret;
 
@@ -34,8 +31,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 	if (!c->alg->compress_destsize)
 		return -ENOTSUP;
 
-	ret = c->alg->compress_destsize(c, compression_level,
-					src, srcsize, dst, dstsize);
+	ret = c->alg->compress_destsize(c, src, srcsize, dst, dstsize);
 	if (ret < 0)
 		return ret;
 
@@ -50,6 +46,18 @@ const char *z_erofs_list_available_compressors(unsigned int i)
 	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
 }
 
+int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
+{
+	DBG_BUGON(!c->alg);
+	if (c->alg->setlevel)
+		return c->alg->setlevel(c, compression_level);
+
+	if (compression_level >= 0)
+		return -EINVAL;
+	c->compression_level = 0;
+	return 0;
+}
+
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 {
 	int ret, i;
diff --git a/lib/compressor.h b/lib/compressor.h
index b2471c41ca4e..8c4e72cfa8b9 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -21,9 +21,9 @@ struct erofs_compressor {
 
 	int (*init)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
+	int (*setlevel)(struct erofs_compress *c, int compression_level);
 
 	int (*compress_destsize)(struct erofs_compress *c,
-				 int compress_level,
 				 void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize);
 };
@@ -32,6 +32,7 @@ struct erofs_compress {
 	struct erofs_compressor *alg;
 
 	unsigned int compress_threshold;
+	unsigned int compression_level;
 
 	/* *_destsize specific */
 	unsigned int destsize_alignsize;
@@ -45,10 +46,11 @@ struct erofs_compress {
 extern struct erofs_compressor erofs_compressor_lz4;
 extern struct erofs_compressor erofs_compressor_lz4hc;
 
-int erofs_compress_destsize(struct erofs_compress *c, int compression_level,
+int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize);
 
+int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 8540a0d01cbb..c2141f39e95b 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -11,7 +11,6 @@
 #include "compressor.h"
 
 static int lz4_compress_destsize(struct erofs_compress *c,
-				 int compression_level,
 				 void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize)
 {
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 6680563986c3..5188a7cf6ea4 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -12,16 +12,13 @@
 #include "compressor.h"
 
 static int lz4hc_compress_destsize(struct erofs_compress *c,
-				   int compression_level,
-				   void *src,
-				   unsigned int *srcsize,
-				   void *dst,
-				   unsigned int dstsize)
+				   void *src, unsigned int *srcsize,
+				   void *dst, unsigned int dstsize)
 {
 	int srcSize = (int)*srcsize;
 	int rc = LZ4_compress_HC_destSize(c->private_data, src, dst,
 					  &srcSize, (int)dstsize,
-					  compression_level);
+					  c->compression_level);
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
@@ -47,12 +44,24 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	return 0;
 }
 
+static int compressor_lz4hc_setlevel(struct erofs_compress *c,
+				     int compression_level)
+{
+	if (compression_level > LZ4HC_CLEVEL_MAX)
+		return -EINVAL;
+
+	c->compression_level = compression_level < 0 ?
+		LZ4HC_CLEVEL_DEFAULT : compression_level;
+	return 0;
+}
+
 struct erofs_compressor erofs_compressor_lz4hc = {
 	.name = "lz4hc",
 	.default_level = LZ4HC_CLEVEL_DEFAULT,
 	.best_level = LZ4HC_CLEVEL_MAX,
 	.init = compressor_lz4hc_init,
 	.exit = compressor_lz4hc_exit,
+	.setlevel = compressor_lz4hc_setlevel,
 	.compress_destsize = lz4hc_compress_destsize,
 };
 
-- 
2.24.0

