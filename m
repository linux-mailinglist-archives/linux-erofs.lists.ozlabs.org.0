Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5FA47CA
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:54:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj8B2pTBzDqY5
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:54:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317242;
	bh=dJbMApUE/AJ/NQQwOADqxrTX59zSV6M4jJnLT6sOK3g=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Q9YZCHwlTLsxAUOu6VLfblQdQS19QFEk7/zxtlv7upBxNfl4+0GTgty0+9gVYqm6C
	 uvlwmxfL9EVd6or9vwoQuOUkUBFL6ZfRi3lUOoKdDKd4OI1MBEpdxIc2bBaEBdF/uT
	 IwwxxvSe1dcDzytbAPbTijMzknlFtHBCWNSowDNzqa5zGgbMx/iaUYcsvY4dJfKRbY
	 K5C6uHaUbP+SSMUsrAid6gLA99MJ+eE10jvsiGP6HGieAu/Y9f2LGgfeT4pTzi5QA4
	 SzgtkKMWavp8tYDZ0szQSBY0Dt/yyS7fvjoNvX1PKvswJqm7W1FP7utOmT0/52jDl7
	 dpypDG1QezZ8w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.146; helo=sonic302-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="lKXLPbVP"; 
 dkim-atps=neutral
Received: from sonic302-20.consmr.mail.gq1.yahoo.com
 (sonic302-20.consmr.mail.gq1.yahoo.com [98.137.68.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj7k0B9YzDqsd
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:53:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317216; bh=ySOjUNFL7mo7zveDqU/4Z0wkYe9jEHD2Y9oC7hlElfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=lKXLPbVP7MsQKDx2ZMkJDYW4MKlAWq/2hszjhL99ORwyao0Sw54rfQkcMsBYJPFqFY5JC4wZ2cthIiMw5njQTGXmfpAVUGUGtc1sL7L+5fg57DBlAMdUQ32ceXVrrTI2lkGW/0pLM2UuXqEm0WUWttZ3bAkGrDsfBks4TXp3gYVGl31GUgiyJ0z6z0xvpGaxPV8hGOcyfP+HY4Be9MUiIENhtLhx6oy8VMO0jBRZZogmOtik92r4uSWErOKciDi8SBB15zmZv41v2nCJqOzZSE+AlGyTpmbDU/ALZN5QbaSiWWinDq84XmA/hscZv4zrWCVPZi/B8X3Dl8oH/qTUEg==
X-YMail-OSG: liVo4cgVM1mzDpW09q3IaGaEpUxqUUQHfhJ051r8J5dmSupj5ENTqVC88FQcymW
 SpNx4wrxjbmu8PfBngVpUVEPYwCgvHvTL3P0O09h82pDoRrvvyYjnOT9wABMmTl5UO5agQJv_G04
 UklayXisTNTq2qLTSEdQ8dntzf5jaF4lHGjDynFFvIutbAzC1gP2r1QzdG8IyMPvMN2NtRrUzinp
 C9i1kEuIBlu9U.04RylTlUMiuoZ7CMfeo6R_..HVIFm4XAFMKcTYwskUWBqL0qSL68_ZDNX0r0se
 3k.1z4KauGaZXvemNN7qA8ov7bTP3SsmbZ8GGV9VO2foH57Ns3V5kZm.gK2q69jtOGMuX5bz7TuY
 f1kSQtvn5a5aU3fQLBY4DuDyPEOXjAn9gnuiMu88ntUOBmIM9JsIVv81YpDLAGV1umhB40hUBuL4
 FD6pqib4dYnQcQ8BB2l_r0cOnYqfJjCmUi.kx4z3sii9Aqqij1J348KTsi5Ik5XHSupCPJ_FWZUD
 ewPkJaE.SoVEGZNRN3BV9n.UTGoNbL3HkA8SAmkIcFBdp2YnHZCPFcwceylq2FJ4rjmsn4mFVSDt
 6YjKRhWVTU0sZxvz0UiWMKb7R2YlKXaU5aQnWXEAA2MlgliAKgdfjFZ1omAa3chiFWlk_Aa2ufGE
 C2cQs85X4aPC6i0IBaPpSClVVhGJFajiBp7MPrb.1Hj7CLVIQPnYm78kwbLktDbtkqHFW9.K0m9W
 9W0ta71El4vp9j2slxrV3NzXeloz3H0jM_ApSWX22Km0AmhzUVdahUNX4RyN2nP1zcmLaKGY3VY6
 YOVP8VsuSHuHxH6U6bHkKTqBycl9iAEIlKICOfSGMrgxdHtyPypCEJxD9THxxB8smMC_gBBcjJgj
 DUifdJmhGcdGpUFDMPDBA4ZJKDBB.sDJ5C0v1byI0t3PvqmbkgFsyCFu8vrC7fLhaoykagJKyXwq
 jozOltzGlTjYF0z8aRpJNeCNGDPx_rXPTX789NPv0DDm.FxREQvPuj0egIYkBA4mNdsbv9wznqQu
 PuTVg.E.vCrywjOIyK6WJvh7m_Wim92LDO4CTa5sndT.keJXvb.f_kFlGRJXNLa4KtZU92.qSaOf
 BqhVvYBTR9P1WGdC_6XF6SwClM5cdCgFuTaN3yKNw9PfLdPwKR.fmfcXFBPHoY0qubySvu4w2NKK
 dqrALY6NOxC0AJFIRlwL5vp9MLURwFSa3gSN8ulh9eKxXGIuqEZZOf2mjqH9iTTaOh_e8OJ4n_WQ
 YP.fGI8_li4906TgZnQL8DDwz9kxw0_14UvLjDiPTr7cGP0c-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:36 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:53:32 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 20/21] erofs: kill use_vmap module parameter
Date: Sun,  1 Sep 2019 13:51:29 +0800
Message-Id: <20190901055130.30572-21-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph said [1],
"vm_map_ram is supposed to generally behave better.  So if
it doesn't please report that that to the arch maintainer
and linux-mm so that they can look into the issue.  Having
user make choices of deep down kernel internals is just
a horrible interface.

Please talk to maintainers of other bits of the kernel
if you see issues and / or need enhancements. "

Let's redo the previous conclusion and kill the vmap
approach.

[1] https://lore.kernel.org/r/20190830165533.GA10909@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/erofs.txt |  4 ----
 fs/erofs/decompressor.c             | 12 +-----------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
index c3b5f603b2b6..b0c085326e2e 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -67,10 +67,6 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
                                    It still does in-place I/O decompression
                                    for the rest compressed physical clusters.
 
-Module parameters
-=================
-use_vmap=[0|1]         Use vmap() instead of vm_map_ram() (default 0).
-
 On-disk details
 ===============
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index bb2944c96c89..af273d89e62c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -28,10 +28,6 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
-static bool use_vmap;
-module_param(use_vmap, bool, 0444);
-MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
-
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 					 struct list_head *pagepool)
 {
@@ -224,9 +220,6 @@ static void *erofs_vmap(struct page **pages, unsigned int count)
 {
 	int i = 0;
 
-	if (use_vmap)
-		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
-
 	while (1) {
 		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
 
@@ -240,10 +233,7 @@ static void *erofs_vmap(struct page **pages, unsigned int count)
 
 static void erofs_vunmap(const void *mem, unsigned int count)
 {
-	if (!use_vmap)
-		vm_unmap_ram(mem, count);
-	else
-		vunmap(mem);
+	vm_unmap_ram(mem, count);
 }
 
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
-- 
2.17.1

