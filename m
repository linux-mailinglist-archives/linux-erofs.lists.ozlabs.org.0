Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D1E8B052C
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 10:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713949157;
	bh=3QDRNmAVBJwEI0DjW4Q8QZxGCbMGYjzUHZhHfViYzqA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=GxMFcsxM4Ad+Tx0GelE0/saSLI3JzUNhK+63VMs7yt0ExQj/BEKaSnIJ/X5PqkQFQ
	 Kzcp+ak5MGGX3lQ36PM9JNpULukGnv0NbXBhFdPDZxZO81qRCg0SUc53tZnNzGpVHC
	 ZuKEdeeh4zBnTxM+57NCzttpPReIH2e0f3auY5K+0DOhUlxvX4km6U1q227Il9Xqkc
	 Thfxx1Rq9u3JHfiaB6Eu4tuWMQUV3XaGWVxeJhj5hUJnsIOG5DpUb7fgnOS+mrSnqK
	 qcA7HUOT/9AX2HTABB+LsGL3rj0WmXutGB6gdhrhtuL8A4SPVa0sdlUsdLYTIZJxyA
	 xC53XgRGKICsA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPXwj0MYvz3cP7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 18:59:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPXwY4MYsz3byl
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 18:59:06 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VPXTy0jFYz1j0sv;
	Wed, 24 Apr 2024 16:39:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 14EB518005F;
	Wed, 24 Apr 2024 16:42:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 16:42:37 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH -next] erofs: modify the error message when prepare_ondemand_read failed
Date: Wed, 24 Apr 2024 16:42:47 +0800
Message-ID: <20240424084247.759432-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When prepare_ondemand_read failed, wrong error message is printed.
The prepare_read is also implemented in cachefiles, so we amend it.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8aff1a724805..62da538d91cb 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 		if (WARN_ON(len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-			erofs_err(NULL, "prepare_read failed (source %d)", source);
+			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
 			return -EIO;
 		}
 
-- 
2.34.1

