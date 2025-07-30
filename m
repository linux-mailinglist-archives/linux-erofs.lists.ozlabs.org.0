Return-Path: <linux-erofs+bounces-725-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E479CB15AFB
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 10:55:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsQzC5lRdz3blH;
	Wed, 30 Jul 2025 18:55:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753865735;
	cv=none; b=HZ+Ifc7jorN/zAzqqDIXmNiCDV3oIHs2mk3W4yPcaB4rEgzZq/8/2PZfSGLZ7mrG0B7xAZ93eCbNSe3NYP7QyZ4mvnMLoV+vzzss581Z28YbSIHLL6gPMMPN6OIvlxY2T2F1W9zyH7m2oTlpc6ozBA5IsXuQjS6Y+fMuhzuHlpX4GNPuCFj5IJRFyFYdFXeXOar5qG2MtQVsFmVi7g+RPm7ZGfC5v7RpKoet5H4iyYr2MztotO5Xuo+O7zn21Upz8MIwPEp681rAKgphV3Ea2KrS8/SVMP94aKT7/gQEbToMVbRknMFCD1mymP8i5kbUj+/LySxJPeNSlialq06VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753865735; c=relaxed/relaxed;
	bh=Tf6SebstndB3nzfeYr6WeXalvUJ90KfOjmg7Aqy/RkA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=br/EagRNdh9xamwS1A+6QfvLy3MlJeEbNh5bxz0uarwhVQ6Y7foBdRt+4fur8ZjVLFW0V87aq5drBdBrSq5c6nmZBMA27ZgQBugfit176WK5zq3FZdazYy+C53giX6L+D0RxDER8lCB9x7cK1gzbFA2GB0GNKGWtVMHzX5h/FlHvHdnKArbjtiLg6NNu0Y1O9wgcEKdsZde6O+5+ynJ9kV59Dj++3koLBTMOjx1gJpnVvyIqhHg9fjcvVq17s5x7CLrfz4sSwiNvwNGOSZk+2AEiobSXg/p2sqODN/0tpwB7PtkQITJnLUPnSVVxRf+OMyoAkeXlLOt+lSGvFkmXPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kjtMu1hs; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kjtMu1hs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsQzC0Qbgz2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 18:55:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 632CF5C4C41;
	Wed, 30 Jul 2025 08:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7158C4CEF8;
	Wed, 30 Jul 2025 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865733;
	bh=h+irDCpvDwY14pHQIS6P/IVocNx/1eyxe5yxxO8KnVA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=kjtMu1hsxYRhcCIbxWDVM16scZH7PDrAO7yl+P24UtFur262DLDSC+DdKx5N2GSJC
	 326RZBUKBD8KjGQt9d1c/S5vnWwIeHAFt/PtHk0pzQPiaWtXD63lw0uhZ50J9N5E/i
	 OK4DJ/UGMIc1enLPmF55GAQCkzD3KJbsShfOgxnI=
Subject: Patch "erofs: sunset erofs_dbg()" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,jan.kiszka@siemens.com,linux-erofs@lists.ozlabs.org,s.kerkmann@pengutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 10:55:13 +0200
In-Reply-To: <20250722100029.3052177-3-hsiangkao@linux.alibaba.com>
Message-ID: <2025073013-balsamic-capsize-81c7@gregkh>
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
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    erofs: sunset erofs_dbg()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-sunset-erofs_dbg.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Jul 22 12:00:54 2025
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 22 Jul 2025 18:00:26 +0800
Subject: erofs: sunset erofs_dbg()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>
Message-ID: <20250722100029.3052177-3-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 10656f9ca60ed85f4cfc06bcbe1f240ee310fa8c upstream.

Such debug messages are rarely used now.  Let's get rid of these,
and revert locally if they are needed for debugging.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230414083027.12307-1-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/inode.c    |    3 ---
 fs/erofs/internal.h |    2 --
 fs/erofs/namei.c    |    9 +++------
 fs/erofs/zdata.c    |    5 -----
 fs/erofs/zmap.c     |    3 ---
 5 files changed, 3 insertions(+), 19 deletions(-)

--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -26,9 +26,6 @@ static void *erofs_read_inode(struct ero
 	blkaddr = erofs_blknr(sb, inode_loc);
 	*ofs = erofs_blkoff(sb, inode_loc);
 
-	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
-		  __func__, vi->nid, *ofs, blkaddr);
-
 	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,10 +32,8 @@ __printf(3, 4) void _erofs_info(struct s
 #define erofs_info(sb, fmt, ...) \
 	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
-#define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
 #define DBG_BUGON               BUG_ON
 #else
-#define erofs_dbg(x, ...)       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -203,16 +203,13 @@ static struct dentry *erofs_lookup(struc
 
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
-	if (err == -ENOENT) {
+	if (err == -ENOENT)
 		/* negative dentry */
 		inode = NULL;
-	} else if (err) {
+	else if (err)
 		inode = ERR_PTR(err);
-	} else {
-		erofs_dbg("%s, %pd (nid %llu) found, d_type %u", __func__,
-			  dentry, nid, d_type);
+	else
 		inode = erofs_iget(dir->i_sb, nid);
-	}
 	return d_splice_alias(inode, dentry);
 }
 
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -818,8 +818,6 @@ repeat:
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
-
 		if (z_erofs_collector_end(fe))
 			fe->backmost = false;
 		map->m_la = offset + cur;
@@ -935,9 +933,6 @@ out:
 	if (err)
 		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
-
-	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		  __func__, page, spiltted, map->m_llen);
 	return err;
 }
 
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -603,9 +603,6 @@ static int z_erofs_do_map_blocks(struct
 
 unmap_out:
 	erofs_unmap_metabuf(&m.map->buf);
-	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		  __func__, map->m_la, map->m_pa,
-		  map->m_llen, map->m_plen, map->m_flags);
 	return err;
 }
 


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-sunset-erofs_dbg.patch
queue-6.1/erofs-simplify-z_erofs_transform_plain.patch
queue-6.1/erofs-get-rid-of-debug_one_dentry.patch
queue-6.1/erofs-drop-z_erofs_page_mark_eio.patch
queue-6.1/erofs-address-d-cache-aliasing.patch

