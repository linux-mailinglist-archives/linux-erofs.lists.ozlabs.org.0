Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DB212D2F34
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 19:05:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pyBZ1YhvzDqQQ
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2019 04:05:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvGfWqj2"; 
 dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pyBR63GzzDqPm
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2019 04:05:03 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id 205so4308531pfw.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=gvGfWqj2sbpCS2H/vqVs4NUcBTLZV6RORMVIH0wQgZt8Cp7GWfOYQo4C5ZxrQJZ3QD
 GKVmUtQzv4Tln5y6/raeQGSo922p2BFWJmxotOeahj+DMUj4q8PATipqhwyGrzzpwCQc
 3AowiXn9StUhWa+QdBo7WX/QbPiwtDrYb6yj8LmZooDbTMuecMGy2yEFakd7awTRh2vc
 vt4LT8ksYPOFY6k9A4VAcrAULgGyCsFa88mkvdS40rB5WrS4r5tyiu0M0Ara2wcpk98H
 gEq7hwW9mAVI8NH/4LmGvqRRQAubFU7bbl+kzYqNOj9Sg9MeNi0ykp0aASpg8hLxIBPN
 lrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=Nrgc1Wu1gzLDXl7A95G4HPldC7ECZuVnEFKNs9u1i6t7RJNNxRUqwNoP0ii3qVf1/l
 qUnFaIcpOqBh4frUQfh8IgqaLciHG+9L4yWAZZc8pJ+uJlylrBkfCC3/TUFnSG4EhbZs
 VBlXWfc0xGAECerCQXahBJ1GZPovQFRBc4u8a0OodXIptpkdi1MG2NGjxWstv75VdmSZ
 2A71Qggdxi3jm0CivgfkDIpyfYDHYRV9vDT8qpjBDD41kvHz+GTkpDV3J3a9Bxgid/1r
 KGm4he3s0Iw3euWzqyeI8Ou0zIU/fiB6nfITdyvHe7x5FPnqw8WxYnoJHkKryn3UM6dj
 IdPQ==
X-Gm-Message-State: APjAAAVG7sexhoXG8TJMMGp87c1wGF2UOIYd+WO1kd4YXChiNEIAO3f3
 t09qcPqqHCxGQf5v3UZxW7ec9XcwXyU=
X-Google-Smtp-Source: APXvYqzvxssMZURQVJXscGyDAZWoZiabEm8DiyN5CQ6Mwyx4s3ktXpMX/roJFyqtEG0KlEE5Hm0T5w==
X-Received: by 2002:a17:90a:19c1:: with SMTP id
 1mr12500223pjj.52.1570727100778; 
 Thu, 10 Oct 2019 10:05:00 -0700 (PDT)
Received: from localhost (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id 6sm10243534pfa.162.2019.10.10.10.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Oct 2019 10:05:00 -0700 (PDT)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v1] erofs-utils: introduce fixed timestamp
Date: Fri, 11 Oct 2019 01:04:55 +0800
Message-Id: <20191010170455.2169-1-blucerlee@gmail.com>
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

