Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B030499455D
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 12:27:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBzS5QVMz2yZS
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 21:27:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728383250;
	cv=none; b=DOlcwaUbepmq3tMk6ROeg0mUXqexoh3P+3IpURwGADQaG3RtLyxZ6BvCPQRuOtLr3d12jY1102R/OZO9u+qw0lZOqKCQeGIMwPTsmF1Ex8zQlujxR0OMFGxTZ/4xguxbDvhex+qeUci0cn8EyY9FRl4J4KknYenYsIirqsgsdfRb7t4wIv08RUYpc565TexE7BPmlGULdC/qhjLatOFjbgT0bGzgWHQgqhe7ql9th8QMi3aow0UKXAUGM/XdIdZTZl81/D1eCDHlslGK5uZXxmjIBJtSB33Ben0fjXb1Um++erjzqFwOlii3/EYdKSUnYeSkbX4lpDk7KGWiZlgUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728383250; c=relaxed/relaxed;
	bh=0XNY+81f1OZVQcJL8j7OzWyuzEzZXFKWuc4OFJj6CYE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=EUv8BDLiCwiImz7MGHwaHB7suAd/e+1+QW201wZgF4dfCE6EXJeL3C5Ea6v6MSkvPVpP/WF5uh91Hllr7hgiuI/ZNcqLwCtoiOI7QotFr570dOVAIip1ig4FUgrXw2w3HGqaDPpCPNnfPSMkG0SxRaCqZPEBXmQoS+urgxI6MPHbmhMVLwjCh0uXRVITbCWU7TqMGqlhIeCnnRrs3d5abXh+wYqUiAeQNsV0rInhlO259O8SuG21UtsUy4B0veHK6kHcKPP+C9S+WVYRldQcgXAGY7OrLN5KzT0DA6EhFLJLI2JEU0Vg8OkOb7r5XpctcRiLXW2tHJhmWqVjja7Nrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Pu13VMHH; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Pu13VMHH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBzP50h1z2yNJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 21:27:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EF01FA434AE;
	Tue,  8 Oct 2024 10:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77FC4CEC7;
	Tue,  8 Oct 2024 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383247;
	bh=mw5yDHrroQHWGNPvFnFNshEDEL1SdJbrQcrpRKTBDYg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Pu13VMHHK+C8iJxHQKHZVtzeBVd01qGbG3ifnMFK0GBCRxybGVgDn6QTL8OlCalAJ
	 LV76JXOPjLCKVJjV6iHUvuUFs8ftZPmhxBpA7C7vA0c7O6tWvDgLB7He8j7UF0Vp//
	 M81lZcIflvxLSv39zLoTW5x36IbVn2x3pZEFVpDU=
Subject: Patch "erofs: get rid of erofs_inode_datablocks()" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 12:27:19 +0200
In-Reply-To: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
Message-ID: <2024100818-armored-unseated-7994@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: **
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    erofs: get rid of erofs_inode_datablocks()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-get-rid-of-erofs_inode_datablocks.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Oct  8 08:57:30 2024
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue,  8 Oct 2024 14:57:04 +0800
Subject: erofs: get rid of erofs_inode_datablocks()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.

erofs_inode_datablocks() has the only one caller, let's just get
rid of it entirely.  No logic changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Obsoleted EROFS_BLKSIZ impedes efforts to backport
 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")

To avoid further bugfix conflicts due to random EROFS_BLKSIZs
around the whole codebase, just backport the dependencies for 6.1.y.

 fs/erofs/internal.h |    6 ------
 fs/erofs/namei.c    |   18 +++++-------------
 2 files changed, 5 insertions(+), 19 deletions(-)

--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -347,12 +347,6 @@ static inline erofs_off_t erofs_iloc(str
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
-static inline unsigned long erofs_inode_datablocks(struct inode *inode)
-{
-	/* since i_size cannot be changed */
-	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-}
-
 static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
 					  unsigned int bits)
 {
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  */
 #include "xattr.h"
-
 #include <trace/events/erofs.h>
 
 struct erofs_qstr {
@@ -87,19 +86,13 @@ static struct erofs_dirent *find_target_
 	return ERR_PTR(-ENOENT);
 }
 
-static void *find_target_block_classic(struct erofs_buf *target,
-				       struct inode *dir,
-				       struct erofs_qstr *name,
-				       int *_ndirents)
+static void *erofs_find_target_block(struct erofs_buf *target,
+		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
 {
-	unsigned int startprfx, endprfx;
-	int head, back;
+	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
+	unsigned int startprfx = 0, endprfx = 0;
 	void *candidate = ERR_PTR(-ENOENT);
 
-	startprfx = endprfx = 0;
-	head = 0;
-	back = erofs_inode_datablocks(dir) - 1;
-
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
@@ -180,8 +173,7 @@ int erofs_namei(struct inode *dir, const
 	qn.end = name->name + name->len;
 
 	ndirents = 0;
-
-	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
+	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-set-block-size-to-the-on-disk-block-size.patch
queue-6.1/erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
queue-6.1/erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
queue-6.1/erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
queue-6.1/erofs-get-rid-of-erofs_inode_datablocks.patch
