Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BCB99455B
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 12:27:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBzQ2qkdz2yl1
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 21:27:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728383248;
	cv=none; b=cU4KzFK7wQ0lJwwAhdVLiz+vwb6Au6aKjwpYrd3nCPiWjBH8xcKLsopctXI87AbqaZoNjzJ6iklm4WB0N75HzCj2oZ/7cuKH7zkz0jfTHrzc4zJaUWjxYdGCl8czg0CKTMFauwFER7sulAffVAQX0YBgsB1+5v8JdiYl0eUl9IUesCBOdl/U/F4Q84sGcTM4Nale4k87TC/Z6Q1bZkfLE/EANKOSCvpoK72j8islIxbpn5ENcMSJG6ciZti0Te3cBsbxzEW3D61GsqFcsnxm69/b1rL3J8N7/k/+uoU1vu0rw6JhRedwtx2U2Fm5uwgNX629MaF4w7A301yV0xQuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728383248; c=relaxed/relaxed;
	bh=Wpuw9XlBDmLjLCOkfsjB4XazO0x+j5/G8l1Ui0V86Yw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=PAn9qoFVBbDOLtNrjqfvha+qkPHZJOeZwMxD7K/SoUbA1HdH+OstqAe62Sqzj6ClNRdOEqT5e+R8MV5hzFLb209r+gAvCcIJgSh2CK5UQFCT489aqm1nAkSDtN6hLi1D7OD6QefIiDZbVpSBwQrv2PQoIwWOfjjy2tDbWn0YcP4bqV6qiuxfAcLFWFDYuu/Tvy1YHJNckavJkom54eJCU2P+pbTCdejn5WzozY875fWC+Rs7Mm8AgFGhJizYO5j0k0tOP46gioNoglmrHy4LeiLZJsc6b1MURXG0tFyyihtK7/Gv9k9EGYO/+b78XSDuy1xX4YEcedzWtenwWh7c3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I3RbtUjK; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I3RbtUjK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBzM3QTtz2yN3
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 21:27:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DC646A43433;
	Tue,  8 Oct 2024 10:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A0CC4CECC;
	Tue,  8 Oct 2024 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383244;
	bh=fXyMlCZSJome2jluS/CGMtmqYHtElav3MzjLwiGfWXk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=I3RbtUjKTHfECcBOHLcwG/DhoB0GRuFBDG1UyV1lT2TAcHUN1KTv6J+tnYBhnxhN8
	 rqY8KnKXP00T45SLK6ZZwn3k4UfJIZ5eedkx3XQYWbRcUgzqftnbYtRde4sjrzH7kj
	 /gFQc0v/FYz5VWjoDqQKUoNjeJTZXvIIPbhyXIis=
Subject: Patch "erofs: fix incorrect symlink detection in fast symlink" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org,walters@verbum.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 12:27:18 +0200
In-Reply-To: <20241008065708.727659-5-hsiangkao@linux.alibaba.com>
Message-ID: <2024100816-boogeyman-fiber-cc56@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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

    erofs: fix incorrect symlink detection in fast symlink

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Oct  8 08:57:32 2024
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue,  8 Oct 2024 14:57:08 +0800
Subject: erofs: fix incorrect symlink detection in fast symlink
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20241008065708.727659-5-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 9ed50b8231e37b1ae863f5dec8153b98d9f389b4 upstream.

Fast symlink can be used if the on-disk symlink data is stored
in the same block as the on-disk inode, so we don’t need to trigger
another I/O for symlink data.  However, currently fs correction could be
reported _incorrectly_ if inode xattrs are too large.

In fact, these should be valid images although they cannot be handled as
fast symlinks.

Many thanks to Colin for reporting this!

Reported-by: Colin Walters <walters@verbum.org>
Reported-by: https://honggfuzz.dev/
Link: https://lore.kernel.org/r/bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
[ Note that it's a runtime misbehavior instead of a security issue. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20240909031911.1174718-1-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/inode.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -212,12 +212,14 @@ static int erofs_fill_symlink(struct ino
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
+	loff_t off;
 	char *lnk;
 
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
+	m_pofs += vi->xattr_isize;
+	/* check if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	    check_add_overflow(m_pofs, inode->i_size, &off) ||
+	    off > i_blocksize(inode)) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -226,16 +228,6 @@ static int erofs_fill_symlink(struct ino
 	if (!lnk)
 		return -ENOMEM;
 
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
 	memcpy(lnk, kaddr + m_pofs, inode->i_size);
 	lnk[inode->i_size] = '\0';
 


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-set-block-size-to-the-on-disk-block-size.patch
queue-6.1/erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
queue-6.1/erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
queue-6.1/erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
queue-6.1/erofs-get-rid-of-erofs_inode_datablocks.patch
