Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3A764A0E
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 10:06:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBNdP1mzwz3dRT
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 18:06:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBNbK3z8kz3cVY
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 18:04:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoJl2ZD_1690445076;
Received: from 30.97.49.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoJl2ZD_1690445076)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 16:04:37 +0800
Message-ID: <eb4523d0-c4b1-00e6-cca6-81d117b713da@linux.alibaba.com>
Date: Thu, 27 Jul 2023 16:04:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 9/9] erofs-utils: introduce union mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
 <20230727045712.45226-9-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230727045712.45226-9-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



subject: support rebuilding EROFS image from multiple images

On 2023/7/27 12:57, Jingbo Xu wrote:
> Introduce a new "union "mode for mkfs.erofs.

Add support to rebuild EROFS images.

> 
> The new mode merges multiple erofs images into a new erofs image.  It
> can be enabled with [--union] option.

The new mode merges multiple erofs images into a rebuilt EROFS image..

> 
> Currently it is mainly used to merge images generated from tarerofs
> mode, with following special handling:
> 
> - whiteout and opaque directory (marked with "trusted.overlay.opaque"
>    xattr) are specially handled to fit the overlayfs model.
> - data of regular file is handled in fallocate like style, i.e. the
>    space is allocated in the image for the file data, while the file
>    content is not written to the image.  In this way the erofs image only
>    offers metadata and it depends on other container image orchestra to
>    help derive the corresponding file data somehow.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/erofs/config.h   |   4 +
>   include/erofs/inode.h    |   1 +
>   include/erofs/internal.h |  16 +++
>   include/erofs/union.h    |  20 +++
>   lib/Makefile.am          |   4 +-
>   lib/config.c             |  33 +++++
>   lib/inode.c              |  95 +++++++++++++-
>   lib/tar.c                |   2 -
>   lib/union.c              | 266 +++++++++++++++++++++++++++++++++++++++
>   mkfs/Makefile.am         |   3 +-
>   mkfs/main.c              |  81 ++++++++----
>   11 files changed, 496 insertions(+), 29 deletions(-)
>   create mode 100644 include/erofs/union.h
>   create mode 100644 lib/union.c
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 8f52d2c..bef7085 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -53,6 +53,7 @@ struct erofs_configure {
>   	bool c_ignore_mtime;
>   	bool c_showprogress;
>   	bool c_extra_ea_name_prefixes;
> +	bool c_union;

no need adding this, let's use a static variable in
mkfs/main.c instead.

>   
>   #ifdef HAVE_LIBSELINUX
>   	struct selabel_handle *sehnd;
> @@ -107,6 +108,9 @@ static inline int erofs_selabel_open(const char *file_contexts)
>   void erofs_update_progressinfo(const char *fmt, ...);
>   char *erofs_trim_for_progressinfo(const char *str, int placeholder);
>   
> +int erofs_insert_img(const char *path);
> +void erofs_cleanup_imgs(void);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index aba2a94..00ecf97 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -34,6 +34,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
>   struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>   				   const char *name);
>   int tarerofs_dump_tree(struct erofs_inode *dir);
> +int erofs_union_dump_tree(struct erofs_inode *dir);
>   int erofs_init_empty_dir(struct erofs_inode *dir);
>   struct erofs_inode *erofs_new_inode(void);
>   struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 83a2e22..b690a1e 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -44,6 +44,8 @@ typedef u32 erofs_blk_t;
>   /* global sbi */
>   extern struct erofs_sb_info sbi;
>   
> +extern struct list_head imgs_list;
> +
>   #define erofs_blksiz(sbi)	(1u << (sbi)->blkszbits)
>   #define erofs_blknr(sbi, addr)  ((addr) >> (sbi)->blkszbits)
>   #define erofs_blkoff(sbi, addr) ((addr) & (erofs_blksiz(sbi) - 1))
> @@ -69,6 +71,9 @@ struct erofs_sb_info {
>   	erofs_blk_t meta_blkaddr;
>   	erofs_blk_t xattr_blkaddr;
>   
> +	erofs_blk_t data_blkaddr;
> +	unsigned long data_blks;
> +
>   	u32 feature_compat;
>   	u32 feature_incompat;
>   	u64 build_time;
> @@ -136,6 +141,8 @@ EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   #define EROFS_I_EA_INITED	(1 << 0)
>   #define EROFS_I_Z_INITED	(1 << 1)
>   
> +#define S_SHIFT                 12
> +
>   struct erofs_inode {
>   	struct list_head i_hash, i_subdirs, i_xattrs;
>   
> @@ -183,6 +190,7 @@ struct erofs_inode {
>   	bool compressed_idata;
>   	bool lazy_tailblock;
>   	bool with_tmpfile;
> +	bool remap_blkaddr;
>   
>   	unsigned int xattr_isize;
>   	unsigned int extent_isize;
> @@ -415,6 +423,14 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
>   	return crc;
>   }
>   
> +#define EROFS_WHITEOUT_DEV	0
> +
> +struct erofs_img {

move into rebuild.c?

> +	struct list_head list;
> +	char *path;
> +	struct erofs_sb_info sbi;
> +};
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/include/erofs/union.h b/include/erofs/union.h
> new file mode 100644
> index 0000000..999a20c
> --- /dev/null
> +++ b/include/erofs/union.h

rebuild.h?

> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_UNION_H
> +#define __EROFS_UNION_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "internal.h"
> +
> +struct erofs_inode *erofs_union_load_imgs(void);
> +int erofs_union_dump_tree(struct erofs_inode *dir);

erofs_rebuild_???

> +int erofs_union_remap(struct erofs_sb_info *sbi);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index ebe466b..b8af149 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -24,13 +24,15 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>         $(top_srcdir)/include/erofs/xattr.h \
>         $(top_srcdir)/include/erofs/compress_hints.h \
>         $(top_srcdir)/include/erofs/fragments.h \
> +      $(top_srcdir)/include/erofs/union.h \
>         $(top_srcdir)/lib/liberofs_private.h
>   
>   noinst_HEADERS += compressor.h
>   liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>   		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>   		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
> -		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c
> +		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
> +		      union.c
>   
>   liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>   if ENABLE_LZ4
> diff --git a/lib/config.c b/lib/config.c
> index a3235c8..cc214ae 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -17,6 +17,8 @@
>   struct erofs_configure cfg;
>   struct erofs_sb_info sbi;
>   
> +LIST_HEAD(imgs_list);

?

> +
>   void erofs_init_configure(void)
>   {
>   	memset(&cfg, 0, sizeof(cfg));
> @@ -158,3 +160,34 @@ void erofs_update_progressinfo(const char *fmt, ...)
>   	__erofs_is_progressmsg = true;
>   	fflush(stdout);
>   }
> +
> +int erofs_insert_img(const char *path)
> +{
> +	struct erofs_img *img;
> +
> +	img = malloc(sizeof(*img));
> +	if (!img)
> +		return -ENOMEM;
> +
> +	img->path = realpath(path, NULL);
> +	if (!img->path) {
> +		erofs_err("failed to parse image file (%s): %s",
> +				path, erofs_strerror(-errno));
> +		free(img);
> +		return -ENOENT;
> +	}
> +
> +	list_add_tail(&img->list, &imgs_list);
> +	return 0;
> +}
> +
> +void erofs_cleanup_imgs(void)
> +{
> +	struct erofs_img *img, *n;
> +
> +	list_for_each_entry_safe(img, n, &imgs_list, list) {
> +		list_del(&img->list);
> +		free(img->path);
> +		free(img);
> +	}
> +}
> diff --git a/lib/inode.c b/lib/inode.c
> index d82ea95..0a56f3b 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -26,9 +26,10 @@
>   #include "erofs/compress_hints.h"
>   #include "erofs/blobchunk.h"
>   #include "erofs/fragments.h"
> +#include "erofs/dir.h"
> +#include "erofs/tar.h"
>   #include "liberofs_private.h"
>   
> -#define S_SHIFT                 12
>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>   	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
>   	[S_IFDIR >> S_SHIFT]  = EROFS_FT_DIR,
> @@ -508,6 +509,9 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>   	} u = { {0}, };
>   	int ret;
>   
> +	if (inode->remap_blkaddr)
> +		inode->u.i_blkaddr += inode->sbi->data_blkaddr;
> +
>   	switch (inode->inode_isize) {
>   	case sizeof(struct erofs_inode_compact):
>   		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
> @@ -1414,3 +1418,92 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
>   	dir->bh->op = &erofs_write_inode_bhops;
>   	return 0;
>   }
> +
> +static bool erofs_inode_is_whiteout(struct erofs_inode *inode)
> +{
> +	return S_ISCHR(inode->i_mode) && inode->u.i_rdev == EROFS_WHITEOUT_DEV;
> +}
> +
> +int erofs_union_dump_tree(struct erofs_inode *dir)
> +{
> +	struct erofs_dentry *d, *n;
> +	unsigned int nr_subdirs;
> +	int ret;
> +
> +	if (erofs_should_use_inode_extended(dir)) {
> +		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
> +			erofs_err("file %s cannot be in compact form",
> +				  dir->i_srcpath);
> +			return -EINVAL;
> +		}
> +		dir->inode_isize = sizeof(struct erofs_inode_extended);
> +	} else {
> +		dir->inode_isize = sizeof(struct erofs_inode_compact);
> +	}
> +
> +	ret = erofs_prepare_xattr_ibody(dir);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!S_ISDIR(dir->i_mode)) {
> +		if (dir->bh)
> +			return 0;
> +		if (S_ISLNK(dir->i_mode)) {
> +			ret = erofs_write_file_from_buffer(dir, dir->i_link);
> +			if (ret)
> +				return ret;
> +			free(dir->i_link);
> +			dir->i_link = NULL;
> +		}
> +		ret = erofs_prepare_inode_buffer(dir);
> +		if (ret)
> +			return ret;
> +		erofs_write_tail_end(dir);
> +		return 0;
> +	}
> +
> +	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
> +		if (erofs_inode_is_whiteout(d->inode)) {
> +			erofs_dbg("file %s: skip whiteout", d->inode->i_srcpath);
> +			erofs_d_invalidate(d);
> +			list_del(&d->d_child);
> +			free(d);
> +			continue;
> +		}
> +	}
> +
> +	nr_subdirs = 0;
> +	list_for_each_entry(d, &dir->i_subdirs, d_child)
> +		++nr_subdirs;
> +
> +	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
> +	if (ret)
> +		return ret;
> +
> +	ret = erofs_prepare_inode_buffer(dir);
> +	if (ret)
> +		return ret;
> +	dir->bh->op = &erofs_skip_write_bhops;
> +
> +	if (IS_ROOT(dir))
> +		erofs_fixup_meta_blkaddr(dir);
> +
> +	list_for_each_entry(d, &dir->i_subdirs, d_child) {
> +		struct erofs_inode *inode;
> +
> +		if (is_dot_dotdot(d->name))
> +			continue;
> +
> +		inode = erofs_igrab(d->inode);
> +		ret = erofs_union_dump_tree(inode);
> +		if (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR)
> +			dir->i_nlink++;
> +		erofs_iput(inode);
> +		if (ret)
> +			return ret;
> +	}
> +	erofs_write_dir_file(dir);
> +	erofs_write_tail_end(dir);
> +	dir->bh->op = &erofs_write_inode_bhops;
> +	return 0;
> +}
> diff --git a/lib/tar.c b/lib/tar.c
> index 10ae89c..51af638 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -19,8 +19,6 @@
>   #include "erofs/xattr.h"
>   #include "erofs/blobchunk.h"
>   
> -#define EROFS_WHITEOUT_DEV	0
> -
>   static char erofs_libbuf[16384];
>   
>   struct tar_header {
> diff --git a/lib/union.c b/lib/union.c
> new file mode 100644
> index 0000000..15c546c
> --- /dev/null
> +++ b/lib/union.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "erofs/print.h"
> +#include "erofs/cache.h"
> +#include "erofs/tar.h"
> +#include "erofs/inode.h"
> +#include "erofs/io.h"
> +#include "erofs/xattr.h"
> +#include "erofs/dir.h"
> +#include "erofs/internal.h"
> +
> +struct erofs_union_dir_context {
> +	struct erofs_dir_context ctx;
> +	struct erofs_inode *root;
> +};
> +
> +static int erofs_union_fill_inode(struct erofs_inode *inode,
> +				  struct erofs_inode *vi)
> +{
> +	int ret = 0;
> +
> +	inode->i_srcpath = strdup(vi->i_srcpath);
> +	inode->i_mode = vi->i_mode;
> +	inode->i_uid = vi->i_uid;
> +	inode->i_gid = vi->i_gid;
> +	inode->i_mtime = vi->i_mtime;
> +	inode->i_ino[1] = vi->i_ino[0];
> +	inode->i_nlink = 1;
> +
> +	switch (inode->i_mode & S_IFMT) {
> +	case S_IFCHR:
> +	case S_IFBLK:
> +	case S_IFIFO:
> +	case S_IFSOCK:
> +		inode->u.i_rdev = erofs_new_encode_dev(vi->u.i_rdev);
> +		inode->i_size = 0;
> +		erofs_dbg("\tdev: %d %d", major(vi->u.i_rdev),
> +			  minor(vi->u.i_rdev));
> +		break;
> +	case S_IFDIR:
> +		inode->i_size = 0;
> +		ret = erofs_init_empty_dir(inode);
> +		break;
> +	case S_IFLNK:
> +		inode->i_size = vi->i_size;
> +		inode->i_link = malloc(inode->i_size + 1);
> +		ret = erofs_pread(vi, inode->i_link, inode->i_size, 0);
> +		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
> +		break;
> +	case S_IFREG:
> +		inode->i_size = vi->i_size;
> +		if (inode->i_size) {
> +			inode->u.i_blkaddr = inode->sbi->data_blks;
> +			inode->sbi->data_blks += BLK_ROUND_UP(inode->sbi,
> +							      inode->i_size);
> +			inode->remap_blkaddr = true;
> +		} else {
> +			inode->u.i_blkaddr = NULL_ADDR;
> +		}
> +		erofs_dbg("\tregfile: i_blkaddr %d, i_size %d",
> +			  inode->u.i_blkaddr, inode->i_size);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +
> +static int erofs_union_dirent_iter(struct erofs_dir_context *ctx)
> +{
> +	struct erofs_union_dir_context *uctx = (void *)ctx;
> +	struct erofs_inode *dir = ctx->dir;
> +	struct erofs_sb_info *sbi = dir->sbi;
> +	struct erofs_inode *inode, vi = {};
> +	struct erofs_dentry *d;
> +	char *path;
> +	int ret;
> +
> +	if (ctx->dot_dotdot)
> +		return 0;
> +
> +	vi.nid = ctx->de_nid;
> +	vi.sbi = sbi;
> +	ret = erofs_read_inode_from_disk(&vi);
> +	if (ret) {
> +		erofs_err("file %s/%.*s: read failed",
> +			  dir->i_srcpath, ctx->de_namelen, ctx->dname);
> +		return ret;
> +	}
> +
> +	ret = asprintf(&path, "%s/%.*s", dir->i_srcpath, ctx->de_namelen,
> +		       ctx->dname);
> +	if (ret < 0) {
> +		erofs_err("file %s/%.*s: failed to alloc path",
> +			  dir->i_srcpath, ctx->de_namelen, ctx->dname);
> +		return ret;
> +	}
> +	vi.i_srcpath = path;
> +
> +	d = erofs_get_dentry(uctx->root, path, false, NULL, NULL);
> +	if (IS_ERR(d)) {
> +		ret = PTR_ERR(d);
> +		goto exit;
> +	}
> +
> +	if (d->type != EROFS_FT_UNKNOWN) {
> +		inode = d->inode;
> +		DBG_BUGON((inode->i_mode & S_IFMT) != (vi.i_mode & S_IFMT));
> +		if (!S_ISDIR(inode->i_mode) || inode->opaque) {
> +			erofs_dbg("file %s: %s (%d) exists",
> +				  path, inode->i_srcpath,
> +				  erofs_mode_to_ftype(inode->i_mode));
> +			free(path);
> +			return 0;
> +		}
> +		erofs_dbg("dir %s: %s merging", path, inode->i_srcpath);
> +	} else {
> +		erofs_dbg("loading file: %s (%d) (nid %llu)",
> +			  path, erofs_mode_to_ftype(vi.i_mode), ctx->de_nid);
> +		if (S_ISREG(vi.i_mode) && vi.i_nlink > 1 &&
> +		    (inode = erofs_iget(0, vi.i_ino[0]))) {
> +			/* hardlink file */
> +			if (S_ISDIR(inode->i_mode)) {
> +				erofs_dbg("hardlink directory not supported");
> +				erofs_iput(inode);
> +				return -EISDIR;
> +			}
> +			inode->i_nlink++;
> +			erofs_dbg("\thardlink: %s -> %s",
> +				  vi.i_srcpath, inode->i_srcpath);
> +		} else {
> +			inode = erofs_new_inode();
> +			if (IS_ERR(inode)) {
> +				ret = PTR_ERR(inode);
> +				goto exit;
> +			}
> +
> +			inode->i_parent = d->inode;
> +			ret = erofs_union_fill_inode(inode, &vi);
> +			if (ret)
> +				goto exit_inode;
> +
> +			ret = erofs_read_xattrs_from_disk(&vi);
> +			if (ret)
> +				goto exit_inode;
> +			list_splice_tail(&vi.i_xattrs, &inode->i_xattrs);
> +			erofs_inode_tag_opaque(inode);
> +
> +			/* build per-image hash table for hardlink querying */
> +			erofs_insert_ihash(inode, 0, inode->i_ino[1]);
> +		}
> +
> +		d->inode = inode;
> +		d->type = erofs_mode_to_ftype(inode->i_mode);
> +	}
> +
> +	ret = 0;
> +	if (S_ISDIR(vi.i_mode)) {
> +		struct erofs_union_dir_context nctx = {
> +			.ctx.dir = &vi,
> +			.ctx.cb = erofs_union_dirent_iter,
> +			.root = uctx->root,
> +		};
> +		ret = erofs_iterate_dir(&nctx.ctx, false);
> +	}
> +exit:
> +	free(path);
> +	return ret;
> +exit_inode:
> +	erofs_iput(inode);
> +	goto exit;
> +}
> +
> +static int erofs_union_load_img(struct erofs_inode *root, struct erofs_img *img)
> +{
> +	struct erofs_inode inode = {};
> +	struct erofs_sb_info *sbi = &img->sbi;
> +	struct erofs_union_dir_context ctx;
> +	int ret;
> +
> +	erofs_dbg("Loading image %s...", img->path);
> +	ret = dev_open_ro(sbi, img->path);
> +	if (ret) {
> +		erofs_err("failed to open image %s", img->path);
> +		return ret;
> +	}
> +
> +	ret = erofs_read_superblock(sbi);
> +	if (ret) {
> +		erofs_err("failed to read superblock of image %s", img->path);
> +		goto exit;
> +	}
> +
> +	inode.nid = sbi->root_nid;
> +	inode.sbi = sbi;
> +	ret = erofs_read_inode_from_disk(&inode);
> +	if (ret) {
> +		erofs_err("failed to read root inode of image %s", img->path);
> +		goto exit;
> +	}
> +	inode.i_srcpath = strdup("/");
> +
> +	ctx = (struct erofs_union_dir_context) {
> +		.ctx.dir = &inode,
> +		.ctx.cb = erofs_union_dirent_iter,
> +		.root = root,
> +	};
> +	ret = erofs_iterate_dir(&ctx.ctx, false);
> +exit:
> +	erofs_cleanup_ihash();
> +	dev_close(sbi);
> +	return ret;
> +}
> +
> +struct erofs_inode *erofs_union_load_imgs(void)
> +{
> +	struct erofs_img *img;
> +	struct erofs_inode *root;
> +	int ret;
> +
> +	sbi.data_blks = 0;
> +
> +	root = erofs_new_inode();
> +	if (IS_ERR(root))
> +		return root;
> +	root->i_srcpath = strdup("/");
> +	root->i_mode = S_IFDIR | 0777;
> +	root->i_parent = root;
> +	root->i_mtime = root->sbi->build_time;
> +	root->i_mtime_nsec = root->sbi->build_time_nsec;
> +	erofs_init_empty_dir(root);
> +
> +	list_for_each_entry(img, &imgs_list, list) {
> +		ret = erofs_union_load_img(root, img);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +	return root;
> +}
> +
> +int erofs_union_remap(struct erofs_sb_info *sbi)
> +{
> +	struct erofs_buffer_head *bh;
> +	int ret;
> +
> +	if (!sbi->data_blks)
> +		return 0;
> +
> +	bh = erofs_balloc(DATA, erofs_pos(sbi, sbi->data_blks), 0, 0);
> +	if (IS_ERR(bh))
> +		return PTR_ERR(bh);
> +
> +	ret = erofs_mapbh(bh->block);
> +	DBG_BUGON(ret < 0);
> +
> +	sbi->data_blkaddr = erofs_blknr(sbi, erofs_btell(bh, false));
> +	erofs_dbg("data blkaddr %d, blks %d", sbi->data_blkaddr, sbi->data_blks);
> +	bh->op = &erofs_drop_directly_bhops;
> +	erofs_bdrop(bh, false);
> +	return 0;
> +}
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index 603c2f3..dd75485 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -6,4 +6,5 @@ AM_CPPFLAGS = ${libselinux_CFLAGS}
>   mkfs_erofs_SOURCES = main.c
>   mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> -	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${libdeflate_LIBS}
> +	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
> +	${libdeflate_LIBS}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index bc5ed87..4a47b24 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -26,6 +26,7 @@
>   #include "erofs/compress_hints.h"
>   #include "erofs/blobchunk.h"
>   #include "erofs/fragments.h"
> +#include "erofs/union.h"
>   #include "../lib/liberofs_private.h"
>   #include "../lib/liberofs_uuid.h"

static bool rebuild_mode. ?

Thanks,
Gao Xiang
