Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C476B890D
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 04:38:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PbK4Y6fsQz3cMs
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 14:38:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PbK4M0dLvz3cBF
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 14:38:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdqTXfW_1678765096;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdqTXfW_1678765096)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 11:38:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: mkfs: validate chunk/pcluster sizes in the end
Date: Tue, 14 Mar 2023 11:38:11 +0800
Message-Id: <20230314033814.57938-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Laterly, erofs-utils will support sub-page block sizes and
an arbitrary block size can be given at any position of the
command line.

Therefore, chunk/pcluster sizes needs to be validated in the end.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 94f51df..8e5a421 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -126,6 +126,8 @@ static void usage(void)
 	print_available_compressors(stderr, ", ");
 }
 
+static unsigned int pclustersize_packed, pclustersize_max;
+
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
@@ -222,13 +224,12 @@ handle_fragment:
 			cfg.c_fragments = true;
 			if (vallen) {
 				i = strtoull(value, &endptr, 0);
-				if (endptr - value != vallen ||
-				    i < EROFS_BLKSIZ || i % EROFS_BLKSIZ) {
+				if (endptr - value != vallen) {
 					erofs_err("invalid pcluster size for the packed file %s",
 						  next);
 					return -EINVAL;
 				}
-				cfg.c_pclusterblks_packed = i / EROFS_BLKSIZ;
+				pclustersize_packed = i;
 			}
 		}
 
@@ -415,14 +416,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 #endif
 		case 'C':
 			i = strtoull(optarg, &endptr, 0);
-			if (*endptr != '\0' ||
-			    i < EROFS_BLKSIZ || i % EROFS_BLKSIZ) {
+			if (*endptr != '\0') {
 				erofs_err("invalid physical clustersize %s",
 					  optarg);
 				return -EINVAL;
 			}
-			cfg.c_pclusterblks_max = i / EROFS_BLKSIZ;
-			cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
+			pclustersize_max = i;
 			break;
 		case 11:
 			i = strtol(optarg, &endptr, 0);
@@ -436,11 +435,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			if (i < EROFS_BLKSIZ) {
-				erofs_err("chunksize %s must be larger than block size",
-					  optarg);
-				return -EINVAL;
-			}
 			erofs_sb_set_chunked_file();
 			break;
 		case 12:
@@ -521,6 +515,32 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
 	}
+
+	if (pclustersize_max) {
+		if (pclustersize_max < EROFS_BLKSIZ ||
+		    pclustersize_max % EROFS_BLKSIZ) {
+			erofs_err("invalid physical clustersize %u",
+				  pclustersize_max);
+			return -EINVAL;
+		}
+		cfg.c_pclusterblks_max = pclustersize_max / EROFS_BLKSIZ;
+		cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
+	}
+	if (cfg.c_chunkbits && 1u << cfg.c_chunkbits < EROFS_BLKSIZ) {
+		erofs_err("chunksize %u must be larger than block size",
+			  1u << cfg.c_chunkbits);
+		return -EINVAL;
+	}
+
+	if (pclustersize_packed) {
+		if (pclustersize_max < EROFS_BLKSIZ ||
+		    pclustersize_max % EROFS_BLKSIZ) {
+			erofs_err("invalid pcluster size for the packed file %u",
+				  pclustersize_packed);
+			return -EINVAL;
+		}
+		cfg.c_pclusterblks_packed = pclustersize_packed / EROFS_BLKSIZ;
+	}
 	return 0;
 }
 
-- 
2.24.4

