Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0049F237
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 05:05:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JlP5H03pgz3bPK
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 15:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LW074f8G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329;
 helo=mail-wm1-x329.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=LW074f8G; dkim-atps=neutral
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JlP586yZrz2ymt
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 15:05:46 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id
 i187-20020a1c3bc4000000b0034d2ed1be2aso7282450wma.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jan 2022 20:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6xNAMYMaYAPp3PXuZrv8DD4DYUB4vP4tAMMNxf0z2HA=;
 b=LW074f8GDAVJAYmVskQEt5z+fOifDN+aBo1wbNqIFF88INSf3Icf6w9Wy4jLGeO2m+
 KuOPrtMNSPotyc5JACPokMT0N9L/WxbNmUtS7vMO0XMOT4BP9Gk5zXRUd+dL2pJjbai5
 J8ZwSnh9dwgqqAd16rYWdkz+V8BDzut2gXJfvCBaVGu5Kx+q8gHdRWE9Qfz3X/bZcZZX
 jvLqQgElaSX9fDF8KY9cCZzo6FfH2hwB0eCInsL+qmMX5mdOoBoJ/kchQGbNDqs1pmx0
 UCXZ1S2R246RBdFqDwWFpbS3FNSL6IBmyP0zWJHelw1M9aaNOFMDlWP9JVemaChDKOWz
 3NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6xNAMYMaYAPp3PXuZrv8DD4DYUB4vP4tAMMNxf0z2HA=;
 b=qarKCEIeBqSELopN38SkrUblV7SNPg3F+ovZWhB7lthLUWl+67TxFT6SBYN7r/rVMI
 QQt9dqXzEF0joEoRIeDY2V95S3Z4Ka7jnMf+barYdqfTXu01v+rfzlGMEyVx/+erHbKv
 O5DdaScZcF83yTfstSsrER4GEg7JfcK6PiFu+7z1D5faNjbUQMnEJWIPrioDo3ldO6wY
 pmKMAM90PadKnvYFFY1W+psvSHVX2LTtfXyT7/7acppEwCPNvk15kHyrZDb+TJutffb7
 GIwQTjRfap8tYYgs4GyYXzjsmyZ0d3UZJ8X5hHvKCVsaCLhczCpgSKHdvedTfqo1frQT
 TLLw==
X-Gm-Message-State: AOAM5307bnyFcOtJ+V5ueXrNdDegtKiYtWwgKzAYgCXs65cdgorcF9k+
 5i/koeCVJbskuHdmVSQpe0FUhTQNI3HEag==
X-Google-Smtp-Source: ABdhPJycYsmBpusBeV4U+SSO2xbpUJNi0OwVfWyjnV9A11dkvZRqdF+UnQcj1Swvufda10Ee/btrxg==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr14348771wme.51.1643342740908; 
 Thu, 27 Jan 2022 20:05:40 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id i13sm737338wrf.3.2022.01.27.20.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 20:05:40 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Date: Fri, 28 Jan 2022 06:05:11 +0200
Message-Id: <20220128040511.27-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfC7rIs7%2FaAVdcS9@B-P7TQMD6M-0146.local>
References: <YfC7rIs7%2FaAVdcS9@B-P7TQMD6M-0146.local>
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
Cc: Igor Eisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Igor Eisberg <igoreisberg@gmail.com>

* Added tar-like default behaviors for --[no-]preserve options:
  normal user - uses user's owner ID + umask on perms by default;
  root user - preserve original owner IDs + perms by default;
  and add appropriate error message when used without --extract=X.
* "--[no-]same-owner" and "--[no-]same-permissions" were renamed
  to "--[no-]preserve-owner" and "--[no-]preserve-perms" to
  better represent what these options do, the word "same" is
  ambiguous and tells nothing to the user ("same" to what?).
* Added "--[no-]preserve" as shortcuts for both options in one.
* Fixed option descriptions as they had typos and were too ambiguous
  ("extract information" to where? separate file?).
* Added --force option to allow extracting directly to root path.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 104 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 27 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 92e0c76..9080a66 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -18,15 +18,21 @@
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
+	bool superuser;
+	mode_t umask;
 	bool corrupted;
+	u64 physical_blocks;
+	u64 logical_blocks;
 	bool print_comp_ratio;
 	bool check_decomp;
 	char *extract_path;
 	size_t extract_pos;
-	bool overwrite, preserve_owner, preserve_perms;
-	mode_t umask;
-	u64 physical_blocks;
-	u64 logical_blocks;
+	bool force;
+	bool overwrite;
+	bool preserve_owner;
+	bool preserve_perms;
+	bool no_preserve_owner;
+	bool no_preserve_perms;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -34,11 +40,14 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{"extract", optional_argument, 0, 2},
 	{"device", required_argument, 0, 3},
-	{"no-same-owner", no_argument, 0, 4},
-	{"no-same-permissions", no_argument, 0, 5},
-	{"same-owner", no_argument, 0, 6},
-	{"same-permissions", no_argument, 0, 7},
-	{"overwrite", no_argument, 0, 8},
+	{"force", no_argument, 0, 4},
+	{"overwrite", no_argument, 0, 5},
+	{"preserve", no_argument, 0, 6},
+	{"preserve-owner", no_argument, 0, 7},
+	{"preserve-perms", no_argument, 0, 8},
+	{"no-preserve", no_argument, 0, 9},
+	{"no-preserve-owner", no_argument, 0, 10},
+	{"no-preserve-perms", no_argument, 0, 11},
 	{0, 0, 0, 0},
 };
 
@@ -66,11 +75,16 @@ static void usage(void)
 	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
 	      " --help                 display this help and exit\n"
 	      "\nExtraction options (--extract=X is required):\n"
-	      " --no-same-owner        extract files as yourself\n"
-	      " --no-same-permissions  apply the user's umask when extracting permission\n"
-	      " --same-permissions     extract information about file permissions\n"
-	      " --same-owner           extract files about the file ownerships\n"
-	      " --overwrite            if file already exists then overwrite\n"
+	      " --force                allow extracting to root\n"
+	      " --overwrite            overwrite files that already exist\n"
+	      " --preserve             extract with the same ownership and permissions as on the filesystem\n"
+	      "                        (default for superuser)\n"
+	      " --preserve-owner       extract with the same ownership as on the filesystem\n"
+	      " --preserve-perms       extract with the same permissions as on the filesystem\n"
+	      " --no-preserve          extract as yourself and apply user's umask on permissions\n"
+	      "                        (default for ordinary users)\n"
+	      " --no-preserve-owner    extract as yourself\n"
+	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
 	      "\nSupported algorithms are: ", stderr);
 	print_available_decompressors(stderr, ", ");
 }
@@ -121,6 +135,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 					return -ENOMEM;
 				strncpy(fsckcfg.extract_path, optarg, len);
 				fsckcfg.extract_path[len] = '\0';
+				/* if path is root, start writing from position 0 */
+				if (len == 1 && fsckcfg.extract_path[0] == '/')
+					len = 0;
 				fsckcfg.extract_pos = len;
 			}
 			break;
@@ -131,33 +148,62 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			++sbi.extra_devices;
 			break;
 		case 4:
-			fsckcfg.preserve_owner = false;
+			fsckcfg.force = true;
 			break;
 		case 5:
-			fsckcfg.preserve_perms = false;
+			fsckcfg.overwrite = true;
 			break;
 		case 6:
 			fsckcfg.preserve_owner = true;
+			fsckcfg.preserve_perms = true;
+			fsckcfg.no_preserve_owner = false;
+			fsckcfg.no_preserve_perms = false;
 			break;
 		case 7:
-			fsckcfg.preserve_perms = true;
+			fsckcfg.preserve_owner = true;
+			fsckcfg.no_preserve_owner = false;
 			break;
 		case 8:
-			fsckcfg.overwrite = true;
+			fsckcfg.preserve_perms = true;
+			fsckcfg.no_preserve_perms = false;
+			break;
+		case 9:
+			fsckcfg.no_preserve_owner = true;
+			fsckcfg.no_preserve_perms = true;
+			fsckcfg.preserve_owner = false;
+			fsckcfg.preserve_perms = false;
+			break;
+		case 10:
+			fsckcfg.no_preserve_owner = true;
+			fsckcfg.preserve_owner = false;
+			break;
+		case 11:
+			fsckcfg.no_preserve_perms = true;
+			fsckcfg.preserve_perms = false;
 			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
+	if (fsckcfg.extract_path) {
+		if (!fsckcfg.extract_pos && !fsckcfg.force) {
+			erofs_err("--extract=/ must be used together with --force");
+			return -EINVAL;
+		}
+	} else {
+		if (fsckcfg.force)
+			erofs_err("--force must be used together with --extract=X");
+		if (fsckcfg.overwrite)
+			erofs_err("--overwrite must be used together with --extract=X");
+		if (fsckcfg.preserve_owner || fsckcfg.preserve_perms ||
+			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms)
+			erofs_err("--[no-]preserve[-owner/-perms] must be used together with --extract=X");
+	}
+
 	if (optind >= argc)
 		return -EINVAL;
 
-	if (!fsckcfg.extract_path)
-		if (fsckcfg.overwrite || fsckcfg.preserve_owner ||
-		    fsckcfg.preserve_perms)
-			return -EINVAL;
-
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
@@ -680,13 +726,19 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 
+	fsckcfg.superuser = geteuid() == 0;
+	fsckcfg.umask = umask(0);
 	fsckcfg.corrupted = false;
+	fsckcfg.logical_blocks = 0;
+	fsckcfg.physical_blocks = 0;
 	fsckcfg.print_comp_ratio = false;
 	fsckcfg.check_decomp = false;
 	fsckcfg.extract_path = NULL;
 	fsckcfg.extract_pos = 0;
-	fsckcfg.logical_blocks = 0;
-	fsckcfg.physical_blocks = 0;
+	fsckcfg.force = false;
+	fsckcfg.overwrite = false;
+	fsckcfg.preserve_owner = fsckcfg.superuser;
+	fsckcfg.preserve_perms = fsckcfg.superuser;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
@@ -695,8 +747,6 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	fsckcfg.umask = umask(0);
-
 	err = dev_open_ro(cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
-- 
2.30.2

