Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 90362129D25
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 04:49:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hhzF758kzDqNP
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 14:48:57 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hhz66096zDqNC
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 14:48:45 +1100 (AEDT)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id CDDADCB461C64498E2B8
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 11:48:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Dec 2019 11:48:36 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 24 Dec 2019 11:48:35 +0800
Date: Tue, 24 Dec 2019 11:48:20 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
Message-ID: <20191224034817.GA164058@architecture4>
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191223172938.13189-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
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

Thanks for keeping the work. :)
Some inlined comments below as before.

On Mon, Dec 23, 2019 at 10:59:38PM +0530, Pratik Shinde wrote:
> Made some changes based on comments on previous patch :
> 1) defined an on disk structure for representing hole.
> 2) Maintain a list of this structure (per file) and dump this list to
>    disk at the time of writing the inode to disk.
> ---
>  include/erofs/internal.h |   8 +++-
>  lib/inode.c              | 108 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 110 insertions(+), 6 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index e13adda..863ef8a 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -63,7 +63,7 @@ struct erofs_sb_info {
>  extern struct erofs_sb_info sbi;
>  
>  struct erofs_inode {
> -	struct list_head i_hash, i_subdirs, i_xattrs;
> +	struct list_head i_hash, i_subdirs, i_xattrs, i_holes;
>  
>  	unsigned int i_count;
>  	struct erofs_inode *i_parent;
> @@ -93,6 +93,7 @@ struct erofs_inode {
>  
>  	unsigned int xattr_isize;
>  	unsigned int extent_isize;
> +	unsigned int holes_isize;
>  
>  	erofs_nid_t nid;
>  	struct erofs_buffer_head *bh;
> @@ -139,5 +140,10 @@ static inline const char *erofs_strerror(int err)
>  	return msg;
>  }
>  
> +struct erofs_hole {
> +	erofs_blk_t st;
> +	u32 len;
> +	struct list_head next;
> +};


How about recording all extents rather than holes? since it's more useful
for later random read access.

struct erofs_extent_node {
	struct list_head next;

	erofs_blk_t lblk;	/* logical start address */
	erofs_blk_t pblk;	/* physical start address */
	u32 len;		/* extent length in blocks */
};


>  #endif
>  
> diff --git a/lib/inode.c b/lib/inode.c
> index 0e19b11..20bbf06 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -38,6 +38,85 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
>  
>  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
>  
> +
> +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
> +		             roundup(end, EROFS_BLKSIZ) == end &&	\
> +			    (end - start) % EROFS_BLKSIZ == 0)
> +#define HOLE_BLK		-1
> +unsigned int erofs_detect_holes(struct erofs_inode *inode,
> +				struct list_head *holes, unsigned int *htimes)
> +{
> +	int fd, st, en;
> +	unsigned int nholes = 0;
> +	erofs_off_t data, hole, len;
> +	struct erofs_hole *eh;
> +
> +	fd = open(inode->i_srcpath, O_RDONLY);
> +	if (fd < 0) {
> +		return -errno;
> +	}
> +	len = lseek(fd, 0, SEEK_END);
> +	if (lseek(fd, 0, SEEK_SET) == -1)
> +		return -errno;
> +	data = 0;
> +	while (data < len) {
> +		hole = lseek(fd, data, SEEK_HOLE);
> +		if (hole == len)
> +			break;
> +		data = lseek(fd, hole, SEEK_DATA);
> +		if (data < 0 || hole > data) {
> +			return -EINVAL;
> +		}
> +		if (IS_HOLE(hole, data)) {
> +			st = hole >> S_SHIFT;
> +			en = data >> S_SHIFT;
> +			eh = malloc(sizeof(struct erofs_hole));
> +			if (eh == NULL)
> +				return -ENOMEM;
> +			eh->st = st;
> +			eh->len = (en - st);
> +			list_add_tail(&eh->next, holes);
> +			nholes += eh->len;
> +			*htimes += 1;
> +		}
> +	}
> +	return nholes;
> +}
> +
> +bool erofs_ishole(erofs_blk_t blk, struct list_head holes)
> +{
> +	if (list_empty(&holes))
> +		return false;
> +	struct erofs_hole *eh;
> +	list_for_each_entry(eh, &holes, next) {
> +		if (eh->st > blk)
> +			return false;
> +		if (eh->st <= blk && (eh->st + eh->len - 1) >= blk)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +char *erofs_create_holes_buffer(struct list_head *holes, unsigned int size)
> +{
> +	struct erofs_hole *eh;
> +	char *buf;
> +	unsigned int p = 0;
> +
> +	buf = malloc(size);
> +	if (buf == NULL)
> +		return ERR_PTR(-ENOMEM);
> +	list_for_each_entry(eh, holes, next) {
> +		*(__le32 *)(buf + p) = cpu_to_le32(eh->st);
> +		p += sizeof(__le32);
> +		*(__le32 *)(buf + p) = cpu_to_le32(eh->len);
> +		p += sizeof(__le32);
> +		list_del(&eh->next);
> +		free(eh);
> +	}

How about introducing some extent header

/* 12-byte alignment */
struct erofs_inline_extent_header {
	/* e.g. we need to record how many total extents here at least. */
	...
};

and some ondisk extent representation.

struct erofs_extent {
	__le32 ee_lblk;
	__le32 ee_pblk;
	/*
	 * most significant 4 bits reserved for flags and should be 0
	 * now, maximum 256M blocks (8TB) for an extent.
	 */
	__le32 ee_len;
};

(see fs/ext4/ext4_extents.h for ext4 ondisk definitions)

And I'd like to call this inline extent representation (for limited
extents) since we could consider some powerful representation
(e.g. using B+ tree) in the future for complicated requirement, so we
have to reserve i_u.raw_blkaddr in erofs_inode to 0 for now (in order
to indicate extra B+-tree blocks).


> +	return buf;
> +}
> +
>  void erofs_inode_manager_init(void)
>  {
>  	unsigned int i;
> @@ -304,7 +383,7 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
>  
>  int erofs_write_file(struct erofs_inode *inode)
>  {
> -	unsigned int nblocks, i;
> +	unsigned int nblocks, i, nholes, hitems = 0;
>  	int ret, fd;
>  
>  	if (!inode->i_size) {


The fallback condition from compress file to uncompress file should be updated
and give a new data_mapping for this mode as well, but that is minor for now.

Thanks,
Gao Xiang


> @@ -322,16 +401,24 @@ int erofs_write_file(struct erofs_inode *inode)
>  	/* fallback to all data uncompressed */
>  	inode->datalayout = EROFS_INODE_FLAT_INLINE;
>  	nblocks = inode->i_size / EROFS_BLKSIZ;
> -
> -	ret = __allocate_inode_bh_data(inode, nblocks);
> +	nholes = erofs_detect_holes(inode, &inode->i_holes, &hitems);
> +	if (nholes < 0)
> +		return nholes;
> +	inode->holes_isize = (sizeof(struct erofs_hole) -
> +			      sizeof(struct list_head)) * hitems;
> +	if (nblocks < 0)
> +		return nblocks;
> +	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
>  	if (ret)
>  		return ret;
> -
>  	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
>  	if (fd < 0)
>  		return -errno;
>  
>  	for (i = 0; i < nblocks; ++i) {
> +		if (erofs_ishole(i, inode->i_holes)) {
> +			continue;
> +		}
>  		char buf[EROFS_BLKSIZ];
>  
>  		ret = read(fd, buf, EROFS_BLKSIZ);
> @@ -479,8 +566,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		if (ret)
>  			return false;
>  		free(inode->compressmeta);
> +		off += inode->extent_isize;
>  	}
>  
> +	if (inode->holes_isize) {
> +		char *holes = erofs_create_holes_buffer(&inode->i_holes,
> +							inode->holes_isize);
> +		if (IS_ERR(holes))
> +			return false;
> +		ret = dev_write(holes, off, inode->holes_isize);
> +		free(holes);
> +		if (ret)
> +			return false;
> +	}
>  	inode->bh = NULL;
>  	erofs_iput(inode);
>  	return erofs_bh_flush_generic_end(bh);
> @@ -737,6 +835,7 @@ struct erofs_inode *erofs_new_inode(void)
>  
>  	init_list_head(&inode->i_subdirs);
>  	init_list_head(&inode->i_xattrs);
> +	init_list_head(&inode->i_holes);
>  
>  	inode->idata_size = 0;
>  	inode->xattr_isize = 0;
> @@ -961,4 +1060,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
>  
>  	return erofs_mkfs_build_tree(inode);
>  }
> -
> -- 
> 2.9.3
> 
