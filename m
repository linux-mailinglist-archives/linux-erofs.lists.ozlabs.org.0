Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE137F9B2B
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 08:53:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SdyVz0gyXz3cS3
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 18:52:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=yukuai1@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SdyVr3KHxz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 18:52:50 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SdyVf0X6Rz4f3l7D
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 15:52:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E11CA1A0C75
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 15:52:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhDISmRl1qdCCA--.65049S3;
	Mon, 27 Nov 2023 15:52:43 +0800 (CST)
Subject: Re: [PATCH block/for-next v2 07/16] bcachefs: use new helper to get
 inode from block_device
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-8-yukuai1@huaweicloud.com>
 <d3b87b87-2ca7-43ca-9fb4-ee3696561eb5@kernel.org>
 <20231127072409.y22jkynrchm4tkd2@moria.home.lan>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <58ced33e-0a8c-7bd3-beb8-d75119cab60b@huaweicloud.com>
Date: Mon, 27 Nov 2023 15:52:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231127072409.y22jkynrchm4tkd2@moria.home.lan>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhDISmRl1qdCCA--.65049S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1kGw4ktFy5uF47KryUKFg_yoWkArX_XF
	17ur47Zw4fJF1vq3ZYqFsYqrZF9rWrXrWaqFn5JF1UWa4kJFZ5ZFZ5Kr93ZrsxJr4DGF12
	vrZ5XFW3CrySkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
	6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, hch@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, "yukuai \(C\)" <yukuai3@huawei.com>, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, Yu Kuai <yukuai1@huaweicloud.com>, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com, nico@fluxnic.net, lin
 ux@weissschuh.net, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, min15.li@samsung.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

ÔÚ 2023/11/27 15:24, Kent Overstreet Ð´µÀ:
> On Mon, Nov 27, 2023 at 04:09:47PM +0900, Damien Le Moal wrote:
>> On 11/27/23 15:21, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Which is more efficiency, and also prepare to remove the field
>>> 'bd_inode' from block_device.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   fs/bcachefs/util.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
>>> index 2984b57b2958..fe7ccb3a3517 100644
>>> --- a/fs/bcachefs/util.h
>>> +++ b/fs/bcachefs/util.h
>>> @@ -518,7 +518,7 @@ int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
>>>   
>>>   static inline sector_t bdev_sectors(struct block_device *bdev)
>>>   {
>>> -	return bdev->bd_inode->i_size >> 9;
>>> +	return bdev_inode(bdev)->i_size >> 9;
>>
>> shouldn't this use i_size_read() ?
>>
>> I missed the history with this but why not use bdev_nr_sectors() and delete this
>> helper ?
> 
> Actually, this helper seems to be dead code.

Yes, there is no caller of this helper, I'll remove this helper.

Thanks,
Kuai

> .
> 

