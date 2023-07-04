Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EF7470EB
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 14:22:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Yfx9ztWk;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vF6CF3Ol;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwMPj3pSCz3bNp
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 22:22:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Yfx9ztWk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vF6CF3Ol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1c; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwMPS51PXz30f5
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jul 2023 22:22:34 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D9E422868;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5Z0PpLwK7LWiMwHAJV3g58wt4Pu7/r/oCMflfsspxI=;
	b=Yfx9ztWkVatt0fVfNPxdamFDjV837Nu56ImHpS3yWvwdcdXXyeJ1ONnOd+6RA+xJckyxi2
	Fr1h4BOlDMHKk2yJxxmlop9vtybjvkzPRI8sOxjaR75gWlVSNQjeXkVo/sHlsqPbUV+LJG
	uG3Fi84JhxR4KPvRm9XoLJxwd0lLAD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688473345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5Z0PpLwK7LWiMwHAJV3g58wt4Pu7/r/oCMflfsspxI=;
	b=vF6CF3OlMOzmEcsCihpnKLEsv6y6u4duYbSxFgbJ4TrA9OaJnML/9G2T1z6YHtiVQ3zwq6
	zVCIM6qtTQOYAOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 433C713A97;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fiTSDwEPpGQQMAAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97B9EA0763; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Subject: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Date: Tue,  4 Jul 2023 14:21:28 +0200
Message-Id: <20230704122224.16257-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5599; i=jack@suse.cz; h=from:subject; bh=repJSb0/C5PfG8Cx5q/n/kNJZOabhc2tYWxiICNNTtg=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFKW8J3uuK2gorZt+knOzhX81snTGX/57phWXzfXM3w+50Xl rfb7OxmNWRgYORhkxRRZVkde1L42z6hra6iGDMwgViaQKQxcnAIwERsLDobphetsJoi99quKYIut26 wgv/K+lUS+secym02t85epsOp8rtu3acJMN1WFRiX1irKCnSu+LXh+rVyp65RAEGttl+XcP32mOR0n ZJYFm7orF8YFnhVftYzZjm2Rva3I0oqXdap/bUJr8qNjVVfHnBRiFEv0Ocgpck1jlTHfEWUu71NrKu 8EXrbnsfD7wm1qKHDqnnnD21y1n9OFHn8/7qJz4O19panPLvMxrOrNn970IcH6rnhQsq0ZS1v6JUfN RS5ah5XMXNI/c14+vVlVkPVI9n2HQNZlEfdsO13VFx17Z7f0vKnN9UZZ3Zii6WbsWS81/qefFs1Ljl +dK1sZIpSRdXfx+jksz9T4il4AAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Trond Myklebust 
 <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put() and provide blkdev_get_handle_* functions that
return this structure instead of plain bdev pointer. This will
eventually allow us to pass one more argument to blkdev_put() without
too much hassle.

CC: Alasdair Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Anna Schumaker <anna@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Coly Li <colyli@suse.de
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: Dave Kleikamp <shaggy@kernel.org>
CC: David Sterba <dsterba@suse.com>
CC: dm-devel@redhat.com
CC: drbd-dev@lists.linbit.com
CC: Gao Xiang <xiang@kernel.org>
CC: Jack Wang <jinpu.wang@ionos.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
CC: Joern Engel <joern@lazybastard.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: linux-erofs@lists.ozlabs.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: linux-mm@kvack.org
CC: linux-mtd@lists.infradead.org
CC: linux-nfs@vger.kernel.org
CC: linux-nilfs@vger.kernel.org
CC: linux-nvme@lists.infradead.org
CC: linux-pm@vger.kernel.org
CC: linux-raid@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-scsi@vger.kernel.org
CC: linux-xfs@vger.kernel.org
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: Minchan Kim <minchan@kernel.org>
CC: ocfs2-devel@oss.oracle.com
CC: reiserfs-devel@vger.kernel.org
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Song Liu <song@kernel.org>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: target-devel@vger.kernel.org
CC: Ted Tso <tytso@mit.edu>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: xen-devel@lists.xenproject.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 10 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 979e28a46b98..c75de5cac2bc 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -846,6 +846,24 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
 
+struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
+					     GFP_KERNEL);
+	struct block_device *bdev;
+
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
+	handle->bdev = bdev;
+	handle->holder = holder;
+	return handle;
+}
+EXPORT_SYMBOL(blkdev_get_handle_by_dev);
+
 /**
  * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
@@ -884,6 +902,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
+struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	handle = blkdev_get_handle_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
+	    bdev_read_only(handle->bdev)) {
+		blkdev_handle_put(handle);
+		return ERR_PTR(-EACCES);
+	}
+
+	return handle;
+}
+EXPORT_SYMBOL(blkdev_get_handle_by_path);
+
 void blkdev_put(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -920,6 +960,13 @@ void blkdev_put(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(blkdev_put);
 
+void blkdev_handle_put(struct bdev_handle *handle)
+{
+	blkdev_put(handle->bdev, handle->holder);
+	kfree(handle);
+}
+EXPORT_SYMBOL(blkdev_handle_put);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..a910e9997ddd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1471,14 +1471,24 @@ struct blk_holder_ops {
 #define sb_open_mode(flags) \
 	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+};
+
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, void *holder);
+void blkdev_handle_put(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.35.3

