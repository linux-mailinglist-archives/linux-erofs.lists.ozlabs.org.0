Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEEB6A2A5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nryc723tzDqTk
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxf01mpzDqWf
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:53 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 837C6E8F31308165EE4B;
 Tue, 16 Jul 2019 15:04:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:43 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 17/17] erofs-utils: introduce extented options setting
Date: Tue, 16 Jul 2019 15:04:19 +0800
Message-ID: <20190716070419.30203-18-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce option "-E" for extented options.
Legacy images (linux-4.19~5.2) can be generated by "-E legacy-compress".

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 README               | 11 +++++++++
 include/erofs/defs.h |  4 ++++
 mkfs/main.c          | 53 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/README b/README
index fec20aa..312c7cd 100644
--- a/README
+++ b/README
@@ -48,6 +48,17 @@ On Fedora, static lz4 can be installed using:
 However, it's not recommended to use those versions since there was a bug
 in these compressors, see [2] as well.
 
+How to generate legacy erofs images
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Decompression inplace and compacted indexes have been introduced in
+linux-5.3, which are not backward-compatible with older kernels.
+
+In order to generate _legacy_ erofs images for old kernels,
+add "-E legacy-compress" to the command line, e.g.
+
+ $ mkfs.erofs -E legacy-compress -zlz4hc foo.erofs.img foo/
+
 Obsoleted erofs.mkfs
 ~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 111b703..0d9910c 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -155,5 +155,9 @@ typedef int64_t         s64;
 #define DBG_BUGON(condition)	BUG_ON(condition)
 #endif
 
+#ifndef __maybe_unused
+#define __maybe_unused      __attribute__((__unused__))
+#endif
+
 #endif
 
diff --git a/mkfs/main.c b/mkfs/main.c
index eb75bdb..184b2e4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -27,6 +27,7 @@ static void usage(void)
 	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
+	fprintf(stderr, " -EX[,...] X=extended options\n");
 }
 
 u64 parse_num_from_str(const char *str)
@@ -39,11 +40,55 @@ u64 parse_num_from_str(const char *str)
 	return num;
 }
 
+static int parse_extended_opts(const char *opts)
+{
+#define MATCH_EXTENTED_OPT(opt, token, keylen) \
+	(keylen == sizeof(opt) && !memcmp(token, opt, sizeof(opt)))
+
+	const char *token, *next, *tokenend, *value __maybe_unused;
+	unsigned int keylen, vallen;
+
+	value = NULL;
+	for (token = opts; *token != '\0'; token = next) {
+		const char *p = strchr(token, ',');
+
+		next = NULL;
+		if (p)
+			next = p + 1;
+		else {
+			p = token + strlen(token);
+			next = p;
+		}
+
+		tokenend = memchr(token, '=', p - token);
+		if (tokenend) {
+			keylen = tokenend - token;
+			vallen = p - tokenend - 1;
+			if (!vallen)
+				return -EINVAL;
+
+			value = tokenend + 1;
+		} else {
+			keylen = p - token;
+			vallen = 0;
+		}
+
+		if (MATCH_EXTENTED_OPT("legacy-compress", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			/* disable compacted indexes and 0padding */
+			cfg.c_legacy_compress = true;
+			sbi.requirements &= ~EROFS_REQUIREMENT_LZ4_0PADDING;
+		}
+	}
+	return 0;
+}
+
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -66,6 +111,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_dbg_lvl = parse_num_from_str(optarg);
 			break;
 
+		case 'E':
+			opt = parse_extended_opts(optarg);
+			if (opt)
+				return opt;
+			break;
+
 		default: /* '?' */
 			return -EINVAL;
 		}
-- 
2.17.1

