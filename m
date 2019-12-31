Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E612D6FA
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Dec 2019 09:12:48 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47n6VP2nK5zDq9Z
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Dec 2019 19:12:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47n6V73nmBzDq9D
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Dec 2019 19:12:27 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 6C3F583D3810948AFF00
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Dec 2019 16:12:20 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 16:12:20 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 31 Dec 2019 16:12:19 +0800
Date: Tue, 31 Dec 2019 16:11:55 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFCv2] erofs-utils: on-disk extent format for blocks.
Message-ID: <20191231081155.GA122132@architecture4>
References: <20191230104805.27139-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191230104805.27139-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
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

On Mon, Dec 30, 2019 at 04:18:05PM +0530, Pratik Shinde wrote:
> Tracking only the data-extents + some minor naming changes.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/internal.h |  20 ++++++-
>  lib/inode.c              | 151 ++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 150 insertions(+), 21 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index e13adda..5a29a67 100644
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
> @@ -139,5 +140,22 @@ static inline const char *erofs_strerror(int err)
>  	return msg;
>  }
>  
> +/* on disk extent format */

On disk extent format is not useful...

> +struct erofs_extent {

Maybe add _sparse_ in order to distinguish from compress extents...

struct erofs_sparse_extent

> +	__le32 ee_lblk;
> +	__le32 ee_pblk;
> +	__le32 ee_len;
> +};

How about moving all on-disk format to erofs_fs.h?

> +
> +struct erofs_extent_node {

struct erofs_sparse_extent_node {

> +	struct list_head next;
> +	erofs_blk_t lblk;
> +	erofs_blk_t pblk;
> +	u32 len;
> +};
> +
> +struct erofs_inline_extent_header {

struct erofs_sparse_extent_iheader {

> +	u32 count;
> +};
>  #endif
>  
> diff --git a/lib/inode.c b/lib/inode.c
> index 0e19b11..01ac54f 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -38,6 +38,98 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
>  
>  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
>  
> +
> +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
> +		             roundup(end, EROFS_BLKSIZ) == end &&	\
> +			    (end - start) % EROFS_BLKSIZ == 0)

It is used only once, how about getting rid of this macro
helper and add some comments above it?

> +
> +/* returns the number of holes present in the file */
> +unsigned int erofs_read_extents(struct erofs_inode *inode,
> +				struct list_head *extents)

erofs_sparse_read_extents()?

> +{
> +	int fd, st, dt, en;

maybe it'd better have some meaningful names...

> +	unsigned int nholes = 0;
> +	erofs_off_t data, hole, len = 0, last_data;
> +	struct erofs_extent_node *e_data;
> +
> +	fd = open(inode->i_srcpath, O_RDONLY);

It is more preferred to reuse the previous fd?

> +	if (fd < 0)
> +		return -errno;
> +	len = lseek(fd, 0, SEEK_END);
> +	if (len < 0)
> +		goto fail;
> +	if (lseek(fd, 0, SEEK_SET) == -1)
> +		goto fail;
> +	data = 0;
> +	last_data = 0;
> +	while (data < len) {
> +		hole = lseek(fd, data, SEEK_HOLE);
> +		if (hole == len)
> +			break;
> +		data = lseek(fd, hole, SEEK_DATA);
> +		if (data < 0 || hole > data) {
> +			close(fd);
> +			return -EINVAL;
> +		}
> +		if (IS_HOLE(hole, data)) {
> +			st = erofs_blknr(hole);
> +			dt = erofs_blknr(last_data);
> +			en = erofs_blknr(data);
> +			last_data = data;
> +			e_data = malloc(sizeof(struct erofs_extent_node));
> +			if (e_data == NULL)
> +				goto fail;
> +			e_data->lblk = dt;
> +			e_data->len = (st - dt);
> +			list_add_tail(&e_data->next, extents);
> +			nholes += (en - st);
> +		}
> +	}
> +	/* rounddown to exclude tail-end data */
> +	if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> +		e_data = malloc(sizeof(struct erofs_extent_node));
> +		if (e_data == NULL)
> +			goto fail;
> +		st = erofs_blknr(last_data);
> +		e_data->lblk = st;
> +		e_data->len = erofs_blknr(rounddown((len - last_data),
> +					  EROFS_BLKSIZ));
> +		list_add_tail(&e_data->next, extents);
> +	}
> +	return nholes;
> +
> +fail:	close(fd);

Leave the label in a single line...
And if we reuse fd, we could omit close(fd) as well..

> +	return -errno;
> +}
> +
> +char *erofs_create_extent_buffer(struct list_head *extents, unsigned int size)

How about
int erofs_sparse_write_extents(struct erofs_inode *inode, erofs_off_t off)
{
	...

	ret = blk_write(buf, off, inode->sparse_extent_isize);
	...
	free(buf);
	return ret;
}


> +{
> +	struct erofs_extent_node *e_node;
> +	struct erofs_inline_extent_header *header;
> +	char *buf;
> +	unsigned int p = 0;
> +
> +	buf = malloc(size);
> +	if (buf == NULL)
> +		return ERR_PTR(-ENOMEM);
> +	header = (struct erofs_inline_extent_header *) buf;
> +	header->count = 0;
> +	p += sizeof(struct erofs_inline_extent_header);
> +	list_for_each_entry(e_node, extents, next) {
> +		const struct erofs_extent ee = {
> +			.ee_lblk = cpu_to_le32(e_node->lblk),
> +			.ee_pblk = cpu_to_le32(e_node->pblk),
> +			.ee_len  = cpu_to_le32(e_node->len)
> +		};
> +		memcpy(buf + p, &ee, sizeof(struct erofs_extent));
> +		p += sizeof(struct erofs_extent);
> +		header->count++;
> +		list_del(&e_node->next);
> +		free(e_node);
> +	}
> +	return buf;
> +}
> +
>  void erofs_inode_manager_init(void)
>  {
>  	unsigned int i;
> @@ -304,8 +396,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
>  
>  int erofs_write_file(struct erofs_inode *inode)
>  {
> -	unsigned int nblocks, i;
> +	unsigned int nblocks, i, j, nholes;
>  	int ret, fd;
> +	struct erofs_extent_node *e_node;
>  
>  	if (!inode->i_size) {
>  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> @@ -322,31 +415,38 @@ int erofs_write_file(struct erofs_inode *inode)
>  	/* fallback to all data uncompressed */
>  	inode->datalayout = EROFS_INODE_FLAT_INLINE;
>  	nblocks = inode->i_size / EROFS_BLKSIZ;
> -
> -	ret = __allocate_inode_bh_data(inode, nblocks);
> +	nholes = erofs_read_extents(inode, &inode->i_sparse_extents);
> +	if (nholes < 0)
> +		return nholes;
> +	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
>  	if (ret)
>  		return ret;
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
> +	i = inode->u.i_blkaddr;
> +	inode->sparse_extent_isize = sizeof(struct erofs_inline_extent_header);
> +	list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> +		inode->sparse_extent_isize += sizeof(struct erofs_extent);
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
> @@ -479,8 +579,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		if (ret)
>  			return false;
>  		free(inode->compressmeta);
> +		off += inode->extent_isize;
>  	}
>  
> +	if (inode->sparse_extent_isize) {
> +		char *extents = erofs_create_extent_buffer(&inode->i_sparse_extents,
> +						   inode->sparse_extent_isize);
> +		if (IS_ERR(extents))
> +			return false;
> +		ret = dev_write(extents, off, inode->sparse_extent_isize);
> +		if (ret)
> +			return false;
> +		free(extents);

		ret = erofs_sparse_write_extents(inode, off);
		if (ret)
			return false;

Thanks,
Gao Xiang

> +	}
>  	inode->bh = NULL;
>  	erofs_iput(inode);
>  	return erofs_bh_flush_generic_end(bh);
> @@ -737,10 +848,11 @@ struct erofs_inode *erofs_new_inode(void)
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
> @@ -961,4 +1073,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
>  
>  	return erofs_mkfs_build_tree(inode);
>  }
> -
> -- 
> 2.9.3
> 
