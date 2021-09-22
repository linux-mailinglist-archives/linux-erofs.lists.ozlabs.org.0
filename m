Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BC415057
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 21:07:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF78x2jHnz2yd6
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 05:07:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF78p6Rtvz2xv8
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 05:07:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0UpG6Nd._1632337649; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpG6Nd._1632337649) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 03:07:31 +0800
Date: Thu, 23 Sep 2021 03:07:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v3 5/5] erofs-utils: mkfs: support chunk-based
 uncompressed files
Message-ID: <YUt+8QDQywCjoQyI@B-P7TQMD6M-0146.local>
References: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
 <20210922185607.49909-6-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922185607.49909-6-hsiangkao@linux.alibaba.com>
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
Cc: Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 23, 2021 at 02:56:07AM +0800, Gao Xiang wrote:
> mkfs support for the new chunk-based uncompressed files,
> including:
>  * chunk-based files with 4-byte block address array;
>  * chunk-based files with 8-byte inode chunk indexes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  include/erofs/blobchunk.h |  18 ++++
>  include/erofs/config.h    |   1 +
>  include/erofs/defs.h      |  77 ++++++++++++++
>  include/erofs/hashtable.h |  77 --------------
>  include/erofs/internal.h  |   1 +
>  include/erofs/io.h        |   2 +
>  lib/Makefile.am           |   2 +-
>  lib/blobchunk.c           | 217 ++++++++++++++++++++++++++++++++++++++
>  lib/inode.c               |  36 +++++--
>  lib/io.c                  |   2 +-
>  man/mkfs.erofs.1          |   3 +
>  mkfs/main.c               |  38 +++++++
>  12 files changed, 389 insertions(+), 85 deletions(-)
>  create mode 100644 include/erofs/blobchunk.h
>  create mode 100644 lib/blobchunk.c
>

Applying following diff to fix up the MacOS build:

diff --git a/configure.ac b/configure.ac
index 9d7d5c2..03387f5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -170,7 +170,8 @@ AC_CHECK_FUNCS(m4_flatten([
 	strdup
 	strerror
 	strrchr
-	strtoull]))
+	strtoull
+	tmpfile64]))
 
 # Configure debug mode
 AS_IF([test "x$enable_debug" != "xno"], [], [
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e05d0cb..725b517 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -208,7 +208,11 @@ void erofs_blob_exit(void)
 
 int erofs_blob_init(void)
 {
+#ifdef HAVE_TMPFILE64
 	blobfile = tmpfile64();
+#else
+	blobfile = tmpfile();
+#endif
 	if (!blobfile)
 		return -ENOMEM;
 
