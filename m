Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B348D1044
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 15:36:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pFcW3Yt3zDqPQ
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 00:36:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="1b46ONSY"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pFcP2mknzDqKr
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 00:36:37 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F669218AC;
 Wed,  9 Oct 2019 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570628194;
 bh=+D4UF3hV/kRLw66Q15N/rJWnp9fYqSLUWeQ+frUnXus=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=1b46ONSYNdw4UNvyL7slZ0/q6x4zsn+6NQxcZHjX4XagF/aOrbbnQuuNKM4PXigKC
 oy3WHwfUyVRo+zYXp5f8ak/BEs2bpHVmpv+4MOLLeWLMv/6wmkSWgEToFSTVlvx0IK
 FsNTtueDdpQlOiEuNI/8cHvqbm/WlLzihXiJZPyU=
Subject: Patch "staging: erofs: add two missing erofs_workgroup_put for
 corrupted images" has been added to the 4.19-stable tree
To: 20190819103426.87579-4-gaoxiang25@huawei.com, gaoxiang25@huawei.com,
 gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, miaoxie@huawei.com,
 yuchao0@huawei.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Oct 2019 15:36:22 +0200
In-Reply-To: <20191009101239.195587-3-gaoxiang25@huawei.com>
Message-ID: <15706281822828@kroah.com>
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

    staging: erofs: add two missing erofs_workgroup_put for corrupted images

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     staging-erofs-add-two-missing-erofs_workgroup_put-for-corrupted-images.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed 09 Oct 2019 03:26:06 PM CEST
From: Gao Xiang <gaoxiang25@huawei.com>
Date: Wed, 9 Oct 2019 18:12:38 +0800
Subject: staging: erofs: add two missing erofs_workgroup_put for corrupted images
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <20191009101239.195587-3-gaoxiang25@huawei.com>

From: Gao Xiang <gaoxiang25@huawei.com>

commit 138e1a0990e80db486ab9f6c06bd5c01f9a97999 upstream.

As reported by erofs-utils fuzzer, these error handling
path will be entered to handle corrupted images.

Lack of erofs_workgroup_puts will cause unmounting
unsuccessfully.

Fix these return values to EFSCORRUPTED as well.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-4-gaoxiang25@huawei.com
[ Gao Xiang: Older kernel versions don't have length validity check
             and EFSCORRUPTED, thus backport pageofs check for now. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_vle.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -311,7 +311,11 @@ z_erofs_vle_work_lookup(struct super_blo
 	/* if multiref is disabled, `primary' is always true */
 	primary = true;
 
-	DBG_BUGON(work->pageofs != pageofs);
+	if (work->pageofs != pageofs) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(egrp);
+		return ERR_PTR(-EIO);
+	}
 
 	/*
 	 * lock must be taken first to avoid grp->next == NIL between


Patches currently in stable-queue which might be from gaoxiang25@huawei.com are

queue-4.19/staging-erofs-fix-an-error-handling-in-erofs_readdir.patch
queue-4.19/staging-erofs-detect-potential-multiref-due-to-corrupted-images.patch
queue-4.19/staging-erofs-some-compressed-cluster-should-be-submitted-for-corrupted-images.patch
queue-4.19/staging-erofs-add-two-missing-erofs_workgroup_put-for-corrupted-images.patch
