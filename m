Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800D87C6F7
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 02:10:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bBH2515U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwmQg14kCz3dW7
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 12:10:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bBH2515U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwmQJ3YpXz3cy9
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 12:10:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710465028; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=E6P8S5NRZgc6A0t3o9zv+uPpG+BdmwqEkXsLRcTrk44=;
	b=bBH2515UCeJa4Fm9KbsZbv63KJkiv6ZvBBuAKyr5awSaFc985ACPooagjLkHHUWDx+7FFd7zkKxcRS6Gg8zAZJq4oHlCExfhQeV7ZGakespZLTfphMzOqTXEG6u/Ba3yp/tocW4ITaKsCYejAAFRpPrs/0WAOjveOSeuzQMmqxY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2UFdIV_1710465026;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2UFdIV_1710465026)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 09:10:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 3/5] erofs-utils: mkfs: add --workers=# parameter
Date: Fri, 15 Mar 2024 09:10:17 +0800
Message-Id: <20240315011019.610442-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

This patch introduces `--workers=#` parameter for the incoming
multi-threaded compression support.

It also introduces a concept called `segment size` to split large
inodes for multi-threaded compression, which has the fixed value
16MiB and cannot be modified for now.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  4 ++++
 lib/config.c           |  4 ++++
 mkfs/main.c            | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 73e3ac2..d2f91ff 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -75,6 +75,10 @@ struct erofs_configure {
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
+#ifdef EROFS_MT_ENABLED
+	u64 c_segment_size;
+	u32 c_mt_workers;
+#endif
 
 	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
 	u32 c_max_decompressed_extent_bytes;
diff --git a/lib/config.c b/lib/config.c
index 947a183..2530274 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -38,6 +38,10 @@ void erofs_init_configure(void)
 	cfg.c_pclusterblks_max = 1;
 	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
+#ifdef EROFS_MT_ENABLED
+	cfg.c_segment_size = 16ULL * 1024 * 1024;
+	cfg.c_mt_workers = 1;
+#endif
 
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 8a68a72..126a049 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -77,6 +77,9 @@ static struct option long_options[] = {
 #ifdef HAVE_LIBLZMA
 	{"unlzma", optional_argument, NULL, 519},
 	{"unxz", optional_argument, NULL, 519},
+#endif
+#ifdef EROFS_MT_ENABLED
+	{"workers", required_argument, NULL, 520},
 #endif
 	{0, 0, 0, 0},
 };
@@ -178,6 +181,9 @@ static void usage(int argc, char **argv)
 #ifdef HAVE_LIBLZMA
 		" --unxz[=X]            try to filter the tarball stream through xz/lzma/lzip\n"
 		"                       (and optionally dump the raw stream to X together)\n"
+#endif
+#ifdef EROFS_MT_ENABLED
+		" --workers=#           set the number of worker threads to # (default=1)\n"
 #endif
 		" --xattr-prefix=X      X=extra xattr name prefix\n"
 		" --mount-point=X       X=prefix of target fs path (default: /)\n"
@@ -660,6 +666,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofstar.dumpfile = strdup(optarg);
 			tarerofs_decoder = EROFS_IOS_DECODER_GZIP + (opt - 518);
 			break;
+#ifdef EROFS_MT_ENABLED
+		case 520: {
+			unsigned int processors;
+
+			cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
+			if (errno || *endptr != '\0') {
+				erofs_err("invalid worker number %s", optarg);
+				return -EINVAL;
+			}
+
+			processors = erofs_get_available_processors();
+			if (cfg.c_mt_workers > processors)
+				erofs_warn("the number of workers %d is more than the number of processors %d, performance may be impacted.",
+					   cfg.c_mt_workers, processors);
+			break;
+		}
+#endif
 		case 'V':
 			version();
 			exit(0);
-- 
2.39.3

