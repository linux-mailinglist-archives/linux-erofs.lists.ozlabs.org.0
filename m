Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADD81B11F
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Dec 2023 10:01:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Swktd22Bmz3cPk
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Dec 2023 20:01:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=yukuai1@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SwktZ2xMjz2yk6
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Dec 2023 20:01:10 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwktT27Nlz4f3k6J
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Dec 2023 17:01:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AC4691A0DBC
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Dec 2023 17:01:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgC3BQzQ_oNlHiLvEA--.34070S4;
	Thu, 21 Dec 2023 17:01:06 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	roger.pau@citrix.com,
	colyli@suse.de,
	kent.overstreet@gmail.com,
	joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	sth@linux.ibm.com,
	hoeppner@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	p.raghav@samsung.com
Subject: [PATCH RFC v3 for-6.8/block 16/17] ext4: remove block_device_ejected()
Date: Thu, 21 Dec 2023 16:59:07 +0800
Message-Id: <20231221085907.1772856-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgC3BQzQ_oNlHiLvEA--.34070S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UGw1xJF1fWr48KFy3urg_yoW8tF1Up3
	yfuw1fJrW8Zr1I9ayxJr4xW3y0qa92ya40gFyI9r1Fgr1xJ340qF4ktr1Iya4YvrZ3uw1F
	qF1UCrWxCr18CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_JFI_Gr1lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUb
	ZNVDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
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
Cc: linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, yukuai1@huaweicloud.com, yangerkun@huawei.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, yukuai3@huawei.com, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yu Kuai <yukuai3@huawei.com>

block_device_ejected() is added by commit bdfe0cbd746a ("Revert
"ext4: remove block_device_ejected"") in 2015. At that time 'bdi->wb'
is destroyed synchronized from del_gendisk(), hence if ext4 is still
mounted, and then mark_buffer_dirty() will reference destroyed 'wb'.
However, such problem doesn't exist anymore:

- commit d03f6cdc1fc4 ("block: Dynamically allocate and refcount
backing_dev_info") switch bdi to use refcounting;
- commit 13eec2363ef0 ("fs: Get proper reference for s_bdi"), will grab
additional reference of bdi while mounting, so that 'bdi->wb' will not
be destroyed until generic_shutdown_super().

Hence remove this dead function block_device_ejected().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3f07eaa33332..a7935edbd7b1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -467,22 +467,6 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 }
 
-/*
- * The del_gendisk() function uninitializes the disk-specific data
- * structures, including the bdi structure, without telling anyone
- * else.  Once this happens, any attempt to call mark_buffer_dirty()
- * (for example, by ext4_commit_super), will cause a kernel OOPS.
- * This is a kludge to prevent these oops until we can put in a proper
- * hook in del_gendisk() to inform the VFS and file system layers.
- */
-static int block_device_ejected(struct super_block *sb)
-{
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
-	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
-
-	return bdi->dev == NULL;
-}
-
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
@@ -6162,8 +6146,6 @@ static int ext4_commit_super(struct super_block *sb)
 
 	if (!sbh)
 		return -EINVAL;
-	if (block_device_ejected(sb))
-		return -ENODEV;
 
 	ext4_update_super(sb);
 
-- 
2.39.2

