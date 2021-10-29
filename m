Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7843F7B1
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 09:11:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgYVv30Jtz2yMc
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 18:11:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgYVl4ZRwz2y8R
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 18:10:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Uu6U87s_1635491430; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uu6U87s_1635491430) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 29 Oct 2021 15:10:32 +0800
Date: Fri, 29 Oct 2021 15:10:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: introduce fsck.erofs
Message-ID: <YXueZg6vrIpNsv/R@B-P7TQMD6M-0146.local>
References: <20211028235252.2096371-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028235252.2096371-1-daeho43@gmail.com>
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
Cc: jaegeuk@kernel.com, Daeho Jeong <daehojeong@google.com>,
 linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Daeho,

On Thu, Oct 28, 2021 at 04:52:52PM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> I made a fsck.erofs tool to check erofs filesystem image integrity
> and calculate filesystem compression ratio.
> Here are options to support now.
> 
> fsck.erofs [options] IMAGE
> -V      print the version number of fsck.erofs and exit.
> -d#     set output message level to # (maximum 9)
> -p      print total compression ratio of all files
> -c      check if all compressed files are well decompressed
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: merged options printing compression ratio into "-p"
>     added "-c" option to check if compressed files are well decompressed
>     added alphabetical order of dirent entries
>     changed the way to calculate compression rate
>     changed the way to check special named dirent entries

I'm almost fine with this version, let me sort out some minor
stuff this weekend...

Another thing is that it'd be better to write a manpage as well if you
have extra time. Anyway, many thanks for your effort on this!

Thanks,
Gao Xiang

> ---
>  Makefile.am              |   2 +-
>  configure.ac             |   3 +-
>  fsck/Makefile.am         |   9 +
>  fsck/main.c              | 606 +++++++++++++++++++++++++++++++++++++++
>  include/erofs/internal.h |   5 +
>  include/erofs_fs.h       |  13 +
>  lib/data.c               |   4 +-
>  lib/namei.c              |   2 +-
>  lib/super.c              |   1 +
>  mkfs/main.c              |  13 -
>  10 files changed, 640 insertions(+), 18 deletions(-)
>  create mode 100644 fsck/Makefile.am
>  create mode 100644 fsck/main.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index 24e1d38..fc464e8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,7 +2,7 @@
>  
>  ACLOCAL_AMFLAGS = -I m4
>  
> -SUBDIRS = man lib mkfs dump
> +SUBDIRS = man lib mkfs dump fsck
>  if ENABLE_FUSE
>  SUBDIRS += fuse
>  endif
> diff --git a/configure.ac b/configure.ac
> index b2c3225..5698b2e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -298,5 +298,6 @@ AC_CONFIG_FILES([Makefile
>  		 lib/Makefile
>  		 mkfs/Makefile
>  		 dump/Makefile
> -		 fuse/Makefile])
> +		 fuse/Makefile
> +		 fsck/Makefile])
>  AC_OUTPUT
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> new file mode 100644
> index 0000000..82973ba
> --- /dev/null
> +++ b/fsck/Makefile.am
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Makefile.am
> +
> +AUTOMAKE_OPTIONS = foreign
> +bin_PROGRAMS     = fsck.erofs
> +AM_CPPFLAGS = ${libuuid_CFLAGS}
> +fsck_erofs_SOURCES = main.c
> +fsck_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> +fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${liblz4_LIBS}
> diff --git a/fsck/main.c b/fsck/main.c
> new file mode 100644
> index 0000000..7cc3763
> --- /dev/null
> +++ b/fsck/main.c
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Google LLC
> + * Author: Daeho Jeong <daehojeong@google.com>
> + */
> +#include <stdlib.h>
> +#include <getopt.h>
> +#include <time.h>
> +#include "erofs/print.h"
> +#include "erofs/io.h"
> +#include "erofs/decompress.h"
> +
> +static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
> +
> +struct erofsfsck_cfg {
> +	bool corrupted;
> +	bool print_comp_ratio;
> +	bool check_decomp;
> +	u64 physical_blocks;
> +	u64 logical_blocks;
> +};
> +static struct erofsfsck_cfg fsckcfg;
> +
> +static struct option long_options[] = {
> +	{"help", no_argument, 0, 1},
> +	{0, 0, 0, 0},
> +};
> +
> +static void usage(void)
> +{
> +	fputs("usage: [options] IMAGE\n\n"
> +	      "Check erofs filesystem integrity of IMAGE, and [options] are:\n"
> +	      " -V      print the version number of fsck.erofs and exit.\n"
> +	      " -d#     set output message level to # (maximum 9)\n"
> +	      " -p      print total compression ratio of all files\n"
> +	      " -c      check if all compressed files are well decompressed\n"
> +	      " --help  display this help and exit.\n",
> +	      stderr);
> +}
> +
> +static void erofsfsck_print_version(void)
> +{
> +	fprintf(stderr, "fsck.erofs %s\n", cfg.c_version);
> +}
> +
> +static int erofsfsck_parse_options_cfg(int argc, char **argv)
> +{
> +	int opt, i;
> +
> +	while ((opt = getopt_long(argc, argv, "Vd:pc",
> +				  long_options, NULL)) != -1) {
> +		switch (opt) {
> +		case 'V':
> +			erofsfsck_print_version();
> +			exit(0);
> +		case 'd':
> +			i = atoi(optarg);
> +			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
> +				erofs_err("invalid debug level %d", i);
> +				return -EINVAL;
> +			}
> +			cfg.c_dbg_lvl = i;
> +			break;
> +		case 'p':
> +			fsckcfg.print_comp_ratio = true;
> +			break;
> +		case 'c':
> +			fsckcfg.check_decomp = true;
> +			break;
> +		case 1:
> +			usage();
> +			exit(0);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		return -EINVAL;
> +
> +	cfg.c_img_path = strdup(argv[optind++]);
> +	if (!cfg.c_img_path)
> +		return -ENOMEM;
> +
> +	if (optind < argc) {
> +		erofs_err("unexpected argument: %s\n", argv[optind]);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int erofs_check_sb_chksum(void)
> +{
> +	int ret;
> +	u8 buf[EROFS_BLKSIZ];
> +	u32 crc;
> +	struct erofs_super_block *sb;
> +
> +	ret = blk_read(buf, 0, 1);
> +	if (ret) {
> +		erofs_err("failed to read superblock to check checksum: "
> +			  "errno(%d)", ret);
> +		return -1;
> +	}
> +
> +	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
> +	sb->checksum = 0;
> +
> +	crc = crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
> +	if (crc != sbi.checksum) {
> +		erofs_err("superblock checksum doesn't match: saved(0x%08x) "
> +			  "calculated(0x%08x)", sbi.checksum, crc);
> +		fsckcfg.corrupted = true;
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int check_special_dentry(struct erofs_dirent *de,
> +				unsigned int de_namelen, erofs_nid_t nid,
> +				erofs_nid_t pnid)
> +{
> +	if (de_namelen == 2 && de->nid != pnid) {
> +		erofs_err("wrong parent dir nid(%llu): pnid(%llu) @ nid(%llu)",
> +			  de->nid | 0ULL, pnid | 0ULL, nid | 0ULL);
> +		return -1;
> +	}
> +
> +	if (de_namelen == 1 && de->nid != nid) {
> +		erofs_err("wrong current dir nid(%llu) @ nid(%llu)",
> +			  de->nid | 0ULL, nid | 0ULL);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
> +			    void *dentry_blk, erofs_off_t offset,
> +			    unsigned int next_nameoff, unsigned int maxsize)
> +{
> +	struct erofs_dirent *de = dentry_blk;
> +	const struct erofs_dirent *end = dentry_blk + next_nameoff;
> +	unsigned int idx = 0;
> +	char *prev_name = NULL, *cur_name = NULL;
> +	int ret = 0;
> +
> +	erofs_dbg("traversing pnid(%llu), nid(%llu)", pnid | 0ULL, nid | 0ULL);
> +
> +	if (offset == 0 && (next_nameoff < 2 * sizeof(struct erofs_dirent))) {
> +		erofs_err("too small dirents of size(%d) in nid(%llu)",
> +			  next_nameoff, nid | 0ULL);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	while (de < end) {
> +		const char *de_name;
> +		unsigned int de_namelen;
> +		unsigned int nameoff;
> +
> +		nameoff = le16_to_cpu(de->nameoff);
> +		de_name = (char *)dentry_blk + nameoff;
> +
> +		/* the last dirent check */
> +		if (de + 1 >= end)
> +			de_namelen = strnlen(de_name, maxsize - nameoff);
> +		else
> +			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> +
> +		if (prev_name)
> +			free(prev_name);
> +		prev_name = cur_name;
> +		cur_name = strndup(de_name, de_namelen);
> +		BUG_ON(!cur_name);
> +
> +		erofs_dbg("traversed filename(%s)", cur_name);
> +
> +		/* corrupted entry check */
> +		if (nameoff != next_nameoff) {
> +			erofs_err("bogus dirent with nameoff(%u): expected(%d) "
> +				  "@ nid(%llu), offset(%llu), idx(%u)",
> +				  nameoff, next_nameoff, nid | 0ULL,
> +				  offset | 0ULL, idx);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		if (nameoff + de_namelen > maxsize ||
> +				de_namelen > EROFS_NAME_LEN) {
> +			erofs_err("bogus dirent with namelen(%u) @ nid(%llu), "
> +				  "offset(%llu), idx(%u)",
> +				  de_namelen, nid | 0ULL, offset | 0ULL, idx);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		if (prev_name && (strcmp(prev_name, cur_name) >= 0)) {
> +			erofs_err("wrong dirent name order @ nid(%llu), "
> +				  "offset(%llu), idx(%u): prev(%s), cur(%s)",
> +				  nid | 0ULL, offset | 0ULL, idx,
> +				  prev_name, cur_name);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		if (is_dot_dotdot(cur_name)) {
> +			if (check_special_dentry(de, de_namelen, nid, pnid)) {
> +				ret = -EFSCORRUPTED;
> +				goto out;
> +			}
> +		} else {
> +			erofs_check_inode(nid, de->nid);
> +		}
> +
> +		if (fsckcfg.corrupted) {
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		next_nameoff += de_namelen;
> +		++de;
> +		++idx;
> +	}
> +
> +out:
> +	if (prev_name)
> +		free(prev_name);
> +	if (cur_name)
> +		free(cur_name);
> +
> +	erofs_dbg("traversing ... done nid(%llu)", nid | 0ULL);
> +	return ret;
> +}
> +
> +static int verify_raw_data_chunk(struct erofs_inode *inode)
> +{
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +	};
> +	int ret;
> +	erofs_off_t ptr = 0;
> +	u64 i_blocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +
> +	while (ptr < inode->i_size) {
> +		map.m_la = ptr;
> +		ret = erofs_map_blocks(inode, &map, 0);
> +		if (ret)
> +			return ret;
> +
> +		if (map.m_plen != map.m_llen || ptr != map.m_la) {
> +			erofs_err("broken data chunk layout m_la %" PRIu64
> +				  " ptr %" PRIu64 " m_llen %" PRIu64 " m_plen %"
> +				  PRIu64, map.m_la, ptr, map.m_llen,
> +				  map.m_plen);
> +			return -EFSCORRUPTED;
> +		}
> +
> +		if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen) {
> +			/* readched EOF */
> +			ptr = inode->i_size;
> +			continue;
> +		}
> +
> +		ptr += map.m_llen;
> +	}
> +
> +	if (fsckcfg.print_comp_ratio) {
> +		fsckcfg.logical_blocks += i_blocks;
> +		fsckcfg.physical_blocks += i_blocks;
> +	}
> +
> +	return 0;
> +}
> +
> +static int verify_compressed_chunk(struct erofs_inode *inode)
> +{
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +	};
> +	int ret = 0;
> +	u64 pchunk_len = 0;
> +	erofs_off_t end = inode->i_size;
> +	unsigned int algorithmformat, raw_size = 0, buffer_size = 0;
> +	char *raw = NULL, *buffer = NULL;
> +
> +	while (end > 0) {
> +		map.m_la = end - 1;
> +
> +		ret = z_erofs_map_blocks_iter(inode, &map);
> +		if (ret)
> +			goto out;
> +
> +		if (end > map.m_la + map.m_llen) {
> +			erofs_err("broken compressed chunk layout m_la %" PRIu64
> +				  " m_llen %" PRIu64 " end %" PRIu64,
> +				  map.m_la, map.m_llen, end);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		pchunk_len += map.m_plen;
> +		end = map.m_la;
> +
> +		if (!fsckcfg.check_decomp || !(map.m_flags & EROFS_MAP_MAPPED))
> +			continue;
> +
> +		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
> +						Z_EROFS_COMPRESSION_LZ4 :
> +						Z_EROFS_COMPRESSION_SHIFTED;
> +
> +		if (map.m_plen > raw_size) {
> +			raw_size = map.m_plen;
> +			raw = realloc(raw, raw_size);
> +			BUG_ON(!raw);
> +		}
> +
> +		if (map.m_llen > buffer_size) {
> +			buffer_size = map.m_llen;
> +			buffer = realloc(buffer, buffer_size);
> +			BUG_ON(!buffer);
> +		}
> +
> +		ret = dev_read(raw, map.m_pa, map.m_plen);
> +		if (ret < 0) {
> +			erofs_err("an error occurred when reading compressed "
> +				  "data of nid(%" PRIu64 "), m_pa %" PRIu64
> +				  ", m_plen %" PRIu64 ": errno(%d)",
> +				  inode->nid, map.m_pa, map.m_plen, ret);
> +			goto out;
> +		}
> +
> +		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> +					.in = raw,
> +					.out = buffer,
> +					.decodedskip = 0,
> +					.inputsize = map.m_plen,
> +					.decodedlength = map.m_llen,
> +					.alg = algorithmformat,
> +					.partial_decoding = 0
> +					 });
> +
> +		if (ret < 0) {
> +			erofs_err("an error occurred when decompressing "
> +				  "data of nid(%" PRIu64 "), m_pa %" PRIu64
> +				  ", m_plen %" PRIu64 ": errno(%d)",
> +				  inode->nid, map.m_pa, map.m_plen, ret);
> +			goto out;
> +		}
> +	}
> +
> +	if (fsckcfg.print_comp_ratio) {
> +		fsckcfg.logical_blocks += DIV_ROUND_UP(inode->i_size,
> +						       EROFS_BLKSIZ);
> +		fsckcfg.physical_blocks += DIV_ROUND_UP(pchunk_len,
> +							EROFS_BLKSIZ);
> +	}
> +out:
> +	if (raw)
> +		free(raw);
> +	if (buffer)
> +		free(buffer);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int erofs_verify_xattr(struct erofs_inode *inode)
> +{
> +	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
> +	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
> +	erofs_off_t addr;
> +	unsigned int ofs, xattr_shared_count;
> +	struct erofs_xattr_ibody_header *ih;
> +	struct erofs_xattr_entry *entry;
> +	int i, remaining = inode->xattr_isize, ret = 0;
> +	char *buf = calloc(EROFS_BLKSIZ, 1);
> +
> +	BUG_ON(!buf);
> +
> +	if (inode->xattr_isize == xattr_hdr_size) {
> +		erofs_err("xattr_isize %d of nid %llu is not supported yet",
> +			  inode->xattr_isize, inode->nid | 0ULL);
> +		ret = -EFSCORRUPTED;
> +		goto out;
> +	} else if (inode->xattr_isize < xattr_hdr_size) {
> +		if (inode->xattr_isize) {
> +			erofs_err("bogus xattr ibody @ nid %llu",
> +				  inode->nid | 0ULL);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +	}
> +
> +	addr = iloc(inode->nid) + inode->inode_isize;
> +	ret = dev_read(buf, addr, xattr_hdr_size);
> +	if (ret < 0) {
> +		erofs_err("an error occurred when reading xattr header "
> +			  "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
> +		goto out;
> +	}
> +	ih = (struct erofs_xattr_ibody_header *)buf;
> +	xattr_shared_count = ih->h_shared_count;
> +
> +	ofs = erofs_blkoff(addr) + xattr_hdr_size;
> +	addr += xattr_hdr_size;
> +	remaining -= xattr_hdr_size;
> +	for (i = 0; i < xattr_shared_count; ++i) {
> +		if (ofs >= EROFS_BLKSIZ) {
> +			if (ofs != EROFS_BLKSIZ) {
> +				erofs_err("unaligned xattr entry in "
> +					  "xattr shared area of nid(%llu)",
> +					  inode->nid | 0ULL);
> +				ret = -EFSCORRUPTED;
> +				goto out;
> +			}
> +			ofs = 0;
> +		}
> +		ofs += xattr_entry_size;
> +		addr += xattr_entry_size;
> +		remaining -= xattr_entry_size;
> +	}
> +
> +	while (remaining > 0) {
> +		unsigned int entry_sz;
> +
> +		ret = dev_read(buf, addr, xattr_entry_size);
> +		if (ret) {
> +			erofs_err("an error occurred when reading xattr entry "
> +				  "of nid(%llu): errno(%d)",
> +				  inode->nid | 0ULL, ret);
> +			goto out;
> +		}
> +
> +		entry = (struct erofs_xattr_entry *)buf;
> +		entry_sz = erofs_xattr_entry_size(entry);
> +		if (remaining < entry_sz) {
> +			erofs_err("xattr on-disk corruption: xattr entry "
> +				  "beyond xattr_isize of nid(%llu)",
> +				  inode->nid | 0ULL);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +		addr += entry_sz;
> +		remaining -= entry_sz;
> +	}
> +out:
> +	free(buf);
> +	return ret;
> +}
> +
> +static int erofs_verify_data_chunk(struct erofs_inode *inode)
> +{
> +	int ret;
> +
> +	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
> +		  inode->nid | 0ULL, inode->datalayout);
> +
> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_CHUNK_BASED:
> +		ret = verify_raw_data_chunk(inode);
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		ret = verify_compressed_chunk(inode);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret == -EIO)
> +		erofs_err("I/O error occurred when verifying "
> +			  "data chunk of nid(%llu)", inode->nid | 0ULL);
> +
> +	return ret;
> +}
> +
> +static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
> +{
> +	int ret;
> +	struct erofs_inode *inode;
> +	char *buf;
> +	erofs_off_t offset;
> +
> +	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
> +	inode = calloc(1, sizeof(struct erofs_inode));
> +	BUG_ON(!inode);
> +	buf = calloc(EROFS_BLKSIZ, 1);
> +	BUG_ON(!buf);
> +
> +	inode->nid = nid;
> +	ret = erofs_read_inode_from_disk(inode);
> +	if (ret) {
> +		if (ret == -EIO)
> +			erofs_err("I/O error occurred when reading nid(%llu)",
> +				  nid | 0ULL);
> +		goto out;
> +	}
> +
> +	/* verify xattr field */
> +	ret = erofs_verify_xattr(inode);
> +	if (ret)
> +		goto out;
> +
> +	/* verify data chunk layout */
> +	ret = erofs_verify_data_chunk(inode);
> +	if (ret)
> +		goto out;
> +
> +	if ((inode->i_mode & S_IFMT) != S_IFDIR)
> +		goto out;
> +
> +	offset = 0;
> +	while (offset < inode->i_size) {
> +		erofs_off_t maxsize = min_t(erofs_off_t,
> +					inode->i_size - offset, EROFS_BLKSIZ);
> +		struct erofs_dirent *de = (void *)buf;
> +		unsigned int nameoff;
> +
> +		ret = erofs_pread(inode, buf, maxsize, offset);
> +		if (ret) {
> +			erofs_err("I/O error occurred when reading dirents: "
> +				  "nid(%llu), offset(%llu), size(%llu)",
> +				  nid | 0ULL, offset | 0ULL, maxsize | 0ULL);
> +			goto out;
> +		}
> +
> +		nameoff = le16_to_cpu(de->nameoff);
> +		if (nameoff < sizeof(struct erofs_dirent) ||
> +				nameoff >= PAGE_SIZE) {
> +			erofs_err("invalid de[0].nameoff %u @ nid(%llu), "
> +				  "offset(%llu)",
> +				  nameoff, nid | 0ULL, offset | 0ULL);
> +			ret = -EFSCORRUPTED;
> +			goto out;
> +		}
> +
> +		ret = traverse_dirents(pnid, nid, buf, offset,
> +				       nameoff, maxsize);
> +		if (ret)
> +			goto out;
> +
> +		offset += maxsize;
> +	}
> +out:
> +	free(buf);
> +	free(inode);
> +	if (ret && ret != -EIO)
> +		fsckcfg.corrupted = true;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int err;
> +
> +	erofs_init_configure();
> +
> +	fsckcfg.corrupted = false;
> +	fsckcfg.print_comp_ratio = false;
> +	fsckcfg.check_decomp = false;
> +	fsckcfg.logical_blocks = 0;
> +	fsckcfg.physical_blocks = 0;
> +
> +	err = erofsfsck_parse_options_cfg(argc, argv);
> +	if (err) {
> +		if (err == -EINVAL)
> +			usage();
> +		goto exit;
> +	}
> +
> +	err = dev_open_ro(cfg.c_img_path);
> +	if (err) {
> +		erofs_err("failed to open image file");
> +		goto exit;
> +	}
> +
> +	err = erofs_read_superblock();
> +	if (err) {
> +		erofs_err("failed to read superblock");
> +		goto exit;
> +	}
> +
> +	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
> +		erofs_err("failed to verify superblock checksum");
> +		goto exit;
> +	}
> +
> +	erofs_check_inode(sbi.root_nid, sbi.root_nid);
> +
> +	if (fsckcfg.corrupted) {
> +		fprintf(stderr, "Found some filesystem corruption\n");
> +	} else {
> +		fprintf(stderr, "No error found\n");
> +		if (fsckcfg.print_comp_ratio) {
> +			double comp_ratio =
> +				(double)fsckcfg.physical_blocks * 100 /
> +				(double)fsckcfg.logical_blocks;
> +			fprintf(stderr, "Compression Ratio: %.2f(%%)\n",
> +				comp_ratio);
> +		}
> +	}
> +
> +exit:
> +	erofs_exit_configure();
> +	return err;
> +}
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 8b154ed..80065b2 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -82,6 +82,8 @@ struct erofs_sb_info {
>  
>  	u16 available_compr_algs;
>  	u16 lz4_max_distance;
> +
> +	u32 checksum;
>  };
>  
>  /* global sbi */
> @@ -264,10 +266,13 @@ int erofs_read_superblock(void);
>  
>  /* namei.c */
>  int erofs_ilookup(const char *path, struct erofs_inode *vi);
> +int erofs_read_inode_from_disk(struct erofs_inode *vi);
>  
>  /* data.c */
>  int erofs_pread(struct erofs_inode *inode, char *buf,
>  		erofs_off_t count, erofs_off_t offset);
> +int erofs_map_blocks(struct erofs_inode *inode,
> +		     struct erofs_map_blocks *map, int flags);
>  /* zmap.c */
>  int z_erofs_fill_inode(struct erofs_inode *vi);
>  int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 66a68e3..62e9981 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -400,4 +400,17 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>  		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
>  }
>  
> +#define CRC32C_POLY_LE	0x82F63B78
> +static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
> +{
> +	int i;
> +
> +	while (len--) {
> +		crc ^= *in++;
> +		for (i = 0; i < 8; i++)
> +			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
> +	}
> +	return crc;
> +}
> +
>  #endif
> diff --git a/lib/data.c b/lib/data.c
> index 641d840..6cb7eeb 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -61,8 +61,8 @@ err_out:
>  	return err;
>  }
>  
> -static int erofs_map_blocks(struct erofs_inode *inode,
> -			    struct erofs_map_blocks *map, int flags)
> +int erofs_map_blocks(struct erofs_inode *inode,
> +		     struct erofs_map_blocks *map, int flags)
>  {
>  	struct erofs_inode *vi = inode;
>  	struct erofs_inode_chunk_index *idx;
> diff --git a/lib/namei.c b/lib/namei.c
> index b4bdabf..56f199a 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -22,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
>  	return makedev(major, minor);
>  }
>  
> -static int erofs_read_inode_from_disk(struct erofs_inode *vi)
> +int erofs_read_inode_from_disk(struct erofs_inode *vi)
>  {
>  	int ret, ifmt;
>  	char buf[sizeof(struct erofs_inode_extended)];
> diff --git a/lib/super.c b/lib/super.c
> index 0fa69ab..0c30403 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -62,6 +62,7 @@ int erofs_read_superblock(void)
>  	sbi.islotbits = EROFS_ISLOTBITS;
>  	sbi.root_nid = le16_to_cpu(dsb->root_nid);
>  	sbi.inos = le64_to_cpu(dsb->inos);
> +	sbi.checksum = le32_to_cpu(dsb->checksum);
>  
>  	sbi.build_time = le64_to_cpu(dsb->build_time);
>  	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 1c8dea5..b9b46f5 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -424,19 +424,6 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	return 0;
>  }
>  
> -#define CRC32C_POLY_LE	0x82F63B78
> -static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
> -{
> -	int i;
> -
> -	while (len--) {
> -		crc ^= *in++;
> -		for (i = 0; i < 8; i++)
> -			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
> -	}
> -	return crc;
> -}
> -
>  static int erofs_mkfs_superblock_csum_set(void)
>  {
>  	int ret;
> -- 
> 2.33.1.1089.g2158813163f-goog
