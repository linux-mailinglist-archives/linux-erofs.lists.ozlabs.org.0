Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9D44AE91
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 14:14:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpT3B5v3tz2yQC
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 00:14:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RqZ7DgE9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RqZ7DgE9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpT372rc1z2xth
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 00:14:27 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72DA361152;
 Tue,  9 Nov 2021 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636463663;
 bh=tnv+FFewn2OdL3YaMozQgYvvCCc5Y4bljpO86LE2UBg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RqZ7DgE96A38SycEAptGIDzCs8Oew0gcqo8zpKBGwkztJU06aWtUG5okeZxjdIHOG
 Azv5ZVTB305Gl1HLDMgSKS+FYbDGMEe0r6r7kOmkIikuNRr15qclUXpKwNyYYx0442
 9vOGLCn+Yms/LkoDOauDyY/wTXQMHXFNvzUPsWmxOTvUL1cMUQZIj5ihr1EgETK26/
 xhPdBZNuKftZ7lZEYRiYHYWbZXRkq1PN2YQkyr+TWLo5vYmtBGnTvB00tg5o7BOP9C
 48w+DL/JKh4yIJ5T9GAxyD0FdW0g9hAFF4K+B4kFZAiZ+5F+Nq1cqVT0hZCJvTftLg
 LrLkLEwioNEsw==
Message-ID: <d057b9da-c204-511d-4ae5-4735f5f40d7f@kernel.org>
Date: Tue, 9 Nov 2021 21:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/2] erofs: add sysfs interface
Content-Language: en-US
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org
References: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
 <20211109074536.23137-1-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211109074536.23137-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, zhangshiming@oppo.com, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/9 15:45, Huang Jianan via Linux-erofs wrote:
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
> changes since v1:
> - Add sysfs API documentation.
> - Use sysfs_emit over snprintf.
> 
>   Documentation/ABI/testing/sysfs-fs-erofs |   7 +
>   fs/erofs/Makefile                        |   2 +-
>   fs/erofs/internal.h                      |  10 +
>   fs/erofs/super.c                         |  12 ++
>   fs/erofs/sysfs.c                         | 237 +++++++++++++++++++++++
>   5 files changed, 267 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
>   create mode 100644 fs/erofs/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> new file mode 100644
> index 000000000000..86d0d0234473
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -0,0 +1,7 @@
> +What:		/sys/fs/erofs/features/
> +Date:		November 2021
> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> +Description:	Shows all enabled kernel features.
> +		Supported features:
> +		lz4_0padding, compr_cfgs, big_pcluster, device_table,
> +		sb_chksum.
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 756fe2d65272..8a3317e38e5a 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3265688af7f9..d0cd712dc222 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -134,6 +134,10 @@ struct erofs_sb_info {
>   	u8 volume_name[16];             /* volume name */
>   	u32 feature_compat;
>   	u32 feature_incompat;
> +
> +	/* sysfs support */
> +	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
> +	struct completion s_kobj_unregister;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -498,6 +502,12 @@ int erofs_pcpubuf_growsize(unsigned int nrpages);
>   void erofs_pcpubuf_init(void);
>   void erofs_pcpubuf_exit(void);
>   
> +/* sysfs.c */
> +int erofs_register_sysfs(struct super_block *sb);
> +void erofs_unregister_sysfs(struct super_block *sb);
> +int __init erofs_init_sysfs(void);
> +void erofs_exit_sysfs(void);
> +
>   /* utils.c / zdata.c */
>   struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
>   static inline void erofs_pagepool_add(struct page **pagepool,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 6a969b1e0ee6..abc1da5d1719 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -695,6 +695,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		return err;
>   
> +	err = erofs_register_sysfs(sb);
> +	if (err)
> +		return err;
> +
>   	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
>   	return 0;
>   }
> @@ -808,6 +812,7 @@ static void erofs_put_super(struct super_block *sb)
>   
>   	DBG_BUGON(!sbi);
>   
> +	erofs_unregister_sysfs(sb);
>   	erofs_shrinker_unregister(sb);
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	iput(sbi->managed_cache);
> @@ -852,6 +857,10 @@ static int __init erofs_module_init(void)
>   	if (err)
>   		goto zip_err;
>   
> +	err = erofs_init_sysfs();
> +	if (err)
> +		goto sysfs_err;
> +
>   	err = register_filesystem(&erofs_fs_type);
>   	if (err)
>   		goto fs_err;
> @@ -859,6 +868,8 @@ static int __init erofs_module_init(void)
>   	return 0;
>   
>   fs_err:
> +	erofs_exit_sysfs();
> +sysfs_err:
>   	z_erofs_exit_zip_subsystem();
>   zip_err:
>   	z_erofs_lzma_exit();
> @@ -877,6 +888,7 @@ static void __exit erofs_module_exit(void)
>   	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
>   	rcu_barrier();
>   
> +	erofs_exit_sysfs();
>   	z_erofs_exit_zip_subsystem();
>   	z_erofs_lzma_exit();
>   	erofs_exit_shrinker();
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> new file mode 100644
> index 000000000000..dd328d20c451
> --- /dev/null
> +++ b/fs/erofs/sysfs.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
> + *             https://www.oppo.com/
> + */
> +#include <linux/sysfs.h>
> +#include <linux/kobject.h>
> +
> +#include "internal.h"
> +
> +enum {
> +	attr_feature,
> +	attr_pointer_ui,
> +	attr_pointer_bool,
> +};
> +
> +enum {
> +	struct_erofs_sb_info,
> +};
> +
> +struct erofs_attr {
> +	struct attribute attr;
> +	short attr_id;
> +	int struct_type;
> +	int offset;
> +};
> +
> +#define EROFS_ATTR(_name, _mode, _id)					\
> +static struct erofs_attr erofs_attr_##_name = {				\
> +	.attr = {.name = __stringify(_name), .mode = _mode },		\
> +	.attr_id = attr_##_id,						\
> +}
> +#define EROFS_ATTR_FUNC(_name, _mode)	EROFS_ATTR(_name, _mode, _name)
> +#define EROFS_ATTR_FEATURE(_name)	EROFS_ATTR(_name, 0444, feature)
> +
> +#define EROFS_ATTR_OFFSET(_name, _mode, _id, _struct)	\
> +static struct erofs_attr erofs_attr_##_name = {			\
> +	.attr = {.name = __stringify(_name), .mode = _mode },	\
> +	.attr_id = attr_##_id,					\
> +	.struct_type = struct_##_struct,			\
> +	.offset = offsetof(struct _struct, _name),\
> +}
> +
> +#define EROFS_ATTR_RW(_name, _id, _struct)	\
> +	EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
> +
> +#define EROFS_RO_ATTR(_name, _id, _struct)	\
> +	EROFS_ATTR_OFFSET(_name, 0444, _id, _struct)
> +
> +#define EROFS_ATTR_RW_UI(_name, _struct)	\
> +	EROFS_ATTR_RW(_name, pointer_ui, _struct)
> +
> +#define EROFS_ATTR_RW_BOOL(_name, _struct)	\
> +	EROFS_ATTR_RW(_name, pointer_bool, _struct)
> +
> +#define ATTR_LIST(name) (&erofs_attr_##name.attr)
> +
> +static struct attribute *erofs_attrs[] = {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(erofs);
> +
> +/* Features this copy of erofs supports */
> +EROFS_ATTR_FEATURE(lz4_0padding);
> +EROFS_ATTR_FEATURE(compr_cfgs);
> +EROFS_ATTR_FEATURE(big_pcluster);
> +EROFS_ATTR_FEATURE(device_table);
> +EROFS_ATTR_FEATURE(sb_chksum);
> +
> +static struct attribute *erofs_feat_attrs[] = {
> +	ATTR_LIST(lz4_0padding),
> +	ATTR_LIST(compr_cfgs),
> +	ATTR_LIST(big_pcluster),
> +	ATTR_LIST(device_table),
> +	ATTR_LIST(sb_chksum),
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(erofs_feat);
> +
> +static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
> +					  int struct_type, int offset)
> +{
> +	if (struct_type == struct_erofs_sb_info)
> +		return (unsigned char *)sbi + offset;
> +	return NULL;
> +}
> +
> +static ssize_t erofs_attr_show(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +						s_kobj);
> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
> +
> +	switch (a->attr_id) {
> +	case attr_feature:
> +		return sysfs_emit(buf, "supported\n");
> +	case attr_pointer_ui:
> +		if (!ptr)
> +			return 0;
> +		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
> +	case attr_pointer_bool:
> +		if (!ptr)
> +			return 0;
> +		return sysfs_emit(buf, *(bool *)ptr ? "true\n" : "false\n");

Is it fine to just print 1 or 0 like the value user set via the sysfs entry
to indicate true or false.

> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
> +						const char *buf, size_t len)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +						s_kobj);
> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
> +	unsigned long t;
> +	int ret;
> +
> +	switch (a->attr_id) {
> +	case attr_pointer_ui:
> +		if (!ptr)
> +			return 0;
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;

if (t > UINT_MAX)
	return -EINVAL;

> +		*((unsigned int *) ptr) = t;
> +		return len;
> +	case attr_pointer_bool:
> +		if (!ptr)
> +			return 0;
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;

@t should be 0 or 1?

if (t != 0 && t != 1)
	return -EINVAL;

Thanks,

> +		*((bool *) ptr) = !!t;
> +		return len;
> +	}
> +
> +	return 0;
> +}
> +
> +static void erofs_sb_release(struct kobject *kobj)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +								s_kobj);
> +	complete(&sbi->s_kobj_unregister);
> +}
> +
> +static const struct sysfs_ops erofs_attr_ops = {
> +	.show	= erofs_attr_show,
> +	.store	= erofs_attr_store,
> +};
> +
> +static struct kobj_type erofs_sb_ktype = {
> +	.default_groups = erofs_groups,
> +	.sysfs_ops	= &erofs_attr_ops,
> +	.release	= erofs_sb_release,
> +};
> +
> +static struct kobj_type erofs_ktype = {
> +	.sysfs_ops	= &erofs_attr_ops,
> +};
> +
> +static struct kset erofs_root = {
> +	.kobj	= {.ktype = &erofs_ktype},
> +};
> +
> +static struct kobj_type erofs_feat_ktype = {
> +	.default_groups = erofs_feat_groups,
> +	.sysfs_ops	= &erofs_attr_ops,
> +};
> +
> +static struct kobject erofs_feat = {
> +	.kset	= &erofs_root,
> +};
> +
> +int erofs_register_sysfs(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	int err;
> +
> +	sbi->s_kobj.kset = &erofs_root;
> +	init_completion(&sbi->s_kobj_unregister);
> +	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL,
> +				"%s", sb->s_id);
> +	if (err)
> +		goto put_sb_kobj;
> +
> +	return 0;
> +
> +put_sb_kobj:
> +	kobject_put(&sbi->s_kobj);
> +	wait_for_completion(&sbi->s_kobj_unregister);
> +	return err;
> +}
> +
> +void erofs_unregister_sysfs(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	kobject_del(&sbi->s_kobj);
> +	kobject_put(&sbi->s_kobj);
> +	wait_for_completion(&sbi->s_kobj_unregister);
> +}
> +
> +int __init erofs_init_sysfs(void)
> +{
> +	int ret;
> +
> +	kobject_set_name(&erofs_root.kobj, "erofs");
> +	erofs_root.kobj.parent = fs_kobj;
> +	ret = kset_register(&erofs_root);
> +	if (ret)
> +		goto root_err;
> +
> +	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
> +				   NULL, "features");
> +	if (ret)
> +		goto feat_err;
> +
> +	return ret;
> +
> +feat_err:
> +	kobject_put(&erofs_feat);
> +	kset_unregister(&erofs_root);
> +root_err:
> +	return ret;
> +}
> +
> +void erofs_exit_sysfs(void)
> +{
> +	kobject_put(&erofs_feat);
> +	kset_unregister(&erofs_root);
> +}
> +
> 
