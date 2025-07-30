Return-Path: <linux-erofs+bounces-723-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1960B15AF9
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 10:55:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsQz62y54z3bkg;
	Wed, 30 Jul 2025 18:55:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753865730;
	cv=none; b=fPctZsdkEpvguONIrwyQZfSis7fYgwPQ/kd8TRfsl/bFHkzGMJVaO534XEDegVzAs0TxAMivKWautsYoaQr6uIEd1/aa+ytSuC6IKDQGJr1WXSEPHQsL4DovDBE6LsICMA3Er9dYVWX58WDEZxGmdOxLBULSh98g2+VQPVWIsFwyT8+ZP0Kliv7PXlfsGfq2NGByMCeTF3SJdWc+lIU0iwwIzKzsX1dZuMPJKYo8S//ibSSadnbfEtXC1o0t/fg7PMzlgN+O5seSlrg3CUq99PTfV8bkardfi4lhiYwZmhd48xdBrN9RU8avAPG3zi77UvusNcQUak7d8vAu8RLqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753865730; c=relaxed/relaxed;
	bh=pbiMs0bsY4BA5sP3Ya1fNtanThx9a0MbMLubqKe9p8M=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=N0y52cBbVxsWnr3qCSuzDLgjPrMYp0BVM3L8xMj3TMpdsCLIaoG8b23LcC3N1tvjfK+VgfBk8Zu8NnVMsPslokynIkXnetsOg3uaNAmikBgIVs6qjkeUx0jJKychgMmz74znnq6Ih1UQ7aGJ90U2bZCeRfmOnxBqCpOeNDFpygq/F8LdO5bX2unugGKB8nwtNtxlAwwgSToIetRTBH+Fc0PuZ9L0+4WwSGh0bu4h6GzYimNw/cZzxOlf0A32weqsuW39pc6Jr+T/ymVMhAom3wk3C6cX88jx1dk02kGG23UE2swb17L0Yajg6GCAmcqPXUfqMPWjwKGbTbrVEw6XEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pd09s1iM; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pd09s1iM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsQz54SDQz2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 18:55:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 75135A551DD;
	Wed, 30 Jul 2025 08:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38AFC4CEE7;
	Wed, 30 Jul 2025 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865727;
	bh=R9tPMtanhfbxzRV0pHfeS2nZ2gL77dZLb8pS8Uq0Qh4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pd09s1iMQ3eHcRZWuJRAuvDVrg9nbRXPxq6mZ4mk2h0VL9wyENNcEDerAF061Pw0y
	 HDOjuq2kQzZgukWW4ypCYsZDxTkkXql28aLQLlB/sGMmDPOJBQj1PacPlv3k8IDRDd
	 3lzqzRNBj/5CqgNvl9SehaUfuNo7ZSlJzCPht1e0=
Subject: Patch "erofs: get rid of debug_one_dentry()" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jan.kiszka@siemens.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org,s.kerkmann@pengutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 10:55:13 +0200
In-Reply-To: <20250722100029.3052177-2-hsiangkao@linux.alibaba.com>
Message-ID: <2025073013-panama-zombie-6139@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    erofs: get rid of debug_one_dentry()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-get-rid-of-debug_one_dentry.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-163683-greg=kroah.com@vger.kernel.org Tue Jul 22 12:04:24 2025
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 22 Jul 2025 18:00:25 +0800
Subject: erofs: get rid of debug_one_dentry()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>
Message-ID: <20250722100029.3052177-2-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit e324eaa9790614577c93e819651e0a83963dac79 upstream.

Since erofsdump is available, no need to keep this debugging
functionality at all.

Also drop a useless comment since it's the VFS behavior.

Link: https://lore.kernel.org/r/20230114125746.399253-1-xiang@kernel.org
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/dir.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -6,21 +6,6 @@
  */
 #include "internal.h"
 
-static void debug_one_dentry(unsigned char d_type, const char *de_name,
-			     unsigned int de_namelen)
-{
-#ifdef CONFIG_EROFS_FS_DEBUG
-	/* since the on-disk name could not have the trailing '\0' */
-	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
-
-	memcpy(dbg_namebuf, de_name, de_namelen);
-	dbg_namebuf[de_namelen] = '\0';
-
-	erofs_dbg("found dirent %s de_len %u d_type %d", dbg_namebuf,
-		  de_namelen, d_type);
-#endif
-}
-
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff, unsigned int maxsize)
@@ -52,10 +37,8 @@ static int erofs_fill_dentries(struct in
 			return -EFSCORRUPTED;
 		}
 
-		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      le64_to_cpu(de->nid), d_type))
-			/* stopped by some reason */
 			return 1;
 		++de;
 		ctx->pos += sizeof(struct erofs_dirent);


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-sunset-erofs_dbg.patch
queue-6.1/erofs-simplify-z_erofs_transform_plain.patch
queue-6.1/erofs-get-rid-of-debug_one_dentry.patch
queue-6.1/erofs-drop-z_erofs_page_mark_eio.patch
queue-6.1/erofs-address-d-cache-aliasing.patch

