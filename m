Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17241972B
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 17:04:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJ5X94jwMz2yP4
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 01:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VfRZuSU7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VfRZuSU7; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJ5X62zC1z2yNG
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 01:04:38 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98AA060F39;
 Mon, 27 Sep 2021 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632755074;
 bh=b2HdKqkcg6NIgG6DMMGzcRadtZa0atOxMYXsFFzNw60=;
 h=From:To:Cc:Subject:Date:From;
 b=VfRZuSU7Gzx/J/wogUJ5nPjwTUMcjWcr1gHSOxcwWrc/dT+gNuA/mcK/bqJnTbg3k
 f94D5n5Z/5jt7axi9IDJakPT8gGd9AG6XECYa6eGzd0xcgqsp7fMql7yYuzzcoR0NE
 xPYdrr6XgTnn7RwmjvcNQSGzARMGc4X5mPEn7ohybsoeIyn6ThRMjNO6NKktj/FkBH
 nEHi3i9g7OVO9fxMEJG3tk+BuDohCNZjbk/37m+7StIY1LS9XxqbQLdeIwR25nHY0m
 hriW/ZqEOntsycKxdu9NlNXmACPKOaOEZs5V236Mndl+jhHvreb3E3hheMP2ItOsTQ
 Gk+AWnmRYGVWg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: mkfs: rearrange arguments
Date: Mon, 27 Sep 2021 23:03:59 +0800
Message-Id: <20210927150401.14305-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

1) rearrange usage();
2) rearrange argument list.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
some minor cleanups.

 mkfs/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b61205dac91a..beba6eb8b905 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -72,16 +72,18 @@ static void usage(void)
 {
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
-	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
-	      " -C#                   specify the size of compress physical cluster in bytes\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
+	      " -C#                   specify the size of compress physical cluster in bytes\n"
 	      " -EX[,...]             X=extended options\n"
 	      " -T#                   set a fixed UNIX timestamp # to all files\n"
 #ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
 #endif
-	      " --chunksize=X         generate chunk-based files with X-byte chunks\n"
+	      " --all-root            make all files owned by root\n"
+	      " --chunksize=#         generate chunk-based files with #-byte chunks\n"
+	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
 	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
@@ -89,10 +91,8 @@ static void usage(void)
 #endif
 	      " --force-uid=#         set all file uids to # (# = UID)\n"
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
-	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
-	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -180,7 +180,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while ((opt = getopt_long(argc, argv, "d:x:z:E:T:U:C:",
+	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
-- 
2.20.1

