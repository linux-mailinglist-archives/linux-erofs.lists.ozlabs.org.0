Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D75D145C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 18:44:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pKmX2wdwzDqXJ
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 03:43:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUKe56TO"; 
 dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pKmS28KczDqTG
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 03:43:52 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id p1so1764772pgi.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Oct 2019 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=BUKe56TOlt9+HSf2NU3Vmj3vixunqlVGmdOc9HbiQLvbgYCpfxhxazycLkD1pHNsXA
 mryWewlqyk7UJsIJEWasD1iZHPuCID1aQpwJowA202RFAZhnsgyO97nD29D2QJzv4df6
 F6FvMBGTna4Xb1pf/MZOefyH+nbjWH1Wdarpw67NvPFTpOeMTod3RdQCupH39aAjS3IM
 vMd1lHxv6BdlOQ7RDwYetPUBOc6bTQ5mbjA+Dc6zOb6ygZBkzIcjRPVrOQym1oT1WLFH
 GfHoU1SYB02FlfihNGxa1bMxoIoxbkc3CIDurZbVylyW5CTvr2GWx12ys6qZwLhNYjeH
 xtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3hk98JuCeWHOrIUfRtRz6SrmpiW5uP4+Af+s4mVv/2w=;
 b=lnjj5kBl1WjJue8fjBuE8tNnZMqU508qoR/F9tthNvAPeOK/sLNx+iOdv1eSbnCGmA
 85KBagDqetfZ38pMU3oQbvYNJDmEoyTvOfOwpnlQqBzJ5qwhZ535UaciPkeLHs6nHuMF
 hJYGG/kh3GGzA9mr2JDTqSJ/1IvM15WBwJoKFItbrZe5gDpAwbMnxwGUuy0oM+U4pEfx
 P/LoYFG2FQkv7VtUefAQ4N+jnUrVcm4Ip4gb1l7/xUV3vp+Yxl8o1C+1ZnFtSiCYwUyz
 33TZBqniIgS5lPXKgnhufLoD8BudVG6F7wyKj88qxrBVjOC2dwHEXvZHsr+2o+9vT3bX
 QM9Q==
X-Gm-Message-State: APjAAAWVK90nyflDuwgLu3OBA2Chat+IbEOfH3A7Kxvr4xeUJksYXH6R
 xxhIAEpbQxbHwvV2E1p3C9aPdmhi
X-Google-Smtp-Source: APXvYqz49DiDhxcGU4u/y8A5XH6zCSXoqVzZGIrPHWbxN5RxInlqvYimCzPlUIeK3jgXX4dzfgmE4w==
X-Received: by 2002:a17:90a:8c86:: with SMTP id
 b6mr5434577pjo.129.1570639429469; 
 Wed, 09 Oct 2019 09:43:49 -0700 (PDT)
Received: from localhost (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id j17sm2696015pfr.70.2019.10.09.09.43.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Oct 2019 09:43:49 -0700 (PDT)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH preview][] erofs-utils:introduce fixed timestamp using "-T"
Date: Thu, 10 Oct 2019 00:43:36 +0800
Message-Id: <20191009164336.15596-1-blucerlee@gmail.com>
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

