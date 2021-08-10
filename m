Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D38073E5437
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Aug 2021 09:24:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GkPbZ59C4z30Fp
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Aug 2021 17:24:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=kpE7jy+R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kpE7jy+R; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GkPbS2B4yz2xvM
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 Aug 2021 17:24:35 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so3068713pjr.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 Aug 2021 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cYnOcpl3RqojwjJFnnVg8/yScojJWlu8lq+uPSDpFCs=;
 b=kpE7jy+RHLjjTgDUj5ZCNtZFEzhNDgahQds/OSrJZWyhOmabvFIlJIVOzfdPJF/B9P
 r6tO+Ajm1Sj8684aXZxS0vH0hhOpRHjk5Xf7KsRpgPjW5jaLFNx6oNDqmFq8K/VWsmOP
 0Kt28fsAFLXJjxUJbRPXkpMiIKS1wYVYaSeBVyKqTU04etoiMnpk83r7C1PiBGlMWyRj
 3ike4BGfczGrizs9Pf8wtfrgPL0i2ijRLi3bSOhszEcGit2bgxcKDSBei3uyDPyIYDvw
 4XxmBpztEQYAzOmovDM2o0s/GqYDIlsSAPJTmrxmDgq14tE8mMZjgs/zcnl/UljW9ji2
 suEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cYnOcpl3RqojwjJFnnVg8/yScojJWlu8lq+uPSDpFCs=;
 b=FJ91jiLK9/0jo3AMzCLVQRsayt4VXE1F15h8wojb8bu9l0ewTVMUFZyFuah9kNYT55
 a85V7C5k/tBxVfE7NgGdBsfn+I4JTN/NfWbnf6KCmwpjvkRWrRPN279EaAFGG0n0Xenb
 kw0+B7OGzn86CfoRYp0Z9pTWdsgLaGxwyURyaqgYR66c8ma8+xsPugUE0YvavAVuS3J5
 5j7Ac/FcyqhmxklzGrZScXF5KWX63hsH1g2QoJM9mv6dFOfUxE/YabczrRslzKsrLiot
 8ga3bQWSsTUswqgdacBZqdKPTV2bEv1+WqP0Uiz3nzRkZdj575/caJeouJfdD6nUjH6q
 cbUA==
X-Gm-Message-State: AOAM5308ukMBQxvpEMC7FS1eUopQRWbixixoFFkPrc47tr5ZfEqZNV+X
 YU2GhbL9/PSpmf/UlhvoZhM=
X-Google-Smtp-Source: ABdhPJw4PyPIV7cQtAVaumkgLBq8X4eRVCkdZumHP2PheLVmuVa8cZoFBLhJwAZGov6XX9cJdk6VwQ==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr330017pga.403.1628580272230;
 Tue, 10 Aug 2021 00:24:32 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id f4sm27326222pgi.68.2021.08.10.00.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 00:24:31 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove the mapping parameter from
 erofs_try_to_free_cached_page()
Date: Tue, 10 Aug 2021 15:24:16 +0800
Message-Id: <20210810072416.1392-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

The mapping is not used at all, remove it and update related code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/internal.h | 3 +--
 fs/erofs/super.c    | 2 +-
 fs/erofs/zdata.c    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f92e3e3..e21b147 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -442,8 +442,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
-int erofs_try_to_free_cached_page(struct address_space *mapping,
-				  struct page *page);
+int erofs_try_to_free_cached_page(struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bbf3bbd..72fff34 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -430,7 +430,7 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
 
 	if (PagePrivate(page))
-		ret = erofs_try_to_free_cached_page(mapping, page);
+		ret = erofs_try_to_free_cached_page(page);
 
 	return ret;
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a809730..c8e1594 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -337,8 +337,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_try_to_free_cached_page(struct address_space *mapping,
-				  struct page *page)
+int erofs_try_to_free_cached_page(struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
 	int ret = 0;	/* 0 - busy */
-- 
1.9.1

