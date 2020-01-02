Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A876C12E50C
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 11:47:54 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pPrS1jQ8zDqB5
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 21:47:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pPrL3y1bzDq8F
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 21:47:42 +1100 (AEDT)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 66B505586F5446CA1643
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 18:47:31 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 18:47:30 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 2 Jan 2020 18:47:30 +0800
Date: Thu, 2 Jan 2020 18:47:04 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>, Chao Yu <yuchao0@huawei.com>,
 Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [RFCv3] erofs-utils: on-disk extent format for blocks
Message-ID: <20200102104704.GB189482@architecture4>
References: <20200102094732.31567-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200102094732.31567-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
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
Cc: xiaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Thu, Jan 02, 2020 at 03:17:32PM +0530, Pratik Shinde wrote:
> 1)Moved on-disk structures to erofs_fs.h
> 2)Some naming changes.
> 
> I think we can keep 'IS_HOLE()' macro, otherwise the code
> does not look clean(if used directly/without macro).Its getting
> used only in inode.c so it can be kept there.
> what do you think ?

What I'm little concerned is the relationship between
the name of IS_HOLE and its implementation...

In other words, why
 roundup(start, EROFS_BLKSIZ) == start &&
 roundup(end, EROFS_BLKSIZ) == end &&
 (end - start) % EROFS_BLKSIZ == 0
should be an erofs hole...

But that is minor, I reserve my opinion on this for now...

This patch generally looks good to me, yet I haven't
played with it till now.

Could you implement a workable RFC patch for kernel side
as well? Since I'm still busying in XZ library and other
convert patches for 5.6...

I'd like to hear if some other opinions from Chao and Guifu.
Since it enhances the on-disk format, we need to think it
over (especially its future expandability).


To Chao and Guifu,
Could you have some extra time looking at this stuff as well?


Thanks,
Gao Xiang

> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/internal.h |   9 ++-
>  include/erofs_fs.h       |  11 ++++
>  lib/inode.c              | 153 ++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 150 insertions(+), 23 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index e13adda..2d7466b 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -63,7 +63,7 @@ struct erofs_sb_info {
>  extern struct erofs_sb_info sbi;
>  
>  struct erofs_inode {
> -	struct list_head i_hash, i_subdirs, i_xattrs;
> +	struct list_head i_hash, i_subdirs, i_xattrs, i_sparse_extents;
>  
>  	unsigned int i_count;
>  	struct erofs_inode *i_parent;
> @@ -93,6 +93,7 @@ struct erofs_inode {
>  
>  	unsigned int xattr_isize;
>  	unsigned int extent_isize;
> +	unsigned int sparse_extent_isize;
>  
>  	erofs_nid_t nid;
>  	struct erofs_buffer_head *bh;
> @@ -139,5 +140,11 @@ static inline const char *erofs_strerror(int err)
>  	return msg;
>  }
>  
> +struct erofs_sparse_extent_node {
> +	struct list_head next;
> +	erofs_blk_t lblk;
> +	erofs_blk_t pblk;
> +	u32 len;
> +};
>  #endif
>  
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index bcc4f0c..a63e1c6 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -321,5 +321,16 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>  		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
>  }
>  
> +/* on-disk sparse extent format */
> +struct erofs_sparse_extent {
> +	__le32 ee_lblk;
> +	__le32 ee_pblk;
> +	__le32 ee_len;
> +};
> +
> +struct erofs_sparse_extent_iheader {
> +	u32 count;
> +};
> +
>  #endif
>  
> diff --git a/lib/inode.c b/lib/inode.c
> index 0e19b11..da20599 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -38,6 +38,97 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
>  
>  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
>  
> +
> +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
> +		             roundup(end, EROFS_BLKSIZ) == end &&	\
> +			    (end - start) % EROFS_BLKSIZ == 0)
> +
> +/**
> +   read extents of the given file.
> +   record the data extents and link them into a chain.
> +   exclude holes present in file.
> + */
> +unsigned int erofs_read_sparse_extents(int fd, struct list_head *extents)
> +{
> +	erofs_blk_t startblk, endblk, datablk;
> +	unsigned int nholes = 0;
> +	erofs_off_t data, hole, len = 0, last_data;
> +	struct erofs_sparse_extent_node *e_data;
> +
> +	len = lseek(fd, 0, SEEK_END);
> +	if (len < 0)
> +		return -errno;
> +	if (lseek(fd, 0, SEEK_SET) == -1)
> +		return -errno;
> +	data = 0;
> +	last_data = 0;
> +	while (data < len) {
> +		hole = lseek(fd, data, SEEK_HOLE);
> +		if (hole == len)
> +			break;
> +		data = lseek(fd, hole, SEEK_DATA);
> +		if (data < 0 || hole > data)
> +			return -EINVAL;
> +		if (IS_HOLE(hole, data)) {
> +			startblk = erofs_blknr(hole);
> +			datablk = erofs_blknr(last_data);
> +			endblk = erofs_blknr(data);
> +			last_data = data;
> +			e_data = malloc(sizeof(
> +					 struct erofs_sparse_extent_node));
> +			if (e_data == NULL)
> +				return -ENOMEM;
> +			e_data->lblk = datablk;
> +			e_data->len = (startblk - datablk);
> +			list_add_tail(&e_data->next, extents);
> +			nholes += (endblk - startblk);
> +		}
> +	}
> +	/* rounddown to exclude tail-end data */
> +	if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> +		e_data = malloc(sizeof(struct erofs_sparse_extent_node));
> +		if (e_data == NULL)
> +			return -ENOMEM;
> +		startblk = erofs_blknr(last_data);
> +		e_data->lblk = startblk;
> +		e_data->len = erofs_blknr(rounddown((len - last_data),
> +					  EROFS_BLKSIZ));
> +		list_add_tail(&e_data->next, extents);
> +	}
> +	return nholes;
> +}
> +
> +int erofs_write_sparse_extents(struct erofs_inode *inode, erofs_off_t off)
> +{
> +	struct erofs_sparse_extent_node *e_node;
> +	struct erofs_sparse_extent_iheader *header;
> +	char *buf;
> +	unsigned int p = 0;
> +	int ret;
> +
> +	buf = malloc(inode->sparse_extent_isize);
> +	if (buf == NULL)
> +		return -ENOMEM;
> +	header = (struct erofs_sparse_extent_iheader *) buf;
> +	header->count = 0;
> +	p += sizeof(struct erofs_sparse_extent_iheader);
> +	list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> +		const struct erofs_sparse_extent ee = {
> +			.ee_lblk = cpu_to_le32(e_node->lblk),
> +			.ee_pblk = cpu_to_le32(e_node->pblk),
> +			.ee_len  = cpu_to_le32(e_node->len)
> +		};
> +		memcpy(buf + p, &ee, sizeof(struct erofs_sparse_extent));
> +		p += sizeof(struct erofs_sparse_extent);
> +		header->count++;
> +		list_del(&e_node->next);
> +		free(e_node);
> +	}
> +	ret = dev_write(buf, off, inode->sparse_extent_isize);
> +	free(buf);
> +	return ret;
> +}
> +
>  void erofs_inode_manager_init(void)
>  {
>  	unsigned int i;
> @@ -304,8 +395,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
>  
>  int erofs_write_file(struct erofs_inode *inode)
>  {
> -	unsigned int nblocks, i;
> +	unsigned int nblocks, i, j, nholes;
>  	int ret, fd;
> +	struct erofs_sparse_extent_node *e_node;
>  
>  	if (!inode->i_size) {
>  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> @@ -322,31 +414,42 @@ int erofs_write_file(struct erofs_inode *inode)
>  	/* fallback to all data uncompressed */
>  	inode->datalayout = EROFS_INODE_FLAT_INLINE;
>  	nblocks = inode->i_size / EROFS_BLKSIZ;
> -
> -	ret = __allocate_inode_bh_data(inode, nblocks);
> -	if (ret)
> -		return ret;
> -
>  	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
>  	if (fd < 0)
>  		return -errno;
> -
> -	for (i = 0; i < nblocks; ++i) {
> -		char buf[EROFS_BLKSIZ];
> -
> -		ret = read(fd, buf, EROFS_BLKSIZ);
> -		if (ret != EROFS_BLKSIZ) {
> -			if (ret < 0)
> +	nholes = erofs_read_sparse_extents(fd, &inode->i_sparse_extents);
> +	if (nholes < 0) {
> +		close(fd);
> +		return nholes;
> +	}
> +	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> +	if (ret) {
> +		close(fd);
> +		return ret;
> +	}
> +	i = inode->u.i_blkaddr;
> +	inode->sparse_extent_isize = sizeof(struct erofs_sparse_extent_iheader);
> +	list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> +		inode->sparse_extent_isize += sizeof(struct erofs_sparse_extent);
> +		e_node->pblk = i;
> +		ret = lseek(fd, blknr_to_addr(e_node->lblk), SEEK_SET);
> +		if (ret < 0)
> +			goto fail;
> +		for (j = 0; j < e_node->len; j++) {
> +			char buf[EROFS_BLKSIZ];
> +			ret = read(fd, buf, EROFS_BLKSIZ);
> +			if (ret != EROFS_BLKSIZ) {
> +				if (ret < 0)
> +					goto fail;
> +				close(fd);
> +				return -EAGAIN;
> +			}
> +			ret = blk_write(buf, e_node->pblk + j, 1);
> +			if (ret)
>  				goto fail;
> -			close(fd);
> -			return -EAGAIN;
>  		}
> -
> -		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> -		if (ret)
> -			goto fail;
> +		i += e_node->len;
>  	}
> -
>  	/* read the tail-end data */
>  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
>  	if (inode->idata_size) {
> @@ -479,8 +582,14 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		if (ret)
>  			return false;
>  		free(inode->compressmeta);
> +		off += inode->extent_isize;
>  	}
>  
> +	if (inode->sparse_extent_isize) {
> +		ret = erofs_write_sparse_extents(inode, off);
> +		if (ret)
> +			return false;
> +	}
>  	inode->bh = NULL;
>  	erofs_iput(inode);
>  	return erofs_bh_flush_generic_end(bh);
> @@ -737,10 +846,11 @@ struct erofs_inode *erofs_new_inode(void)
>  
>  	init_list_head(&inode->i_subdirs);
>  	init_list_head(&inode->i_xattrs);
> +	init_list_head(&inode->i_sparse_extents);
>  
>  	inode->idata_size = 0;
>  	inode->xattr_isize = 0;
> -	inode->extent_isize = 0;
> +	inode->sparse_extent_isize = 0;
>  
>  	inode->bh = inode->bh_inline = inode->bh_data = NULL;
>  	inode->idata = NULL;
> @@ -961,4 +1071,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
>  
>  	return erofs_mkfs_build_tree(inode);
>  }
> -
> -- 
> 2.9.3
> 
