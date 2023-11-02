Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B37DFB0D
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Nov 2023 20:41:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLvQK63vZz3ck3
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Nov 2023 06:41:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukeshu.com (client-ip=104.207.138.63; helo=mav.lukeshu.com; envelope-from=lukeshu@lukeshu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 596 seconds by postgrey-1.37 at boromir; Fri, 03 Nov 2023 06:41:41 AEDT
Received: from mav.lukeshu.com (mav.lukeshu.com [104.207.138.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLvQF3VBSz3bv3
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Nov 2023 06:41:41 +1100 (AEDT)
Received: from lukeshu-thinkpad-e15 (unknown [IPv6:2601:281:8200:4f:aee0:10ff:fe55:8023])
	by mav.lukeshu.com (Postfix) with ESMTPSA id B928D80626;
	Thu,  2 Nov 2023 15:31:44 -0400 (EDT)
From: "Luke T. Shumaker" <lukeshu@lukeshu.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: fsck: Add -a, -A, and -y flags
Date: Thu,  2 Nov 2023 13:31:22 -0600
Message-ID: <20231102193122.140921-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102193122.140921-1-lukeshu@lukeshu.com>
References: <20231102193122.140921-1-lukeshu@lukeshu.com>
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
Cc: "Luke T. Shumaker" <lukeshu@umorpha.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Luke T. Shumaker" <lukeshu@umorpha.io>

Other fsck.${filesystem} commands generally take -a or -p and
sometimes -A to automatically repair a filesystem, and -y to either
repair agree to all prompts about repairing.

For example:

 - fsck.ext{2,3,4} takes -a or -p to repair, and -y to agree
 - fsck.xfs takes -y to repair; and -a, -A, or -p to silence a warning
   about repairing
 - fsck.btrfs takes -a, -A, -p, or -y to silence a warning about repairing

So, like fsck.btrfs, we should accept these flags as no-ops, for
compatibility with programs that expect to be able to pass these to
fsck.  In particular, Arch Linux's mkinitcpio (when fsck is enabled)
unconditionally passes -a to `fsck`.

Naturally, I'd have liked to include '-p' in the list, but it already
does something different for fsck.erofs.  I'd like to call out the
fsck.ext4 manual, which says:

       -a   This option does the same thing as the -p option. It is
            provided for backwards compatibility only; it is
            suggested that people use -p option whenever possible.

Signed-off-by: Luke T. Shumaker <lukeshu@umorpha.io>
---
 fsck/main.c      | 8 +++++++-
 man/fsck.erofs.1 | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index aeea892..26cd131 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -98,6 +98,8 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		"\n"
+		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
+		"\n"
 		"Extraction options (--extract=X is required):\n"
 		" --force                allow extracting to root\n"
 		" --overwrite            overwrite files that already exist\n"
@@ -124,7 +126,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	int opt, ret;
 	bool has_opt_preserve = false;
 
-	while ((opt = getopt_long(argc, argv, "Vd:ph",
+	while ((opt = getopt_long(argc, argv, "Vd:phaAy",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'V':
@@ -144,6 +146,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		case 'h':
 			usage(argc, argv);
 			exit(0);
+		case 'a':
+		case 'A':
+		case 'y':
+			break;
 		case 2:
 			fsckcfg.check_decomp = true;
 			if (optarg) {
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index a226995..c94fff9 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -34,6 +34,10 @@ so it might take too much time depending on the image.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
+.TP
+\fB\-a\fR, \fB\-A\fR, \fB-y\R
+These options do nothing at all; they are provided only for compatibility with
+the fsck programs of other filesystems.
 .SH AUTHOR
 This version of \fBfsck.erofs\fR is written by
 Daeho Jeong <daehojeong@google.com>.
-- 
2.42.0

