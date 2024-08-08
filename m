Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4894B9EA
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 11:45:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yUp/15MP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfhxP12sPz2xps
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 19:45:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yUp/15MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfhxF1bQqz2xjL
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 19:45:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723110330; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EG1nMrzevU6Lm3XeAcfukiKVK9FuNF2XX0RPJcZ349g=;
	b=yUp/15MPN0PichM0FP9hsgPXCtKAbDCY0jK4nwkJVYI4E6isLqC3z7Xd9eFphwbyJs+VToP2fZF+WXq1GU3UvU4PuOT/BJXkJMPaTM1EzSZUSQ7vLAauFlIbYrjTca/RKR15HcVgz6YtY5O5a9V2XoBcZzx3Y9ZAmwDIHXkVbQY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCMCJqY_1723110323;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCMCJqY_1723110323)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 17:45:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add `--mkfs-time` option
Date: Thu,  8 Aug 2024 17:45:22 +0800
Message-ID: <20240808094522.2161075-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Some users need a fixed build time in the superblock for reproducible
builds rather than a fixed timestamp everywhere.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 man/mkfs.erofs.1       | 14 ++++++++++++--
 mkfs/main.c            | 18 ++++++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 56650e3..ae366c1 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -27,6 +27,7 @@ enum {
 };
 
 enum {
+	TIMESTAMP_UNSPECIFIED,
 	TIMESTAMP_NONE,
 	TIMESTAMP_FIXED,
 	TIMESTAMP_CLAMPING,
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 3bff41d..d599fac 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -100,8 +100,10 @@ Set the volume label for the filesystem to
 The maximum length of the volume label is 16 bytes.
 .TP
 .BI "\-T " #
-Set all files to the given UNIX timestamp. Reproducible builds require setting
-all to a specific one. By default, the source file's modification time is used.
+Specify a UNIX timestamp for image creation time for reproducible builds.
+If \fI--mkfs-time\fR is not specified, it will behave as \fI--all-time\fR:
+setting all files to the specified UNIX timestamp instead of using the
+modification times of the source files.
 .TP
 .BI "\-U " UUID
 Set the universally unique identifier (UUID) of the filesystem to
@@ -112,6 +114,10 @@ like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
 .B \-\-all-root
 Make all files owned by root.
 .TP
+.B \-\-all-time
+(used together with \fB-T\fR) set all files to the fixed timestamp. This is the
+default.
+.TP
 .BI "\-\-blobdev " file
 Specify an extra blob device to store chunk-based data.
 .TP
@@ -177,6 +183,10 @@ can reduce total metadata size. Implied by
 .BI "\-\-max-extent-bytes " #
 Specify maximum decompressed extent size in bytes.
 .TP
+.B \-\-mkfs-time
+(used together with \fB-T\fR) the given timestamp is only applied to the build
+time.
+.TP
 .B "\-\-preserve-mtime"
 Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
diff --git a/mkfs/main.c b/mkfs/main.c
index aba5ce4..b7129eb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -82,6 +82,8 @@ static struct option long_options[] = {
 	{"clean", optional_argument, NULL, 522},
 	{"incremental", optional_argument, NULL, 523},
 	{"root-xattr-isize", required_argument, NULL, 524},
+	{"mkfs-time", no_argument, NULL, 525},
+	{"all-time", no_argument, NULL, 526},
 	{0, 0, 0, 0},
 };
 
@@ -150,7 +152,9 @@ static void usage(int argc, char **argv)
 		" -C#                   specify the size of compress physical cluster in bytes\n"
 		" -EX[,...]             X=extended options\n"
 		" -L volume-label       set the volume label (maximum 16)\n"
-		" -T#                   set a fixed UNIX timestamp # to all files\n"
+		" -T#                   specify a fixed UNIX timestamp # as build time\n"
+		"    --all-time         the timestamp is also applied to all files (default)\n"
+		"    --mkfs-time        the timestamp is applied as build time only\n"
 		" -UX                   use a given filesystem UUID\n"
 		" --all-root            make all files owned by root\n"
 		" --blobdev=X           specify an extra device X to store chunked data\n"
@@ -548,6 +552,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i, err;
 	bool quiet = false;
 	int tarerofs_decoder = 0;
+	bool has_timestamp = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
 				  long_options, NULL)) != -1) {
@@ -607,7 +612,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid UNIX timestamp %s", optarg);
 				return -EINVAL;
 			}
-			cfg.c_timeinherit = TIMESTAMP_FIXED;
+			has_timestamp = true;
 			break;
 		case 'U':
 			if (erofs_uuid_parse(optarg, fixeduuid)) {
@@ -829,6 +834,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 525:
+			cfg.c_timeinherit = TIMESTAMP_NONE;
+			break;
+		case 526:
+			cfg.c_timeinherit = TIMESTAMP_FIXED;
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -984,6 +995,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
 	}
+
+	if (has_timestamp && cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
+		cfg.c_timeinherit = TIMESTAMP_FIXED;
 	return 0;
 }
 
-- 
2.43.5

