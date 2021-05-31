Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C763960E3
	for <lists+linux-erofs@lfdr.de>; Mon, 31 May 2021 16:31:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FtyQt65sBz3034
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Jun 2021 00:31:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dE33RrLo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dE33RrLo; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FtyQp5xJSz2xb8
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Jun 2021 00:31:30 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C88E7613CD;
 Mon, 31 May 2021 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622471488;
 bh=XHFPme1XmJV9ot/IC076HNyxaCjxfWE60OefRveS2iE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dE33RrLoHP4IoaM3AtcN4OAPXxGGrTMdhZoUxcYkbVbBuOB1FLX2gARYtXvWnb5/k
 A74qMJItyXYRqCQUFQ/yhHItxXhoHyV/yqquRipSRvfAG7+3/6jomYQ5K40JfRDiFi
 EDw3h1vUh1TKRu0YUhXTvbx952g4+odS9q+uQe8sRzYreu1wpQVQxENaiuxd3wCIMd
 qNiwZCAF5SjUm+c7F5JTNVXdeq4Q4oTrVoirQjsbVcdeZt255OjfR5v2Jl9BNZhAEA
 1z1rVlj5u0rlT+MzMAK1aaxbGgjuHS1eEhUL1XJNAPoWZjcgSaRwDEXlaV4KHc5xtJ
 5fwSmysX7AIpw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: support limit max decompressed extent size
Date: Mon, 31 May 2021 22:31:17 +0800
Message-Id: <20210531143117.6327-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531143117.6327-1-xiang@kernel.org>
References: <20210531143117.6327-1-xiang@kernel.org>
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

Currently, some data pattern (e.g. zeroed data) could cause very
high CR with EROFS. However, for such extreme high C/R compressed
pclusters, the kernel side hasn't optimize such cases yet (such as
decompressing such pclusters fully in advance.)

Alternatively, let's add support to limit each decompressed extent
size for now.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/config.h |  1 +
 lib/compress.c         |  2 +-
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  3 +++
 mkfs/main.c            | 11 +++++++++++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 21bd25e886e6..d140a735bd49 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,6 +58,7 @@ struct erofs_configure {
 	int c_inline_xattr_tolerance;
 
 	u32 c_physical_clusterblks;
+	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
 #ifdef WITH_ANDROID
diff --git a/lib/compress.c b/lib/compress.c
index 1b847ce27c2f..2093bfd68b71 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -184,7 +184,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 			}
 		}
 
-		count = len;
+		count = min(len, cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, pclustersize);
diff --git a/lib/config.c b/lib/config.c
index bc0afa284807..99fcf498f178 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -27,6 +27,7 @@ void erofs_init_configure(void)
 	cfg.c_uid = -1;
 	cfg.c_gid = -1;
 	cfg.c_physical_clusterblks = 1;
+	cfg.c_max_decompressed_extent_bytes = -1;
 }
 
 void erofs_show_config(void)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 4f2e43565799..d164fa51fe17 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -85,6 +85,9 @@ Make all files owned by root.
 .TP
 .B \-\-help
 Display this help and exit.
+.TP
+.B \-\-max-extent-bytes #
+Specify maximum decompressed extent size # in bytes.
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
diff --git a/mkfs/main.c b/mkfs/main.c
index b2a4cba1d2f5..e476189f0731 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -42,6 +42,7 @@ static struct option long_options[] = {
 #ifndef NDEBUG
 	{"random-pclusterblks", no_argument, NULL, 8},
 #endif
+	{"max-extent-bytes", required_argument, NULL, 9},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
@@ -85,6 +86,7 @@ static void usage(void)
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
 	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
+	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -268,6 +270,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_random_pclusterblks = true;
 			break;
 #endif
+		case 9:
+			cfg.c_max_decompressed_extent_bytes =
+				strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid maximum uncompressed extent size %s",
+					  optarg);
+				return -EINVAL;
+			}
+			break;
 #ifdef WITH_ANDROID
 		case 10:
 			cfg.mount_point = optarg;
-- 
2.20.1

