Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76041973F
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 17:06:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJ5Yh1Rdrz2yP6
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 01:06:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BxgWcpr+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BxgWcpr+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJ5Yd4hSLz2yHT
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 01:05:57 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA73C60FF2;
 Mon, 27 Sep 2021 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632755155;
 bh=hx1+VULmm1eomNuVscHO4OBOMjXe8+RUoTlQZqix6Ls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BxgWcpr+G0JCd2CxOq5tmbt1C+A+xOh9+2Bz7jeHPHeSx+0z6kZ5x8izxJIHkWiqj
 fDuRHbcekhP3UPO2DzVrcTwh5qqjDSw7cCGvXrQ1AV5hPDqes6NujHGBnxaP8NoOdB
 OFLRMmrW3Md69yQz49tFRHevbDytpJi3rfAMa8IynrzEP6+jhDqDIkLw09WU07lW+g
 xaOcQGcKPRXRjY0gLIGOD56RmnXYSVUdHUBWYiwAFBI6oyFGm9Bb1Tm5VkLnetMQmU
 JoHZ+qZPVHQNlZn93ugmEhHvdScRJaAm0i1gb3glqqQwPiVYa9FH3ktPw82GCikj1d
 kis+Oink0h+eQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: manpage: fix style
Date: Mon, 27 Sep 2021 23:04:01 +0800
Message-Id: <20210927150401.14305-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927150401.14305-1-xiang@kernel.org>
References: <20210927150401.14305-1-xiang@kernel.org>
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

Fix some style in mkfs.erofs.1

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/mkfs.erofs.1 | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 3c250c118168..c7829c3f1c8f 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -63,6 +63,23 @@ Set the universally unique identifier (UUID) of the filesystem to
 The format of the UUID is a series of hex digits separated by hyphens,
 like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
 .TP
+.B \-\-all-root
+Make all files owned by root.
+.TP
+.BI "\-\-chunksize " #
+Generate chunk-based files with #-byte chunks.
+.TP
+.BI "\-\-compress-hints " file
+If the optional
+.BI "\-\-compress-hints " file
+argument is given,
+.B mkfs.erofs
+uses it to apply the per-file compression strategy. Each line is defined by
+tokens separated by spaces in the following form:
+.RS 1.2i
+<pcluster-in-bytes> <match-pattern>
+.RE
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple `--exclude-path' options.
@@ -80,28 +97,11 @@ Set all file uids to \fIUID\fR.
 .BI "\-\-force-gid=" GID
 Set all file gids to \fIGID\fR.
 .TP
-.B \-\-all-root
-Make all files owned by root.
-.TP
-.BI "\-\-chunksize " #
-Generate chunk-based files with #-byte chunks.
-.TP
 .B \-\-help
 Display this help and exit.
 .TP
-.B \-\-max-extent-bytes #
+.BI "\-\-max-extent-bytes " #
 Specify maximum decompressed extent size # in bytes.
-.TP
-.BI "\-\-compress-hints " file
-If the optional
-.BI "\-\-compress-hints " file
-argument is given,
-.B mkfs.erofs
-uses it to apply the per-file compression strategy. Each line is defined by
-tokens separated by spaces in the following form:
-.RS 1.2i
-<pcluster-in-bytes> <match-pattern>
-.RE
 .SH AUTHOR
 This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
 Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
-- 
2.20.1

