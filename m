Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75C44A8F4
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 09:34:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpLqy28H4z2yK3
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 19:34:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jWJH7gRa;
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
 header.s=casper.20170209 header.b=jWJH7gRa; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpLqT60CSz3bWk
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 19:33:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=w7OlGcun90+irmAPYzmTcZBOPYBcRc9XENfZ6+Mb9vU=; b=jWJH7gRabA1nTyzMlvOyrMmL6A
 d1snCm4OAtdG9l96Fl8SdKPajWndw2wLlbGdJcqzIZuESJlOdHsiUq58YLz9LH9Mlp11mSyTq/37f
 Gi5Fa9czKxgBGgLurjuhXBCqhQIk4HYDrJnbGc3S00AjlhI2SdXjzPkKbqK8qebbUvMI1X9wwVq1t
 f0JNoiiUP0y6wny2CDC5c6gmSjssHyPwLn85K617F9BzrxUekruJ3zUtV7YSU7uoqQs4ZIlHoyAFH
 JXb42BtJPPQnrHsObmA6aGnKjFyz7ZK36uY2Eok7JXO3qbtMsmSl0/btVmQrUctSho4PyptJVK4HM
 KAEOcvJw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZe-000s6P-H3; Tue, 09 Nov 2021 08:33:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 19/29] ext2: cleanup the dax handling in ext2_fill_super
Date: Tue,  9 Nov 2021 09:32:59 +0100
Message-Id: <20211109083309.584081-20-hch@lst.de>
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

Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
the need for the dax_dev local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext2/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index a964066a80aa7..7e23482862e69 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -802,7 +802,6 @@ static unsigned long descriptor_loc(struct super_block *sb,
 
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	struct buffer_head * bh;
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
@@ -822,17 +821,17 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		goto failed;
+		return -ENOMEM;
 
 	sbi->s_blockgroup_lock =
 		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
 	if (!sbi->s_blockgroup_lock) {
 		kfree(sbi);
-		goto failed;
+		return -ENOMEM;
 	}
 	sb->s_fs_info = sbi;
 	sbi->s_sb_block = sb_block;
-	sbi->s_daxdev = dax_dev;
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
 
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
@@ -946,7 +945,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-		if (!dax_dev) {
+		if (!sbi->s_daxdev) {
 			ext2_msg(sb, KERN_ERR,
 				"DAX unsupported by block device. Turning off DAX.");
 			clear_opt(sbi->s_mount_opt, DAX);
@@ -1201,11 +1200,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount:
 	brelse(bh);
 failed_sbi:
+	fs_put_dax(sbi->s_daxdev);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 	kfree(sbi);
-failed:
-	fs_put_dax(dax_dev);
 	return ret;
 }
 
-- 
2.30.2

