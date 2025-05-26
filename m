Return-Path: <linux-erofs+bounces-367-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C1AC40B5
	for <lists+linux-erofs@lfdr.de>; Mon, 26 May 2025 15:51:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5ccK2w3sz2xXP;
	Mon, 26 May 2025 23:51:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=90.154.21.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748267473;
	cv=none; b=GJ+29ovPs8A51axJ35S0VnH5Vdu8PcBK5kJfE9xuazei+IumfqmzBAmlTuPW6Q193ct8HoaL00ZKH+9XgSLZCLWfEwk4QrxooeUifok6tdeODS9VgquZJ1EGyQpnXXh1Y9XBs9bMe6TEZRh31TxbjVQKbHgxcIz/rq6cmgC0XhW7BENdHvd+kXlfIMXSya/vUUNrszP2ZBdnViLKswlm0WSvLThBl2G/ypIEm4Kr9wKKv3CPBBfwfSGEipVsa8W95auwLRP3hgnRpJbflKH4VKDAEosmYqlcxQh91RTdYVZeZf3+OkuYCQS6UafhLTKi47o+GN+cLtySroRCMORTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748267473; c=relaxed/relaxed;
	bh=83JgehcwjsMcP7cCjNsED6CTcbJgtfZpXPQ0xsndF9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkVIT8JdoZXse5qAQhsg3SNniQRugl7uohcfUljKCg4w1cLdJeCdhzd9zDRPabGLsKAgbGTZTC0/EOTIhar2VB27T/evTeS9EApDyGzTMBFlf7lh6+l2doEGJ2nxaYvtKneus72hFlaVTF1WP4sGcAOBI5wyRT/FHJXWJgeTZtY1Ck8/a+tTL6weh57n7byinnhSaCiDM+AUf+2IXtvzlpyCgzlaeuRXSIygRFMhi4X31zCuNI6/OJrZkcbQRSKaD9Yq8rivgF574F5zriGijzn33x9tJUbzmHRkM23CXa28tFQrlZXYTDJZCAQ6s8D9Ph5pHXWWN4o9V9CgfqA/Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass (client-ip=90.154.21.10; helo=mx01.omp.ru; envelope-from=d.privalov@omp.ru; receiver=lists.ozlabs.org) smtp.mailfrom=omp.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=omp.ru (client-ip=90.154.21.10; helo=mx01.omp.ru; envelope-from=d.privalov@omp.ru; receiver=lists.ozlabs.org)
X-Greylist: delayed 911 seconds by postgrey-1.37 at boromir; Mon, 26 May 2025 23:51:10 AEST
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b5ccG5npyz2xTh
	for <linux-erofs@lists.ozlabs.org>; Mon, 26 May 2025 23:51:07 +1000 (AEST)
Received: from localhost.localdomain (188.234.28.56) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 26 May
 2025 16:35:39 +0300
From: d.privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dmitriy Privalov <d.privalov@omp.ru>
Subject: [PATCH 6.1 1/1] erofs: get rid of z_erofs_fill_inode()
Date: Mon, 26 May 2025 16:34:35 +0300
Message-ID: <20250526133435.47105-1-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [188.234.28.56]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 05/26/2025 13:24:02
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 193597 [May 26 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: d.privalov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 59 0.3.59
 65f85e645735101144875e459092aa877af15aaa
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 188.234.28.56 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 188.234.28.56
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/26/2025 13:27:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/26/2025 10:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 4fdadd5b0f0c723c812842454f8cca1619f2e731 upstream.

Prior to big pclusters, non-compact compression indexes could have
empty headers.

Let's just avoid the legacy path since it can be handled properly
as a specific compression header with z_erofs_fill_inode_lazy() too.

Tested with erofs-utils exist versions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230413092241.73829-1-hsiangkao@linux.alibaba.com
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
 fs/erofs/inode.c    | 12 ++++++++----
 fs/erofs/internal.h |  2 --
 fs/erofs/zmap.c     | 18 ------------------
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7dcf350b9fef9..550b93fd12031 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -283,11 +283,15 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+#ifdef CONFIG_EROFS_FS_ZIP
 		if (!erofs_is_fscache_mode(inode->i_sb) &&
-		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
-			err = z_erofs_fill_inode(inode);
-		else
-			err = -EOPNOTSUPP;
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
+			inode->i_mapping->a_ops = &z_erofs_aops;
+			err = 0;
+			goto out_unlock;
+		}
+#endif
+		err = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d7cd1e619d46f..161317f8fe266 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -425,12 +425,10 @@ enum {
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 #ifdef CONFIG_EROFS_FS_ZIP
-int z_erofs_fill_inode(struct inode *inode);
 int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags);
 #else
-static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
 static inline int z_erofs_map_blocks_iter(struct inode *inode,
 					  struct erofs_map_blocks *map,
 					  int flags)
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 2cd70cf4c8b27..b030a04bdd283 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,24 +7,6 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
-int z_erofs_fill_inode(struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-	if (!erofs_sb_has_big_pcluster(sbi) &&
-	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		vi->z_advise = 0;
-		vi->z_algorithmtype[0] = 0;
-		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
-		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-	}
-	inode->i_mapping->a_ops = &z_erofs_aops;
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-- 
2.34.1


