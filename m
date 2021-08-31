Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CC3FCBD7
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 18:51:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzYBB0g7qz2yMx
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 02:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=fFlGcI0v;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fFlGcI0v; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzYB032Qjz2yJl
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 02:51:36 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id y23so17348505pgi.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4torBFRZ1CBRByTLYN5YK7ivHTRZs03N6tDudVMC5DQ=;
 b=fFlGcI0vCa0wrIGy1IWCHIhvPgs1SMdR+jfRDATLCY3+TZKNmwRqPbYenGaB938UBD
 mDKlC6V942KOkinhieNoGew4jdOnMlwRG0prnOuqLxoag+HzIw+1nKWUPAw2M0q1iLNg
 kqRkNhksSOyaKmPzTHeeZy/4x8hev/7irxYO26fYwNubgEe0D53gz3L6H5Jp9qNQJ6qc
 684p7OA+PtaV4k0Q7InkWM54rtDoMkaYWH2RGXSJRRHNDsdLGVqpKAuNlF40bx6diOAh
 Qz5bZnescPkvHxJaHauFsv1APghSw4NEaRFGxX+LaMaI4obNIKXjXQMKYKE5oeIoum63
 TjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4torBFRZ1CBRByTLYN5YK7ivHTRZs03N6tDudVMC5DQ=;
 b=rnMscAaqQaeAHxYEMl80GL5yomHyth7m83YB00knpOdsYK+Z9YQhNyHfTf7oQfKFmZ
 XvrAv7l4tQm4tJg/5Yvacg08Jo+n1EV5bOsW9DQd2h0sOzPTjQ7twEQST8lBXMiqVlTQ
 BUa42P4LKf9JTI4TB7Kv7I2u9aaNLjRFrLxUX8ZZbJsgqTPS3fGxZiCuEgNZEjsC4bF8
 d9RbxRKKqme3xEZdHo5/f32Hl67RrM2HuRkQk10iW2g6ks1odOe6qlQWKpjUZDqjIJ8E
 lNEHLmw/vW41ij34IeLDEU8+8GCcXklaBKGYCFZwZ3ekDgFkcDQH1AzkD1N5RVwiQVcN
 vaSA==
X-Gm-Message-State: AOAM5320CZoQbjYu0M8OBdAk7+0dF0lfLsb//bLrGYtVe47Hhh+Iwxms
 JQAChZ1AXzZGH5yJz4sbVqLXKJYLKH/Q0Q==
X-Google-Smtp-Source: ABdhPJyXJMOs9NnWhgszPHrxpQzR5ONWHlK7sLTUg0fiP6A1UdEnIUjt37Xcgkaj+804Kz9ylyExBQ==
X-Received: by 2002:a63:4e5a:: with SMTP id o26mr27825959pgl.19.1630428693586; 
 Tue, 31 Aug 2021 09:51:33 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id u6sm20697487pgr.3.2021.08.31.09.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:51:33 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: remove unnecessary codes and comments
Date: Wed,  1 Sep 2021 00:51:15 +0800
Message-Id: <20210831165116.16575-5-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831165116.16575-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
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

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/inode.c | 4 ----
 lib/zmap.c  | 1 -
 2 files changed, 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 62047d3..f001016 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -677,11 +677,7 @@ out:
 		 * Don't leave DATA buffers which were written in the global
 		 * buffer list. It will make balloc() slowly.
 		 */
-#if 0
-		bh->op = &erofs_drop_directly_bhops;
-#else
 		erofs_bdrop(bh, false);
-#endif
 		inode->bh_data = NULL;
 	}
 	return 0;
diff --git a/lib/zmap.c b/lib/zmap.c
index fdc84af..88da515 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -423,7 +423,6 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 			goto err_bonus_cblkcnt;
 		if (m->compressedlcs)
 			break;
-		/* fallthrough */
 	default:
 		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
 			  lcn, vi->nid | 0ULL);
-- 
2.25.1

