Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE600805472
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Dec 2023 13:38:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sl0TC3DGLz3clw
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Dec 2023 23:38:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=yukuai1@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sl0Sy5KxZz3cV4
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Dec 2023 23:38:42 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sl0Ss5X2xz4f3kKD
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Dec 2023 20:38:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CA9151A0C22
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Dec 2023 20:38:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDnNw7GGW9lr8E8Cw--.35507S8;
	Tue, 05 Dec 2023 20:38:38 +0800 (CST)
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
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	p.raghav@samsung.com
Subject: [PATCH -next RFC 04/14] mtd: block2mtd: use bdev apis
Date: Tue,  5 Dec 2023 20:37:18 +0800
Message-Id: <20231205123728.1866699-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnNw7GGW9lr8E8Cw--.35507S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1DtryDWw17CF45XFyrZwb_yoW7AF15pa
	y3Ca95Aw4UKrn8ur4xXwn8Zr12g3sFqayUCay7C3yakF93JryIkas7ta45KFyrKry8AFWk
	XF4DArs5XF40grJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	oxhLUUUUU
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
Cc: linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, gfs2@lists.linux.dev, linux-scsi@vger.kernel.org, yukuai1@huaweicloud.com, yangerkun@huawei.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, yukuai3@huawei.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yu Kuai <yukuai3@huawei.com>

On the one hand covert to use folio while reading bdev inode, on the
other hand prevent to access bd_inode directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/mtd/devices/block2mtd.c | 80 +++++++++++++++------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index aa44a23ec045..927fc9cf0856 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -46,40 +46,34 @@ struct block2mtd_dev {
 /* Static info about the MTD, used in cleanup_module */
 static LIST_HEAD(blkmtd_device_list);
 
-
-static struct page *page_read(struct address_space *mapping, pgoff_t index)
-{
-	return read_mapping_page(mapping, index, NULL);
-}
-
 /* erase a specified part of the device */
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
-	struct page *page;
+	struct block_device *bdev = dev->bdev_handle->bdev;
+	struct folio *folio;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
 	u_long *p;
 	u_long *max;
 
 	while (pages) {
-		page = page_read(mapping, index);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		folio = bdev_read_folio(bdev, index);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		max = page_address(page) + PAGE_SIZE;
-		for (p=page_address(page); p<max; p++)
+		max = folio_address(folio) + folio_size(folio);
+		for (p = folio_address(folio); p < max; p++)
 			if (*p != -1UL) {
-				lock_page(page);
-				memset(page_address(page), 0xff, PAGE_SIZE);
-				set_page_dirty(page);
-				unlock_page(page);
-				balance_dirty_pages_ratelimited(mapping);
+				folio_lock(folio);
+				memset(folio_address(folio), 0xff,
+				       folio_size(folio));
+				folio_mark_dirty(folio);
+				folio_unlock(folio);
+				bdev_balance_dirty_pages_ratelimited(bdev);
 				break;
 			}
 
-		put_page(page);
+		folio_put(folio);
 		pages--;
 		index++;
 	}
@@ -106,9 +100,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
 	int cpylen;
@@ -120,12 +112,12 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 			cpylen = len;	// this page
 		len = len - cpylen;
 
-		page = page_read(mapping, index);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		folio = bdev_read_folio(dev->bdev_handle->bdev, index);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		memcpy(buf, page_address(page) + offset, cpylen);
-		put_page(page);
+		memcpy(buf, folio_address(folio) + offset, cpylen);
+		folio_put(folio);
 
 		if (retlen)
 			*retlen += cpylen;
@@ -141,9 +133,8 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 		loff_t to, size_t len, size_t *retlen)
 {
-	struct page *page;
-	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+	struct block_device *bdev = dev->bdev_handle->bdev;
+	struct folio *folio;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -155,18 +146,18 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 			cpylen = len;			// this page
 		len = len - cpylen;
 
-		page = page_read(mapping, index);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		folio = bdev_read_folio(bdev, index);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		if (memcmp(page_address(page)+offset, buf, cpylen)) {
-			lock_page(page);
-			memcpy(page_address(page) + offset, buf, cpylen);
-			set_page_dirty(page);
-			unlock_page(page);
-			balance_dirty_pages_ratelimited(mapping);
+		if (memcmp(folio_address(folio) + offset, buf, cpylen)) {
+			folio_lock(folio);
+			memcpy(folio_address(folio) + offset, buf, cpylen);
+			folio_mark_dirty(folio);
+			folio_unlock(folio);
+			bdev_balance_dirty_pages_ratelimited(bdev);
 		}
-		put_page(page);
+		folio_put(folio);
 
 		if (retlen)
 			*retlen += cpylen;
@@ -211,8 +202,7 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 	kfree(dev->mtd.name);
 
 	if (dev->bdev_handle) {
-		invalidate_mapping_pages(
-			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
+		invalidate_bdev(dev->bdev_handle->bdev);
 		bdev_release(dev->bdev_handle);
 	}
 
@@ -295,7 +285,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev->bd_inode->i_size % erase_size) {
+	if ((long)bdev_size(bdev) % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -313,7 +303,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = bdev_size(bdev) & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
-- 
2.39.2

