Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874380E456
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 07:36:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sq85W3sc2z3bPM
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 17:36:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sq85L19tNz30PD
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 17:36:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=50;SR=0;TI=SMTPD_---0VyLR3Ee_1702362952;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyLR3Ee_1702362952)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 14:35:54 +0800
Message-ID: <1812c1bf-08b5-46a5-a633-12470e2c8f18@linux.alibaba.com>
Date: Tue, 12 Dec 2023 14:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 for-6.8/block 11/18] erofs: use bdev api
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, roger.pau@citrix.com,
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231211140722.974745-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, gfs2@lists.linux.dev, linux-scsi@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, yukuai3@huawei.com, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/11 22:07, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_devcie.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   fs/erofs/data.c     | 18 ++++++++++++------
>   fs/erofs/internal.h |  2 ++
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index c98aeda8abb2..8cf3618190ab 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -32,8 +32,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>   		  enum erofs_kmap_type type)
>   {
> -	struct inode *inode = buf->inode;
> -	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
> +	erofs_off_t offset = (erofs_off_t)blkaddr << buf->blkszbits;
I'd suggest that use `buf->blkszbits` only for bdev_read_folio() since
erofs_init_metabuf() is not always called before erofs_bread() is used.

For example, buf->inode can be one of directory inodes other than
initialized by erofs_init_metabuf().

Thanks,
Gao Xiang


>   	pgoff_t index = offset >> PAGE_SHIFT;
>   	struct page *page = buf->page;
>   	struct folio *folio;
> @@ -43,7 +42,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>   		erofs_put_metabuf(buf);
>   
>   		nofs_flag = memalloc_nofs_save();
> -		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
> +		folio = buf->inode ?
> +			read_mapping_folio(buf->inode->i_mapping, index, NULL) :
> +			bdev_read_folio(buf->bdev, offset);
>   		memalloc_nofs_restore(nofs_flag);
>   		if (IS_ERR(folio))
>   			return folio;
> @@ -67,10 +68,15 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>   
>   void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>   {
> -	if (erofs_is_fscache_mode(sb))
> +	if (erofs_is_fscache_mode(sb)) {
>   		buf->inode = EROFS_SB(sb)->s_fscache->inode;
> -	else
> -		buf->inode = sb->s_bdev->bd_inode;
> +		buf->bdev = NULL;
> +		buf->blkszbits = buf->inode->i_blkbits;
> +	} else {
> +		buf->inode = NULL;
> +		buf->bdev = sb->s_bdev;
> +		buf->blkszbits = EROFS_SB(sb)->blkszbits;
> +	}
>   }
>   
>   void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index b0409badb017..c9206351b485 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -224,8 +224,10 @@ enum erofs_kmap_type {
>   
>   struct erofs_buf {
>   	struct inode *inode;
> +	struct block_device *bdev;
>   	struct page *page;
>   	void *base;
> +	u8 blkszbits;
>   	enum erofs_kmap_type kmap_type;
>   };
>   #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
