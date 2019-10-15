Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00460D7978
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 17:12:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46szRm39RjzDr4Y
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2019 02:12:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilhBaD6N"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46szRb4TNfzDr2y
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2019 02:11:55 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id y22so12687671pfr.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=26zNHNhcEJ5famWSGhSZAKABPGyqyW8rKBC2gKeGNS4=;
 b=ilhBaD6NKhBe8fu0owaKxEByBf24Ni9YcOKQ8WUpFSo9OsOaK2XHNwpGGvJZB87HNj
 +qGV1rzSavzq6/a1GeVxcPdxHxc7KQiaNRirT0NfQVb1bPswJQJMAB8vdUXO+lZ/xhmr
 pxK1zgNprQ4WuRgu4cmY/IbpAfT3iS3RIqP2h2nziMsXvjy+Dv4Ge+NFONb4rdfJshn6
 Kb1rUYcWHl9tYGYpcqTnEM+ZHy5XY187MU61XKbFnDtfAF8t+Sfo1wc2/gDIDroB9l8t
 6Lin3+9wh3458Y7BKnRT4M2djGZT9f8LAn05WZlQuNYTxe/mlWlSthfAHHt5wWVoenFX
 LS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=26zNHNhcEJ5famWSGhSZAKABPGyqyW8rKBC2gKeGNS4=;
 b=npiPScjCWeEacIhNOmqUkKiGUeU1xU+UeusTMohWm0JYbNnUhA6crbLczXWer09p4i
 LnHih3RozOUonfEQ5wyj1EVVHis7b8fN41DyusSZHDjjECEtWmhLM/eoCqYBzWrNXnPh
 A2MwhyLs3mZrnolWh8VRYgJzUPN3hA1jHX1ne8Bicro6C2Y/5Bj0Zb14WOsYYktcnCwd
 K8BVuMOfGc2NgMM+mZWE7bKR67QZYVjqk39MsOLXcDgvJ8vqB66MbQAfLbR/wyfiJz5N
 y7PlDjfFwlGwkE4FbT6qv3Ibr/BwZUXcErhBEGg9m49bJWJQVwDPfOFjCxcFbxNykar0
 l5cQ==
X-Gm-Message-State: APjAAAVmBO7whr6YySApcJEs9fxZMsoa1ZyJGCwe/jqQozYgp2b7pvJ6
 /fncGDJMrA+zkE5or7VTrt8=
X-Google-Smtp-Source: APXvYqxx4dcQ6KlWv6gS+/y8akGMevDhVumZqG24dF+c/T+OxPwGx4nWbbmH0dnJPalw5v7URAW2KQ==
X-Received: by 2002:a63:8ac8:: with SMTP id y191mr807192pgd.324.1571152310311; 
 Tue, 15 Oct 2019 08:11:50 -0700 (PDT)
Received: from [0.0.0.0] (li868-97.members.linode.com. [139.162.27.97])
 by smtp.gmail.com with ESMTPSA id p24sm6875403pgc.72.2019.10.15.08.11.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 08:11:49 -0700 (PDT)
Subject: Re: [PATCH-v3] erofs-utils:code for calculating crc checksum of erofs
 blocks.
To: Pratik Shinde <pratikshinde320@gmail.com>, linux-erofs@lists.ozlabs.org,
 bluce.liguifu@huawei.com, miaoxie@huawei.com, fangwei1@huawei.com
References: <20191015051830.7756-1-pratikshinde320@gmail.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <2e0cf8fd-4b60-d8a4-e7ed-17e9f7674826@gmail.com>
Date: Tue, 15 Oct 2019 23:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015051830.7756-1-pratikshinde320@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik, Gao Xiang

Can sbi.fearture merge into sbi.feature_incompat ?
If not, it will has two feature parameter

It has the blocks field in the super block, chksum_blocks duplicates it.
and chksum may be used to check whole erofs image file.

> Added code for calculating crc of erofs blocks (4K size).for now it calculates
> checksum of first block. but can modified to calculate crc for any no. of blocks
> 
> 1) Added 'chksum_blocks' field to erofs_super_block
> 2) removed unnecessary prints
> 3) moved EROFS_FEATURE_SB_CHKSUM include/erofs_fs.h
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>   include/erofs/internal.h |  1 +
>   include/erofs/io.h       |  8 ++++++
>   include/erofs_fs.h       |  3 ++-
>   lib/io.c                 | 27 +++++++++++++++++++
>   mkfs/main.c              | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 5384946..53335bc 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -55,6 +55,7 @@ struct erofs_sb_info {
>   	u32 feature_incompat;
>   	u64 build_time;
>   	u32 build_time_nsec;
> +	u32 feature;
>   };
>   
>   /* global sbi */
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 9775047..e0ca8d9 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -19,6 +19,7 @@
>   int dev_open(const char *devname);
>   void dev_close(void);
>   int dev_write(const void *buf, u64 offset, size_t len);
> +int dev_read(void *buf, u64 offset, size_t len);
>   int dev_fillzero(u64 offset, size_t len, bool padding);
>   int dev_fsync(void);
>   int dev_resize(erofs_blk_t nblocks);
> @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>   			 blknr_to_addr(nblocks));
>   }
>   
> +static inline int blk_read(void *buf, erofs_blk_t start,
> +			    u32 nblocks)
> +{
> +	return dev_read(buf, blknr_to_addr(start),
> +			 blknr_to_addr(nblocks));
> +}
> +
>   #endif
>   
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index f29aa25..8bd29d6 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -19,6 +19,7 @@
>    */
>   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>   #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_SB_CHKSUM	0x0001
>   
>   /* 128-byte erofs on-disk super block */
>   struct erofs_super_block {
> @@ -39,7 +40,7 @@ struct erofs_super_block {
>   	__u8 uuid[16];          /* 128-bit uuid for volume */
>   	__u8 volume_name[16];   /* volume name */
>   	__le32 feature_incompat;
> -
> +	__le32 chksum_blocks;	/* number of blocks used for checksum */
>   	__u8 reserved2[44];
>   };
>   
> diff --git a/lib/io.c b/lib/io.c
> index 7f5f94d..52f9424 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
>   	return dev_fillzero(st.st_size, length, true);
>   }
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
> index 91a018f..0633e83 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -22,6 +22,9 @@
>   
>   #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>   
> +/* number of blocks for calculating checksum */
> +#define EROFS_CKSUM_BLOCKS	1
> +
>   static void usage(void)
>   {
>   	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -85,6 +88,10 @@ static int parse_extended_opts(const char *opts)
>   				return -EINVAL;
>   			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
>   		}
> +
> +		if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> +			sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
> +		}
>   	}
>   	return 0;
>   }
> @@ -180,6 +187,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>   		.meta_blkaddr  = sbi.meta_blkaddr,
>   		.xattr_blkaddr = 0,
>   		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> +		.checksum = 0,
> +		.chksum_blocks = cpu_to_le32(EROFS_CKSUM_BLOCKS)
>   	};
>   	const unsigned int sb_blksize =
>   		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -202,6 +211,64 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>   	return 0;
>   }
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
> +/* calculate checksum for first n blocks */
> +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
> +{
> +	char *buf;
> +	int err = 0;
> +
> +	buf = malloc(nblks * EROFS_BLKSIZ);
> +	err = blk_read(buf, 0, nblks);
> +	if (err) {
> +		return err;
> +	}
> +	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> +	free(buf);
> +	return 0;
> +}
> +
> +void erofs_write_sb_checksum()
> +{
> +	struct erofs_super_block *sb;
> +	char buf[EROFS_BLKSIZ];
> +	int ret = 0;
> +	u32 crc;
> +
> +	ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> +	if (ret) {
> +		return;
> +	}
> +	ret = blk_read(buf, 0, 1);
> +	if (ret) {
> +		return;
> +	}
> +
> +	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> +		return;
> +	}
> +	sb->checksum = cpu_to_le32(crc);
> +	ret = blk_write(buf, 0, 1);
> +	if (ret) {
> +		return;
> +	}
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	int err = 0;
> @@ -217,6 +284,7 @@ int main(int argc, char **argv)
>   
>   	cfg.c_legacy_compress = false;
>   	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> +	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
>   
>   	err = mkfs_parse_options_cfg(argc, argv);
>   	if (err) {
> @@ -301,6 +369,8 @@ int main(int argc, char **argv)
>   		err = -EIO;
>   	else
>   		err = dev_resize(nblocks);
> +	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> +		erofs_write_sb_checksum();
>   exit:
>   	z_erofs_compress_exit();
>   	dev_close();
> 
