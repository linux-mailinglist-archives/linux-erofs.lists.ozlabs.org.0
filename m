Return-Path: <linux-erofs+bounces-907-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D06B3515E
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Aug 2025 04:08:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9rgR2njMz3cy9;
	Tue, 26 Aug 2025 12:08:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756174131;
	cv=none; b=oFvuNBcySkRp3nD/RS8iaOETCKHk58FsjLY9PcPEMrG5Ki9UMWEoGASD33FANsyOCo1vb8Mn6SPpF1SkHlpUfo2SK1RHcywuus0xw4fEeIgMGk4m+g6AwneuCUms77CRoSf+SAX9OVjqPY50LRBN3srOvtGiQmWldk+xuEf+qYxHSflW22FQzyqZLaqUDFB28FWrx31hINNsEHB7nkqPdJisvkMMyqxC5tLxOsavHqj5sqeYoupWZzz4ThvG969MwWGeUUALq4DaEp7PdLYJ4jmQAcQDsW613/pVjV02oJlin+Chk4YrTqQqaIBMIwb3RgKHEUaDN2cF8TqLDZqnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756174131; c=relaxed/relaxed;
	bh=AX9vqeDGu6HN/GW80qXcpyc7q+WJpV42IiKw1mJxe/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5eA3YND/pBhvgcAXhkOANgJiodiYoMDNd/p8olCxA9LCq9w/mpDVps3zYfpeKDW2bU1bdUISmOjMkVeZuElu6IcKtyrvHygALZ2LFunSO5IOxWVrazGXJDv2xa1rtXVSebYo+NQNNmvwBFAL8XuhroKufjBrfmqxphwvRp6q2j7sfn3/dNTtJ4GbUA0ih/vDpX5Jain+qflUYN01bgaoaFduaoXS7Wz0oZ2TDI3Jyut61t+0LdW6U7ASY7V6u6CzW4j80u3MLrmtvh1uAoGk2xXKDtRyYlR1rdABvkqWb0DEJcJ3n640ehpoNDk6HT/Ewjb+N5tpzq4CwT9uKPmDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fu8l2nTB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fu8l2nTB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9rgN6Cdmz3cQq
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 12:08:47 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756174123; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AX9vqeDGu6HN/GW80qXcpyc7q+WJpV42IiKw1mJxe/Y=;
	b=Fu8l2nTBYuq0wdcQi7CZrFwJPr41Qm9rtnph5DiFSqPpBNITDCQOqJcENQ5tqitF2ibTnBh0IGFacAlqIKW+OBrCT1um4PkwPGZYxT/iz7qv2r5BKaikusg0MZChcXjhfApx2X0FlpAwv7SI+K5xSydg8B7ttv4BV67gvVUmAZs=
Received: from 30.221.130.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmc2raN_1756174120 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 10:08:40 +0800
Message-ID: <9251e366-06ea-405d-9980-e90c1a48aaaa@linux.alibaba.com>
Date: Tue, 26 Aug 2025 10:08:38 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20250825120617.19746-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250825120617.19746-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

On 2025/8/25 20:06, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> ---
>   fs/erofs/Makefile   |  2 +-
>   fs/erofs/data.c     |  4 ++++
>   fs/erofs/dir.c      |  4 ++++
>   fs/erofs/inode.c    |  2 +-
>   fs/erofs/internal.h | 10 ++++++++++
>   fs/erofs/ioctl.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  2 ++
>   fs/erofs/zdata.c    | 11 +++++++++++
>   8 files changed, 80 insertions(+), 2 deletions(-)
>   create mode 100644 fs/erofs/ioctl.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..5be6cc4acc1c 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3b1ba571c728..8ca29962a3dd 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
>   const struct file_operations erofs_file_fops = {
>   	.llseek		= erofs_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   	.mmap_prepare	= erofs_file_mmap_prepare,
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index debf469ad6bd..32b4f5aa60c9 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read		= generic_read_dir,
>   	.iterate_shared	= erofs_readdir,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 9a2f59721522..9248143e26df 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -214,7 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
>   		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			inode->i_fop = &generic_ro_fops;
> +			inode->i_fop = &z_erofs_file_fops;

Please also just use erofs_file_fops instead and adjust
erofs_file_read_iter() for example.

>   		else
>   			inode->i_fop = &erofs_file_fops;
>   		break;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ccc5f0ee8df..2f874b920c8b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -32,6 +32,8 @@ __printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
>   #define DBG_BUGON(x)            ((void)(x))
>   #endif	/* !CONFIG_EROFS_FS_DEBUG */
>   
> +#define EROFS_VOLUME_LABEL_LEN	16
> +
>   /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
>   #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
>   
> @@ -166,6 +168,9 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	/* volume name */
> +	u8 volume_label[EROFS_VOLUME_LABEL_LEN];

	char *volume_name;

>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -404,6 +409,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations z_erofs_file_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> @@ -535,6 +541,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg);
> +
>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
>   
>   #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c
> new file mode 100644
> index 000000000000..10bfd593225f
> --- /dev/null
> +++ b/fs/erofs/ioctl.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/fs.h>
> +#include <linux/compat.h>
> +#include <linux/file.h>
> +
> +#include "erofs_fs.h"
> +#include "internal.h"
> +
> +static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
> +{
> +	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
> +	size_t len;
> +	int ret;
> +	char label[EROFS_VOLUME_LABEL_LEN];
> +
> +	memcpy(label, sbi->volume_label, EROFS_VOLUME_LABEL_LEN);
> +
> +	len = strnlen(label, EROFS_VOLUME_LABEL_LEN);
> +	if (len == EROFS_VOLUME_LABEL_LEN)
> +		erofs_err(inode->i_sb, "label is too long, return the first %zu bytes",
> +			  --len);

No needed.

> +
> +	ret = copy_to_user(arg, label, len);


	if (!sbi->volume_name)
		ret = clear_user(arg, 1);
	else
		ret = copy_to_user(arg, sbi->volume_name,
				   strlen(sbi->volume_name));
	return ret ? -EFAULT : 0;

...

> +
> +	return ret ? -EFAULT : 0;
> +}
> +
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	void __user *argp = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case FS_IOC_GETFSLABEL:
> +		return erofs_ioctl_get_volume_label(inode, argp);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +#ifdef CONFIG_COMPAT
> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg)
> +{
> +	return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#endif
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1b529ace4db0..e6ad6cf4ba82 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -343,6 +343,8 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>   	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>   
> +	memcpy(sbi->volume_label, dsb->volume_name, EROFS_VOLUME_LABEL_LEN);

	if (dsb->volume_name[0]) {
		sbi->volume_name = kstrndup(dsb->volume_name, dsb->volume_name, GFP_KERNEL);
		if (!sbi->volume_name) {
			...
		}
	}

Need to kfree(sbi->volume_name) properly too.

Thanks,
Gao Xiang

> +
>   	/* parse on-disk compression configurations */
>   	ret = z_erofs_parse_cfgs(sb, dsb);
>   	if (ret < 0)
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 2d73297003d2..b612bf7b2f08 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1931,3 +1931,14 @@ const struct address_space_operations z_erofs_aops = {
>   	.read_folio = z_erofs_read_folio,
>   	.readahead = z_erofs_readahead,
>   };
> +
> +const struct file_operations z_erofs_file_fops = {
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= generic_file_read_iter,
> +	.unlocked_ioctl	= erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= erofs_compat_ioctl,
> +#endif
> +	.mmap		= generic_file_readonly_mmap,
> +	.splice_read	= filemap_splice_read,
> +};


