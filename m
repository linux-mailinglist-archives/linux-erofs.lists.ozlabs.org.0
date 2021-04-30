Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C636F4C1
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 06:03:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWdz1076kz300c
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 14:03:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XDK/RqYY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XDK/RqYY; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWdyy5gfzz2yy4
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Apr 2021 14:03:54 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881C5611AC;
 Fri, 30 Apr 2021 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619755432;
 bh=LdzSLi7PgoSn/22ipbiZLp8yzYiOPTRphKu5v+e6W5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XDK/RqYYIgYU3S3QA79q6AaG1jKZx+r0B3fJz5WHG5AggXuyfEAnIW8Obc/xsqxPF
 TpiIDH+c1vNItbIRqReWmTOve0g/Gu5OMibEbzXOEySTrIXJ8PUA30cTgWhS3hkpKP
 Whmug96bh01ki9+eLAgV7RJEle9zoaHn+aqnfScDcybUb0gWqCYck21sT0Ou1XukBt
 RuhoZY3wou9VglbsBlGB2HFlIgvOxzjgS+uRrRSMwTsZMoFY0hakuGMVECcwQjChpY
 pup8SV3ZrXCXIBUete7StsTLPkjdJoWQU1MNDVn7vadsaSva5vBhmES3tUYceYKvzQ
 eZAwzKbPxU8VQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v4 2/5] erofs-utils: warn out experimental big pcluster
Date: Fri, 30 Apr 2021 12:03:42 +0800
Message-Id: <20210430040345.17120-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430040345.17120-1-xiang@kernel.org>
References: <20210430040345.17120-1-xiang@kernel.org>
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

It's still an experimental feature for now. Also set the default
logging level to 2 in order to print warn messages.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c   | 2 ++
 lib/config.c     | 2 +-
 man/mkfs.erofs.1 | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 654286d3f33e..b8bb89e7ae9d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -619,6 +619,8 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (!cfg.c_legacy_compress)
 			mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+
+		erofs_warn("EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
 	}
 	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
 					  algorithmtype[0];
diff --git a/lib/config.c b/lib/config.c
index d733cc366794..bc0afa284807 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -17,7 +17,7 @@ void erofs_init_configure(void)
 {
 	memset(&cfg, 0, sizeof(cfg));
 
-	cfg.c_dbg_lvl  = 0;
+	cfg.c_dbg_lvl  = 2;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
 	cfg.c_compr_level_master = -1;
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 254c3ec4de41..2520b6a08974 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -25,7 +25,8 @@ Set an algorithm for file compression, which can be set with an optional
 compression level separated by a comma.
 .TP
 .BI "\-d " #
-Specify the level of debugging messages. The default is 0.
+Specify the level of debugging messages. The default is 2, which shows basic
+warning messages.
 .TP
 .BI "\-x " #
 Specify the upper limit of an xattr which is still inlined. The default is 2.
-- 
2.20.1

