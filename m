Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F86244A8B1
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 09:34:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpLqV2ZrRz2yQw
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 19:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=k+J4p1sx;
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
 header.s=casper.20170209 header.b=k+J4p1sx; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpLq71DmGz2yJF
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 19:33:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9DfHXjXpwPV16JwxKDzlwLsQrCaf21dbRLJzYHAhNZM=; b=k+J4p1sxv4GIaf/pZry1mADwB+
 Ar1HiQrfR69z+VUk+LXPZwyTUodROP6Ve2JzAJaLMLYKGRK2OL7DDKMIHeGPn3jFxKNlLvXYsyelf
 TOkCDzO0pNwMWvfo4xkbl6QMwmB+MsxPivzTRf3Y41pDkQ+OnrH5ig+xpkzEFpmu8x16htqod2pJy
 /G/Yvb1ksftU66dUi9xDWAuBfQYqIfgnrrTnDC1t60iM2U8YX9P9wjw1hVd9b8Nwa/CIq2Yf1kEUT
 WAiAtLf9ZLb3DGoYBWz/exnngImMfLdkhciTOz/OKeKkkIWbM0lVNy3hRWeXtiPMoMqgcdTTivSmi
 q/cr92yQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZK-000s09-9X; Tue, 09 Nov 2021 08:33:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
Date: Tue,  9 Nov 2021 09:32:47 +0100
Message-Id: <20211109083309.584081-8-hch@lst.de>
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

Factor out another DAX setup helper to simplify future changes.  Also
move the experimental warning after the checks to not clutter the log
too much if the setup failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e21459f9923a8..875fd3151d6c9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -340,6 +340,32 @@ xfs_buftarg_is_dax(
 			bdev_nr_sectors(bt->bt_bdev));
 }
 
+static int
+xfs_setup_dax_always(
+	struct xfs_mount	*mp)
+{
+	struct super_block	*sb = mp->m_super;
+
+	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
+	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
+		xfs_alert(mp,
+			"DAX unsupported by block device. Turning off DAX.");
+		goto disable_dax;
+	}
+
+	if (xfs_has_reflink(mp)) {
+		xfs_alert(mp, "DAX and reflink cannot be used together!");
+		return -EINVAL;
+	}
+
+	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+	return 0;
+
+disable_dax:
+	xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
+	return 0;
+}
+
 STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
@@ -1593,26 +1619,9 @@ xfs_fs_fill_super(
 		sb->s_flags |= SB_I_VERSION;
 
 	if (xfs_has_dax_always(mp)) {
-		bool rtdev_is_dax = false, datadev_is_dax;
-
-		xfs_warn(mp,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-
-		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
-		if (mp->m_rtdev_targp)
-			rtdev_is_dax = xfs_buftarg_is_dax(sb,
-						mp->m_rtdev_targp);
-		if (!rtdev_is_dax && !datadev_is_dax) {
-			xfs_alert(mp,
-			"DAX unsupported by block device. Turning off DAX.");
-			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
-		}
-		if (xfs_has_reflink(mp)) {
-			xfs_alert(mp,
-		"DAX and reflink cannot be used together!");
-			error = -EINVAL;
+		error = xfs_setup_dax_always(mp);
+		if (error)
 			goto out_filestream_unmount;
-		}
 	}
 
 	if (xfs_has_discard(mp)) {
-- 
2.30.2

