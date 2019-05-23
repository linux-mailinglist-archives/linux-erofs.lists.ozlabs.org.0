Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BA2754E
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2019 07:03:21 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458cpG0QMFzDqRb
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2019 15:03:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=vivo.com
 (client-ip=59.111.176.12; helo=smtp.qiye.163.com;
 envelope-from=huanglianjun@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
X-Greylist: delayed 339 seconds by postgrey-1.36 at bilbo;
 Thu, 23 May 2019 15:03:11 AEST
Received: from smtp.qiye.163.com (mail-m17612.qiye.163.com [59.111.176.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 458cp70K8czDqRW
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2019 15:03:09 +1000 (AEST)
Received: from localhost (unknown [58.251.74.226])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9638E4220FD;
 Thu, 23 May 2019 12:57:18 +0800 (CST)
Date: Thu, 23 May 2019 12:57:17 +0800
From: Lianjun Huang <huanglianjun@vivo.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com,
 miaoxie@huawei.com, fangwei1@huawei.com
Subject: [PATCH] erofs-utils: fix an uninitialized variable
Message-ID: <20190523045717.GA15346@hlj.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-HM-Spam-Status: e1kIGBQJHllBWU9VSklPS0tLS0xJT0xCSU5ZV1koWUFITzdXWS1ZQUlXWQ
 kOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Ehw5IzkDAwhNChAvPhwS
 UT8aFD5VSlVKTk5DTkNMT0hDTE5IVTMWGhIXVRMOGhUcFxIaFREOFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOSlVMT1VJSU1ZV1kIAVlBSkhMTjcG
X-HM-Tid: 0a6ae30cf61b93b9kuws9638e4220fd
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
Cc: huanglianjun@vivo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This fixes a building failure caused by using a variable before initialization.

Signed-off-by: Lianjun Huang <huanglianjun@vivo.com>
---
 mkfs/erofs_cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/erofs_cache.c b/mkfs/erofs_cache.c
index 5bb293b..0d7acf7 100644
--- a/mkfs/erofs_cache.c
+++ b/mkfs/erofs_cache.c
@@ -142,7 +142,7 @@ int erofs_flush_all_blocks(void)
 	char *erofs_blk_buf;
 	char *pbuf;
 	int count;
-	int ret;
+	int ret = 0;
 
 	erofs_blk_buf = malloc(EROFS_BLKSIZE);
 	if (!erofs_blk_buf)
-- 
1.7.9.5

