Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0A80E472
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 07:49:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sq8PJ2HvFz30fh
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 17:49:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=yukuai1@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sq8PD4CXzz2ygY
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 17:49:50 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sq8P16c3kz4f3jpk
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 14:49:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1F5341A07E8
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 14:49:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxGDAnhl4n6yDQ--.9546S3;
	Tue, 12 Dec 2023 14:49:42 +0800 (CST)
Subject: Re: [PATCH RFC v2 for-6.8/block 11/18] erofs: use bdev api
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yu Kuai
 <yukuai1@huaweicloud.com>, axboe@kernel.dk, roger.pau@citrix.com,
 colyli@suse.de, kent.overstreet@gmail.com, joern@lazybastard.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 p.raghav@samsung.com, hare@suse.de
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140722.974745-1-yukuai1@huaweicloud.com>
 <1812c1bf-08b5-46a5-a633-12470e2c8f18@linux.alibaba.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7465ebce-1290-e258-13cf-146fa4fd6302@huaweicloud.com>
Date: Tue, 12 Dec 2023 14:49:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1812c1bf-08b5-46a5-a633-12470e2c8f18@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxGDAnhl4n6yDQ--.9546S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Jr1kGFWxtFWfXFyUtrb_yoW5Kw4fpF
	ykAFy8GrWrJrn5ur1xXr1UZFy5t397Ja18Cw4xX3WFvw4UJr10gFy0qr1qgF1UKr4kGr40
	qr1Ivr97ur1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_WFyU
	JVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
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
Cc: linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, gfs2@lists.linux.dev, linux-scsi@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, "yukuai \(C\)" <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

在 2023/12/12 14:35, Gao Xiang 写道:
> 
> 
> On 2023/12/11 22:07, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Avoid to access bd_inode directly, prepare to remove bd_inode from
>> block_devcie.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   fs/erofs/data.c     | 18 ++++++++++++------
>>   fs/erofs/internal.h |  2 ++
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index c98aeda8abb2..8cf3618190ab 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -32,8 +32,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>>   void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>>             enum erofs_kmap_type type)
>>   {
>> -    struct inode *inode = buf->inode;
>> -    erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
>> +    erofs_off_t offset = (erofs_off_t)blkaddr << buf->blkszbits;
> I'd suggest that use `buf->blkszbits` only for bdev_read_folio() since
> erofs_init_metabuf() is not always called before erofs_bread() is used.
> 
> For example, buf->inode can be one of directory inodes other than
> initialized by erofs_init_metabuf().

Thanks for the notice, and you're right, I'll update code in v3:

u8 blkszbits = buf->inode ? inode->i_blkbits : buf->blkszbits;
erofs_off_t offset = (erofs_off_t)blkaddr << blkszbits;

Kuai
> 
> Thanks,
> Gao Xiang
> 
> 
>>       pgoff_t index = offset >> PAGE_SHIFT;
>>       struct page *page = buf->page;
>>       struct folio *folio;
>> @@ -43,7 +42,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t 
>> blkaddr,
>>           erofs_put_metabuf(buf);
>>           nofs_flag = memalloc_nofs_save();
>> -        folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
>> +        folio = buf->inode ?
>> +            read_mapping_folio(buf->inode->i_mapping, index, NULL) :
>> +            bdev_read_folio(buf->bdev, offset);
>>           memalloc_nofs_restore(nofs_flag);
>>           if (IS_ERR(folio))
>>               return folio;
>> @@ -67,10 +68,15 @@ void *erofs_bread(struct erofs_buf *buf, 
>> erofs_blk_t blkaddr,
>>   void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>>   {
>> -    if (erofs_is_fscache_mode(sb))
>> +    if (erofs_is_fscache_mode(sb)) {
>>           buf->inode = EROFS_SB(sb)->s_fscache->inode;
>> -    else
>> -        buf->inode = sb->s_bdev->bd_inode;
>> +        buf->bdev = NULL;
>> +        buf->blkszbits = buf->inode->i_blkbits;
>> +    } else {
>> +        buf->inode = NULL;
>> +        buf->bdev = sb->s_bdev;
>> +        buf->blkszbits = EROFS_SB(sb)->blkszbits;
>> +    }
>>   }
>>   void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index b0409badb017..c9206351b485 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -224,8 +224,10 @@ enum erofs_kmap_type {
>>   struct erofs_buf {
>>       struct inode *inode;
>> +    struct block_device *bdev;
>>       struct page *page;
>>       void *base;
>> +    u8 blkszbits;
>>       enum erofs_kmap_type kmap_type;
>>   };
>>   #define __EROFS_BUF_INITIALIZER    ((struct erofs_buf){ .page = NULL })
> .
> 

