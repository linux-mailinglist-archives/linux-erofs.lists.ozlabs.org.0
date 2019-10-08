Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F1035CFA7D
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 14:54:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ncjw0YtfzDqPn
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 23:54:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ncj54tjLzDqKS
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2019 23:53:29 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EE9D35AAA5101B890E4B;
 Tue,  8 Oct 2019 20:53:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH for-next 5/5] erofs: set iowait for sync decompression
Date: Tue, 8 Oct 2019 20:56:16 +0800
Message-ID: <20191008125616.183715-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For those tasks waiting I/O for sync decompression,
they should be better marked as IO wait state.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 878449f11665..be3c79421dba 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1282,8 +1282,8 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 		return;
 
 	/* wait until all bios are completed */
-	wait_event(io[JQ_SUBMIT].u.wait,
-		   !atomic_read(&io[JQ_SUBMIT].pending_bios));
+	io_wait_event(io[JQ_SUBMIT].u.wait,
+		      !atomic_read(&io[JQ_SUBMIT].pending_bios));
 
 	/* let's synchronous decompression */
 	z_erofs_vle_unzip_all(&io[JQ_SUBMIT], pagepool);
-- 
2.17.1

