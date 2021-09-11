Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29540798F
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 18:29:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6J9Q2Bypz2yNr
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Sep 2021 02:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hgYfv9CM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hgYfv9CM; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6J9M5Ykgz2y1R
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Sep 2021 02:29:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012D260F58;
 Sat, 11 Sep 2021 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631377765;
 bh=bf8FFMZ5pwqacCKBCgJ0xsFJ16QNWtHEy/02hr6idwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hgYfv9CMGEePdpGHhQvB8Z9DncO5hL3eQp99QeWZcqiQGu65SOoAh9XP2+EH7xHSS
 k+GV9TSEPU4EOn8Q7kY/y9gxfmkg4N1S+Uulpaedbqpqmu0dvDsK9h0/V+uVTnhRiU
 kcTYUVELBEycjjv2KYZovGkmXW43HlyKZXK/34xuF1ueGxEmrbZijfONyYi5L0ShbU
 tDlCUxDr8bGVQbwzEZdpY/88NQspBis7TFCxuJBsgvMHnJY/83gJ6UPVyb4nyAi77x
 W1qqffmc9PNGV51ZawIDpts1r2hqgYCkN9erU41P6CukaI0d/1mjjJbfIU8/yzZ0Ab
 gi16yV65TC8RQ==
Date: Sun, 12 Sep 2021 00:29:11 +0800
From: Gao Xiang <xiang@kernel.org>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v1 5/5] dump.erofs: add -I options to dump the layout of
 a particular inode on disk
Message-ID: <20210911162909.GE3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-5-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911134635.1253426-5-guoxuenan@huawei.com>
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

On Sat, Sep 11, 2021 at 09:46:35PM +0800, Guo Xuenan wrote:
> From: mpiglet <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: mpiglet <mpiglet@outlook.com>
> ---
>  dump/main.c | 108 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 2389cef..efce309 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -21,8 +21,10 @@ struct dumpcfg {
>  	bool print_superblock;
>  	bool print_inode;
>  	bool print_statistic;
> +	bool print_inode_phy;
>  	bool print_version;
>  	u64 ino;
> +	u64 ino_phy;
>  };
>  static struct dumpcfg dumpcfg;
>  
> @@ -105,6 +107,7 @@ static void usage(void)
>  		"-s         print information about superblock\n"
>  		"-S         print statistic information of the erofs-image\n"
>  		"-i #       print target # inode info\n"
> +		"-I #       print target # inode on-disk info\n"
>  		"-v/-V      print dump.erofs version info\n"
>  		"-h/--help  display this help and exit\n", stderr);
>  }
> @@ -136,6 +139,11 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  			dumpcfg.print_inode = true;
>  			dumpcfg.ino = i;
>  			break;
> +		case 'I':
> +			i = atoll(optarg);
> +			dumpcfg.print_inode_phy = true;
> +			dumpcfg.ino_phy = i;
> +			break;
>  		case 'h':
>  		case 1:
>  		    usage();
> @@ -402,25 +410,25 @@ static void dumpfs_print_inode(void)
>  	fprintf(stderr, "Inode %lu info:\n", dumpcfg.ino);
>  	switch (inode.inode_isize) {
>  	case 32:
> -		fprintf(stderr, "	File inode is compacted layout\n");
> +		fprintf(stderr, "File inode is compacted layout\n");
>  		break;
>  	case 64:
> -		fprintf(stderr, "	File inode is extended layout\n");
> +		fprintf(stderr, "File inode is extended layout\n");
>  		break;
>  	default:
>  		erofs_err("unsupported inode layout\n");
>  	}
> -	fprintf(stderr, "	File size:		%lu\n",
> +	fprintf(stderr, "File size:		%lu\n",

How about folding these in the previous patch?

>  			inode.i_size);
> -	fprintf(stderr, "	File nid:		%lu\n",
> +	fprintf(stderr, "File nid:		%lu\n",
>  			inode.nid);
> -	fprintf(stderr, "	File extent size:	%u\n",
> +	fprintf(stderr, "File extent size:	%u\n",
>  			inode.extent_isize);
> -	fprintf(stderr, "	File xattr size:	%u\n",
> +	fprintf(stderr, "File xattr size:	%u\n",
>  			inode.xattr_isize);
> -	fprintf(stderr, "	File inode size:	%u\n",
> +	fprintf(stderr, "File inode size:	%u\n",
>  			inode.inode_isize);
> -	fprintf(stderr, "	File type:		");
> +	fprintf(stderr, "File type:		");
>  	switch (inode.i_mode & S_IFMT) {
>  	case S_IFREG:
>  		fprintf(stderr, "regular\n");
> @@ -453,13 +461,13 @@ static void dumpfs_print_inode(void)
>  		return;
>  	}
>  
> -	fprintf(stderr, "	File original size:	%lu\n"
> -			"	File on-disk size:	%lu\n",
> +	fprintf(stderr, "File original size:	%lu\n"
> +			"File on-disk size:	%lu\n",
>  			inode.i_size, size);
> -	fprintf(stderr, "	File compress rate:	%.2f%%\n",
> +	fprintf(stderr, "File compress rate:	%.2f%%\n",
>  			(double)(100 * size) / (double)(inode.i_size));
>  
> -	fprintf(stderr, "	File datalayout:	");
> +	fprintf(stderr, "File datalayout:	");
>  	switch (inode.datalayout) {
>  	case EROFS_INODE_FLAT_PLAIN:
>  		fprintf(stderr, "EROFS_INODE_FLAT_PLAIN\n");
> @@ -477,18 +485,82 @@ static void dumpfs_print_inode(void)
>  		break;
>  	}
>  
> -	fprintf(stderr, "	File create time:	%s", ctime(&t));
> -	fprintf(stderr, "	File uid:		%u\n", inode.i_uid);
> -	fprintf(stderr, "	File gid:		%u\n", inode.i_gid);
> -	fprintf(stderr, "	File hard-link count:	%u\n", inode.i_nlink);
> +	fprintf(stderr, "File create time:	%s", ctime(&t));
> +	fprintf(stderr, "File uid:		%u\n", inode.i_uid);
> +	fprintf(stderr, "File gid:		%u\n", inode.i_gid);
> +	fprintf(stderr, "File hard-link count:	%u\n", inode.i_nlink);
>  
>  	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
>  	if (!err)
> -		fprintf(stderr, "	File path:		%s\n", path);
> +		fprintf(stderr, "File path:		%s\n", path);
>  	else
>  		fprintf(stderr, "Path not found\n");
>  }
>  
> +static void dumpfs_print_inode_phy(void)
> +{
> +	int err;
> +	erofs_nid_t nid = dumpcfg.ino_phy;
> +	struct erofs_inode inode = {.nid = nid};
> +	char path[PATH_MAX + 1] = {0};
> +
> +	err = erofs_read_inode_from_disk(&inode);
> +	if (err < 0) {
> +		erofs_err("read inode %lu from disk failed", nid);
> +		return;
> +	}
> +
> +	const erofs_off_t ibase = iloc(inode.nid);
> +	const erofs_off_t pos = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(
> +			ibase + inode.inode_isize + inode.xattr_isize);
> +	erofs_blk_t blocks = inode.u.i_blocks;
> +	erofs_blk_t start = 0;
> +	erofs_blk_t end = 0;
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +		.m_la = 0,
> +	};
> +
> +	fprintf(stderr, "Inode %lu on-disk info:\n", nid);
> +	switch (inode.datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:
> +		if (inode.u.i_blkaddr == NULL_ADDR)
> +			start = end = erofs_blknr(pos);
> +		else {
> +			start = inode.u.i_blkaddr;
> +			end = start + BLK_ROUND_UP(inode.i_size) - 1;
> +		}
> +		fprintf(stderr, "File size:			%lu\n",
> +				inode.i_size);
> +		fprintf(stderr,
> +				"	Plain Block Address:		%u - %u\n",
> +				start, end);
> +		break;
> +
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		err = z_erofs_map_blocks_iter(&inode, &map);
> +		if (err)
> +			erofs_err("get file blocks range failed");
> +
> +		start = erofs_blknr(map.m_pa);
> +		end = start - 1 + blocks;
> +		fprintf(stderr,
> +				"	Compressed Block Address:	%u - %u\n",
> +				start, end);

How about porting/using fiemap code directly instead?

Thanks,
Gao Xiang

> +		break;
> +	}
> +
> +	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
> +	if (!err)
> +		fprintf(stderr, "File Path:			%s\n",
> +				path);
> +	else
> +		erofs_err("path not found");
> +}
> +
> +
>  static int get_file_type(const char *filename)
>  {
>  	char *postfix = strrchr(filename, '.');
> @@ -810,5 +882,7 @@ int main(int argc, char **argv)
>  	if (dumpcfg.print_inode)
>  		dumpfs_print_inode();
>  
> +	if (dumpcfg.print_inode_phy)
> +		dumpfs_print_inode_phy();
>  	return 0;
>  }
> -- 
> 2.25.4
> 
