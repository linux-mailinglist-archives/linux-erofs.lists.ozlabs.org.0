Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F47592849
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 05:54:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M5gQd1r7qz3bXg
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 13:54:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660535689;
	bh=fwX1TCIyTWz0xP+8ZOwpknPc5c76aXBpni2Nn8yl60A=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=myd1ozpeaRKGcT1I/pCIzlluOvjXU0Gg9akt+F2WV8XEo8cn5wQjC2lE6cDvQEh0g
	 xIron7gvMKGacNAbQwGXTFsAoLCRgQKn6hhnLu1HQFkil0LfcEZqK0bV16dxjb6acv
	 f57cE0ug22MI21DnmKaTsc6uejzkDtm1RHLoTadjZg7+I4g9iFGlm/8sJ8ejKjYBtT
	 k2qTgmxULXoJp5+xNXVfkRMlA2CLVsS36LR45LiEyNvnjKRy+KmCrbP37smd4+8NFN
	 ji/ooszTwk2DGvD2a5wc2R03ffDJvdZ7rQMVpja19OAeXsWU8l01l/JIipzql3Pq5v
	 HHumwmJVpoHKg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=sunke32@huawei.com; receiver=<UNKNOWN>)
X-Greylist: delayed 1059 seconds by postgrey-1.36 at boromir; Mon, 15 Aug 2022 13:54:40 AEST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M5gQS2Yw8z2xGJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Aug 2022 13:54:37 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M5fy643rpz1M88V;
	Mon, 15 Aug 2022 11:33:34 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:36:52 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 11:36:51 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH] erofs: fix error return code in erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Date: Mon, 15 Aug 2022 11:48:29 +0800
Message-ID: <20220815034829.3940803-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
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
From: Sun Ke via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sun Ke <sunke32@huawei.com>
Cc: kernel-janitors@vger.kernel.org, sunke32@huawei.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If erofs_fscache_alloc_request fail and then goto out, it will return 0.
it should return a negative error code instead of 0.

Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 fs/erofs/fscache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..b5fd9d71e67f 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -222,8 +222,10 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 
 	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
-	if (IS_ERR(rreq))
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
 		goto out;
+	}
 
 	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
 				rreq, mdev.m_pa);
@@ -301,8 +303,10 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 
 	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
-	if (IS_ERR(rreq))
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
 		goto out_unlock;
+	}
 
 	pstart = mdev.m_pa + (pos - map.m_la);
 	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-- 
2.31.1

