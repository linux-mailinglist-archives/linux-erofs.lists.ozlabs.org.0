Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3844A911
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 09:34:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpLrF3YSGz3bhd
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 19:34:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CgyYqJWA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+ffbfd99345897bc8db8d+6652+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=CgyYqJWA; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpLqg1BmSz2yn9
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 19:34:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=zphFQ64GDoQ6nE7lIDbLOIsP6ENH++XRmNe1655SS+g=; b=CgyYqJWAV0BrHw+hsyhXvr5uae
 Z5ScPpOf2m4sPoffDadhNmmOS+vcqYAeYet70ERrkF7hZiHk4d8nP2reuvLnTc1lhCnbOGSJY+prs
 Nt/DYUl9ylpDLMg78P9HxD+54LYCr9mE2mXO/za05eItBpf2qBYCZCt9JPgLmz5Rd5wCAMDA1La4h
 oN3+WFXqpMVNbDwgb59BwwCLH7CbatRIuzy9l+f+/IiBlzk3LkwXWDGk/8mOtjYY+Rk7BMB2yHgU7
 YMFQkY08G6FZAbDlAkVnLdn4a23GNOwDur3J0tOYtkjfG/sTeRdMGuJ7ftHe0FmXCQxclLKqg94TE
 bxjqmUjQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZk-000s9a-KF; Tue, 09 Nov 2021 08:33:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 23/29] xfs: use IOMAP_DAX to check for DAX mappings
Date: Tue,  9 Nov 2021 09:33:03 +0100
Message-Id: <20211109083309.584081-24-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use the explicit DAX flag instead of checking the inode flag in the
iomap code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 7 ++++---
 fs/xfs/xfs_iomap.h | 3 ++-
 fs/xfs/xfs_pnfs.c  | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 604000b6243ec..8cef3b68cba78 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -188,6 +188,7 @@ xfs_iomap_write_direct(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
 	xfs_fileoff_t		count_fsb,
+	unsigned int		flags,
 	struct xfs_bmbt_irec	*imap)
 {
 	struct xfs_mount	*mp = ip->i_mount;
@@ -229,7 +230,7 @@ xfs_iomap_write_direct(
 	 * the reserve block pool for bmbt block allocation if there is no space
 	 * left but we need to do unwritten extent conversion.
 	 */
-	if (IS_DAX(VFS_I(ip))) {
+	if (flags & IOMAP_DAX) {
 		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
 		if (imap->br_state == XFS_EXT_UNWRITTEN) {
 			force = true;
@@ -620,7 +621,7 @@ imap_needs_alloc(
 	    imap->br_startblock == DELAYSTARTBLOCK)
 		return true;
 	/* we convert unwritten extents before copying the data for DAX */
-	if (IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN)
+	if ((flags & IOMAP_DAX) && imap->br_state == XFS_EXT_UNWRITTEN)
 		return true;
 	return false;
 }
@@ -826,7 +827,7 @@ xfs_direct_write_iomap_begin(
 	xfs_iunlock(ip, lockmode);
 
 	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
-			&imap);
+			flags, &imap);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index f1a281ab9328c..5648262a71736 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -12,7 +12,8 @@ struct xfs_inode;
 struct xfs_bmbt_irec;
 
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
-		xfs_fileoff_t count_fsb, struct xfs_bmbt_irec *imap);
+		xfs_fileoff_t count_fsb, unsigned int flags,
+		struct xfs_bmbt_irec *imap);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 5e1d29d8b2e73..e188e1cf97cc5 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -155,7 +155,7 @@ xfs_fs_map_blocks(
 		xfs_iunlock(ip, lock_flags);
 
 		error = xfs_iomap_write_direct(ip, offset_fsb,
-				end_fsb - offset_fsb, &imap);
+				end_fsb - offset_fsb, 0, &imap);
 		if (error)
 			goto out_unlock;
 
-- 
2.30.2

