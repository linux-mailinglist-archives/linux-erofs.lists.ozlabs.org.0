Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213F12B0DC
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2019 04:51:05 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47kXtG0fTMzDqG1
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Dec 2019 14:51:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47kXt22vzmzDqFZ
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Dec 2019 14:50:46 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 40510CCD4E87E58BFA84;
 Fri, 27 Dec 2019 11:50:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Dec 2019 11:50:35 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 27 Dec 2019 11:50:35 +0800
Date: Fri, 27 Dec 2019 11:50:16 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND] erofs: convert to use the new mount fs_context api
Message-ID: <20191227035016.GA142350@architecture4>
References: <20191226022519.53386-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191226022519.53386-1-yuchao0@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, David
 Howells <dhowells@redhat.com>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Al,

Greeting, we plan to convert erofs to new mount api for 5.6

and I just notice your branch
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=untested.fs_parse

do a lot further work on fs context (e.g. "get rid of ->enums",
"remove fs_parameter_description name field" and switch to
use XXXfc() instead of XXXf() with prefixed string).

Does it plan for 5.6 as well? If yes, we will update this patch
based on the latest branch and maybe have chance to go though
your tree if it can?

Thanks,
Gao Xiang

On Thu, Dec 26, 2019 at 10:25:19AM +0800, Chao Yu wrote:
> Convert the erofs to use new internal mount API as the old one will
> be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> +Cc David Howells
>  fs/erofs/internal.h |   2 +-
>  fs/erofs/super.c    | 249 +++++++++++++++++++++-----------------------
>  2 files changed, 118 insertions(+), 133 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1ed5beff7d11..a5fac25db6af 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -102,13 +102,13 @@ struct erofs_sb_info {
>  #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
>  #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
>  
> -#ifdef CONFIG_EROFS_FS_ZIP
>  enum {
>  	EROFS_ZIP_CACHE_DISABLED,
>  	EROFS_ZIP_CACHE_READAHEAD,
>  	EROFS_ZIP_CACHE_READAROUND
>  };
>  
> +#ifdef CONFIG_EROFS_FS_ZIP
>  #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
>  
>  /* basic unit of the workstation of a super_block */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 057e6d7b5b7f..b90713760885 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -10,6 +10,8 @@
>  #include <linux/parser.h>
>  #include <linux/seq_file.h>
>  #include <linux/crc32c.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -192,41 +194,6 @@ static int erofs_read_superblock(struct super_block *sb)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_EROFS_FS_ZIP
> -static int erofs_build_cache_strategy(struct super_block *sb,
> -				      substring_t *args)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	const char *cs = match_strdup(args);
> -	int err = 0;
> -
> -	if (!cs) {
> -		erofs_err(sb, "Not enough memory to store cache strategy");
> -		return -ENOMEM;
> -	}
> -
> -	if (!strcmp(cs, "disabled")) {
> -		sbi->cache_strategy = EROFS_ZIP_CACHE_DISABLED;
> -	} else if (!strcmp(cs, "readahead")) {
> -		sbi->cache_strategy = EROFS_ZIP_CACHE_READAHEAD;
> -	} else if (!strcmp(cs, "readaround")) {
> -		sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
> -	} else {
> -		erofs_err(sb, "Unrecognized cache strategy \"%s\"", cs);
> -		err = -EINVAL;
> -	}
> -	kfree(cs);
> -	return err;
> -}
> -#else
> -static int erofs_build_cache_strategy(struct super_block *sb,
> -				      substring_t *args)
> -{
> -	erofs_info(sb, "EROFS compression is disabled, so cache strategy is ignored");
> -	return 0;
> -}
> -#endif
> -
>  /* set up default EROFS parameters */
>  static void erofs_default_options(struct erofs_sb_info *sbi)
>  {
> @@ -251,73 +218,79 @@ enum {
>  	Opt_err
>  };
>  
> -static match_table_t erofs_tokens = {
> -	{Opt_user_xattr, "user_xattr"},
> -	{Opt_nouser_xattr, "nouser_xattr"},
> -	{Opt_acl, "acl"},
> -	{Opt_noacl, "noacl"},
> -	{Opt_cache_strategy, "cache_strategy=%s"},
> -	{Opt_err, NULL}
> +static const struct fs_parameter_spec erofs_param_specs[] = {
> +	fsparam_flag("user_xattr",	Opt_user_xattr),
> +	fsparam_flag("nouser_xattr",	Opt_nouser_xattr),
> +	fsparam_flag("acl",		Opt_acl),
> +	fsparam_flag("noacl",		Opt_noacl),
> +	fsparam_enum("cache_strategy",	Opt_cache_strategy),
> +	{}
>  };
>  
> -static int erofs_parse_options(struct super_block *sb, char *options)
> -{
> -	substring_t args[MAX_OPT_ARGS];
> -	char *p;
> -	int err;
> -
> -	if (!options)
> -		return 0;
> +static const struct fs_parameter_enum erofs_param_enums[] = {
> +	{ Opt_cache_strategy, "disabled",	EROFS_ZIP_CACHE_DISABLED },
> +	{ Opt_cache_strategy, "readahead",	EROFS_ZIP_CACHE_READAHEAD},
> +	{ Opt_cache_strategy, "readaround",	EROFS_ZIP_CACHE_READAROUND},
> +	{}
> +};
>  
> -	while ((p = strsep(&options, ","))) {
> -		int token;
> +static const struct fs_parameter_description erofs_fs_parameters = {
> +	.name	= "erofs",
> +	.specs	= erofs_param_specs,
> +	.enums	= erofs_param_enums,
> +};
>  
> -		if (!*p)
> -			continue;
> +static int erofs_fc_parse_param(struct fs_context *fc,
> +				struct fs_parameter *param)
> +{
> +	struct erofs_sb_info *sbi __maybe_unused = fc->s_fs_info;
> +	struct fs_parse_result result;
> +	int opt;
>  
> -		args[0].to = args[0].from = NULL;
> -		token = match_token(p, erofs_tokens, args);
> +	opt = fs_parse(fc, &erofs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
>  
> -		switch (token) {
> +	switch (opt) {
>  #ifdef CONFIG_EROFS_FS_XATTR
> -		case Opt_user_xattr:
> -			set_opt(EROFS_SB(sb), XATTR_USER);
> -			break;
> -		case Opt_nouser_xattr:
> -			clear_opt(EROFS_SB(sb), XATTR_USER);
> -			break;
> +	case Opt_user_xattr:
> +		set_opt(sbi, XATTR_USER);
> +		break;
> +	case Opt_nouser_xattr:
> +		clear_opt(sbi, XATTR_USER);
> +		break;
>  #else
> -		case Opt_user_xattr:
> -			erofs_info(sb, "user_xattr options not supported");
> -			break;
> -		case Opt_nouser_xattr:
> -			erofs_info(sb, "nouser_xattr options not supported");
> -			break;
> +	case Opt_user_xattr:
> +		invalf(fc, "erofs: user_xattr options not supported");
> +		break;
> +	case Opt_nouser_xattr:
> +		invalf(fc, "erofs: nouser_xattr options not supported");
> +		break;
>  #endif
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -		case Opt_acl:
> -			set_opt(EROFS_SB(sb), POSIX_ACL);
> -			break;
> -		case Opt_noacl:
> -			clear_opt(EROFS_SB(sb), POSIX_ACL);
> -			break;
> +	case Opt_acl:
> +		set_opt(sbi, POSIX_ACL);
> +		break;
> +	case Opt_noacl:
> +		clear_opt(sbi, POSIX_ACL);
> +		break;
> +#else
> +	case Opt_acl:
> +		invalf(fc, "erofs: acl options not supported");
> +		break;
> +	case Opt_noacl:
> +		invalf(fc, "erofs: noacl options not supported");
> +		break;
> +#endif
> +	case Opt_cache_strategy:
> +#ifdef CONFIG_EROFS_FS_ZIP
> +		sbi->cache_strategy = result.uint_32;
>  #else
> -		case Opt_acl:
> -			erofs_info(sb, "acl options not supported");
> -			break;
> -		case Opt_noacl:
> -			erofs_info(sb, "noacl options not supported");
> -			break;
> +		errorf(fc, "erofs: compression not supported, cache strategy ignored");
>  #endif
> -		case Opt_cache_strategy:
> -			err = erofs_build_cache_strategy(sb, args);
> -			if (err)
> -				return err;
> -			break;
> -		default:
> -			erofs_err(sb, "Unrecognized mount option \"%s\" or missing value", p);
> -			return -EINVAL;
> -		}
> +		break;
> +	default:
> +		return invalf(fc, "erofs: invalid mount option: %s", param->key);
>  	}
>  	return 0;
>  }
> @@ -381,7 +354,7 @@ static int erofs_init_managed_cache(struct super_block *sb)
>  static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>  #endif
>  
> -static int erofs_fill_super(struct super_block *sb, void *data, int silent)
> +static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
>  	struct erofs_sb_info *sbi;
> @@ -394,11 +367,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  		return -EINVAL;
>  	}
>  
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sb->s_fs_info = sbi;
> +	sbi = sb->s_fs_info;
>  	err = erofs_read_superblock(sb);
>  	if (err)
>  		return err;
> @@ -412,12 +381,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	sb->s_xattr = erofs_xattr_handlers;
>  #endif
> -	/* set erofs default mount options */
> -	erofs_default_options(sbi);
> -
> -	err = erofs_parse_options(sb, data);
> -	if (err)
> -		return err;
>  
>  	if (test_opt(sbi, POSIX_ACL))
>  		sb->s_flags |= SB_POSIXACL;
> @@ -450,15 +413,61 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (err)
>  		return err;
>  
> -	erofs_info(sb, "mounted with opts: %s, root inode @ nid %llu.",
> -		   (char *)data, ROOT_NID(sbi));
> +	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
> +	return 0;
> +}
> +
> +static int erofs_fc_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, erofs_fc_fill_super);
> +}
> +
> +static int erofs_fc_reconfigure(struct fs_context *fc)
> +{
> +	struct super_block *sb = fc->root->d_sb;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	DBG_BUGON(!sb_rdonly(sb));
> +
> +	if (test_opt(sbi, POSIX_ACL))
> +		fc->sb_flags |= SB_POSIXACL;
> +	else
> +		fc->sb_flags &= ~SB_POSIXACL;
> +
> +	fc->sb_flags |= SB_RDONLY;
>  	return 0;
>  }
>  
> -static struct dentry *erofs_mount(struct file_system_type *fs_type, int flags,
> -				  const char *dev_name, void *data)
> +static void erofs_fc_free(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, erofs_fill_super);
> +	/*
> +	 * sbi stored in fs_context will be cleaned after transferring
> +	 * to corresponding superblock on a successful new mount, or
> +	 * free it here.
> +	 */
> +	kfree(fc->s_fs_info);
> +}
> +
> +static const struct fs_context_operations erofs_context_ops = {
> +	.parse_param	= erofs_fc_parse_param,
> +	.get_tree       = erofs_fc_get_tree,
> +	.reconfigure    = erofs_fc_reconfigure,
> +	.free		= erofs_fc_free,
> +};
> +
> +static int erofs_init_fs_context(struct fs_context *fc)
> +{
> +	struct erofs_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	/* set default mount options */
> +	erofs_default_options(sbi);
> +
> +	fc->s_fs_info = sbi;
> +	fc->ops = &erofs_context_ops;
> +	return 0;
>  }
>  
>  /*
> @@ -497,7 +506,7 @@ static void erofs_put_super(struct super_block *sb)
>  static struct file_system_type erofs_fs_type = {
>  	.owner          = THIS_MODULE,
>  	.name           = "erofs",
> -	.mount          = erofs_mount,
> +	.init_fs_context = erofs_init_fs_context,
>  	.kill_sb        = erofs_kill_sb,
>  	.fs_flags       = FS_REQUIRES_DEV,
>  };
> @@ -603,36 +612,12 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  	return 0;
>  }
>  
> -static int erofs_remount(struct super_block *sb, int *flags, char *data)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	unsigned int org_mnt_opt = sbi->mount_opt;
> -	int err;
> -
> -	DBG_BUGON(!sb_rdonly(sb));
> -	err = erofs_parse_options(sb, data);
> -	if (err)
> -		goto out;
> -
> -	if (test_opt(sbi, POSIX_ACL))
> -		sb->s_flags |= SB_POSIXACL;
> -	else
> -		sb->s_flags &= ~SB_POSIXACL;
> -
> -	*flags |= SB_RDONLY;
> -	return 0;
> -out:
> -	sbi->mount_opt = org_mnt_opt;
> -	return err;
> -}
> -
>  const struct super_operations erofs_sops = {
>  	.put_super = erofs_put_super,
>  	.alloc_inode = erofs_alloc_inode,
>  	.free_inode = erofs_free_inode,
>  	.statfs = erofs_statfs,
>  	.show_options = erofs_show_options,
> -	.remount_fs = erofs_remount,
>  };
>  
>  module_init(erofs_module_init);
> -- 
> 2.18.0.rc1
> 
