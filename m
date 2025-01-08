Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7CA05FC1
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Jan 2025 16:15:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSs1T3NyFz3c66
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 02:15:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736349339;
	cv=none; b=aWT84+93rLVVZDJXQCrnKmJXwL+13fCQlHb0hEXKkNkPQcyJ/n90mNltnhYaeoayun3hBI1RK07xuLEfsdogU9JwULNep/+O4g551S/xi2X1Xrcrrsmxj1WL0iuGQSkK3+McBVrt33qTbHckoS1JkTdPCGxFwB31445Kopy49YFYPnfpQR9XJ4gHmJ/3knGGWC/CeywNfIpVVokexGdnKKGxckb2xt1F44NiNLUrQOniqEH0URoih3p6PgPpvvW5xjXOoN1oq8V77BeR6qHNOsg9nIOpXxilzqIowTblouUbhV3iXMWvInZdHd7qxUVRgMLhkmMTyP/Mvoxs3l3frw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736349339; c=relaxed/relaxed;
	bh=rC5m1R1hJhyi1o9ERb1jqfotWwANUnB960DqUUbF3UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhtpTuxwAow5LVCbzo4rD5p1JFBYl47EnE3P4tO6aytWtAep0Y/TXldeaWkexbsggIUO8TZU/sITsqP0cgdEFz9ozwy1agdN+2jWX1d6Y8UgX2nAfMn8u3LfoWLkbBQVIWlIxvt+sFVlilDBGVtPeIzPLJXteSMPeJHtl93gm8mt91tmpn5W9rA1SrNdz+nY5JuBtUBmPLAa8/AzfvLKZNPwgi66plBqm+ICHYvas1+jp0kiQITfos06+BlckP51JUngH/VQDI++tRep/YtiAwn8Svo2jiU9oLyhMpgFXHknjBR7u6mYCL4lmRgh70UZCS+hYl4Eq53qzSoMnkOmxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BrBGmHvP; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BrBGmHvP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSs1P0hPFz30Tt
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 02:15:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736349329; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rC5m1R1hJhyi1o9ERb1jqfotWwANUnB960DqUUbF3UQ=;
	b=BrBGmHvP2Kj+CUkSkpwm8KF8Vg8vW2HZtp2MDfMzNCcXA0QaxV8CUC2aBYYZ4RprxeKF+gzCcY5ZWEhXgiuFDKliw8ZHUS1wBstoEWOcT7zueiJjOqkBMWZnIRqGpdl4cimtVI31CSFYFfXtJ1+QtNqtsQamwLQqEjO1KVQcFTM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNEIvhk_1736349327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 23:15:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y 2/2] erofs: fix PSI memstall accounting
Date: Wed,  8 Jan 2025 23:15:20 +0800
Message-ID: <20250108151520.2515903-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108151520.2515903-1-hsiangkao@linux.alibaba.com>
References: <20250108151520.2515903-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 1a2180f6859c73c674809f9f82e36c94084682ba upstream.

Max Kellermann recently reported psi_group_cpu.tasks[NR_MEMSTALL] is
incorrect in the 6.11.9 kernel.

The root cause appears to be that, since the problematic commit, bio
can be NULL, causing psi_memstall_leave() to be skipped in
z_erofs_submit_queue().

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com
Fixes: 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20241127085236.3538334-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9fa07436a4da..496e4c7c52a4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1730,11 +1730,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
-	if (bio) {
+	if (bio)
 		submit_bio(bio);
-		if (memstall)
-			psi_memstall_leave(&pflags);
-	}
+	if (memstall)
+		psi_memstall_leave(&pflags);
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-- 
2.43.5

