Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EF38D38E
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 06:35:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fn9dQ5pzNz30Bw
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 14:35:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e2/1Heut;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=e2/1Heut; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fn9dM0YH4z3092
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 May 2021 14:35:35 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 534AE6135A;
 Sat, 22 May 2021 04:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621658133;
 bh=B1BX5/qa2/rXh6xtG12TvS5xPlx4NgAqLBiASeDCMUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e2/1HeutM9+RWhYbJp7KDar8EBHrO9ynnedLISPjtPc8kwWTnA9B/B3/SRAMGur0E
 BKPuAcdzDUw+mhsePsVK6S7LvesprZcneFZNjnGC2DsEXJ54UkVgrWteb0XQ0Y6+wX
 NE0rsva+wikSQ5Wgh7za/RRUIsQt4a2eCsk8z7XdR0uXb7QXi9/jlqqSLbFAuHk2y2
 n07eV17bjWWs23mdrHRM6MPj3fC0/xlWD2deS3ntlKJbJHemaq6ppq1BhqOWEvlX57
 zuk2y/bpmFEzFBTEL7+7zV4gh2sF7YuUqzUmdYrNFOngga4CIBUyhQhX4CrBSvhd7a
 ir6DtLiGSPCBw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: support randomizing pclusterblks in
 debugging mode
Date: Sat, 22 May 2021 12:35:02 +0800
Message-Id: <20210522043502.11975-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210522043502.11975-1-xiang@kernel.org>
References: <20210522043502.11975-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's used for big pcluster selftest.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/config.h |  3 +++
 lib/compress.c         |  4 ++++
 mkfs/main.c            | 50 +++++++++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e2f6541f1d1f..21bd25e886e6 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -40,6 +40,9 @@ struct erofs_configure {
 	int c_dbg_lvl;
 	bool c_dry_run;
 	bool c_legacy_compress;
+#ifndef NDEBUG
+	bool c_random_pclusterblks;
+#endif
 	char c_timeinherit;
 
 #ifdef HAVE_LIBSELINUX
diff --git a/lib/compress.c b/lib/compress.c
index 2f83198202ba..1b847ce27c2f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -152,6 +152,10 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 /* TODO: apply per-(sub)file strategies here */
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
+#ifndef NDEBUG
+	if (cfg.c_random_pclusterblks)
+		return 1 + rand() % cfg.c_physical_clusterblks;
+#endif
 	return cfg.c_physical_clusterblks;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 3e0f64eb2d31..b2a4cba1d2f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -39,6 +39,9 @@ static struct option long_options[] = {
 	{"force-uid", required_argument, NULL, 5},
 	{"force-gid", required_argument, NULL, 6},
 	{"all-root", no_argument, NULL, 7},
+#ifndef NDEBUG
+	{"random-pclusterblks", no_argument, NULL, 8},
+#endif
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
@@ -64,29 +67,32 @@ static void usage(void)
 {
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
-	      " -zX[,Y]            X=compressor (Y=compression level, optional)\n"
-	      " -C#                specify the size of compress physical cluster in bytes\n"
-	      " -d#                set output message level to # (maximum 9)\n"
-	      " -x#                set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
-	      " -EX[,...]          X=extended options\n"
-	      " -T#                set a fixed UNIX timestamp # to all files\n"
+	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
+	      " -C#                   specify the size of compress physical cluster in bytes\n"
+	      " -d#                   set output message level to # (maximum 9)\n"
+	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+	      " -EX[,...]             X=extended options\n"
+	      " -T#                   set a fixed UNIX timestamp # to all files\n"
 #ifdef HAVE_LIBUUID
-	      " -UX                use a given filesystem UUID\n"
+	      " -UX                   use a given filesystem UUID\n"
 #endif
-	      " --exclude-path=X   avoid including file X (X = exact literal path)\n"
-	      " --exclude-regex=X  avoid including files that match X (X = regular expression)\n"
+	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
+	      " --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
-	      " --file-contexts=X  specify a file contexts file to setup selinux labels\n"
+	      " --file-contexts=X     specify a file contexts file to setup selinux labels\n"
+#endif
+	      " --force-uid=#         set all file uids to # (# = UID)\n"
+	      " --force-gid=#         set all file gids to # (# = GID)\n"
+	      " --all-root            make all files owned by root\n"
+	      " --help                display this help and exit\n"
+#ifndef NDEBUG
+	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
-	      " --force-uid=#      set all file uids to # (# = UID)\n"
-	      " --force-gid=#      set all file gids to # (# = GID)\n"
-	      " --all-root         make all files owned by root\n"
-	      " --help             display this help and exit\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
-	      " --mount-point=X    X=prefix of target fs path (default: /)\n"
-	      " --product-out=X    X=product_out directory\n"
-	      " --fs-config-file=X X=fs_config file\n"
+	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
+	      " --product-out=X       X=product_out directory\n"
+	      " --fs-config-file=X    X=fs_config file\n"
 #endif
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
@@ -257,6 +263,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 7:
 			cfg.c_uid = cfg.c_gid = 0;
 			break;
+#ifndef NDEBUG
+		case 8:
+			cfg.c_random_pclusterblks = true;
+			break;
+#endif
 #ifdef WITH_ANDROID
 		case 10:
 			cfg.mount_point = optarg;
@@ -523,7 +534,10 @@ int main(int argc, char **argv)
 
 	erofs_show_config();
 	erofs_set_fs_root(cfg.c_src_path);
-
+#ifndef NDEBUG
+	if (cfg.c_random_pclusterblks)
+		srand(time(NULL));
+#endif
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
-- 
2.20.1

