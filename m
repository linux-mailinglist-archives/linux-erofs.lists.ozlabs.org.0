Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F28414FF
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 22:16:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=owLk9BdI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TP1Lj4H6Nz30Q3
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jan 2024 08:16:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=owLk9BdI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=efficios.com (client-ip=167.114.26.122; helo=smtpout.efficios.com; envelope-from=mathieu.desnoyers@efficios.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 542 seconds by postgrey-1.37 at boromir; Tue, 30 Jan 2024 08:16:02 AEDT
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TP1LV5TTRz2ykZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jan 2024 08:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562410;
	bh=/LtPwfaY3uvi/uQueiJk5XQ5+25aOGLyhq5zZA6ahe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owLk9BdIvYMqzPMeQbF2d7yNSH3zTkRUuREg1aXHoA5/oKPsRDPqPidgGmIGg+ZMe
	 uDiNO1/hYtcLl6AbcYMjONTAvJEsm6nwxQqyLcdJ/rEInjNK7h/7xuu18NXQG94k5M
	 nDpyHDrTa9Es9c9pzOQ+TFHsELADk92a4djW5vooUTinmDn2l9YfYZTRGedTlpDb1b
	 MI3xshUjIJfHBa1pLt/SmgLF6goBo2TIOsc/su8NScSwzwbLdoBVSgvIlqpOTOOubM
	 FokMDNIjPddKGnlVW51N6DyLGp3GD1P7ThIgTTI/7EBNQcDz6UZ9lqZkBEx0WblNU7
	 uTSeb4zKuNrPw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17t029YzVXW;
	Mon, 29 Jan 2024 16:06:49 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [RFC PATCH 3/7] erofs: Use dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:27 -0500
Message-Id: <20240129210631.193493-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
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
Cc: linux-arch@vger.kernel.org, nvdimm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Yue Hu <huyue2@coolpad.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-cxl@vger.kernel.org, linux-erofs@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use dax_is_supported() to validate whether the architecture has
virtually aliased data caches at mount time.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches
(ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Yue Hu <huyue2@coolpad.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
---
 fs/erofs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..bd88221f1ad7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -419,9 +419,13 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
-#ifdef CONFIG_FS_DAX
 	struct erofs_fs_context *ctx = fc->fs_private;
 
+	if (!dax_is_supported()) {
+		errorfc(fc, "dax options not supported");
+		return false;
+	}
+
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
@@ -436,10 +440,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 		DBG_BUGON(1);
 		return false;
 	}
-#else
-	errorfc(fc, "dax options not supported");
-	return false;
-#endif
 }
 
 static int erofs_fc_parse_param(struct fs_context *fc,
-- 
2.39.2

