Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB54E0C29
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 21:03:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yNFm28yjzDqHb
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 06:03:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571771020;
	bh=xvfZyDCb4qWHi/oz2hIQDxMUreJZohXnuqJ7CSx0Eow=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VmnUuGVHHRvOaXfJRMd4fqjCQgJTh4auf0YqNkcduzQ0tH1xsXMhyoo7/54LySBT2
	 JRMHsoZHNHeoZ5tAU1xc5VB6FPzdL/anI8M9RaepAPxsgrwIEaM3ASQpxXRaa/7Nn+
	 F7YDilLF8hAq2qls2y/Of6PnsKtwoZTvXP0ue8QONv8sr7xqRDE2BGDdwqb83W4pmM
	 m0hLsbVITtxGVI0/p8R29Gy2vG1wHo+Vtx7L++iCQ6ay57Gt2cIgrZZhq1K5IyIW1t
	 b/Dk3AYOnUVAyxRISzD+/aEM7VV7o62Bhf2/w/EkwhW7Cbb0lXgTx6EtiV5SzKzEG/
	 O/I7Bp//9zwrQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="ilfpawaO"; 
 dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yN9q2FCTzDqPv
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 06:00:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571770808; bh=vjmGUSwN55r83X2Mn1e3rPv1/sVwxHbTPZlfpbtprsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=ilfpawaO6G5guKb1m6d5mq7XhkhJipoTK3zXx2gdbACJEymqnnS3XiQr8l8RJg1vSs7dlpkXsEwrYbKpR4q/+xpu+OdvbOIp4t9anJiZbHOyST9gvAobaaFEHVyKxPeY35npJ9lHo4nMfj+z/mqmiohpK0d4OE4qCTVSJD3HGHOSrMj+NerkuTEODFdM/GQ3dqppR10Wcp6O/KDWeK9ZqV8c/TBtRiCxaNeEb/9oNQW117SuV6BiFl0nxcqxrBDd8SbUkVVJ7tao5TgZf4gD/0uxxmTjsZnQTP8sodNFDPsBJhCrsZEdh7/7Qsq8wYKKMcxLIPLTY2iJ2A0TneuIhg==
X-YMail-OSG: AD_D0TIVM1mRh56xbkJ_iqtVLg2en5WpSXi7ce4q13tYBtrPx8tQqim8wPSgTgv
 kvLU2Tti9ucxAWtdIjcCksrd3NowHijv2hNlF4NANUFHEswIn6TJHANfJv0f3o15VSrH35MWu5cr
 OeCRQG9svmpLY9yd5gfl9J8HtSxe3Pd1neR2e5qDmvVy6NrXhMBCLr8zI4JPhTQs2yepp0iIa9QC
 0II5AKPc.ODgxLAr_a1KCMLi2DR9rp.xuxQvE4sqwCP8RtZR330LWru_5aA7.JR4YkwH6KM0G47H
 pq.mzxrnDB1L.X.Br7H1G9VL9EuVe6HC7OzKh4DiudS5fK.EUYDo30m230wDRAmXupjQxYoCLIx.
 2lDq70hxYlpHyqLt6x1Anbqkaq31hMH8uHTj1uPuGMQW3k8e2_KCf80li7YaodrJBDLmJDc0ZNuU
 oXwIV9wKSB5Ka1JqE7g7_pyWxKGlUR.F6Bi5dn1LIHSTOyS0ZLBwLQEzdCX9kFAROQj3LfOMZk3C
 9S6xR2mOqLBR5JnV5rfh4rQvOlJAm4XVUexUdZLp0UsNu3SUNFBSii6mewapM5YxQHiqfwUzpzwz
 T9j19dcD43NViQBK9EXyD6h3ACThESIlKPpQeriM5ja8f02tvPTlYkxnU2jutbj9fcE9ddlKf_9C
 _T2xqu4oVHZVxm2OLtAdg9KumXouNHPFm9tWm7EqnxVPhQs5e9HXVkm7JkTT_iNn2mWbjdivEiZ8
 g68kSig7grFCiiBxOp7lneFKm.Ct1rbxJn4l50oykChJfS8Bw4jY1pqOu2RDW.sHIhcSP1ceqZkX
 CDGQabIQVDsGPpXqF6nAlRq9lqOo4d7FkZs1Jx.ppGzMKtAE6g7awNQT9GKmZ20CV8WuJDeG158a
 xVU8C61qpxjMKdnjOWkp.UhkO4g9e4IG4IwRqtluwHaM.CazWcMssOoJ14o_6Bkgt8Yik_E0ye5s
 vHHyyV.oBtofdQdSQcT.IYnQqPa784_Pad.JHklR9JvN_UkSgsO4XKdrJO0Orsa5SjqpccdLx_oJ
 GjOCDgdODysidcZd8YvRFM1nv88KBL40IEcwILALU6rnjbVXqW3veb2GtDAx8t.NlEGjwnA1NwEo
 Et7Ba46Z2IlgbWdGUhkU9_KjA.VjZ4SBa7tV9WgLG0.ujI2FE_usZOXP89wvhlK64RrMF8I0ko.X
 BnMwRHXTad7xnrkplSPz6iCtcMYhcYKVMW6IQkm1wr3SRcaSYGlMrbienB1Tn84hldcEVtbF.iXU
 gTVpxqdysHd6Q2KmX5DiPChTNvAWDr3SbzSCGA.WfYhHRh0rpn_AMg96l7QDi6_mGIqie8bcvIpK
 KEAbf.pipvJF3Uu64ZpAtOg8MTlkDCR03DOz2DXMP
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 22 Oct 2019 19:00:08 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID fc068d67395b99274d16e3cd955c5c72; 
 Tue, 22 Oct 2019 19:00:03 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: list available compressors for help command
Date: Wed, 23 Oct 2019 02:59:47 +0800
Message-Id: <20191022185947.12326-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022164954.GA4132@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191022164954.GA4132@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Users can get knowledge of supported compression
algorithms then.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/compress.h |  2 ++
 lib/compressor.c         | 29 ++++++++++++++++++-----------
 lib/compressor.h         |  4 +++-
 lib/compressor_lz4.c     |  6 ++----
 lib/compressor_lz4hc.c   |  7 ++-----
 mkfs/main.c              | 15 +++++++++++++++
 6 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index e0abb8f..fa91873 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -21,5 +21,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode);
 int z_erofs_compress_init(void);
 int z_erofs_compress_exit(void);
 
+const char *z_erofs_list_available_compressors(unsigned int i);
+
 #endif
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 8cc2f43..b2434e0 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -12,6 +12,15 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
+static struct erofs_compressor *compressors[] = {
+#if LZ4_ENABLED
+#if LZ4HC_ENABLED
+		&erofs_compressor_lz4hc,
+#endif
+		&erofs_compressor_lz4,
+#endif
+};
+
 int erofs_compress_destsize(struct erofs_compress *c,
 			    int compression_level,
 			    void *src,
@@ -36,18 +45,13 @@ int erofs_compress_destsize(struct erofs_compress *c,
 	return ret;
 }
 
-int erofs_compressor_init(struct erofs_compress *c,
-			  char *alg_name)
+const char *z_erofs_list_available_compressors(unsigned int i)
 {
-	static struct erofs_compressor *compressors[] = {
-#if LZ4_ENABLED
-#if LZ4HC_ENABLED
-		&erofs_compressor_lz4hc,
-#endif
-		&erofs_compressor_lz4,
-#endif
-	};
+	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
+}
 
+int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
+{
 	int ret, i;
 
 	/* should be written in "minimum compression ratio * 100" */
@@ -65,7 +69,10 @@ int erofs_compressor_init(struct erofs_compress *c,
 
 	ret = -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(compressors); ++i) {
-		ret = compressors[i]->init(c, alg_name);
+		if (alg_name && strcmp(alg_name, compressors[i]->name))
+			continue;
+
+		ret = compressors[i]->init(c);
 		if (!ret) {
 			DBG_BUGON(!c->alg);
 			return 0;
diff --git a/lib/compressor.h b/lib/compressor.h
index 6429b2a..b2471c4 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -14,10 +14,12 @@
 struct erofs_compress;
 
 struct erofs_compressor {
+	const char *name;
+
 	int default_level;
 	int best_level;
 
-	int (*init)(struct erofs_compress *c, char *alg_name);
+	int (*init)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
 
 	int (*compress_destsize)(struct erofs_compress *c,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 0d33223..8540a0d 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -29,16 +29,14 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4_init(struct erofs_compress *c,
-				 char *alg_name)
+static int compressor_lz4_init(struct erofs_compress *c)
 {
-	if (alg_name && strcmp(alg_name, "lz4"))
-		return -EINVAL;
 	c->alg = &erofs_compressor_lz4;
 	return 0;
 }
 
 struct erofs_compressor erofs_compressor_lz4 = {
+	.name = "lz4",
 	.default_level = 0,
 	.best_level = 0,
 	.init = compressor_lz4_init,
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 14e0175..6680563 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -37,12 +37,8 @@ static int compressor_lz4hc_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4hc_init(struct erofs_compress *c,
-				 char *alg_name)
+static int compressor_lz4hc_init(struct erofs_compress *c)
 {
-	if (alg_name && strcmp(alg_name, "lz4hc"))
-		return -EINVAL;
-
 	c->alg = &erofs_compressor_lz4hc;
 
 	c->private_data = LZ4_createStreamHC();
@@ -52,6 +48,7 @@ static int compressor_lz4hc_init(struct erofs_compress *c,
 }
 
 struct erofs_compressor erofs_compressor_lz4hc = {
+	.name = "lz4hc",
 	.default_level = LZ4HC_CLEVEL_DEFAULT,
 	.best_level = LZ4HC_CLEVEL_MAX,
 	.init = compressor_lz4hc_init,
diff --git a/mkfs/main.c b/mkfs/main.c
index 31cf1c2..1161b3f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -29,6 +29,19 @@ static struct option long_options[] = {
 	{0, 0, 0, 0},
 };
 
+static void print_available_compressors(FILE *f, const char *delim)
+{
+	unsigned int i = 0;
+	const char *s;
+
+	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
+		if (i++)
+			fputs(delim, f);
+		fputs(s, f);
+	}
+	fputc('\n', f);
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
@@ -39,6 +52,8 @@ static void usage(void)
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
 	fprintf(stderr, " --help    display this help and exit\n");
+	fprintf(stderr, "\nAvailable compressors are: ");
+	print_available_compressors(stderr, ", ");
 }
 
 static int parse_extended_opts(const char *opts)
-- 
2.17.1

