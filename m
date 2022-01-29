Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD34A3151
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 19:22:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JmN355071z3bYv
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jan 2022 05:22:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nhrtzHW+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630;
 helo=mail-ej1-x630.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=nhrtzHW+; dkim-atps=neutral
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JmN2x0w5wz30R0
 for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jan 2022 05:22:15 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id ah7so27860886ejc.4
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pJ4VEj4SOlkrxi+q9qBA75kta6fq/Yr5DqB2/uC4u2U=;
 b=nhrtzHW+adUu2JzmmFjAn7b2HGrvTNCz0sUFs0dsQQs4DwMbXu/tQQk06o+MzXMYO9
 4yLBB6BSQ2TQaA1c39N+KGW8M0chrXTHSxJSrxDQb7+/dO5M4/v6YEfrNyhGE5jm4xKL
 bw9niYGGw+bL879setYfOECHY30nLo3Hh7rF8AHbE7cfRvuA32K/WLGKBHwb1RdsZR4x
 xV7GukETRlkC8CJ/k+kBKwVX9y7GQiEFRZVJKC2VYT/+OtKFfI1zyJOwifafDRoiI9Ac
 /bCbHv7PS8KK2TZTijTTPm6E4oLCx2YY+79NEUSswPNLg64yWVlTdFBpbHryv+OaSVHI
 AH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pJ4VEj4SOlkrxi+q9qBA75kta6fq/Yr5DqB2/uC4u2U=;
 b=226r2+n8ELLrfrUmBtZ8UkZ8MXN6oDozp282AlDXV6ETNsRfjPjgGAXOVh0rwqjcrd
 7RqJh57/noDcpAr1BYegWwymaSZqFfEixhzBlreqx0Etp/V+G8nJr5Kz6vi133XIK5cG
 bdkMcj2q8cFz66e07aoOkf5m9TYDh+rSoZbdCDppTuarzSWMATYJxneBPpmbboDhZsrh
 dsAy+KD1AZN9SZhkkpGdmLbo3AQ5cnmwx0bcnvGjmwFCur8iNqSdb8iT7hH18d8ZEXgx
 KfgzrqTt8NnwoMF2GwuLwpfJeINe0/5sxakUjuNUfiCEoaM4p11p6X213IO07V3b0epM
 CJ8w==
X-Gm-Message-State: AOAM530F032GERcmCD4f0nZ+s7rw9OjhuVur3cwAUz5bbJRaCLYkBfla
 en8HLfUN1yUrY3lHcM1cGnbgT5NjIY8+HQ==
X-Google-Smtp-Source: ABdhPJzk4SHTz1pwZ20hVGMulbqwFsphfxbDDi9XrNVIRdwHtCV3gMEJNnbSjzNYAgqRmWZjvcIA0A==
X-Received: by 2002:a17:907:2887:: with SMTP id
 em7mr11137237ejc.145.1643480527809; 
 Sat, 29 Jan 2022 10:22:07 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id bo11sm11459502ejb.24.2022.01.29.10.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jan 2022 10:22:07 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Date: Sat, 29 Jan 2022 20:22:04 +0200
Message-Id: <20220129182204.26-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
References: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
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

* Added useful error messages.
* Most errors start with lower-case, let's make all non-summarizing
  error messages lower-case for better consistency.
* Sorted default values in fsck's main function to match the struct.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 dump/main.c |  4 +++-
 fsck/main.c | 44 ++++++++++++++++++++++++++------------------
 mkfs/main.c | 30 ++++++++++++++++--------------
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 0616113..664780b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -162,8 +162,10 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		}
 	}
 
-	if (optind >= argc)
+	if (optind >= argc) {
+		erofs_err("missing argument: IMAGE");
 		return -EINVAL;
+	}
 
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
diff --git a/fsck/main.c b/fsck/main.c
index 5b75ee3..3be5d66 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -122,8 +122,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			if (optarg) {
 				size_t len = strlen(optarg);
 
-				if (len == 0)
+				if (len == 0) {
+					erofs_err("empty value given for --extract=X");
 					return -EINVAL;
+				}
 
 				/* remove trailing slashes except root */
 				while (len > 1 && optarg[len - 1] == '/')
@@ -134,10 +136,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 					return -ENOMEM;
 				strncpy(fsckcfg.extract_path, optarg, len);
 				fsckcfg.extract_path[len] = '\0';
-				/* if path is root, start writing from position 0 */
-				if (len == 1 && fsckcfg.extract_path[0] == '/')
-					len = 0;
-				fsckcfg.extract_pos = len;
+				/* update position only if path is not root */
+				if (len > 1 || fsckcfg.extract_path[0] != '/')
+					fsckcfg.extract_pos = len;
 			}
 			break;
 		case 3:
@@ -201,8 +202,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		}
 	}
 
-	if (optind >= argc)
+	if (optind >= argc) {
+		erofs_err("missing argument: IMAGE");
 		return -EINVAL;
+	}
 
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
@@ -513,7 +516,7 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 		struct stat st;
 
 		if (errno != EEXIST) {
-			erofs_err("failed to create directory %s: %s",
+			erofs_err("failed to create directory: %s (%s)",
 				  fsckcfg.extract_path, strerror(errno));
 			return -errno;
 		}
@@ -529,8 +532,11 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 		 * Try to change permissions of existing directory so
 		 * that we can write to it
 		 */
-		if (chmod(fsckcfg.extract_path, 0700) < 0)
+		if (chmod(fsckcfg.extract_path, 0700) < 0) {
+			erofs_err("failed to set permissions: %s (%s)",
+				  fsckcfg.extract_path, strerror(errno));
 			return -errno;
+		}
 	}
 	return 0;
 }
@@ -552,18 +558,20 @@ again:
 				erofs_warn("try to forcely remove directory %s",
 					   fsckcfg.extract_path);
 				if (rmdir(fsckcfg.extract_path) < 0) {
-					erofs_err("failed to remove: %s",
-						  fsckcfg.extract_path);
+					erofs_err("failed to remove: %s (%s)",
+						  fsckcfg.extract_path, strerror(errno));
 					return -EISDIR;
 				}
 			} else if (errno == EACCES &&
 				   chmod(fsckcfg.extract_path, 0700) < 0) {
+				erofs_err("failed to set permissions: %s (%s)",
+					  fsckcfg.extract_path, strerror(errno));
 				return -errno;
 			}
 			tryagain = false;
 			goto again;
 		}
-		erofs_err("failed to open %s: %s", fsckcfg.extract_path,
+		erofs_err("failed to open: %s (%s)", fsckcfg.extract_path,
 			  strerror(errno));
 		return -errno;
 	}
@@ -728,15 +736,15 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 
-	fsckcfg.superuser = geteuid() == 0;
+	fsckcfg.physical_blocks = 0;
+	fsckcfg.logical_blocks = 0;
+	fsckcfg.extract_path = NULL;
+	fsckcfg.extract_pos = 0;
 	fsckcfg.umask = umask(0);
+	fsckcfg.superuser = geteuid() == 0;
 	fsckcfg.corrupted = false;
-	fsckcfg.logical_blocks = 0;
-	fsckcfg.physical_blocks = 0;
 	fsckcfg.print_comp_ratio = false;
 	fsckcfg.check_decomp = false;
-	fsckcfg.extract_path = NULL;
-	fsckcfg.extract_pos = 0;
 	fsckcfg.force = false;
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
@@ -775,9 +783,9 @@ int main(int argc, char **argv)
 		err = -EFSCORRUPTED;
 	} else if (!err) {
 		if (!fsckcfg.extract_path)
-			erofs_info("No error found");
+			erofs_info("No errors found");
 		else
-			erofs_info("Extract data successfully");
+			erofs_info("Extracted filesystem successfully");
 
 		if (fsckcfg.print_comp_ratio) {
 			double comp_ratio =
diff --git a/mkfs/main.c b/mkfs/main.c
index c755da1..5f241a1 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -381,9 +381,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 
-	if (optind >= argc)
-		return -EINVAL;
-
 	if (cfg.c_blobdev_path && cfg.c_chunkbits < LOG_BLOCK_SIZE) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
@@ -396,24 +393,29 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (optind >= argc) {
+		erofs_err("missing argument: FILE");
+		return -EINVAL;
+	}
+
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
 
 	if (optind >= argc) {
-		erofs_err("Source directory is missing");
+		erofs_err("missing argument: DIRECTORY");
 		return -EINVAL;
 	}
 
 	cfg.c_src_path = realpath(argv[optind++], NULL);
 	if (!cfg.c_src_path) {
-		erofs_err("Failed to parse source directory: %s",
+		erofs_err("failed to parse source directory: %s",
 			  erofs_strerror(-errno));
 		return -ENOENT;
 	}
 
 	if (optind < argc) {
-		erofs_err("Unexpected argument: %s\n", argv[optind]);
+		erofs_err("unexpected argument: %s\n", argv[optind]);
 		return -EINVAL;
 	}
 	if (quiet)
@@ -456,7 +458,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
-		erofs_err("Failed to allocate memory for sb: %s",
+		erofs_err("failed to allocate memory for sb: %s",
 			  erofs_strerror(-errno));
 		return -ENOMEM;
 	}
@@ -538,7 +540,7 @@ int parse_source_date_epoch(void)
 
 	epoch = strtoull(source_date_epoch, &endptr, 10);
 	if (epoch == -1ULL || *endptr != '\0') {
-		erofs_err("Environment variable $SOURCE_DATE_EPOCH %s is invalid",
+		erofs_err("environment variable $SOURCE_DATE_EPOCH %s is invalid",
 			  source_date_epoch);
 		return -EINVAL;
 	}
@@ -641,34 +643,34 @@ int main(int argc, char **argv)
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
-		erofs_err("Failed to initialize buffers: %s",
+		erofs_err("failed to initialize buffers: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
 	if (err < 0) {
-		erofs_err("Failed to balloon erofs_super_block: %s",
+		erofs_err("failed to balloon erofs_super_block: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
 	err = erofs_load_compress_hints();
 	if (err) {
-		erofs_err("Failed to load compress hints %s",
+		erofs_err("failed to load compress hints %s",
 			  cfg.c_compress_hints_file);
 		goto exit;
 	}
 
 	err = z_erofs_compress_init(sb_bh);
 	if (err) {
-		erofs_err("Failed to initialize compressor: %s",
+		erofs_err("failed to initialize compressor: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
 	err = erofs_generate_devtable();
 	if (err) {
-		erofs_err("Failed to generate device table: %s",
+		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
@@ -681,7 +683,7 @@ int main(int argc, char **argv)
 
 	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
 	if (err) {
-		erofs_err("Failed to build shared xattrs: %s",
+		erofs_err("failed to build shared xattrs: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
-- 
2.30.2

