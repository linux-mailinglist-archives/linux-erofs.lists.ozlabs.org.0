Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79FD5969
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 03:53:53 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46s1nC0bXczDqLr
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 12:53:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46s1my34BRzDqFB
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 12:53:36 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 6C93F20D12041B494CDB
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 09:53:28 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 14 Oct 2019 09:53:28 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 14 Oct 2019 09:53:27 +0800
Date: Mon, 14 Oct 2019 09:56:29 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] code for calculating crc checksum of erofs blocks.
Message-ID: <20191014015629.GA204311@architecture4>
References: <20191013104911.30358-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191013104911.30358-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

Thanks for your patch, some comments as below...

On Sun, Oct 13, 2019 at 04:19:11PM +0530, Pratik Shinde wrote:
> Added code for calculating crc of erofs blocks (4K size).for now it calculates
> checksum of first block. but can modified to calculate crc for any no. of blocks.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/config.h |  3 +++
>  include/erofs/io.h     |  8 ++++++
>  lib/config.c           |  2 ++
>  lib/io.c               | 27 +++++++++++++++++++
>  mkfs/main.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 113 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 9711638..e167cd4 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -16,6 +16,8 @@ enum {
>  	FORCE_INODE_EXTENDED,
>  };
>  
> +#define EROFS_FEATURE_BLK_CKSUM		1

how about using EROFS_FEATURE_SB_CHKSUM


> +
>  struct erofs_configure {
>  	const char *c_version;
>  	int c_dbg_lvl;
> @@ -29,6 +31,7 @@ struct erofs_configure {
>  	int c_compr_level_master;
>  	int c_force_inodeversion;
>  	u64 c_unix_timestamp;
> +	int c_blk_cksum;
>  };

Since it is actually a filesystem feature, I think we should add
an extra field to erofs_sb_info instead.

 51 struct erofs_sb_info {
 52         erofs_blk_t meta_blkaddr;
 53         erofs_blk_t xattr_blkaddr;
 54

add         u32 feature;

 55         u32 feature_incompat;
 56         u64 build_time;
 57         u32 build_time_nsec;
 58 };


>  
>  extern struct erofs_configure cfg;
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 9775047..e0ca8d9 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -19,6 +19,7 @@
>  int dev_open(const char *devname);
>  void dev_close(void);
>  int dev_write(const void *buf, u64 offset, size_t len);
> +int dev_read(void *buf, u64 offset, size_t len);
>  int dev_fillzero(u64 offset, size_t len, bool padding);
>  int dev_fsync(void);
>  int dev_resize(erofs_blk_t nblocks);
> @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>  			 blknr_to_addr(nblocks));
>  }
>  
> +static inline int blk_read(void *buf, erofs_blk_t start,
> +			    u32 nblocks)
> +{
> +	return dev_read(buf, blknr_to_addr(start),
> +			 blknr_to_addr(nblocks));
> +}
> +
>  #endif
>  
> diff --git a/lib/config.c b/lib/config.c
> index 46625d7..b5ddff8 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include "erofs/print.h"
>  #include "erofs/internal.h"
> +#include "erofs/config.h"
>  
>  struct erofs_configure cfg;
>  
> @@ -22,6 +23,7 @@ void erofs_init_configure(void)
>  	cfg.c_compr_level_master = -1;
>  	cfg.c_force_inodeversion = 0;
>  	cfg.c_unix_timestamp = -1;
> +	cfg.c_blk_cksum = EROFS_FEATURE_BLK_CKSUM;

change to sbi.feature = EROFS_FEATURE_SB_CHKSUM;
and move this to mkfs/main.c (lib/config.c will also
be used for debugfs/erofs-fuse...)

>  }
>  
>  void erofs_show_config(void)
> diff --git a/lib/io.c b/lib/io.c
> index 7f5f94d..52f9424 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
>  	return dev_fillzero(st.st_size, length, true);
>  }
>  
> +int dev_read(void *buf, u64 offset, size_t len)
> +{
> +	int ret;
> +
> +	if (cfg.c_dry_run)
> +		return 0;
> +
> +	if (!buf) {
> +		erofs_err("buf is NULL");
> +		return -EINVAL;
> +	}
> +	if (offset >= erofs_devsz || len > erofs_devsz ||
> +	    offset > erofs_devsz - len) {
> +		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
> +			  "the end of device(%" PRIu64 ").",
> +			  offset, len, erofs_devsz);
> +		return -EINVAL;
> +	}
> +
> +	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> +	if (ret != (int)len) {
> +		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
> +			  erofs_devname, offset, len);
> +		return -errno;
> +	}
> +	return 0;
> +}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 91a018f..239d6e7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -22,6 +22,9 @@
>  
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>  
> +// number of blocks for calculating checksum

How about using C comments for all cases

> +#define EROFS_CKSUM_BLOCKS	1

#define EROFS_SB_CHKSUM_BLOCKS	1

> +
>  static void usage(void)
>  {
>  	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -85,6 +88,10 @@ static int parse_extended_opts(const char *opts)
>  				return -EINVAL;
>  			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
>  		}
> +
> +		if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> +			cfg.c_blk_cksum = ~EROFS_FEATURE_BLK_CKSUM;

                        sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM

> +		}
>  	}
>  	return 0;
>  }
> @@ -180,6 +187,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  		.meta_blkaddr  = sbi.meta_blkaddr,
>  		.xattr_blkaddr = 0,

		.feature = cpu_to_le32(sbi.feature),

>  		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> +		.checksum = 0
>  	};
>  	const unsigned int sb_blksize =
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -202,6 +210,68 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	return 0;
>  }
>  
> +#define CRCPOLY	0x82F63B78
> +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> +{
> +	int i;
> +	u32 crc = seed;
> +
> +	while (len--) {
> +		crc ^= *in++;
> +		for (i = 0; i < 8; i++) {
> +			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> +		}
> +	}
> +	return crc;
> +}
> +
> +// calculate checksum for first n blocks
> +u32 erofs_blk_checksum(erofs_blk_t nblks, u32 *crc) {

use K&R c style, how about naming erofs_calc_blk_chksum?

> +	char *buf;
> +	int err = 0;
> +
> +	buf = malloc(nblks * EROFS_BLKSIZ);
> +	err = blk_read(buf, 0, nblks);
> +	if (err) {
> +		erofs_err("Failed to calculate erofs checksum - %s",
> +			  erofs_strerror(err));
> +		return err;
> +	}
> +	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> +	free(buf);
> +	return 0;
> +}
> +
> +void erofs_set_checksum() {

erofs_write_sb_chksum()? and K&R style as well...

> +	struct erofs_super_block *sb;
> +	char buf[EROFS_BLKSIZ];
> +	int ret = 0;
> +	u32 crc;
> +
> +	ret = erofs_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> +	if (ret) {
> +		return;
> +	}
> +	ret = blk_read(buf, 0, 1);
> +	if (ret) {
> +		erofs_err("error reading super-block structure");

                erofs_err("failed to read superblock for checksuming");

> +		return;
> +	}
> +
> +	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> +		erofs_err("not an erofs image");
> +		return;
> +	}
> +	sb->checksum = cpu_to_le32(crc);
> +	ret = blk_write(buf, 0, 1);
> +	if (ret) {
> +		erofs_err("error writing 0th block to disk - %s",

			  failed to write checksumed superblock: %s"


> +			  erofs_strerror(ret));
> +		return;
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -301,6 +371,9 @@ int main(int argc, char **argv)
>  		err = -EIO;
>  	else
>  		err = dev_resize(nblocks);
> +	if (cfg.c_blk_cksum & EROFS_FEATURE_BLK_CKSUM) {
> +		erofs_set_checksum();
> +	}

no need to wrap in braces for the single line statement
according to linux kernel style.

Thanks,
Gao Xiang

>  exit:
>  	z_erofs_compress_exit();
>  	dev_close();
> -- 
> 2.9.3
> 
