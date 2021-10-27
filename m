Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344143C9AE
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 14:29:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfSg12Sqpz2yPW
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 23:29:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfSfx3rz9z2y7V
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 23:29:12 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UtuF090_1635337744; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtuF090_1635337744) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 20:29:05 +0800
Date: Wed, 27 Oct 2021 20:29:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH 3/3] erofs-utils: dump: add -e option to dump the inode
 extent info
Message-ID: <YXlGEC8fzYnGOJf+@B-P7TQMD6M-0146.local>
References: <20211027120351.2885966-1-guoxuenan@huawei.com>
 <20211027120351.2885966-3-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027120351.2885966-3-guoxuenan@huawei.com>
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

Hi Xuenan,

On Wed, Oct 27, 2021 at 08:03:51PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>

Please help resend the FIEMAP report patch as well. So I could use b4
tool to merge the whole patchset....

> ---
>  dump/main.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 8a31345..e4018a7 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -18,9 +18,11 @@
>  struct erofsdump_cfg {
>  	unsigned int totalshow;
>  	bool show_inode;
> +	bool show_inode_phy;
>  	bool show_superblock;
>  	bool show_statistics;
>  	u64 ino;
> +	u64 ino_phy;
>  };
>  static struct erofsdump_cfg dumpcfg;
>  
> @@ -94,6 +96,7 @@ static void usage(void)
>  	      "Dump erofs layout from IMAGE, and [options] are:\n"
>  	      " -S      show statistic information of the image\n"
>  	      " -V      print the version number of dump.erofs and exit.\n"
> +	      " -e #    show the inode extent info of nid #\n"
>  	      " -i #    show the target inode info of nid #\n"
>  	      " -s      show information about superblock\n"
>  	      " --help  display this help and exit.\n",
> @@ -110,9 +113,14 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  	int opt;
>  	u64 i;
>  
> -	while ((opt = getopt_long(argc, argv, "SVi:s",
> +	while ((opt = getopt_long(argc, argv, "SVi:e:s",
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
> +		case 'e':
> +			dumpcfg.show_inode_phy = true;
> +			dumpcfg.ino_phy = atoll(optarg);
> +			++dumpcfg.totalshow;
> +			break;
>  		case 'i':
>  			i = atoll(optarg);
>  			dumpcfg.show_inode = true;
> @@ -408,6 +416,79 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
>  	return -1;
>  }
>  
> +static void erofsdump_show_inode_phy(void)
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
> +	unsigned int extent_count;
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +		.m_la = 0,
> +	};

let's avoid variable definitions here (please help define them at the
beginning of this function instead.)

> +
> +	fprintf(stdout, "Inode: %lu\n", nid);
> +	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid, nid, path, 0);
> +	if (err) {
> +		erofs_err("Path not found\n");
> +		return;
> +	}
> +	fprintf(stdout, "File path: %s\n", path);
> +	fprintf(stdout, "File size: %lu\n", inode.i_size);
> +
> +	switch (inode.datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:

we need to implement EROFS_INODE_CHUNK_BASED:

> +		if (inode.u.i_blkaddr == NULL_ADDR)
> +			start = end = erofs_blknr(pos);
> +		else {
> +			start = inode.u.i_blkaddr;
> +			end = start + BLK_ROUND_UP(inode.i_size) - 1;
> +		}
> +		fprintf(stdout, "Plain blknr: %u - %u\n", start, end);
> +		break;
> +
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:

Actually I guess these can be merged into one helper erofs_map_block()
instead.

Thanks,
Gao Xiang

> +		err = z_erofs_map_blocks_iter(&inode, &map, 0);
> +		if (err)
> +			erofs_err("get file blocks range failed");
> +
> +		start = erofs_blknr(map.m_pa);
> +		end = start - 1 + blocks;
> +		fprintf(stdout,
> +				"Compressed blknr: %u - %u\n", start, end);
> +		extent_count = 0;
> +		map.m_la = 0;
> +		fprintf(stdout, "Ext:  logical_offset/length:  physical_offset/length\n");
> +		while (map.m_la < inode.i_size) {
> +			err = z_erofs_map_blocks_iter(&inode, &map,
> +					EROFS_GET_BLOCKS_FIEMAP);
> +			fprintf(stdout, "%u: ", extent_count++);
> +			fprintf(stdout, "%6lu..%-6lu / %-lu: ",
> +					map.m_la, map.m_la + map.m_llen, map.m_llen);
> +			fprintf(stdout, "%lu..%lu / %-lu\n",
> +					map.m_pa, map.m_pa + map.m_plen, map.m_plen);
> +			map.m_la += map.m_llen;
> +		}
> +		break;
> +	}
> +}
> +
>  static void dumpfs_print_inode(void)
>  {
>  	int err;
> @@ -645,6 +726,9 @@ int main(int argc, char **argv)
>  	if (dumpcfg.show_inode)
>  		dumpfs_print_inode();
>  
> +	if (dumpcfg.show_inode_phy)
> +		erofsdump_show_inode_phy();
> +
>  exit:
>  	erofs_exit_configure();
>  	return err;
> -- 
> 2.31.1
