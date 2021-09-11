Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD36407938
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 17:58:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6HTv5q1Tz2yNK
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Sep 2021 01:58:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M9JctW1q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M9JctW1q; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6HTs1ZhHz2yJ6
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Sep 2021 01:58:41 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82D7560FE6;
 Sat, 11 Sep 2021 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631375918;
 bh=R/cVgEYqnuFfww0VlLaIps26pct7C4a474uNO/Sg+cA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M9JctW1qB9qys1Wetc5DtjpHGuE4WSkQYlWcIYkV/mPmGAbMMF1Q3kUhK8rHAtQfp
 VT8l05G9OQEKHTCNYSQiEis6kwxhBvKFz/bLGX3FGLImKrnE6BOVu5vUxQHv2nQzRO
 0FE9du8zrYoHLWDAwkGRJgXvJ11ObQIKP7GvDU2Htpw+cSSbefRECTLZubgiKJWR1Z
 bMLSPvOjV/HnVK3d3uMNbcCf19mPV4lF+PW4QKSH29+dtDsvXyJP+H4jsvwBkkgqR+
 L0Dr9IKhzjLNFOS1vzxaCG4gUf1o2tjBN5Lwch47vqnEqc1iMijLMxF+1ldis/hI0A
 IwqI1zWSIz0ww==
Date: Sat, 11 Sep 2021 23:58:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v1 2/5] dump.erofs: add "-s" option to dump superblock
 information
Message-ID: <20210911155825.GB3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-2-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911134635.1253426-2-guoxuenan@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Sep 11, 2021 at 09:46:32PM +0800, Guo Xuenan wrote:
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: mpiglet <mpiglet@outlook.com>

Same here.

> ---
>  dump/main.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 8fbc24a..25ac89f 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -17,6 +17,12 @@
>  #include "erofs/print.h"
>  #include "erofs/io.h"
>  
> +struct dumpcfg {
> +	bool print_superblock;
> +	bool print_version;
> +};
> +static struct dumpcfg dumpcfg;
> +
>  static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{0, 0, 0, 0},
> @@ -26,6 +32,7 @@ static void usage(void)
>  {
>  	fputs("usage: [options] erofs-image \n\n"
>  		"Dump erofs layout from erofs-image, and [options] are:\n"
> +		"-s          print information about superblock\n"
>  		"-v/-V      print dump.erofs version info\n"
>  		"-h/--help  display this help and exit\n", stderr);
>  }
> @@ -41,6 +48,9 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",
>  					long_options, NULL)) != -1) {
>  		switch (opt) {
> +		case 's':
> +			dumpcfg.print_superblock = true;
> +			break;
>  		case 'v':
>  		case 'V':
>  			dumpfs_print_version();
> @@ -68,6 +78,39 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> +static void dumpfs_print_superblock(void)
> +{
> +	time_t time = sbi.build_time;
> +
> +	fprintf(stderr, "Filesystem magic number:	0x%04X\n", EROFS_SUPER_MAGIC_V1);
> +	fprintf(stderr, "Filesystem blocks: 		%lu\n", sbi.blocks);
> +	fprintf(stderr, "Filesystem meta block:		%u\n", sbi.meta_blkaddr);

Filesystem inode metadata start block:

> +	fprintf(stderr, "Filesystem xattr block:	%u\n", sbi.xattr_blkaddr);

Filesystem shared xattr metadata start block:

> +	fprintf(stderr, "Filesystem root nid:		%ld\n", sbi.root_nid);


> +	fprintf(stderr, "Filesystem valid inos:		%lu\n", sbi.inos);

Inode count:

> +	fprintf(stderr, "Filesystem created:		%s", ctime(&time));
> +	fprintf(stderr, "Filesystem uuid:		");

Filesystem UUID:

How about printing to stdout directly? according to
dumpe2fs:
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/misc/dumpe2fs.c#n219

Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          c46ea44a-e249-446f-af40-xxxxxxxxxxxx
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              8003584
Block count:              32000000
Reserved block count:     1600000
Free blocks:              18661241
Free inodes:              7681550
First block:              0
Block size:               4096
Fragment size:            4096


> +	for (int i = 0; i < 16; i++)
> +		fprintf(stderr, "%02x", sbi.uuid[i]);
> +	fprintf(stderr, "\n");

It seems not the correct UUID style...

> +
> +	if (erofs_sb_has_lz4_0padding())
> +		fprintf(stderr, "Filesystem support lz4 0padding\n");
> +	else
> +		fprintf(stderr, "Filesystem not support lz4 0padding\n");
> +
> +	if (erofs_sb_has_big_pcluster())
> +		fprintf(stderr, "Filesystem support big pcluster\n");
> +	else
> +		fprintf(stderr, "Filesystem not support big pcluster\n");
> +
> +	if (erofs_sb_has_sb_chksum())
> +		fprintf(stderr, "Filesystem has super block checksum feature\n");
> +	else
> +		fprintf(stderr, "Filesystem has no superblock checksum feature\n");

How about showing the features in a list as above?

Thanks,
Gao Xiang

> +
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -80,5 +123,20 @@ int main(int argc, char **argv)
>  		return -1;
>  	}
>  
> +	err = dev_open_ro(cfg.c_img_path);
> +	if (err) {
> +		erofs_err("open image file failed");
> +		return -1;
> +	}
> +
> +	err = erofs_read_superblock();
> +	if (err) {
> +		erofs_err("read superblock failed");
> +		return -1;
> +	}
> +
> +	if (dumpcfg.print_superblock)
> +		dumpfs_print_superblock();
> +
>  	return 0;
>  }
> -- 
> 2.25.4
> 
