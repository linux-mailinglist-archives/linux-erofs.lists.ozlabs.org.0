Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D646588D
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 22:48:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4CPz562zz2yg5
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 08:48:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638395303;
	bh=XTOSn/6RXHjd/BN8WT3uNc0kMPrX68EjOf9aA4xuUb4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=FjPOaRSHYAd6pG7FGoVLvsi3yzoA4WCrbZxYtBqUcT6iy+rH1hUstdtXPR/jHdmPf
	 86Sl4mCvADq1oOoUJjmsQ4s7E+6nOo2Xe5LbeGB2oagdGdGMbrPsrXxc5qRSD21uW7
	 LlGYUwB1Xtbnetvm1XPH/DGKkv3m0NqW8XNJqJMPFK3reBVhTgyj70egvHMYFQH8iv
	 URXYvmyzo367MR3V8jC5eo0OdUswz/i+AGPgUxyKzCKzy4gXfvY17fQwxa06Ozz+MD
	 taUBBDA74h8S/Ypygb7c8/Si/dgUWECTeRBQ2+apf2l8e05giV8j44/mSMcfHoMJpx
	 9lN0Gpv983L7g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=3l-2nyqskcyybjcpimgnxkpiqqing.eqonkpwz-gtqhunkuvu.qbncdu.qti@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=FbjbzuVy; dkim-atps=neutral
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4CPp3TDgz2yb6
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 08:48:12 +1100 (AEDT)
Received: by mail-vk1-xa4a.google.com with SMTP id
 j194-20020a1f6ecb000000b002f4c0eb8185so15043239vkc.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 01 Dec 2021 13:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=XTOSn/6RXHjd/BN8WT3uNc0kMPrX68EjOf9aA4xuUb4=;
 b=OFJ3Ji5BDnySPQDzoKawyZXcuKaf9KWRaACxhx921OJImbpo012reEdbcayGggCc6N
 3wKlH4045iZYVRqdTcOQmYGOOcm8MES6M1p6+LTJUqH9XtJcqQ9d+NSaoekDCdTk23fb
 0lMvmESBJUkIDunSco7vF0xD3nS2eCtCCqfRoOEuV2pfbNHbLWN5gmYVbjvoz6IPlttA
 NZmiJnkLwmxAtzTK36Zyl9gWZU07WW+yyarswRNmIHD3czgbOXwxpu66gU/LhOJoktE7
 zRcI/iswfpcG6DC5wgXoeY07DcCVD9cJSL7TVvI+WoZUBdz6vtGDe2Wbi47nWGeEk/WI
 fcig==
X-Gm-Message-State: AOAM533+D/4Td7Z5qH59Op1ltGaQDo+X758HY9BNrqXubN2mkm4U395i
 NBR0zx4TWi0cjwZ7+WmDXA0Nf55HJ9BHx/YYiLvVxtSAmXwJD5vwv6bsEK6InlJcicdL9y+QrdK
 8y8usZ99+IDsp736M1EMsse86N9RwfxH3aM2L0da0w9XZf0mo7sHDSCLWlor88hDtAE7QUVVZGX
 r961Zsc/M=
X-Google-Smtp-Source: ABdhPJzCT+c+Ptow5DdMZWaRIXLxL+OVqJoqeu5ybfTC0CpCdpHvrpR10dG6C9eNK7GBN/CFVE9Fesr4rHvwuq3arQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a1f:9049:: with SMTP id
 s70mr11356535vkd.19.1638395287182; Wed, 01 Dec 2021 13:48:07 -0800 (PST)
Date: Wed,  1 Dec 2021 13:48:02 -0800
Message-Id: <20211201214802.1545918-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1] Add an option to only dump/fsck an inode by path
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is useful when playing around with EROFS images locally. For
example, it allows us to inspect block mappings of a filepath.

Change-Id: Iac1aebba5d510dd3d4f38e65d4056ea9ac9871bb
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c | 15 ++++++++++++++-
 fsck/main.c | 16 +++++++++++++++-
 mkfs/main.c |  7 +++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b7560ec..dcf577e 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include "erofs/internal.h"
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
@@ -23,6 +24,7 @@ struct erofsdump_cfg {
 	bool show_superblock;
 	bool show_statistics;
 	erofs_nid_t nid;
+	const char *inode_path;
 };
 static struct erofsdump_cfg dumpcfg;
 
@@ -71,6 +73,7 @@ static struct option long_options[] = {
 	{"help", no_argument, NULL, 1},
 	{"nid", required_argument, NULL, 2},
 	{"device", required_argument, NULL, 3},
+	{"path", required_argument, NULL, 4},
 	{0, 0, 0, 0},
 };
 
@@ -103,6 +106,7 @@ static void usage(void)
 	      " -s              show information about superblock\n"
 	      " --device=X      specify an extra device to be used together\n"
 	      " --nid=#         show the target inode info of nid #\n"
+	      " --path=str      show the target inode info of path\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
 }
@@ -148,6 +152,10 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 				return err;
 			++sbi.extra_devices;
 			break;
+		case 4:
+			dumpcfg.inode_path = optarg;
+			dumpcfg.show_inode = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -449,7 +457,12 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		.m_la = 0,
 	};
 
-	err = erofs_read_inode_from_disk(&inode);
+	if (dumpcfg.inode_path) {
+		err = erofs_ilookup(dumpcfg.inode_path, &inode);
+	} else {
+		err = erofs_read_inode_from_disk(&inode);
+	}
+
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
 		return;
diff --git a/fsck/main.c b/fsck/main.c
index aefa881..ecdd0bf 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include "erofs/internal.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/decompress.h"
@@ -18,6 +19,7 @@ struct erofsfsck_cfg {
 	bool check_decomp;
 	u64 physical_blocks;
 	u64 logical_blocks;
+	const char *inode_path;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -25,6 +27,7 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{"extract", no_argument, 0, 2},
 	{"device", required_argument, 0, 3},
+	{"path", required_argument, 0, 4},
 	{0, 0, 0, 0},
 };
 
@@ -37,6 +40,7 @@ static void usage(void)
 	      " -p              print total compression ratio of all files\n"
 	      " --device=X      specify an extra device to be used together\n"
 	      " --extract       check if all files are well encoded\n"
+	      " --path					check if a specific file well encoded\n"
 	      " --help          display this help and exit.\n",
 	      stderr);
 }
@@ -79,6 +83,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return ret;
 			++sbi.extra_devices;
 			break;
+		case 4:
+			fsckcfg.inode_path = optarg;
+			fsckcfg.check_decomp = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -582,7 +590,13 @@ int main(int argc, char **argv)
 		goto exit_dev_close;
 	}
 
-	erofs_check_inode(sbi.root_nid, sbi.root_nid);
+	if (fsckcfg.inode_path) {
+		struct erofs_inode inode;
+		erofs_ilookup(fsckcfg.inode_path, &inode);
+		erofs_verify_inode_data(&inode);
+	} else {
+		erofs_check_inode(sbi.root_nid, sbi.root_nid);
+	}
 
 	if (fsckcfg.corrupted) {
 		erofs_err("Found some filesystem corruption");
diff --git a/mkfs/main.c b/mkfs/main.c
index 58a6441..d6bc7dd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -24,6 +24,13 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 
+#ifdef WITH_ANDROID
+#include <selinux/android.h>
+#include <private/android_filesystem_config.h>
+#include <private/canned_fs_config.h>
+#include <private/fs_config.h>
+#endif
+
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
 #endif
-- 
2.34.0.rc2.393.gf8c9666880-goog

