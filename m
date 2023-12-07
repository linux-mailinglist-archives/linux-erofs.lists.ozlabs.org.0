Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0D807EE7
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 03:45:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlzCf3lrWz3cRy
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 13:45:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=yukuai1@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlzCV3jtQz3bt2
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 13:45:23 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SlzCD2Wh9z4f3lDJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 10:45:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 19F981A0909
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 10:45:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxG5MXFllH3QCw--.13955S3;
	Thu, 07 Dec 2023 10:45:16 +0800 (CST)
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
To: Matthew Wilcox <willy@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXCMJ9skAAgPm4z3@casper.infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d195aba8-7b89-698f-b7a0-06b87ae01c21@huaweicloud.com>
Date: Thu, 7 Dec 2023 10:45:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZXCMJ9skAAgPm4z3@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxG5MXFllH3QCw--.13955S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4Dury5Kr13Aw47Gr4Uurg_yoW5Ar4DpF
	W8KFZ8JrW8Gr18ursrJa15Z3WFg34UJFW5ZrWxG343C3s0yr9akFWYgws0kayIv3yUJFs7
	ZFWjvrW8WF1j9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
	WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUojjgUUUUU
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, "yukuai \(C\)" <yukuai3@huawei.com>, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, rog
 er.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

ÔÚ 2023/12/06 22:58, Matthew Wilcox Ð´µÀ:
> On Tue, Dec 05, 2023 at 08:37:15PM +0800, Yu Kuai wrote:
>> +struct folio *bdev_read_folio(struct block_device *bdev, pgoff_t index)
>> +{
>> +	return read_mapping_folio(bdev->bd_inode->i_mapping, index, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(bdev_read_folio);
> 
> I'm coming to the opinion that 'index' is the wrong parameter here.
> Looking through all the callers of bdev_read_folio() in this patchset,
> they all have a position in bytes, and they all convert it to
> index for this call.  The API should probably be:
> 
> struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
> {
> 	return read_mapping_folio(bdev->bd_inode->i_mapping,
> 			pos / PAGE_SIZE, NULL);
> }

Thanks for reviewing this patchset! Okay, I'll convert to pass in "pos"
in v2.
> 
> ... and at some point, we'll get round to converting read_mapping_folio()
> to take its argument in loff_t.
> 
> Similiarly for these two APIs:
> 
>> +struct folio *bdev_read_folio_gfp(struct block_device *bdev, pgoff_t index,
>> +				  gfp_t gfp)
>> +struct folio *bdev_get_folio(struct block_device *bdev, pgoff_t index)
> 
>> +struct folio *bdev_find_or_create_folio(struct block_device *bdev,
>> +					pgoff_t index, gfp_t gfp)
>> +{
>> +	return __filemap_get_folio(bdev->bd_inode->i_mapping, index,
>> +				   FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
>> +}
>> +EXPORT_SYMBOL_GPL(bdev_find_or_create_folio);
> 
> This one probably shouldn't exist.  I've been converting callers of
> find_or_create_page() to call __filemap_get_folio; I suspect we
> should expose a __bdev_get_folio and have the callers use the FGP
> arguments directly, but I'm open to other opinions here.

If nobody against this, I will expose single __bdev_get_folio() to use
in v2.
> 
>> +void bdev_sync_readahead(struct block_device *bdev, struct file_ra_state *ra,
>> +			 struct file *file, pgoff_t index,
>> +			 unsigned long req_count)
>> +{
>> +	struct file_ra_state tmp_ra = {};
>> +
>> +	if (!ra) {
>> +		ra = &tmp_ra;
>> +		file_ra_state_init(ra, bdev->bd_inode->i_mapping);
>> +	}
>> +	page_cache_sync_readahead(bdev->bd_inode->i_mapping, ra, file, index,
>> +				  req_count);
>> +}
> 
> I think the caller should always be passing in a valid file_ra_state.
> It's only cramfs that doesn't have one, and it really should!
> Not entirely sure about the arguments here; part of me says "bytes",
> but this is weird enough to maybe take arguments in pages.

In fact, bdev_sync_readahead() is only called for cramfs and ext4.

For ext4 it's used in ext4_readdir() so there is valid file_ra_state.

Hoever, for cramfs it's used in cramfs_read(), and cramfs_read() is used
for:

1) cramfs_read_folio
2) cramfs_readdir
3) cramfs_lookup
4) cramfs_read_super

Looks like it's easy to pass in valid file_ra_state() for 1) and 2),
however, I don't see an easy way to do this for 3) and 4).

Thanks,
Kuai

> 
> .
> 

