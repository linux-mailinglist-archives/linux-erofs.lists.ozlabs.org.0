Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C848F43DFFA
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 13:27:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg3FF599Mz2yX8
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 22:27:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg3FB2QRlz2xXW
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 22:27:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uu.wnSq_1635420425; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uu.wnSq_1635420425) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 28 Oct 2021 19:27:06 +0800
Date: Thu, 28 Oct 2021 19:27:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 4/5] erofs-utils: dump: add support for showing file
 extents.
Message-ID: <YXqJCduOaW2NTsrJ@B-P7TQMD6M-0146.local>
References: <20211028105748.3586231-1-guoxuenan@huawei.com>
 <20211028105748.3586231-4-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028105748.3586231-4-guoxuenan@huawei.com>
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
Cc: daeho43@gmail.com, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 06:57:47PM +0800, Guo Xuenan wrote:
> Add option -e to show file extents info, this option needs
> specify nid as well. (eg. dump.erofs --nid # -e erofs.img)
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  dump/main.c              | 77 ++++++++++++++++++++++++++++++++++------
>  include/erofs/internal.h |  2 ++
>  lib/data.c               |  4 +--
>  3 files changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index d1aa017..58ecf93 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -18,6 +18,7 @@
>  struct erofsdump_cfg {
>  	unsigned int totalshow;
>  	bool show_inode;
> +	bool show_extent;
>  	bool show_superblock;
>  	bool show_statistics;
>  	erofs_nid_t nid;
> @@ -94,6 +95,7 @@ static void usage(void)
>  	fputs("usage: [options] IMAGE\n\n"
>  	      "Dump erofs layout from IMAGE, and [options] are:\n"
>  	      " -V      print the version number of dump.erofs and exit.\n"
> +	      " -e      show extent info (require --nid #)\n"

	      " -e      show extent info (require --nid set)\n"

>  	      " -s      show information about superblock\n"
>  	      " -S      show statistic information of the image\n"
>  	      " --nid=# show the target inode info of nid #\n"
> @@ -110,9 +112,13 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
>  
> -	while ((opt = getopt_long(argc, argv, "SV:s",
> +	while ((opt = getopt_long(argc, argv, "SVes",
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
> +		case 'e':
> +			dumpcfg.show_extent = true;
> +			++dumpcfg.totalshow;
> +			break;
>  		case 's':
>  			dumpcfg.show_superblock = true;
>  			++dumpcfg.totalshow;
> @@ -407,7 +413,28 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
>  	return -1;
>  }
>  
> -static void erofsdump_show_fileinfo(void)
> +static int erofsdump_map_blocks_helper(struct erofs_inode *inode,
> +		struct erofs_map_blocks *map, int flags)
> +{
> +	int err = 0;
> +

Let's add a generic entry in lib/zmap.c:

int erofs_map_blocks(struct inode *inode,
		     struct erofs_map_blocks *map, int flags)
{
	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
		return z_erofs_map_blocks_iter(inode, map, flags);
	return erofs_map_blocks_flatmode(inode, map, flags);
}

> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_CHUNK_BASED:
> +		err = erofs_map_blocks(inode, map, flags);
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		err = z_erofs_map_blocks_iter(inode, map, flags);
> +		break;
> +	default:

		err = -EOPNOTSUPP;

> +		break;
> +	}
> +	return err;
> +}
> +
> +static void erofsdump_show_fileinfo(bool show_extent)
>  {
>  	int err;
>  	erofs_off_t size;
> @@ -418,6 +445,11 @@ static void erofsdump_show_fileinfo(void)
>  	char path[PATH_MAX + 1] = {0};
>  	char access_mode_str[] = "rwxrwxrwx";
>  	char timebuf[128] = {0};
> +	unsigned int extent_count = 0;
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +		.m_la = 0,
> +	};
>  
>  	err = erofs_read_inode_from_disk(&inode);
>  	if (err) {
> @@ -437,6 +469,14 @@ static void erofsdump_show_fileinfo(void)
>  		return;
>  	}
>  
> +	t = inode.i_ctime;
> +	strftime(timebuf, sizeof(timebuf),
> +			"%Y-%m-%d %H:%M:%S", localtime(&t));
> +	access_mode = inode.i_mode & 0777;
> +	for (int i = 8; i >= 0; i--) {
> +		if (((access_mode >> i) & 1) == 0)
> +			access_mode_str[8 - i] = '-';
> +	}

Why we need to move this part?

Thanks,
Gao Xiang

