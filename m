Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF08D144E
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 18:42:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pKkm19dwzDqX9
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 03:42:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xl9iNoIN"; 
 dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pKkg25ZDzDqGW
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 03:42:19 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id e1so1762568pgj.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Oct 2019 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=Xl9iNoINKhZWO0XyIEjdRJrP3Sh58gCuF+zZ6hY9h4iQw8yZwsgEmM5T8cbbOaO088
 wW4ErH4dWf5id4kVTQbFIIqXFCH9YFBgMllGRYc6xH3GdP8d4ZsXOA5WBMQKVfyEjtGY
 /S6FUKbQciU8Re1ScsxLJh4C2hO51GliBZsSXZKJHsjW9lCOsgsAMMPNutndqdNaSqEw
 qnnwUMiz6vq2g3xhTJhUghDBCPAipL4p9P6d4n/MTVP4caQr7QUlhbNBg5oy8KPiH+KU
 eYtkjBipStKJBX/tmeIY87njGvAR3GJ43sGJSpi0xeWPtqBxUnXi57wNEO6EPM38wzo2
 dp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=T85+t/axzH5PCie9HBlJXJys2OaZl9pJmRH8Jh3oavhrgOoI7HQtx/z68e8nT7A63F
 5UkVP6dNfXY/1aUQ8cjNZzUeDju4WMMWwtQItArWV8NCsln8vOSWE/KXxxcclChlFATo
 4uJjrEbu+uD318x94om3V3d/Gzj+r6+7pAnaBQ0g+n9mlgjwUdqnotLbtGAsf+Y0TtyN
 sQV1E4BPOWjh2GBj/bzTq5Rqyep9nZ8j1oLxIjV8eFFwlhRuY6WXCQUioedptnyA9EA/
 J0TcjKHiy1czzGwYFd9yYzTfoYlutBKvYfxfdbGGcd/O1UJfVfpjAZxXdZQiM8NOWzmm
 K/Tg==
X-Gm-Message-State: APjAAAUzedUapjpIqhuYVOBm0u+LM3qHytJkmXJd5ljqRhsVrqdFGtYK
 qgf8blroZjk8kFedDenEcDaRN3JM
X-Google-Smtp-Source: APXvYqwhmRTFszDL/SFletW1k0p7JAde/O7w5SlydyveAvl5L6D9Z+PtUYlfgp+YbVz9PQMYCeqqzA==
X-Received: by 2002:a63:1b0d:: with SMTP id b13mr5371800pgb.312.1570639335547; 
 Wed, 09 Oct 2019 09:42:15 -0700 (PDT)
Received: from localhost (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id 37sm3108122pgv.32.2019.10.09.09.42.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Oct 2019 09:42:15 -0700 (PDT)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH preview][] erofs-utils:intriduce fixed timestamp using "-T"
Date: Thu, 10 Oct 2019 00:41:27 +0800
Message-Id: <20191009164127.15401-1-blucerlee@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce option "-T" for timestamp.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
---
 include/erofs/config.h |  3 +++
 lib/config.c           |  1 +
 mkfs/main.c            | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index fde936c..61f5c71 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -11,6 +11,8 @@
 
 #include "defs.h"
 
+#define EROFS_FIXED_TIMESTAMP 1569859200 // 2019/10/1 00:00:00
+
 enum {
 	FORCE_INODE_COMPACT = 1,
 	FORCE_INODE_EXTENDED,
@@ -30,6 +32,7 @@ struct erofs_configure {
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
+	long long c_timestamp;
 };
 
 extern struct erofs_configure cfg;
diff --git a/lib/config.c b/lib/config.c
index dc10754..6141497 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -24,6 +24,7 @@ void erofs_init_configure(void)
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
+	cfg.c_timestamp = -1;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 978c5b4..85b8f34 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,6 +30,7 @@ static void usage(void)
 	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
 	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
 	fprintf(stderr, " -EX[,...] X=extended options\n");
+	fprintf(stderr, " -T#       set a fixed timestamp to files and dirs\n");
 }
 
 static int parse_extended_opts(const char *opts)
@@ -93,7 +94,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	int opt, i;
 
-	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:z:E:T::")) != -1) {
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
@@ -126,6 +127,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
+		case 'T':
+			if (optarg)
+				cfg.c_timestamp = strtoll(optarg, NULL, 10);
+			else
+				cfg.c_timestamp = EROFS_FIXED_TIMESTAMP;
+			break;
 
 		default: /* '?' */
 			return -EINVAL;
@@ -224,7 +231,10 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (!gettimeofday(&t, NULL)) {
+	if (cfg.c_timestamp != -1) {
+		sbi.build_time      = cfg.c_timestamp;
+		sbi.build_time_nsec = 0;
+	} else if (!gettimeofday(&t, NULL)) {
 		sbi.build_time      = t.tv_sec;
 		sbi.build_time_nsec = t.tv_usec;
 	}
-- 
2.17.1

