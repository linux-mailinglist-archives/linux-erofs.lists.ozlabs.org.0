Return-Path: <linux-erofs+bounces-3-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B1A4DC19
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:12:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Y1f0FJWz3blR;
	Tue,  4 Mar 2025 22:12:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.16.41.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741086390;
	cv=none; b=jAknF3cYjBAU8yOwzH/WNNm9BLywIhVNILatm6jRwppZAvorMU5iu8QVHtxlAlSJTvmmSHeX+q/lvoPVHcIiayvNxnx3SSxkIM8qFx8hzlJAKxMJoSsghUUrZpb4+YNsrVHNIA0VJBiU1TmLsPAAK4nnixMsN7QLfAAQtOPd+T8eF1b9spacfMt5qOi5qW4Q46KAWNz0hGQBY4w8TNPwYE2VYAel8IH1zppVrW8JtwPrDKM5qSJ2G0ieRu8D8JYJ0Z9b3yY8zJxmX6HIPvcpx73KY7lHqiJ79iglvwpGUaSwwQEwKGpj1gqHX0FPkZQPLELOuhxxd6UcsK4Uh836kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741086390; c=relaxed/relaxed;
	bh=GBi7kVOERajG15ZmNxA3pI9RIZT9xcj7HjiluG1H8m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igJ8usdFDEOWVOyo9x4tJ1FJ4bJqEX5EZzjAu3BavHD8RTChawn4N0Kjo8n4qq8WMRutmPyOpIgYbIAFi2cpLHziPPKyydKqrGEYUhR7/uhHbVhefSHuRCfibkzVr1pXXRBsOke0URg7+layddnh/pDgkScNECubgWckt8bRKoU2O3fIZL+uYXRZoeegAwZEPi8bLOWu4ERO4G83E9cvya/Arpe7Nq4tYOUvKCf75aiawX82EF0jSXn57T2PhxTjzV3XGilBPzpaO/pwvl+5kuFqFKxd/z5ZPlqhR6y2ZUrdXULYsn/EGH6cDAInOZB3HAr71jzoaF2x9DTDvAR5Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass (client-ip=195.16.41.108; helo=mail-gw02.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org) smtp.mailfrom=astralinux.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=195.16.41.108; helo=mail-gw02.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6XtY0xDqz3bkT
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 22:06:26 +1100 (AEDT)
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 9C0191F9EB;
	Tue,  4 Mar 2025 14:06:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:06:19 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6XtL4skQzkX1p;
	Tue,  4 Mar 2025 14:06:18 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 6.1 2/2] erofs: fix PSI memstall accounting
Date: Tue,  4 Mar 2025 14:05:58 +0300
Message-Id: <20250304110558.8315-3-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250304110558.8315-1-apanov@astralinux.ru>
References: <20250304110558.8315-1-apanov@astralinux.ru>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191452 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

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
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20241127085236.3538334-1-hsiangkao@linux.alibaba.com
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 fs/erofs/zdata.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ac01c0ede7f7..d175b5d0a2f5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1589,11 +1589,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
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
2.39.5


