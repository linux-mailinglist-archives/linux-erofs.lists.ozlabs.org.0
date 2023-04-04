Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37C6D5A34
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxp4szdz3chV
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxQ3pWqz3cG7
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:34 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfL00--_1680595349;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfL00--_1680595349)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:30 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 6/6] erofs-utils: mkfs.erofs: introduce --xattr-prefix option
Date: Tue,  4 Apr 2023 16:02:23 +0800
Message-Id: <20230404080224.77577-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
References: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce --xattr-prefix option to make user capable of specifying
customised extra xattr name prefix.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 mkfs/main.c            | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e4d4130..bf3c5d2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_packedfile;
+	bool c_ea_prefix;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/mkfs/main.c b/mkfs/main.c
index 56b100c..09b03fc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -56,6 +56,7 @@ static struct option long_options[] = {
 	{"preserve-mtime", no_argument, NULL, 15},
 	{"uid-offset", required_argument, NULL, 16},
 	{"gid-offset", required_argument, NULL, 17},
+	{"xattr-prefix", required_argument, NULL, 19},
 	{"mount-point", required_argument, NULL, 512},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
@@ -116,6 +117,7 @@ static void usage(void)
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 	      " --random-algorithms   randomize per-file algorithms (debugging only)\n"
 #endif
+	      " --xattr-prefix=X      X=extra xattr name prefix\n"
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
@@ -475,6 +477,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 19:
+			errno = 0;
+			opt = erofs_insert_ea_type(optarg);
+			if (opt) {
+				erofs_err("failed to parse extra xattr prefix: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			cfg.c_ea_prefix = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -555,7 +567,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
-	if (cfg.c_fragments)
+	if (cfg.c_fragments || cfg.c_ea_prefix)
 		cfg.c_packedfile = true;
 	return 0;
 }
@@ -935,6 +947,8 @@ exit:
 		erofs_fragments_exit();
 	if (cfg.c_packedfile)
 		erofs_packedfile_exit();
+	if (cfg.c_ea_prefix)
+		erofs_cleanup_ea_type();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

