Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B56ABA66
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:53:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVYmM4CNVz3cFH
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:53:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVYmH5ztQz3bfk
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:53:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdETNzd_1678096378;
Received: from 30.221.131.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdETNzd_1678096378)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 17:52:59 +0800
Message-ID: <8a83a2c7-2c46-5988-4d49-f376ad8c1ca5@linux.alibaba.com>
Date: Mon, 6 Mar 2023 17:52:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/2] erofs: set block size to the on-disk block size
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
 <20230302143915.111739-3-jefflexu@linux.alibaba.com>
 <20230306153108.00006877.zbestahu@gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230306153108.00006877.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/6/23 3:31 PM, Yue Hu wrote:
> On Thu,  2 Mar 2023 22:39:15 +0800
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Set the block size to that specified in on-disk superblock.
>>
>> Also remove the hard constraint of PAGE_SIZE block size for the
>> uncompressed device backend.  This constraint is temporarily remained
>> for compressed device and fscache backend, as there is more work needed
>> to handle the condition where the block size is not equal to PAGE_SIZE.
>>
>> It is worth noting that the on-disk block size is read prior to
>> erofs_superblock_csum_verify(), as the read block size is needed in the
>> latter.
>>
>> Besides, later we are going to make erofs refer to tar data blobs (which
>> is 512-byte aligned) for OCI containers, where the block size is 512
>> bytes.  In this case, the 512-byte block size may not be adequate for a
>> directory to contain enough dirents.  To fix this, we are also going to
>> introduce directory block size independent on the block size.
>>
>> Due to we have already supported block size smaller than PAGE_SIZE now,
>> disable all these images with such separated directory block size until
>> we supported this feature later.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/erofs_fs.h |  5 +++--
>>  fs/erofs/inode.c    |  3 ++-
>>  fs/erofs/internal.h | 11 ++---------
>>  fs/erofs/super.c    | 46 +++++++++++++++++++++++++++++----------------
>>  4 files changed, 37 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>> index dbcd24371002..ac9c2ff3aa66 100644
>> --- a/fs/erofs/erofs_fs.h
>> +++ b/fs/erofs/erofs_fs.h
>> @@ -53,7 +53,7 @@ struct erofs_super_block {
>>  	__le32 magic;           /* file system magic number */
>>  	__le32 checksum;        /* crc32c(super_block) */
>>  	__le32 feature_compat;
>> -	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
>> +	__u8 blkszbits;         /* filesystem block size */
> 
> /* filesystem block size in bit shift */
> 
>>  	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>>  
>>  	__le16 root_nid;	/* nid of root directory */
>> @@ -75,7 +75,8 @@ struct erofs_super_block {
>>  	} __packed u1;
>>  	__le16 extra_devices;	/* # of devices besides the primary device */
>>  	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
>> -	__u8 reserved[6];
>> +	__u8 dirblkbits;	/* directory block size */
> 
> Ditto.
> 
>> +	__u8 reserved[5];
>>  	__le64 packed_nid;	/* nid of the special packed inode */
>>  	__u8 reserved2[24];
>>  };
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index de26dac4e07e..0e6ff8a98c68 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
>>  	}
>>  
>>  	if (erofs_inode_is_data_compressed(vi->datalayout)) {
>> -		if (!erofs_is_fscache_mode(inode->i_sb))
>> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
>> +		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
>>  			err = z_erofs_fill_inode(inode);
>>  		else
>>  			err = -EOPNOTSUPP;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index d8019d835405..f99ba4061a3b 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -148,7 +148,8 @@ struct erofs_sb_info {
>>  	u16 device_id_mask;	/* valid bits of device id to be used */
>>  
>>  	unsigned char islotbits;	/* inode slot unit size in bit shift */
>> -	unsigned char blkszbits;
>> +	unsigned char blkszbits;	/* filesystem block size */
> 
> Ditto.
> 
>> +	unsigned char dirblkbits;	/* directory block size */
> 
> Ditto.
> 
>>  
>>  	u32 sb_size;			/* total superblock size */
>>  	u32 build_time_nsec;
>> @@ -240,14 +241,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>>  					VAL != EROFS_LOCKED_MAGIC);
>>  }
>>  
>> -/* we strictly follow PAGE_SIZE and no buffer head yet */
>> -#define LOG_BLOCK_SIZE		PAGE_SHIFT
>> -#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
>> -
>> -#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
>> -#error erofs cannot be used in this platform
>> -#endif
>> -
>>  enum erofs_kmap_type {
>>  	EROFS_NO_KMAP,		/* don't map the buffer */
>>  	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index c97615c96ef8..d5fa0f582cbe 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -330,7 +330,6 @@ static int erofs_read_superblock(struct super_block *sb)
>>  	struct erofs_sb_info *sbi;
>>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>  	struct erofs_super_block *dsb;
>> -	unsigned int blkszbits;
>>  	void *data;
>>  	int ret;
>>  
>> @@ -349,6 +348,17 @@ static int erofs_read_superblock(struct super_block *sb)
>>  		goto out;
>>  	}
>>  
>> +	sbi->blkszbits  = dsb->blkszbits;
>> +	sbi->dirblkbits = dsb->dirblkbits;
>> +	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
>> +		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
>> +		goto out;
>> +	}
>> +	if (sbi->dirblkbits) {
>> +		erofs_err(sb, "dirblkbits %u isn't supported", sbi->dirblkbits);
>> +		goto out;
>> +	}
>> +
>>  	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
>>  	if (erofs_sb_has_sb_chksum(sbi)) {
>>  		ret = erofs_superblock_csum_verify(sb, data);
>> @@ -357,19 +367,11 @@ static int erofs_read_superblock(struct super_block *sb)
>>  	}
>>  
>>  	ret = -EINVAL;
>> -	blkszbits = dsb->blkszbits;
>> -	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>> -	if (blkszbits != LOG_BLOCK_SIZE) {
>> -		erofs_err(sb, "blkszbits %u isn't supported on this platform",
>> -			  blkszbits);
>> -		goto out;
>> -	}
>> -
>>  	if (!check_layout_compatibility(sb, dsb))
>>  		goto out;
>>  
>>  	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
>> -	if (sbi->sb_size > EROFS_BLKSIZ) {
>> +	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
>>  		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
>>  			  sbi->sb_size);
>>  		goto out;
>> @@ -736,8 +738,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>  
>>  	sbi->blkszbits = PAGE_SHIFT;
>>  	if (erofs_is_fscache_mode(sb)) {
>> -		sb->s_blocksize = EROFS_BLKSIZ;
>> -		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
>> +		sb->s_blocksize = PAGE_SIZE;
>> +		sb->s_blocksize_bits = PAGE_SHIFT;
>>  
>>  		err = erofs_fscache_register_fs(sb);
>>  		if (err)
>> @@ -747,8 +749,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>  		if (err)
>>  			return err;
>>  	} else {
>> -		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
>> -			erofs_err(sb, "failed to set erofs blksize");
>> +		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
>> +			errorfc(fc, "failed to set initial blksize");
>>  			return -EINVAL;
>>  		}
>>  
>> @@ -761,12 +763,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>  	if (err)
>>  		return err;
>>  
>> -	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
>> -		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
>> +	if (sb->s_blocksize_bits != sbi->blkszbits) {
>> +		if (erofs_is_fscache_mode(sb)) {
>> +			errorfc(fc, "unsupported blksize for fscache mode");
>> +			return -EINVAL;
>> +		}
>> +		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
>> +			errorfc(fc, "failed to set erofs blksize");
>> +			return -EINVAL;
>> +		}
>> +	}
>>  
>> +	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
>>  		if (!sbi->dax_dev) {
>>  			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
>>  			clear_opt(&sbi->opt, DAX_ALWAYS);
>> +		} else if (sbi->blkszbits != PAGE_SHIFT) {
>> +			errorfc(fc, "unsupported blocksize for DAX");
>> +			clear_opt(&sbi->opt, DAX_ALWAYS);
>>  		}
>>  	}
>>  

Thanks for the review.  I will update all these in the next version.

-- 
Thanks,
Jingbo
