Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F304D16F5A9
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 03:32:15 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48S0F91XcszDqYb
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 13:32:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48S0Dr42h1zDqF6
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 13:31:55 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 48639CE6B3828CDC0B36;
 Wed, 26 Feb 2020 10:31:50 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Feb
 2020 10:31:40 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 3/3] erofs: handle corrupted images whose decompressed size
 less than it'd be
Date: Wed, 26 Feb 2020 10:30:11 +0800
Message-ID: <20200226023011.103798-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226023011.103798-1-gaoxiang25@huawei.com>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Lasse pointed out, "Looking at fs/erofs/decompress.c,
the return value from LZ4_decompress_safe_partial is only
checked for negative value to catch errors. ... So if
I understood it correctly, if there is bad data whose
uncompressed size is much less than it should be, it can
leave part of the output buffer untouched and expose the
previous data as the file content. "

Let's fix it now.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c77cec4327fa..be8d9adef236 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -165,14 +165,18 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		ret = LZ4_decompress_safe(src + inputmargin, out,
 					  inlen, rq->outputsize);
 
-	if (ret < 0) {
-		erofs_err(rq->sb, "failed to decompress, in[%u, %u] out[%u]",
-			  inlen, inputmargin, rq->outputsize);
+	if (ret != rq->outputsize) {
+		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+			  ret, inlen, inputmargin, rq->outputsize);
+
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, inlen, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
+
+		if (ret >= 0)
+			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EIO;
 	}
 
-- 
2.17.1

