Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5961940798D
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 18:25:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6J5222gdz2yNp
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Sep 2021 02:25:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o1+BwPkj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o1+BwPkj; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6J4z3lFdz2y1R
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Sep 2021 02:25:39 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA92860F58;
 Sat, 11 Sep 2021 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631377537;
 bh=8BbFhj+j54jFLqurInh1rUdFqSt6a3Yh83XikldW7B0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o1+BwPkjdexHEQwVSmT7haNTpDCuIYo2FtOykSgjMLGd69yhPQV+TVgfcZRlSexYr
 AHBsfiv1ERI5w8JEWa2frFzN/gBw/fNdmKtyt7kViI7S5keF6HNu/9Nwl5R024kLJ9
 hL9h9Ev5dtRFia5EtSFpGus6+hH0KQHY8uqymJO570HG6smRFnYeVt3Elys6kdoJ25
 vD1yS1inRKjtBPLkmsL9egr0nw3eItm+AZS8QY3mCY03v6NOiKPIdQ6EiepUGKYVQP
 dybAp8KyzcZPyJX/djjYEPSyqJz6BNDoo177M8vcfm0E56EWVWI4tFnKKf0ApCoaMH
 xwFMwQO98vmSg==
Date: Sun, 12 Sep 2021 00:25:25 +0800
From: Gao Xiang <xiang@kernel.org>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v1 4/5] dump.erofs: add -i options to dump file
 information of specific inode number
Message-ID: <20210911162523.GD3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-4-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911134635.1253426-4-guoxuenan@huawei.com>
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

On Sat, Sep 11, 2021 at 09:46:34PM +0800, Guo Xuenan wrote:
> From: mpiglet <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: mpiglet <mpiglet@outlook.com>
> ---
>  dump/main.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 200 insertions(+), 2 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index b0acc0b..2389cef 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -19,8 +19,10 @@
>  
>  struct dumpcfg {
>  	bool print_superblock;
> +	bool print_inode;
>  	bool print_statistic;
>  	bool print_version;
> +	u64 ino;
>  };
>  static struct dumpcfg dumpcfg;
>  
> @@ -100,8 +102,9 @@ static void usage(void)
>  {
>  	fputs("usage: [options] erofs-image \n\n"
>  		"Dump erofs layout from erofs-image, and [options] are:\n"
> -		"-s          print information about superblock\n"
> -		"-S      print statistic information of the erofs-image\n"
> +		"-s         print information about superblock\n"
> +		"-S         print statistic information of the erofs-image\n"
> +		"-i #       print target # inode info\n"
>  		"-v/-V      print dump.erofs version info\n"
>  		"-h/--help  display this help and exit\n", stderr);
>  }
> @@ -113,6 +116,7 @@ static void dumpfs_print_version(void)
>  static int dumpfs_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
> +	u64 i;
>  
>  	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",
>  					long_options, NULL)) != -1) {
> @@ -127,6 +131,11 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  		case 'V':
>  			dumpfs_print_version();
>  			exit(0);
> +		case 'i':
> +			i = atoll(optarg);
> +			dumpcfg.print_inode = true;
> +			dumpcfg.ino = i;
> +			break;
>  		case 'h':
>  		case 1:
>  		    usage();
> @@ -293,6 +302,193 @@ static void dumpfs_print_superblock(void)
>  
>  }
>  
> +static int get_path_by_nid(erofs_nid_t nid, erofs_nid_t parent_nid,
> +		erofs_nid_t target, char *path, unsigned int pos)

Can we refactor it as a transversal function (together with a function
in the previous patch)? Also, how to resolve hard links?

> +{
> +	int err;
> +	struct erofs_inode inode = {.nid = nid};
> +	erofs_off_t offset;
> +	char buf[EROFS_BLKSIZ];
> +
> +	path[pos++] = '/';
> +	if (target == sbi.root_nid)
> +		return 0;
> +
> +	err = erofs_read_inode_from_disk(&inode);
> +	if (err) {
> +		erofs_err("read inode %lu failed", nid);
> +		return err;
> +	}
> +
> +	offset = 0;
> +	while (offset < inode.i_size) {
> +		erofs_off_t maxsize = min_t(erofs_off_t,
> +					inode.i_size - offset, EROFS_BLKSIZ);
> +		struct erofs_dirent *de = (void *)buf;
> +		struct erofs_dirent *end;
> +		unsigned int nameoff;
> +
> +		err = erofs_pread(&inode, buf, maxsize, offset);
> +		if (err)
> +			return err;
> +
> +		nameoff = le16_to_cpu(de->nameoff);
> +		if (nameoff < sizeof(struct erofs_dirent) ||
> +		    nameoff >= PAGE_SIZE) {
> +			erofs_err("invalid de[0].nameoff %u @ nid %llu",
> +				  nameoff, nid | 0ULL);
> +			return -EFSCORRUPTED;
> +		}
> +
> +		end = (void *)buf + nameoff;
> +		while (de < end) {
> +			const char *dname;
> +			unsigned int dname_len;
> +
> +			nameoff = le16_to_cpu(de->nameoff);
> +			dname = (char *)buf + nameoff;
> +			if (de + 1 >= end)
> +				dname_len = strnlen(dname, maxsize - nameoff);
> +			else
> +				dname_len = le16_to_cpu(de[1].nameoff)
> +					- nameoff;
> +
> +			/* a corrupted entry is found */
> +			if (nameoff + dname_len > maxsize ||
> +			    dname_len > EROFS_NAME_LEN) {
> +				erofs_err("bogus dirent @ nid %llu",
> +						le64_to_cpu(de->nid) | 0ULL);
> +				DBG_BUGON(1);
> +				return -EFSCORRUPTED;
> +			}
> +
> +			if (de->nid == target) {
> +				memcpy(path + pos, dname, dname_len);
> +				return 0;
> +			}
> +
> +			if (de->file_type == EROFS_FT_DIR &&
> +					de->nid != parent_nid &&
> +					de->nid != nid) {
> +				memcpy(path + pos, dname, dname_len);
> +				err = get_path_by_nid(de->nid, nid,
> +						target, path, pos + dname_len);
> +				if (!err)
> +					return 0;
> +				memset(path + pos, 0, dname_len);
> +			}
> +			++de;
> +		}
> +		offset += maxsize;
> +	}
> +	return -1;
> +}
> +
> +static void dumpfs_print_inode(void)
> +{
> +	int err;
> +	erofs_off_t size;
> +	erofs_nid_t nid = dumpcfg.ino;
> +	struct erofs_inode inode = {.nid = nid};
> +	char path[PATH_MAX + 1] = {0};
> +	time_t t = inode.i_ctime;
> +
> +	err = erofs_read_inode_from_disk(&inode);
> +	if (err) {
> +		erofs_err("read inode %lu from disk failed", nid);
> +		return;
> +	}
> +
> +	fprintf(stderr, "Inode %lu info:\n", dumpcfg.ino);
> +	switch (inode.inode_isize) {
> +	case 32:
> +		fprintf(stderr, "	File inode is compacted layout\n");

It's enough to print "Inode core size: 32/64."

> +		break;
> +	case 64:
> +		fprintf(stderr, "	File inode is extended layout\n");
> +		break;
> +	default:
> +		erofs_err("unsupported inode layout\n");
> +	}
> +	fprintf(stderr, "	File size:		%lu\n",
> +			inode.i_size);
> +	fprintf(stderr, "	File nid:		%lu\n",
> +			inode.nid);
> +	fprintf(stderr, "	File extent size:	%u\n",
> +			inode.extent_isize);
> +	fprintf(stderr, "	File xattr size:	%u\n",
> +			inode.xattr_isize);
> +	fprintf(stderr, "	File inode size:	%u\n",
> +			inode.inode_isize);
> +	fprintf(stderr, "	File type:		");
> +	switch (inode.i_mode & S_IFMT) {
> +	case S_IFREG:
> +		fprintf(stderr, "regular\n");
> +		break;
> +	case S_IFDIR:
> +		fprintf(stderr, "directory\n");
> +		break;
> +	case S_IFLNK:
> +		fprintf(stderr, "link\n");
> +		break;
> +	case S_IFCHR:
> +		fprintf(stderr, "character device\n");
> +		break;
> +	case S_IFBLK:
> +		fprintf(stderr, "block device\n");
> +		break;
> +	case S_IFIFO:
> +		fprintf(stderr, "fifo\n");
> +		break;
> +	case S_IFSOCK:
> +		fprintf(stderr, "sock\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	err = get_file_compressed_size(&inode, &size);
> +	if (err) {
> +		erofs_err("get file size failed\n");
> +		return;
> +	}
> +
> +	fprintf(stderr, "	File original size:	%lu\n"
> +			"	File on-disk size:	%lu\n",
> +			inode.i_size, size);
> +	fprintf(stderr, "	File compress rate:	%.2f%%\n",
> +			(double)(100 * size) / (double)(inode.i_size));

I think we could use "compressed blocks" instead...

> +
> +	fprintf(stderr, "	File datalayout:	");
> +	switch (inode.datalayout) {
> +	case EROFS_INODE_FLAT_PLAIN:
> +		fprintf(stderr, "EROFS_INODE_FLAT_PLAIN\n");
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +		fprintf(stderr, "EROFS_INODE_FLAT_COMPRESSION_LEGACY\n");
> +		break;
> +	case EROFS_INODE_FLAT_INLINE:
> +		fprintf(stderr, "EROFS_INODE_FLAT_INLINE\n");
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		fprintf(stderr, "EROFS_INODE_FLAT_COMPRESSION\n");
> +		break;

Just using a number is fine, since there could be some new types in the
future (also I'd like to rename EROFS_INODE_FLAT_COMPRESSION_LEGACY later.)


> +	default:
> +		break;
> +	}
> +
> +	fprintf(stderr, "	File create time:	%s", ctime(&t));
> +	fprintf(stderr, "	File uid:		%u\n", inode.i_uid);
> +	fprintf(stderr, "	File gid:		%u\n", inode.i_gid);

Lack of Access mode.

> +	fprintf(stderr, "	File hard-link count:	%u\n", inode.i_nlink);

Anyway...How about just using "stat" likewise style and add more fields?

  File: erofs.rst
  Size: 14035     	Blocks: 32         IO Block: 4096   regular file
Device: 10303h/66307d	Inode: 7120988     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/hsiangkao)   Gid: ( 1000/hsiangkao)
Access: 2021-09-11 00:42:02.748083341 +0800
Modify: 2021-09-03 02:54:32.188031546 +0800
Change: 2021-09-03 02:54:32.188031546 +0800
 Birth: -

Thanks,
Gao Xiang

> +
> +	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
> +	if (!err)
> +		fprintf(stderr, "	File path:		%s\n", path);
> +	else
> +		fprintf(stderr, "Path not found\n");
> +}
> +
>  static int get_file_type(const char *filename)
>  {
>  	char *postfix = strrchr(filename, '.');
> @@ -611,6 +807,8 @@ int main(int argc, char **argv)
>  	if (dumpcfg.print_statistic)
>  		dumpfs_print_statistic();
>  
> +	if (dumpcfg.print_inode)
> +		dumpfs_print_inode();
>  
>  	return 0;
>  }
> -- 
> 2.25.4
> 
