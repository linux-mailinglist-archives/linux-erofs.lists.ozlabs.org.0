Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FE36F4C4
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 06:04:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWdz76jmkz302c
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 14:04:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IDiwiPEQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IDiwiPEQ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWdz61GFFz2yyj
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Apr 2021 14:04:01 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4DBF61441;
 Fri, 30 Apr 2021 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619755440;
 bh=H8mgb1DnwAxCW49sTNCp4fxCn6yzcQzu1iqc2tKfnOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IDiwiPEQUjh5wN11i1aX3PKK7fL26VILxWzaEN+RNpTewWe2sF6/y0qAklPStOW1w
 HYaNnXgzKPbQjo0dx/hQTPgS5jwRPTRa2X3M7RcAgwk1PS50p/DWNYNKRaKH2xjHQB
 z2TXE1/yaHLYga8LA7fpwVibmR4XRAMPG9MkJpMXd9TEViw11HKS+oz38KX0R5zsms
 i+AX6gJ4R57WQoCJxSIXMb6JEN9KQeGufeA0iiMCTdiZ92JLT/EdAyWnIaL/nx2os+
 /lZzGyCfI2M0VIpaxybGQ9LlRzO+Rla4BkuufEb0zsTsoct6FMO9lD+iDFCIM+LQ+J
 Sk0/SgacdAGNw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v4 5/5] erofs-utils: manpage: add manual for erofsfuse
Date: Fri, 30 Apr 2021 12:03:45 +0800
Message-Id: <20210430040345.17120-5-xiang@kernel.org>
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

This patch adds missing erofsfuse manpage.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/erofsfuse.1 | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 man/erofsfuse.1

diff --git a/man/erofsfuse.1 b/man/erofsfuse.1
new file mode 100644
index 000000000000..6bd48b0460bd
--- /dev/null
+++ b/man/erofsfuse.1
@@ -0,0 +1,44 @@
+.\" Copyright (c) 2021 Gao Xiang <xiang@kernel.org>
+.\"
+.TH EROFSFUSE 1
+.SH NAME
+erofsfuse \- FUSE file system client for erofs file system
+.SH SYNOPSIS
+\fBerofsfuse\fR [\fIOPTIONS\fR] \fIDEVICE\fR \fIMOUNTPOINT\fR
+.SH DESCRIPTION
+.B erofsfuse
+is a FUSE file system client that supports reading from devices or image files
+containing erofs file system.
+.SH OPTIONS
+.SS "general options:"
+.TP
+\fB\-o\fR opt,[opt...]
+mount options
+.TP
+\fB\-h\fR   \fB\-\-help\fR
+display help and exit
+.SS "erofsfuse options:"
+.TP
+.BI "\-\-dbglevel=" #
+Specify the level of debugging messages. The default is 2, which shows basic
+warning messages.
+.SS "FUSE options:"
+.TP
+\fB-d -o\fR debug
+enable debug output (implies -f)
+.TP
+\fB-f\fR
+foreground operation
+.TP
+\fB-s\fR
+disable multi-threaded operation
+.P
+For other FUSE options please see
+.BR mount.fuse (8)
+or see the output of
+.I erofsfuse \-\-help
+.SH AVAILABILITY
+\fBerofsfuse\fR is part of erofs-utils package and is available from
+git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
+.SH SEE ALSO
+.BR mount.fuse (8)
-- 
2.20.1

