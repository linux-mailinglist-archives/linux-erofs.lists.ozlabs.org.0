Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE74DD458
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 06:25:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKXXy6xZgz30D6
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 16:25:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1647581154;
	bh=uY1S8oCO2LeNDJLTFXxuj9TRtMtarx2dh6G/Q5krrMw=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=XvIFg9xhy+2GLCgQJlGHxM8g5uOeCE+HIcMUqDUWjx396OLIX72peP6YFMV/pCV8F
	 eTrqSAMZvCOSCboeFw3/mljlPqXA6X7Cr/NkrDXoIa0iTQtlzHiQja6POXgh9yuSM/
	 iHJBScuTaYbEqbhd1BSSTkN88fVV8m/upLVNVPhWIUbUBF8mS2LMaj+94CypImyK9e
	 NpmT+bDul+ta4uJ/IQX7HVlZtbKY1KYKqtnY4Tl4LKRoPkdIdEH/K5m99Gf643kfmm
	 RI1/l3P6GlcBCOn/LZQYXT10JVW4MQvKLdW6berWutLSlEtTI2PaYwUGd8NIox+45W
	 /m8rX4rGjUx9g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com;
 envelope-from=31xc0ygckc-4tlqdtuhweewbu.secbydkn-uhevibyiji.epbqri.ehw@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=VVyT9ZvN; dkim-atps=neutral
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKXXs15Fsz2yP7
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 16:25:47 +1100 (AEDT)
Received: by mail-pj1-x104a.google.com with SMTP id
 il17-20020a17090b165100b001c659558b26so4943354pjb.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 22:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=uY1S8oCO2LeNDJLTFXxuj9TRtMtarx2dh6G/Q5krrMw=;
 b=mqxKeQCzeQXiFH4Xkup/x/OJoeK1LFK/OPvF6YZJg2EoM2luAKjZRResCngka8tfoy
 jvgLoeKcu+vZsqu2ZC866DNdad8uXrMJjP9EONK4b+KALhVuZAXHLmNEB5wt7Qfk87oY
 +Q3Uri4eK3Ehg92wsrr1OqRrKZMZySwz/72s6j5tsMg8tbevJm8wgo9wKntqPaGXl/bC
 eZFFR7Oc5uqBmLDpYj0Xyale1rjQrdjpbsYwvZiu31QoLDZ+2ykL3p82YWiaylMtKRnH
 DsAXf8+ywEvqZG0sFZI9hsagGkEXSb5jCB/l3pQ56Dg9gyYy1g+L/8zO1jWUQOMUjv0w
 Kc4A==
X-Gm-Message-State: AOAM530bcsuLOtjgprsKo1igp69KXEoWgOCBOUz45+bkMSz8mkc3H9P5
 We1ytUGCscsVoeAXHQbL2np7IE1wf0T3nUHWuUjfiGDsI/qzEaE5LdpfWmINJZf2Ca4NNt10psP
 WQKLjMbsS9kKLfHxj2pMk1qOOTipHUFgyHH9FEP2pQ40UgFlbF4C7eb6dLhevd3FrNqNN4b7f
X-Google-Smtp-Source: ABdhPJwgqfVlXhMJABxZKj02e83VPLYXCWP2Sjou6w6xXDsbwLUOMMzWRhgiAwvO9tUBI7Rlrpt2eWWrwKQK
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5102])
 (user=dvander job=sendgmr) by 2002:a05:6a00:b44:b0:4f7:1043:a72d with SMTP id
 p4-20020a056a000b4400b004f71043a72dmr7999789pfo.23.1647581143365; Thu, 17 Mar
 2022 22:25:43 -0700 (PDT)
Date: Fri, 18 Mar 2022 05:25:36 +0000
Message-Id: <20220318052536.1358747-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] erofs-utils: mkfs: use extended inodes when ctime is set
To: linux-erofs@lists.ozlabs.org
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently ctime is effectively ignored because most inodes are compact.
If ctime was set, and it's different from the build time, then extended
inodes should be used instead.

To guarantee that timestamps do not cause extended inodes, a fixed
timestamp should be used (-T). Additionally, a new --ignore-mtime option
has been added to preserve the old behavior.

Signed-off-by: David Anderson <dvander@google.com>
---
 include/erofs/config.h | 1 +
 lib/config.c           | 1 +
 lib/inode.c            | 5 +++++
 man/mkfs.erofs.1       | 5 +++++
 mkfs/main.c            | 5 +++++
 5 files changed, 17 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index cb064b6..0a1b18b 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -43,6 +43,7 @@ struct erofs_configure {
 	char c_timeinherit;
 	char c_chunkbits;
 	bool c_noinline_data;
+	bool c_ignore_mtime;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/config.c b/lib/config.c
index f1c8edf..cc15e57 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -20,6 +20,7 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = EROFS_WARN;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
+	cfg.c_ignore_mtime = false;
 	cfg.c_compr_level_master = -1;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
diff --git a/lib/inode.c b/lib/inode.c
index 461c797..99a4b2f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -730,6 +730,11 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
+	if ((inode->i_ctime != sbi.build_time ||
+	     inode->i_ctime_nsec != sbi.build_time_nsec) &&
+	    !cfg.c_ignore_mtime) {
+		return true;
+	}
 	return false;
 }
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 9c7788e..679291b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -109,6 +109,11 @@ Set all file uids to \fIUID\fR.
 .BI "\-\-force-gid=" GID
 Set all file gids to \fIGID\fR.
 .TP
+.BI "\-\-ignore-mtime"
+File modification time is ignored whenever it would cause \fBmkfs.erofs\fR to
+use extended inodes over compact inodes. When not using a fixed timestamp,
+this can reduce metadata size.
+.TP
 .B \-\-help
 Display this help and exit.
 .TP
diff --git a/mkfs/main.c b/mkfs/main.c
index 3f34450..93caf67 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -49,6 +49,7 @@ static struct option long_options[] = {
 	{"chunksize", required_argument, NULL, 11},
 	{"quiet", no_argument, 0, 12},
 	{"blobdev", required_argument, NULL, 13},
+	{"ignore-mtime", no_argument, NULL, 14},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -95,6 +96,7 @@ static void usage(void)
 #endif
 	      " --force-uid=#         set all file uids to # (# = UID)\n"
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
+	      " --ignore-mtime        use build time and ignore inode modification time\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
@@ -366,6 +368,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 13:
 			cfg.c_blobdev_path = optarg;
 			break;
+		case 14:
+			cfg.c_ignore_mtime = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.35.1.894.gb6a874cedc-goog

