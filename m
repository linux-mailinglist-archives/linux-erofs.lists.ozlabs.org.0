Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6D45B2AC
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 04:30:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzRNV3lmvz2ypR
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 14:30:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzRNM3Qz5z2yPs
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 14:30:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uy3QJvx_1637724604; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uy3QJvx_1637724604) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Nov 2021 11:30:06 +0800
Date: Wed, 24 Nov 2021 11:30:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v3 1/2] Refactor out some I/O logic into separate function
Message-ID: <YZ2xvBhjKH4iwRFV@B-P7TQMD6M-0146.local>
References: <YZ2orHfVF2qbPQHj@B-P7TQMD6M-0146.local>
 <20211124031554.1363689-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124031554.1363689-1-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 23, 2021 at 07:15:54PM -0800, Kelvin Zhang wrote:
> Many of the global variables are for I/O purposes. To make the codebase
> more library friendly, decouple I/O and parsing into separate functions.
> 

Would you mind answering my previous question about the use cases?

My concern why I perfer to use another I/O source rather than
export erofs_parse_superblock and erofs_parse_inode_from_buffer is
that the buffer size of inodes and/or the super block may change in
the future.

If we export these as a library function, buffer size may not be
enough if we update the internal implementation of erofs_parse_superblock
and erofs_parse_inode_from_buffer in the future. And cause out of boundary
for old users which used EROFS_MAX_INODE_SIZE and EROFS_BLKSIZ....

Thanks,
Gao Xiang

> Change-Id: I7dbb3dcd6e82b075205891f9a06b80e1191fa5d6
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/defs.h     | 19 ++++++++++++
>  include/erofs/internal.h |  2 ++
>  include/erofs/parse.h    | 23 ++++++++++++++
>  include/erofs_fs.h       | 11 +++++++
>  lib/io.c                 |  1 +
>  lib/namei.c              | 38 +++++++++++++++--------
>  lib/super.c              | 66 ++++++++++++++++++++++++----------------
>  7 files changed, 120 insertions(+), 40 deletions(-)
>  create mode 100644 include/erofs/parse.h
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 6398cbb..16376dc 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -8,6 +8,11 @@
>  #ifndef __EROFS_DEFS_H
>  #define __EROFS_DEFS_H
>  
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include <stddef.h>
>  #include <stdint.h>
>  #include <assert.h>
> @@ -82,12 +87,18 @@ typedef int64_t         s64;
>  #endif
>  #endif
>  
> +#ifdef __cplusplus
> +#define BUILD_BUG_ON(condition) static_assert(!condition)
> +#else
> +
>  #ifndef __OPTIMIZE__
>  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
>  #else
>  #define BUILD_BUG_ON(condition) assert(!(condition))
>  #endif
>  
> +#endif
> +
>  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  
>  #define __round_mask(x, y)      ((__typeof__(x))((y)-1))
> @@ -110,6 +121,8 @@ typedef int64_t         s64;
>  }							\
>  )
>  
> +// Defining min/max macros in C++ will cause conflicts with std::min/max
> +#ifndef __cplusplus
>  #define min(x, y) ({				\
>  	typeof(x) _min1 = (x);			\
>  	typeof(y) _min2 = (y);			\
> @@ -121,6 +134,7 @@ typedef int64_t         s64;
>  	typeof(y) _max2 = (y);			\
>  	(void) (&_max1 == &_max2);		\
>  	_max1 > _max2 ? _max1 : _max2; })
> +#endif
>  
>  /*
>   * ..and if you can't take the strict types, you can specify one yourself.
> @@ -308,4 +322,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
>  #define stat64		stat
>  #define lstat64		lstat
>  #endif
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 666d1f2..0f45fb8 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -331,4 +331,6 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
>  	return crc;
>  }
>  
> +#define EROFS_MAX_INODE_SIZE sizeof(struct erofs_inode_extended)
> +
>  #endif
> diff --git a/include/erofs/parse.h b/include/erofs/parse.h
> new file mode 100644
> index 0000000..65948a1
> --- /dev/null
> +++ b/include/erofs/parse.h
> @@ -0,0 +1,23 @@
> +
> +#ifndef __EROFS_PARSE_H
> +#define __EROFS_PARSE_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "erofs_fs.h"
> +#include "internal.h"
> +
> +int erofs_parse_inode_from_buffer(const char buf[EROFS_MAX_INODE_SIZE],
> +                                  struct erofs_inode *vi);
> +
> +int erofs_parse_superblock(const char data[EROFS_BLKSIZ],
> +                           struct erofs_sb_info *sbi);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 9a91877..f3a5207 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -9,6 +9,12 @@
>  #ifndef __EROFS_FS_H
>  #define __EROFS_FS_H
>  
> +#ifdef __cplusplus
> +#define inline constexpr
> +extern "C"
> +{
> +#endif
> +
>  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
>  #define EROFS_SUPER_OFFSET      1024
>  
> @@ -425,4 +431,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>  		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
>  }
>  
> +#ifdef __cplusplus
> +#undef inline
> +}
> +#endif
> +
>  #endif
> diff --git a/lib/io.c b/lib/io.c
> index a0d366a..9ee754b 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -12,6 +12,7 @@
>  #endif
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> +#include <sys/fcntl.h>
>  #include "erofs/io.h"
>  #ifdef HAVE_LINUX_FS_H
>  #include <linux/fs.h>
> diff --git a/lib/namei.c b/lib/namei.c
> index 7377e74..6eef304 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -22,17 +22,13 @@ static dev_t erofs_new_decode_dev(u32 dev)
>  	return makedev(major, minor);
>  }
>  
> -int erofs_read_inode_from_disk(struct erofs_inode *vi)
> +int erofs_parse_inode_from_buffer(
> +	const char buf[EROFS_MAX_INODE_SIZE],
> +	struct erofs_inode *vi)
>  {
> -	int ret, ifmt;
> -	char buf[sizeof(struct erofs_inode_extended)];
> +	int ifmt;
>  	struct erofs_inode_compact *dic;
>  	struct erofs_inode_extended *die;
> -	const erofs_off_t inode_loc = iloc(vi->nid);
> -
> -	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
> -	if (ret < 0)
> -		return -EIO;
>  
>  	dic = (struct erofs_inode_compact *)buf;
>  	ifmt = le16_to_cpu(dic->i_format);
> @@ -47,11 +43,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>  	case EROFS_INODE_LAYOUT_EXTENDED:
>  		vi->inode_isize = sizeof(struct erofs_inode_extended);
>  
> -		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
> -			       sizeof(*die) - sizeof(*dic));
> -		if (ret < 0)
> -			return -EIO;
> -
>  		die = (struct erofs_inode_extended *)buf;
>  		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
>  		vi->i_mode = le16_to_cpu(die->i_mode);
> @@ -144,6 +135,27 @@ bogusimode:
>  	return -EFSCORRUPTED;
>  }
>  
> +int erofs_read_inode_from_disk(struct erofs_inode *vi)
> +{
> +	char buf[sizeof(struct erofs_inode_extended)];
> +	struct erofs_inode_compact *dic;
> +	struct erofs_inode_extended *die;
> +	const erofs_off_t inode_loc = iloc(vi->nid);
> +
> +	int ret = dev_read(0, buf, inode_loc, sizeof(*dic));
> +	if (ret < 0)
> +		return -EIO;
> +	dic = (struct erofs_inode_compact *)buf;
> +	int ifmt = le16_to_cpu(dic->i_format);
> +	if (erofs_inode_version(ifmt)) {
> +		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
> +			       sizeof(*die) - sizeof(*dic));
> +		if (ret < 0)
> +			return -EIO;
> +	}
> +	return erofs_parse_inode_from_buffer(buf, vi);
> +}
> +
>  
>  struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
>  					void *dentry_blk,
> diff --git a/lib/super.c b/lib/super.c
> index 3ccc551..f15aaf1 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -4,6 +4,7 @@
>   */
>  #include <string.h>
>  #include <stdlib.h>
> +#include "erofs/internal.h"
>  #include "erofs/io.h"
>  #include "erofs/print.h"
>  
> @@ -62,29 +63,21 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>  	return 0;
>  }
>  
> -int erofs_read_superblock(void)
> -{
> -	char data[EROFS_BLKSIZ];
> -	struct erofs_super_block *dsb;
> -	unsigned int blkszbits;
> -	int ret;
> -
> -	ret = blk_read(0, data, 0, 1);
> -	if (ret < 0) {
> -		erofs_err("cannot read erofs superblock: %d", ret);
> -		return -EIO;
> -	}
> -	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
> +int erofs_parse_superblock(
> +	const char data[EROFS_BLKSIZ],
> +	struct erofs_sb_info *sbi
> +) {
> +	struct erofs_super_block *dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>  
> -	ret = -EINVAL;
> +	int ret = -EINVAL;
>  	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
>  		erofs_err("cannot find valid erofs superblock");
>  		return ret;
>  	}
>  
> -	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
> +	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
>  
> -	blkszbits = dsb->blkszbits;
> +	unsigned int blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
>  		erofs_err("blksize %u isn't supported on this platform",
> @@ -92,20 +85,39 @@ int erofs_read_superblock(void)
>  		return ret;
>  	}
>  
> -	if (!check_layout_compatibility(&sbi, dsb))
> +	if (!check_layout_compatibility(sbi, dsb))
>  		return ret;
>  
> -	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
> -	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
> -	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
> -	sbi.islotbits = EROFS_ISLOTBITS;
> -	sbi.root_nid = le16_to_cpu(dsb->root_nid);
> -	sbi.inos = le64_to_cpu(dsb->inos);
> -	sbi.checksum = le32_to_cpu(dsb->checksum);
> +	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
> +	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
> +	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
> +	sbi->islotbits = EROFS_ISLOTBITS;
> +	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> +	sbi->inos = le64_to_cpu(dsb->inos);
> +	sbi->checksum = le32_to_cpu(dsb->checksum);
>  
> -	sbi.build_time = le64_to_cpu(dsb->build_time);
> -	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> +	sbi->build_time = le64_to_cpu(dsb->build_time);
> +	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> +
> +	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
> +	return 0;
> +}
>  
> -	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
> +int erofs_read_superblock(void)
> +{
> +	char data[EROFS_BLKSIZ];
> +	struct erofs_super_block *dsb;
> +	int ret;
> +
> +	ret = blk_read(0, data, 0, 1);
> +	if (ret < 0) {
> +		erofs_err("cannot read erofs superblock: %d", ret);
> +		return -EIO;
> +	}
> +	ret = erofs_parse_superblock(data, &sbi);
> +	if (ret) {
> +		return ret;
> +	}
> +	
>  	return erofs_init_devices(&sbi, dsb);
>  }
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
