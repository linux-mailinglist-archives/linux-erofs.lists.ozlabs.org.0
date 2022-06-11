Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6C5472D7
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 10:23:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKrSt6tZNz3c00
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 18:23:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Zvb3Zjai;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Zvb3Zjai;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKrSp0LVgz3bnV
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 18:23:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE60611C6
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 08:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8921C34116;
	Sat, 11 Jun 2022 08:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654935813;
	bh=lorDQmV36ovS2gj//3UEGcfxdLB4WFes3ACLD83oKvY=;
	h=From:To:Cc:Subject:Date:From;
	b=Zvb3Zjaig6Rm1dGAsF00/o8RKYnk26+7Oz6XQEc0GZ/PW/DlraSbPm5KNO4AINekU
	 xOXFB7tQVSE4wphaF43UcCdmdgPdCSo4dM2a/VtdDSak02tMR5si6gDyj0tVoVOpx6
	 HS5Wl1Lrqx2M3EqT3SnrAqn2H5+KelrJqhSA2h1U7vcnXS7wAKN0/9QzmwTxl49hx8
	 uV8yMMG3QroQH1tGDkgBHOvQpQjlDBVRPLNtOGiuzlqkO6KQ/58lio81BTfwKl4aXw
	 v9Y7yrJAm5GjcnDwjKsPN9CuVVmNt1S+sbj3EU+xIgrHzRTPuUJNYKWfgzeNIGrLN+
	 BoqyoOAHZYN/Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: introduce `--preserve-mtime'
Date: Sat, 11 Jun 2022 16:22:48 +0800
Message-Id: <20220611082248.338369-1-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the past versions, `-Eforce-inode-compact' worked since timestamps
were ignored.  Currently, since we don't ignore mtime by default any
more, `-Eforce-inode-compact' fails and that breaks compatibility.

Let's fix `-Eforce-inode-compact' to ignore mtime as the past versions
did, also add another option `--preserve-mtime' for this.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/mkfs.erofs.1 | 4 ++++
 mkfs/main.c      | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d61e33e..6017760 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -119,6 +119,10 @@ can reduce total metadata size.
 .TP
 .BI "\-\-max-extent-bytes " #
 Specify maximum decompressed extent size # in bytes.
+.TP
+.B "\-\-preserve-mtime"
+File modification time is preserved whenever \fBmkfs.erofs\fR decides to use
+extended inodes over compact inodes.
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index 9d43cd4..54a3fed 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -50,6 +50,7 @@ static struct option long_options[] = {
 	{"quiet", no_argument, 0, 12},
 	{"blobdev", required_argument, NULL, 13},
 	{"ignore-mtime", no_argument, NULL, 14},
+	{"preserve-mtime", no_argument, NULL, 15},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -158,6 +159,7 @@ static int parse_extended_opts(const char *opts)
 			if (vallen)
 				return -EINVAL;
 			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
+			cfg.c_ignore_mtime = true;
 		}
 
 		if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
@@ -377,6 +379,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 14:
 			cfg.c_ignore_mtime = true;
 			break;
+		case 15:
+			cfg.c_ignore_mtime = false;
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.30.2

