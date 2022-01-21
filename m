Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84049575F
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 01:31:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jg0gD023cz30Nj
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 11:31:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=L3jdfmM5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535;
 helo=mail-ed1-x535.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=L3jdfmM5; dkim-atps=neutral
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jg0g46cgkz2xtW
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jan 2022 11:31:26 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id m11so35755379edi.13
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jan 2022 16:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Cqb7Eg6QqK5TrUXNImxN4kTqSyYttOlcI9fgmYM/s8=;
 b=L3jdfmM5ngLXMKzs1rnYuC/D23NRK+FPV4okwkbmAxW7u8kt5Eiq8lL0dNv3ywxleL
 +jyB7VclzSJ3A8qdZPPgUgtxcqotT94oo62Frx4HQcOOjt0AaeyB7aeCAoKXIZv1T1Ru
 Q+OrJnSU0QFEkz9oQo9O9sG1HPfCb7+hQvrC0xJDyIX8VxZSdZXB7jaXS63vDjlFYBIS
 V3cqaJemO79eMp/9dlJrhHdwddAKTD0DEWYMlNWr8gaE5e8Le0k+GbAehiZKkSPzxZeL
 qWYNWHZMScWcFhQHttdLkFk7NZEW6EY9KSb1kb0UbuCE+8PpvQ1ESBxDv2CQa187sj7I
 fecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Cqb7Eg6QqK5TrUXNImxN4kTqSyYttOlcI9fgmYM/s8=;
 b=bMJjg5eASe1GmQGZJdfu4wHhO+cpyQm7Or8J+EbG+zUtIeV2YkmgE6GCoLLo1DABzC
 hCD3IIfJd63f/WUEJQ0KksZakOciF9ubH6FMv29aP4ytjs7jRiKceMCDWrop6VBF5QS2
 NuoprQ9SXucKF3dX3Md+EouKOeimp5oIN+5/pn9UsfoaWhsb4UWkDEaPLu0mmqH+Ihp8
 bfcXB6CRS6rEjdf/la76ZMU3EcIxQnKy/4lOqVlCpisExSVeIFiwvHkicGGCz+I4pqgZ
 s3fsHzpYIzRlaAW/44xIQhjFI4FD1qIavZWdXsaUZtNzy+s7GhmrwpPiyB6QL+pqfxAa
 AiDQ==
X-Gm-Message-State: AOAM53277EKCw3BCng2V4cqt80y2a6HyJafzZkyN4ZqygXPhBC5iMTjz
 5kiMNfjrhWxGBCWf36/3I/ImSTLb3tOIDmlU
X-Google-Smtp-Source: ABdhPJyJgS8JewW5NnLC95v5bk23m5yUxka6Y3IJlbk0ioEpwdAaMm+uKGuJ6VCBlMc3K8BnL7pT8A==
X-Received: by 2002:a17:906:d542:: with SMTP id
 cr2mr1243879ejc.720.1642725079828; 
 Thu, 20 Jan 2022 16:31:19 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id d16sm1489713ejy.135.2022.01.20.16.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 16:31:19 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Date: Fri, 21 Jan 2022 02:31:16 +0200
Message-Id: <20220121003116.135-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Have to disagree with some changes made to my original patch.
1) Using tar options makes no sense here, since tar has default
   behaviors set for normal user (uses user's owner ID + perms)
   vs. root user (preserve original owner IDs + perms by default),
   and the options were there to override that preset behavior.
   fsck doesn't have any default behavior set, and the default
   values for preserve_owner and preserve_perms were left for
   the compiler to decide. This change sets the default values
   to false explicitly.
   "--no-same-owner" and "--no-same-permissions" are completely
   redundant in fsck's case, unlike tar.
   * "--same-owner" and "--same-permissions" were renamed to
     "--preserve-owner" and "--preserve-perms" to better represent
     what these options do, the word "same" is ambiguous and tells
     nothing to the user ("same" to what?).
   * Added "--preserve" as a shortcut for both options in one.
   * Fixed option descriptions as they had typos and were too
     ambiguous ("extract information" to where? separate file?).
2) Errors for chmod 0700 were not logged, failures were silent.
3) --extract=/ should fail with a proper error due to it being
   dangerous if used with sudo.

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 62 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 14534b9..e2f4157 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -18,15 +18,17 @@
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
-	bool corrupted;
 	bool print_comp_ratio;
 	bool check_decomp;
 	char *extract_path;
 	size_t extract_pos;
-	bool overwrite, preserve_owner, preserve_perms;
+	bool overwrite;
+	bool preserve_owner;
+	bool preserve_perms;
 	mode_t umask;
 	u64 physical_blocks;
 	u64 logical_blocks;
+	bool corrupted;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -34,11 +36,10 @@ static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{"extract", optional_argument, 0, 2},
 	{"device", required_argument, 0, 3},
-	{"no-same-owner", no_argument, 0, 4},
-	{"no-same-permissions", no_argument, 0, 5},
-	{"same-owner", no_argument, 0, 6},
-	{"same-permissions", no_argument, 0, 7},
-	{"overwrite", no_argument, 0, 8},
+	{"overwrite", no_argument, 0, 4},
+	{"preserve", no_argument, 0, 5},
+	{"preserve-owner", no_argument, 0, 6},
+	{"preserve-perms", no_argument, 0, 7},
 	{0, 0, 0, 0},
 };
 
@@ -66,11 +67,10 @@ static void usage(void)
 	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
 	      " --help                 display this help and exit\n"
 	      "\nExtraction options (--extract=X is required):\n"
-	      " --no-same-owner        extract files as yourself\n"
-	      " --no-same-permissions  apply the user's umask when extracting permission\n"
-	      " --same-permissions     extract information about file permissions\n"
-	      " --same-owner           extract files about the file ownerships\n"
-	      " --overwrite            if file already exists then overwrite\n"
+	      " --overwrite            overwrite files that already exist\n"
+	      " --preserve             extract with original ownerships and permissions\n"
+	      " --preserve-owner       extract with original ownerships only\n"
+	      " --preserve-perms       extract with original permissions only\n"
 	      "\nSupported algorithms are: ", stderr);
 	print_available_decompressors(stderr, ", ");
 }
@@ -112,10 +112,16 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				if (len == 0)
 					return -EINVAL;
 
-				/* remove trailing slashes except root */
-				while (len > 1 && optarg[len - 1] == '/')
+				/* remove trailing slashes */
+				while (len > 0 && optarg[len - 1] == '/')
 					len--;
 
+				/* extracting directly to root is dangerous */
+				if (len == 0) {
+					erofs_err("invalid extract path: /");
+					return -EINVAL;
+				}
+
 				fsckcfg.extract_path = malloc(PATH_MAX);
 				if (!fsckcfg.extract_path)
 					return -ENOMEM;
@@ -131,10 +137,11 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			++sbi.extra_devices;
 			break;
 		case 4:
-			fsckcfg.preserve_owner = false;
+			fsckcfg.overwrite = true;
 			break;
 		case 5:
-			fsckcfg.preserve_perms = false;
+			fsckcfg.preserve_owner = true;
+			fsckcfg.preserve_perms = true;
 			break;
 		case 6:
 			fsckcfg.preserve_owner = true;
@@ -142,9 +149,6 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 7:
 			fsckcfg.preserve_perms = true;
 			break;
-		case 8:
-			fsckcfg.overwrite = true;
-			break;
 		default:
 			return -EINVAL;
 		}
@@ -465,7 +469,7 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 		struct stat st;
 
 		if (errno != EEXIST) {
-			erofs_err("failed to create directory %s: %s",
+			erofs_err("failed to create directory: %s (%s)",
 				  fsckcfg.extract_path, strerror(errno));
 			return -errno;
 		}
@@ -481,8 +485,11 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
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
@@ -510,6 +517,8 @@ again:
 				}
 			} else if (errno == EACCES &&
 				   chmod(fsckcfg.extract_path, 0700) < 0) {
+					erofs_err("failed to set permissions: %s (%s)",
+						  fsckcfg.extract_path, strerror(errno));
 				return -errno;
 			}
 			tryagain = false;
@@ -680,13 +689,13 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 
-	fsckcfg.corrupted = false;
 	fsckcfg.print_comp_ratio = false;
 	fsckcfg.check_decomp = false;
 	fsckcfg.extract_path = NULL;
 	fsckcfg.extract_pos = 0;
-	fsckcfg.logical_blocks = 0;
-	fsckcfg.physical_blocks = 0;
+	fsckcfg.overwrite = false;
+	fsckcfg.preserve_owner = false;
+	fsckcfg.preserve_perms = false;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
@@ -696,6 +705,9 @@ int main(int argc, char **argv)
 	}
 
 	fsckcfg.umask = umask(0);
+	fsckcfg.logical_blocks = 0;
+	fsckcfg.physical_blocks = 0;
+	fsckcfg.corrupted = false;
 
 	err = dev_open_ro(cfg.c_img_path);
 	if (err) {
@@ -725,7 +737,7 @@ int main(int argc, char **argv)
 		if (!fsckcfg.extract_path)
 			erofs_info("No error found");
 		else
-			erofs_info("Extract data successfully");
+			erofs_info("Filesystem extracted successfully");
 
 		if (fsckcfg.print_comp_ratio) {
 			double comp_ratio =
-- 
2.30.2

