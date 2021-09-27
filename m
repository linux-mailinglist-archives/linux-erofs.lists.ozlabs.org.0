Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B53418EAB
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 07:30:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HHrnC6NWFz2yMy
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 15:30:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HHrn81G0Tz2xth
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Sep 2021 15:30:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uphdb8W_1632720596; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uphdb8W_1632720596) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Sep 2021 13:29:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 4.19.y RESEND] erofs: fix up erofs_lookup tracepoint
Date: Mon, 27 Sep 2021 13:29:54 +0800
Message-Id: <20210927052954.136280-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <163266167710981@kroah.com>
References: <163266167710981@kroah.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 93368aab0efc87288cac65e99c9ed2e0ffc9e7d0 upstream.

Fix up a misuse that the filename pointer isn't always valid in
the ring buffer, and we should copy the content instead.

Link: https://lore.kernel.org/r/20210921143531.81356-1-hsiangkao@linux.alibaba.com
Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
Cc: stable@vger.kernel.org # 4.19+
Reviewed-by: Chao Yu <chao@kernel.org>
[ Gao Xiang: resolve trivial conflicts for 4.19.y. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
add missing upstream commit id...

 drivers/staging/erofs/include/trace/events/erofs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/include/trace/events/erofs.h b/drivers/staging/erofs/include/trace/events/erofs.h
index 5aead93a762f..852c94176d1b 100644
--- a/drivers/staging/erofs/include/trace/events/erofs.h
+++ b/drivers/staging/erofs/include/trace/events/erofs.h
@@ -32,20 +32,20 @@ TRACE_EVENT(erofs_lookup,
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
 		__field(erofs_nid_t,	nid	)
-		__field(const char *,	name	)
+		__string(name,		dentry->d_name.name	)
 		__field(unsigned int,	flags	)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= dir->i_sb->s_dev;
 		__entry->nid	= EROFS_V(dir)->nid;
-		__entry->name	= dentry->d_name.name;
+		__assign_str(name, dentry->d_name.name);
 		__entry->flags	= flags;
 	),
 
 	TP_printk("dev = (%d,%d), pnid = %llu, name:%s, flags:%x",
 		show_dev_nid(__entry),
-		__entry->name,
+		__get_str(name),
 		__entry->flags)
 );
 
-- 
2.24.4

