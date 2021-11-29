Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C455A46124D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 11:23:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J2hK25X3cz3bZM
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 21:23:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=QV/FtrIw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+13c9c90cf431a9f4f7f6+6672+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=QV/FtrIw; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J2hHm6m8lz2ymc
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:22:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=CHX+n6oDrTWr4Nl3g7rdBdOryWfotdrK7gxEyyupiQA=; b=QV/FtrIwDrWha7Vur1aJccAM72
 ZgAFG0bkaPiwkrKZnFahQVqskCV0kd/W+yTVp0f4tQEZLbixhzP3Mx36E5fxtY8dkFwGN2VQ01vbP
 FEoGdvlZObHVsGoO+GSosoly0LRkB1rsN4Myoau0YzNeey3RCxVA/cF0nbJZ6r8g1hdRReA2ASMc1
 qDRZ71Tpn1tz9sO9eA5MRWXFQLMeuefo/I8zs2AjNZ/IJZLMPa/p1/1bnLXij9kP6s1T3Ar+P1S5X
 MI0FoN8GY/G+7NS1/nh7Gsn9OSHDz/0RV4RNyB5lJUw/DrroYCJ8FKNOReVDfAGg9PYYWKg0ubhp1
 hRtN8o7Q==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnr-0073T8-He; Mon, 29 Nov 2021 10:22:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 20/29] ext4: cleanup the dax handling in ext4_fill_super
Date: Mon, 29 Nov 2021 11:21:54 +0100
Message-Id: <20211129102203.2243509-21-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
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
 dm-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
the need for the dax_dev local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fd3d68f10ee55..8d7e3449c6472 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3878,7 +3878,6 @@ static void ext4_setup_csum_trigger(struct super_block *sb,
 
 static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	char *orig_data = kstrdup(data, GFP_KERNEL);
 	struct buffer_head *bh, **group_desc;
 	struct ext4_super_block *es = NULL;
@@ -3909,12 +3908,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if ((data && !orig_data) || !sbi)
 		goto out_free_base;
 
-	sbi->s_daxdev = dax_dev;
 	sbi->s_blockgroup_lock =
 		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
 	if (!sbi->s_blockgroup_lock)
 		goto out_free_base;
 
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
 	sb->s_fs_info = sbi;
 	sbi->s_sb = sb;
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
@@ -4299,7 +4298,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (dax_dev) {
+	if (sbi->s_daxdev) {
 		if (blocksize == PAGE_SIZE)
 			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
 		else
@@ -5095,10 +5094,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 out_fail:
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
+	fs_put_dax(sbi->s_daxdev);
 out_free_base:
 	kfree(sbi);
 	kfree(orig_data);
-	fs_put_dax(dax_dev);
 	return err ? err : ret;
 }
 
-- 
2.30.2

