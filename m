Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF9D1001
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 15:27:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pFPv0D2QzDqLq
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 00:27:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="0B7UVdev"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pFPh185xzDqKq
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 00:27:20 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61915218DE;
 Wed,  9 Oct 2019 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570627637;
 bh=WwDDvSvraps9ciVLSl8VsuQOGydQQjhVL47eDig+Vbw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=0B7UVdevyCEuLA0nSVYC0Qeh2WGOAC6hz8LWl107LcNlxGD217FepR9Uu1P6VW+Is
 zH4jcr5QOTiEyzNB5u6IrOno9+UP6TIl0rDLXqLX1sqzG+vIG6fnWDokxi5tw02zYa
 Ak/H6WX3A32+LyZcnLA0hd0U9qn1VLvVz7ol66YI=
Subject: Patch "staging: erofs: avoid endless loop of invalid lookback
 distance 0" has been added to the 5.3-stable tree
To: 20190819103426.87579-7-gaoxiang25@huawei.com, gaoxiang25@huawei.com,
 gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, miaoxie@huawei.com,
 yuchao0@huawei.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Oct 2019 15:27:07 +0200
In-Reply-To: <20191009100554.165048-4-gaoxiang25@huawei.com>
Message-ID: <1570627627187166@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    staging: erofs: avoid endless loop of invalid lookback distance 0

to the 5.3-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     staging-erofs-avoid-endless-loop-of-invalid-lookback-distance-0.patch
and it can be found in the queue-5.3 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed 09 Oct 2019 03:24:16 PM CEST
From: Gao Xiang <gaoxiang25@huawei.com>
Date: Wed, 9 Oct 2019 18:05:53 +0800
Subject: staging: erofs: avoid endless loop of invalid lookback distance 0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <20191009100554.165048-4-gaoxiang25@huawei.com>

From: Gao Xiang <gaoxiang25@huawei.com>

commit 598bb8913d015150b7734b55443c0e53e7189fc7 upstream.

As reported by erofs-utils fuzzer, Lookback distance should
be a positive number, so it should be actually looked back
rather than spinning.

Fixes: 02827e1796b3 ("staging: erofs: add erofs_map_blocks_iter")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-7-gaoxiang25@huawei.com
[ Gao Xiang: Since earlier kernels don't define EFSCORRUPTED,
             let's use EIO instead. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/zmap.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -350,6 +350,12 @@ static int vle_extent_lookback(struct z_
 
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (!m->delta[0]) {
+			errln("invalid lookback distance 0 at nid %llu",
+			      vi->nid);
+			DBG_BUGON(1);
+			return -EIO;
+		}
 		return vle_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;


Patches currently in stable-queue which might be from gaoxiang25@huawei.com are

queue-5.3/staging-erofs-fix-an-error-handling-in-erofs_readdir.patch
queue-5.3/staging-erofs-detect-potential-multiref-due-to-corrupted-images.patch
queue-5.3/staging-erofs-avoid-endless-loop-of-invalid-lookback-distance-0.patch
queue-5.3/staging-erofs-some-compressed-cluster-should-be-submitted-for-corrupted-images.patch
queue-5.3/staging-erofs-add-two-missing-erofs_workgroup_put-for-corrupted-images.patch
