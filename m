Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB21C7C402
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 15:50:25 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zFDZ23ykzDqkf
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 23:50:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zCxX2c4VzDqkK
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2019 22:52:15 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2B0487633890531DD7CB;
 Wed, 31 Jul 2019 20:52:09 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 20:52:02 +0800
Subject: Re: [PATCH 11/22] staging: erofs: kill all failure handling in
 fill_super()
To: Chao Yu <yuchao0@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-12-gaoxiang25@huawei.com>
 <56bdc87a-635f-e596-584e-fca0acb4a69e@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c0c198e5-cc91-e2d1-4f54-9d9ae65c4aa3@huawei.com>
Date: Wed, 31 Jul 2019 20:52:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <56bdc87a-635f-e596-584e-fca0acb4a69e@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On 2019/7/31 16:15, Chao Yu wrote:
> On 2019/7/29 14:51, Gao Xiang wrote:
>> .kill_sb() will do that instead in order to remove duplicated code.
>>
>> Note that the initialzation of managed_cache is now moved
>> after s_root is assigned since it's more preferred to iput()
>> in .put_super() and all inodes should be evicted before
>> the end of generic_shutdown_super(sb).
>>
>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>  drivers/staging/erofs/super.c | 121 +++++++++++++++-------------------
>>  1 file changed, 53 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
>> index bfb6e1e09781..af5d87793e4d 100644
>> --- a/drivers/staging/erofs/super.c
>> +++ b/drivers/staging/erofs/super.c
>> @@ -343,51 +343,52 @@ static const struct address_space_operations managed_cache_aops = {
>>  	.invalidatepage = managed_cache_invalidatepage,
>>  };
>>  
>> -static struct inode *erofs_init_managed_cache(struct super_block *sb)
>> +static int erofs_init_managed_cache(struct super_block *sb)
>>  {
>> -	struct inode *inode = new_inode(sb);
>> +	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>> +	struct inode *const inode = new_inode(sb);
>>  
>>  	if (unlikely(!inode))
>> -		return ERR_PTR(-ENOMEM);
>> +		return -ENOMEM;
>>  
>>  	set_nlink(inode, 1);
>>  	inode->i_size = OFFSET_MAX;
>>  
>>  	inode->i_mapping->a_ops = &managed_cache_aops;
>>  	mapping_set_gfp_mask(inode->i_mapping,
>> -			     GFP_NOFS | __GFP_HIGHMEM |
>> -			     __GFP_MOVABLE |  __GFP_NOFAIL);
>> -	return inode;
>> +			     GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);

Seems so, I will add a new patch addressing on it if needed.

Thanks,
Gao Xiang

> 
> It looks above change is not belong to this patch?
> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> +	sbi->managed_cache = inode;
>> +	return 0;
>>  }
>> -
>> +#else
>> +static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>>  #endif
>>  
>>  static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>>  {
>>  	struct inode *inode;
>>  	struct erofs_sb_info *sbi;
>> -	int err = -EINVAL;
>> +	int err;
>>  
>>  	infoln("fill_super, device -> %s", sb->s_id);
>>  	infoln("options -> %s", (char *)data);
>>  
>> +	sb->s_magic = EROFS_SUPER_MAGIC;
>> +
>>  	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
>>  		errln("failed to set erofs blksize");
>> -		goto err;
>> +		return -EINVAL;
>>  	}
>>  
>>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> -	if (unlikely(!sbi)) {
>> -		err = -ENOMEM;
>> -		goto err;
>> -	}
>> -	sb->s_fs_info = sbi;
>> +	if (unlikely(!sbi))
>> +		return -ENOMEM;
>>  
>> +	sb->s_fs_info = sbi;
>>  	err = superblock_read(sb);
>>  	if (err)
>> -		goto err_sbread;
>> +		return err;
>>  
>> -	sb->s_magic = EROFS_SUPER_MAGIC;
>>  	sb->s_flags |= SB_RDONLY | SB_NOATIME;
>>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>  	sb->s_time_gran = 1;
>> @@ -397,13 +398,12 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>>  #ifdef CONFIG_EROFS_FS_XATTR
>>  	sb->s_xattr = erofs_xattr_handlers;
>>  #endif
>> -
>>  	/* set erofs default mount options */
>>  	default_options(sbi);
>>  
>>  	err = parse_options(sb, data);
>> -	if (err)
>> -		goto err_parseopt;
>> +	if (unlikely(err))
>> +		return err;
>>  
>>  	if (!silent)
>>  		infoln("root inode @ nid %llu", ROOT_NID(sbi));
>> @@ -417,93 +417,78 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>>  	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
>>  #endif
>>  
>> -#ifdef EROFS_FS_HAS_MANAGED_CACHE
>> -	sbi->managed_cache = erofs_init_managed_cache(sb);
>> -	if (IS_ERR(sbi->managed_cache)) {
>> -		err = PTR_ERR(sbi->managed_cache);
>> -		goto err_init_managed_cache;
>> -	}
>> -#endif
>> -
>>  	/* get the root inode */
>>  	inode = erofs_iget(sb, ROOT_NID(sbi), true);
>> -	if (IS_ERR(inode)) {
>> -		err = PTR_ERR(inode);
>> -		goto err_iget;
>> -	}
>> +	if (IS_ERR(inode))
>> +		return PTR_ERR(inode);
>>  
>> -	if (!S_ISDIR(inode->i_mode)) {
>> +	if (unlikely(!S_ISDIR(inode->i_mode))) {
>>  		errln("rootino(nid %llu) is not a directory(i_mode %o)",
>>  		      ROOT_NID(sbi), inode->i_mode);
>> -		err = -EINVAL;
>>  		iput(inode);
>> -		goto err_iget;
>> +		return -EINVAL;
>>  	}
>>  
>>  	sb->s_root = d_make_root(inode);
>> -	if (!sb->s_root) {
>> -		err = -ENOMEM;
>> -		goto err_iget;
>> -	}
>> +	if (unlikely(!sb->s_root))
>> +		return -ENOMEM;
>>  
>>  	erofs_shrinker_register(sb);
>> +	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
>> +	err = erofs_init_managed_cache(sb);
>> +	if (unlikely(err))
>> +		return err;
>>  
>>  	if (!silent)
>>  		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
>>  	return 0;
>> -	/*
>> -	 * please add a label for each exit point and use
>> -	 * the following name convention, thus new features
>> -	 * can be integrated easily without renaming labels.
>> -	 */
>> -err_iget:
>> -#ifdef EROFS_FS_HAS_MANAGED_CACHE
>> -	iput(sbi->managed_cache);
>> -err_init_managed_cache:
>> -#endif
>> -err_parseopt:
>> -err_sbread:
>> -	sb->s_fs_info = NULL;
>> -	kfree(sbi);
>> -err:
>> -	return err;
>> +}
>> +
>> +static struct dentry *erofs_mount(struct file_system_type *fs_type, int flags,
>> +				  const char *dev_name, void *data)
>> +{
>> +	return mount_bdev(fs_type, flags, dev_name, data, erofs_fill_super);
>>  }
>>  
>>  /*
>>   * could be triggered after deactivate_locked_super()
>>   * is called, thus including umount and failed to initialize.
>>   */
>> -static void erofs_put_super(struct super_block *sb)
>> +static void erofs_kill_sb(struct super_block *sb)
>>  {
>> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	struct erofs_sb_info *sbi;
>> +
>> +	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>> +	infoln("unmounting for %s", sb->s_id);
>>  
>> -	/* for cases which are failed in "read_super" */
>> +	kill_block_super(sb);
>> +
>> +	sbi = EROFS_SB(sb);
>>  	if (!sbi)
>>  		return;
>> +	kfree(sbi);
>> +	sb->s_fs_info = NULL;
>> +}
>>  
>> -	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>> +/* called when ->s_root is non-NULL */
>> +static void erofs_put_super(struct super_block *sb)
>> +{
>> +	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>>  
>> -	infoln("unmounted for %s", sb->s_id);
>> +	DBG_BUGON(!sbi);
>>  
>>  	erofs_shrinker_unregister(sb);
>>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>>  	iput(sbi->managed_cache);
>> +	sbi->managed_cache = NULL;
>>  #endif
>> -	kfree(sbi);
>> -	sb->s_fs_info = NULL;
>> -}
>> -
>> -static struct dentry *erofs_mount(struct file_system_type *fs_type, int flags,
>> -				  const char *dev_name, void *data)
>> -{
>> -	return mount_bdev(fs_type, flags, dev_name, data, erofs_fill_super);
>>  }
>>  
>>  static struct file_system_type erofs_fs_type = {
>>  	.owner          = THIS_MODULE,
>>  	.name           = "erofs",
>>  	.mount          = erofs_mount,
>> -	.kill_sb        = kill_block_super,
>> +	.kill_sb        = erofs_kill_sb,
>>  	.fs_flags       = FS_REQUIRES_DEV,
>>  };
>>  MODULE_ALIAS_FS("erofs");
>>
