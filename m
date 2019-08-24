Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDF9BC99
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 10:47:24 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46FsMr2RT2zDrRc
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 18:47:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.com
 (client-ip=212.227.17.20; helo=mout.gmx.net; envelope-from=hsiangkao@gmx.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="LN8u15gM"; 
 dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FsMT38vzzDqSJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 18:46:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1566636401;
 bh=8NFCV/0y39dVkO4rzL9M0y7rrjG2Afpi0o8CYNy5EN4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LN8u15gMmd9waSb6TL8cdvIsHUhSxQwkYZ/c62nhhrIKRkBizhL0FsxsSBfhbKDli
 p/jzw3O8p3nalUJJ74KiQmeOs6wAUyJ2nKG/YABN/hDcZuSyQRGk6snbWIWJWaW71C
 Dv8tIy/u1+erBLiTSRnBo1tVMhoF5S/vbU/c5O7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.24.170.89]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M8ZtH-1iO2yp1hLP-00wDDY; Sat, 24 Aug 2019 10:46:41 +0200
Date: Sat, 24 Aug 2019 16:46:30 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824074158.16254-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824074158.16254-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:gKRXpwdNB8mD1k2uxZegErYxc7+di26ZZo42nmS9QQ8tA7DVAKJ
 TA4UV3t3VIXcw7SZYsr0FYg+rW4FeS4Ki2uSl30PCbAZp0omOwpslO5HHIWsebu07ZW3FKc
 HiPOVsduOd01IFYCKEgcd3t4rMhEqYuOiBEXc5NWLwyoV7gD2aDEzgZfVTt4BQ5pFF6VdP1
 EEpcCjQEuQC/4o/8po+tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L7J9sb8FBYU=:qamUH7yle40nu98L2GQF+5
 fEEzjcm6BRJFw4BBv+l562d972SS6K6p2NuhmAQo385n7jXwXtGzjHB9JIFZqWuwKeJp2cWCX
 xj7HxBa7NZrfVP1S8odtk4O1g7BxH7u84Yeus267F7od3kMIMpfjgDhYURux7aI2P4nKVzM95
 N4TfoxdywF/nXjPKj7WbEqyG9Zq2VucaxBJVwEPeAHTkq/tika7I8SlvWa+t5Dn6Rg7PedGOw
 JGjGrprzVx/VZpDhqd0eFCrUq834WR70vh5cs1oGpav8eTnrHi81A/zu1K3fhcwUnJsyeNezD
 qUZK82BTf2FBDQHWimemdJQw8WTULaj3hDhUJlOLn09mg8o1hA11T14ArI9gYb1VAIxydMo2O
 lcnrxA5gKz4fgTFaEJjEOXLa1eWoIpUkoH+w2PuR8IZ1V3SQdRnbofXeGqAzHkjEBSdK1NekC
 5xGcvtefJf8G1RedeACmb41K5+oFYu3TQDDYwMycyE6Mmf+o7TNFoFdiTRoQNcTGoRLuetYSA
 A5FkyVZYsJE7yVkaWhbCACjJuxGNi3oNxLDyCYvOkGF9htMil7t3d33JSKcaFtIY9ztqdpYDc
 lDEhDr3zlMOK3lt4uFy8MyaLoPaTlujV3wo3JPqn1332rAlJB/G7nAqk1TXMIfEUJeSHrZgiP
 DRLcnx/+D6ISfaAps//CnNn05KbFjBX8jHp3C3Ho5bXtnQvqHlJiUC2SpPL+BWFefXVdLJ7VF
 xxVw526tgeFUWhIUdcKBTxJwdySgcH2EWAtI61SO/XrzeWOq9x8tzAN2x37mWO6StvWaCOsF+
 1NihzTrbt7grc64Qe9G/fcXFtwQGTF2TeNYEB9UkVFaPqkmg9tj/JYfSPNeWGZvM6aycij9Kw
 sqw7uFhpaS+IjRAAXDlYqAQUXGFDtesiXhLvdU8NQt/+FZ+EaTPoaFVNXoSdhT1SehL4R9qsQ
 BNX4G4izWc59FToSZ+AWp2tOKOUZmSgHwNpqdfl0I1tYSyVQ5TNFihgOxrR0/RPPcJ688dL96
 Ufcmll7fRnWxhL9ZXEBeceobGPFv/Fz7EzSEFvkfthPucO+5Vh3gay46HMrNvM86wUVkqK84r
 HvdNN+vpe1KAygfR46aBsZ2uG2p+0ByRLw7Rg/otVmTZnbE15cXk9pqPAXv0DQYFjf/JYY4Nj
 ++q+wBJ4JTT3wk8WEAe1TK+ycGw7OhdOrb9SQNwu01e80kdQ==
Content-Transfer-Encoding: quoted-printable
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

On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:
> Adding code for superblock checksum calculation.
>
> This patch adds following things:
> 1)Handle suboptions('-o') to mkfs utility.

Thanks for your patch. :)

Can we use "-O feature" instead in order to keep in line with mke2fs?

> 2)Add superblock checksum calculation(-o sb_cksum) as suboption.

ditto. and I think we can enable sbcrc by default since it is a compat fea=
ture,
and add "-O nosbcrc" to disable it.

> 3)Calculate superblock checksum if feature is enabled.
>
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

And could you please also read my following comments and fix them.
and I'd like to accept your erofs-utils modification in advance. :)


But now you can see we are moving EROFS out of staging now as
the "real" part of Linux, this is the fundamental stuff of other
new features if we want to develop more actively... So we can wait
for the final result and add this new feature to kernel then...

> ---
>  include/erofs/config.h |  1 +
>  include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
>  mkfs/main.c            | 53 +++++++++++++++++++++++++++++++++++++++++++=
++++++-
>  3 files changed, 76 insertions(+), 18 deletions(-)
>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 05fe6b2..40cd466 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -22,6 +22,7 @@ struct erofs_configure {
>  	char *c_src_path;
>  	char *c_compr_alg_master;
>  	int c_compr_level_master;
> +	int c_feature_flags;

we can add this to sbi like requirements...

>  };
>
>  extern struct erofs_configure cfg;
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 601b477..c9ef057 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -20,25 +20,31 @@
>  #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
>
> +/*
> + * feature definations.
> + */
> +#define EROFS_FEATURE_SB_CHKSUM		0x0001
> +
> +#define EROFS_HAS_COMPAT_FEATURE(super,mask)	\
> +	( le32_to_cpu((super)->features) & (mask) )
> +
>  struct erofs_super_block {
>  /*  0 */__le32 magic;           /* in the little endian */
> -/*  4 */__le32 checksum;        /* crc32c(super_block) */
> -/*  8 */__le32 features;        /* (aka. feature_compat) */
> -/* 12 */__u8 blkszbits;         /* support block_size =3D=3D PAGE_SIZE =
only */
> -/* 13 */__u8 reserved;
> -
> -/* 14 */__le16 root_nid;
> -/* 16 */__le64 inos;            /* total valid ino # (=3D=3D f_files - =
f_favail) */
> -
> -/* 24 */__le64 build_time;      /* inode v1 time derivation */
> -/* 32 */__le32 build_time_nsec;
> -/* 36 */__le32 blocks;          /* used for statfs */
> -/* 40 */__le32 meta_blkaddr;
> -/* 44 */__le32 xattr_blkaddr;
> -/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
> -/* 64 */__u8 volume_name[16];   /* volume name */
> -/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> -
> +/*  4 */__le32 features;        /* (aka. feature_compat) */
> +/*  8 */__u8 blkszbits;         /* support block_size =3D=3D PAGE_SIZE =
only */
> +/*  9 */__u8 reserved;
> +
> +/* 10 */__le16 root_nid;
> +/* 12 */__le64 inos;            /* total valid ino # (=3D=3D f_files - =
f_favail) */
> +/* 20 */__le64 build_time;      /* inode v1 time derivation */
> +/* 28 */__le32 build_time_nsec;
> +/* 32 */__le32 blocks;          /* used for statfs */
> +/* 36 */__le32 meta_blkaddr;
> +/* 40 */__le32 xattr_blkaddr;
> +/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
> +/* 60 */__u8 volume_name[16];   /* volume name */
> +/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
> +/* 80 */__le32 checksum;        /* crc32c(super_block) */
>  /* 84 */__u8 reserved2[44];

Why modifying the above?

>  } __packed;                     /* 128 bytes */
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f127fe1..26e14a3 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -13,12 +13,14 @@
>  #include <limits.h>
>  #include <libgen.h>
>  #include <sys/stat.h>
> +#include <zlib.h>

I have no idea that we should introduce "zlib" just for crc32c currently..=
.
Maybe we can add some independent crc32 function..

Thanks,
Gao Xiang

>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/cache.h"
>  #include "erofs/inode.h"
>  #include "erofs/io.h"
>  #include "erofs/compress.h"
> +#include "erofs/defs.h"
>
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super=
_block))
>
> @@ -31,6 +33,28 @@ static void usage(void)
>  	fprintf(stderr, " -EX[,...] X=3Dextended options\n");
>  }
>
> +char *feature_opts[] =3D {
> +	"sb_cksum", NULL
> +};
> +#define O_SB_CKSUM	0
> +
> +static int parse_feature_subopts(char *opts)
> +{
> +	char *arg;
> +
> +	while (*opts !=3D '\0') {
> +		switch(getsubopt(&opts, feature_opts, &arg)) {
> +		case O_SB_CKSUM:
> +			cfg.c_feature_flags |=3D EROFS_FEATURE_SB_CHKSUM;
> +			break;
> +		default:
> +			erofs_err("incorrect suboption");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int parse_extended_opts(const char *opts)
>  {
>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char *arg=
v[])
>  {
>  	int opt, i;
>
> -	while ((opt =3D getopt(argc, argv, "d:z:E:")) !=3D -1) {
> +	while ((opt =3D getopt(argc, argv, "d:z:E:o:")) !=3D -1) {
>  		switch (opt) {
>  		case 'z':
>  			if (!optarg) {
> @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])
>  				return opt;
>  			break;
>
> +		case 'o':
> +			opt =3D parse_feature_subopts(optarg);
> +			if (opt)
> +				return opt;
> +			break;
> +
>  		default: /* '?' */
>  			return -EINVAL;
>  		}
> @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])
>  	return 0;
>  }
>
> +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> +{
> +	int offset;
> +	u32 crc;
> +
> +	offset =3D offsetof(struct erofs_super_block, checksum);
> +	if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
> +		erofs_err("Invalid offset of checksum field: %d", offset);
> +		return -1;
> +	}
> +	crc =3D crc32(~0, (const unsigned char *)sb,(size_t)offset);
> +	erofs_dump("superblock checksum: 0x%x\n", crc);
> +	return 0;
> +}
> +
>  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  				  erofs_nid_t root_nid)
>  {
> @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffe=
r_head *bh,
>  		.meta_blkaddr  =3D sbi.meta_blkaddr,
>  		.xattr_blkaddr =3D 0,
>  		.requirements =3D cpu_to_le32(sbi.requirements),
> +		.features =3D cpu_to_le32(cfg.c_feature_flags),
>  	};
>  	const unsigned int sb_blksize =3D
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct erofs_buff=
er_head *bh,
>  	sb.blocks       =3D cpu_to_le32(erofs_mapbh(NULL, true));
>  	sb.root_nid     =3D cpu_to_le16(root_nid);
>
> +	if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> +		u32 crc =3D erofs_superblock_checksum(&sb);
> +		sb.checksum =3D cpu_to_le32(crc);
> +	}
> +
>  	buf =3D calloc(sb_blksize, 1);
>  	if (!buf) {
>  		erofs_err("Failed to allocate memory for sb: %s",
> --
> 2.9.3
>
