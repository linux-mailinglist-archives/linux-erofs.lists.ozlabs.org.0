Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28312C007
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2019 03:56:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47llZ16NzYzDqC3
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2019 13:56:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1577588169;
	bh=PKAZITFr0hdU3kmDgkmM6vS+rlnetYIl9UNFqU2fq3w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jkk1W5/xW5vwEXNXEbzGjubqr75gXbJ+tf9lxf2+znjRux6qavNl1NkzNPCCrY/SY
	 Oxz88P3HTaoHm2jabLkxXL0SQqkTvVp3p7jfjg2MF/3gvOfjOxIjBsGZvAApmQdEDy
	 jDn9YiHuh5/XgLSC0kJfMtxK38tEuvlrIyUrQ35yTxcrW6NCpuOzNGNo/uANUJTYPv
	 FBklYKsOfnaiz4X+L3IkV1rMBGezkyr1gOcWd3a/w/sMGehacMfjmBRB5A1lz1p7tl
	 lrCuhHjv81ful10c0OoXP2ORfDgbLCB09MxyYzjL2vSAXHMVp7g4PQkRiQDpNzL4nQ
	 qR0pdKLwJxUjw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="aMMZGvIf"; 
 dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47llYx0q0tzDqB4
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2019 13:56:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1577588161; bh=3s0U8zkRAmPGlJHVcUQGJigSeQHMv6X4fFbLFxGnCFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=aMMZGvIfvLhARx31FOLw140vC66AFZXpOhKBDfOjstTQiWoRIizNtWrneA4jMN+xYuaYoUuqDHgPHruf7uUiLfDL9wdm+3UbtzxCYfJfxALrdMPHGJlusLJKLYWlGFR5f8axQ5zlTyMRdtrUdDMge2iYkz4t4QdOTOdaPAROEXEEP0RyUWUC+a6AaV3bKTsgjgDWqiiHVPlzuCWJP7sV6F9MXLennmr1FP/O2wBQ2cmID0gwmlGnWF6NixaRgnnpZYyYWroDvJMS6wwGIXWfy3bGRK/KVnMuYvE9Nm+sjJ576NeHmpthD8eWT3GGI2ZieOD/xExHviz3Gkho5L5CkQ==
X-YMail-OSG: wbYxTXEVM1lAef_B1LMU6fZ4han0HajH70QMV79Q7xKguND_9YqXRVxgRQAezXx
 HHWBO6mvI1zmDQOJua.Br5lx2HFMNGOA3w52fHTtvouDROwpIxIUKYpKsTxfr0kvwoMBRf0c.PFJ
 3DfqvimX9cRwh1UkA4qJ5kn3uYGEZif3sj53eNiRZS1wZQMbYvmrn65F6lIvyb087RxcyCN9P1Jo
 ByCuxnHI7b5nn9ylteke9caSMEQUJQOkPsOQHZInDZwjVwte_0wJB8Oixh5Fx.Z9Ein8nBQwXwgw
 JlTWdG9YCcOU8oGSc9oqrFwrwNxWipNzDfDjLh4DOXJCxrEHGi43WqU4yBOHR9UwVihqkpDpBYvC
 qlk7pc05sa_yTw83mdFUw4lKlaoZHr5HcugtdsnruGlIxQVMzVkvSzTTFBAg3ZB3CwUy9AVdBLrQ
 a3aqbrRiJCs_Mv4zrkWn95frcZbPF0W64Ox1peahfmDaAp_VZ7nwkIpe5ji.E9c8cLkfznOCFm0c
 L5382.sxe3mwf1vdHVn7v.XaFbG2koRXcDFlpnF7AWMtPPMc.SfRTdqpxolNnrs0a5NTYNi_mqhn
 HuZzAhYgVhFVucRR4hXFKKYHUwjSzgQFsDawfkisGPzAmwSCgJfuLf0cM1vSgdPHRxSbBJSxM2MY
 6LQdrunbNJnKhu5MrGdcoUAT_QmrIn5NoMZeBnFTnaqDEYUEaMTwSYcgiraWHas0W5U2W3sNsPUQ
 uUFEm14YV5fY60LH66s1AZnNmzu.WyFlc9N.dCNDJisWIqz_xHGLft7vnnsFCwTDFHm44o3h5Udu
 5p0MR8Bxr8009g1wbkzxkHHuMfwJr8d9T6HoNPdPyOLJlRZRwZGxz17G8uZqpdngVjudEBSBJH4o
 5m7EL_xAwZbGN5PiIg9RhFJAGUrQVAl8sSCvPHgwlLEAYzSVlhJUtjXXXCl7q24r1TogTG.ryXdC
 WSVtqAKTemybVtrxQeM.rf_bd7Mvzwq.z7dYCKWzIVRaU3WJTkaZ9_nM37OjHvaisB2kPpeYhIN4
 vpnNCFDM1fGSV5RhTkEKBBaG4MPzd0a7y7IHVy.z02zuYGBvZ9a4axdpBYkZLXIN9yCbhz8r6lG6
 Du47xxeqY02uEr70gx9oV9fHLW3dZlG5DxLVVMzg.S_IOREyNvZ6U5TiCPhhi.g_ex5BsxHBxyMs
 eWh3I.2RHBDAs0eH_G.SBl5wH1ntUHi2h5FbIIukY9ITScK9Dy4ZAlNV6If1vBICldqFZuUXVGa5
 SFs8aPvkrWhbfViyoTyY9UOppE13dxGzoTD32Gf0qSVWFDlOkDcxleGsPj0HkKnujX6YR0RYFlOO
 LqJWXJkQ.LdxuRgYcnNddSrmtJewebzX8xNPSCzsxMRVGZo4Pz3mySJvT0P87QzICGH2yXhsY4HW
 hqLVz
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 Dec 2019 02:56:01 +0000
Received: by smtp422.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4d36cfb06638d86296f193ee4bb3a5f8; 
 Sun, 29 Dec 2019 02:55:59 +0000 (UTC)
Date: Sun, 29 Dec 2019 10:55:48 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFC] erofs-utils: on-disk extent format for blocks.
Message-ID: <20191229025546.GB2215@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191227154348.21432-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227154348.21432-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:
> since this patch is quite different from previous patches I am treating
> this as new patch.
> 
> 1) On disk extent format for erofs data blocks.
> 2) Detect holes inside files & skip allocation for hole blocks.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/internal.h |  21 ++++++-
>  lib/inode.c              | 155 +++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 156 insertions(+), 20 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index e13adda..128aa63 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -63,7 +63,7 @@ struct erofs_sb_info {
>  extern struct erofs_sb_info sbi;
>  
>  struct erofs_inode {
> -	struct list_head i_hash, i_subdirs, i_xattrs;
> +	struct list_head i_hash, i_subdirs, i_xattrs, i_extents;
>  
>  	unsigned int i_count;
>  	struct erofs_inode *i_parent;
> @@ -93,6 +93,7 @@ struct erofs_inode {
>  
>  	unsigned int xattr_isize;
>  	unsigned int extent_isize;
> +	unsigned int extent_meta_isize;

maybe sparse_extent_isize is better...

p.s. maybe we could send another patch rename extent_isize to
compress_extent_isize or some better name...

>  
>  	erofs_nid_t nid;
>  	struct erofs_buffer_head *bh;
> @@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int err)
>  	return msg;
>  }
>  
> +#define HOLE_BLK	-1
> +/* on disk extent format */
> +struct erofs_extent {
> +	__le32 ee_lblk;
> +	__le32 ee_pblk;
> +	__le32 ee_len;
> +};
> +
> +struct erofs_extent_node {
> +	struct list_head next;
> +	erofs_blk_t lblk;
> +	erofs_blk_t pblk;
> +	u32 len;
> +};
> +
> +struct erofs_inline_extent_header {
> +	u32 count;
> +};
>  #endif
>  
> diff --git a/lib/inode.c b/lib/inode.c
> index 0e19b11..a6af509 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT >> S_SHIFT] = {
>  
>  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
>  
> +
> +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&	\
> +		             roundup(end, EROFS_BLKSIZ) == end &&	\
> +			    (end - start) % EROFS_BLKSIZ == 0)

See below..

> +
> +/* returns the number of holes present in the file */
> +unsigned int erofs_read_extents(struct erofs_inode *inode,
> +				struct list_head *extents)
> +{
> +	int fd, st, en, dt;
> +	unsigned int nholes = 0;
> +	erofs_off_t data, hole, len, last_data;
> +	struct erofs_extent_node *e_hole, *e_data;
> +
> +	fd = open(inode->i_srcpath, O_RDONLY);
> +	if (fd < 0) {
> +		return -errno;
> +	}
> +	len = lseek(fd, 0, SEEK_END);
> +	if (lseek(fd, 0, SEEK_SET) == -1)
> +		return -errno;
> +	data = 0;
> +	last_data = 0;
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
> +			dt = last_data >> S_SHIFT;

Why using S_SHIFT here, some special meaning?

> +			last_data = data;
> +			e_data = malloc(sizeof(struct erofs_extent_node));
> +			if (e_data == NULL)
> +				return -ENOMEM;
> +			e_data->lblk = dt;
> +			e_data->len = (st - dt);
> +			list_add_tail(&e_data->next, extents);
> +			e_hole = malloc(sizeof(struct erofs_extent_node));
> +			if (e_hole == NULL)
> +				return -ENOMEM;
> +			e_hole->lblk = st;
> +			e_hole->pblk = HOLE_BLK;
> +			e_hole->len = (en - st);
> +			list_add_tail(&e_hole->next, extents);
> +			nholes += e_hole->len;

Maybe we don't need to emit all HOLK extents since all data extents
are with _length_... It is easy to detect all holes between extents...

If some block doesn't belong to any extent, it's a hole.

Thanks,
Gao Xiang

> +		}
> +	}
> +	/* rounddown to exclude tail-end data */
> +	if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> +		e_data = malloc(sizeof(struct erofs_extent_node));
> +		if (e_data == NULL)
> +			return -ENOMEM;
> +		st = last_data >> S_SHIFT;
> +		e_data->lblk = st;
> +		e_data->len = rounddown((len - last_data), EROFS_BLKSIZ) >> S_SHIFT;
> +		list_add_tail(&e_data->next, extents);
> +	}
> +	return nholes;
> +}
> +
> +char *erofs_create_extent_buffer(struct list_head *extents, unsigned int size)
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
> @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
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
> @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode *inode)
>  	/* fallback to all data uncompressed */
>  	inode->datalayout = EROFS_INODE_FLAT_INLINE;
>  	nblocks = inode->i_size / EROFS_BLKSIZ;
> -
> -	ret = __allocate_inode_bh_data(inode, nblocks);
> +	nholes = erofs_read_extents(inode, &inode->i_extents);
> +	if (nholes < 0)
> +		return nholes;
> +	if (nblocks < 0)
> +		return nblocks;
> +	ret = __allocate_inode_bh_data(inode, nblocks - nholes);
>  	if (ret)
>  		return ret;
>  
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
> -				goto fail;
> -			close(fd);
> -			return -EAGAIN;
> +	i = inode->u.i_blkaddr;
> +	inode->extent_meta_isize = sizeof(struct erofs_inline_extent_header);
> +	list_for_each_entry(e_node, &inode->i_extents, next) {
> +		inode->extent_meta_isize += sizeof(struct erofs_extent);
> +		if (e_node->pblk == HOLE_BLK) {
> +			lseek(fd, e_node->len * EROFS_BLKSIZ, SEEK_CUR);
> +			continue;
>  		}
> +		e_node->pblk = i;
> +		i += e_node->len;
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
> +				goto fail;
>  
> -		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> -		if (ret)
> -			goto fail;
> +		}
>  	}
> -
>  	/* read the tail-end data */
>  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
>  	if (inode->idata_size) {
> @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  		if (ret)
>  			return false;
>  		free(inode->compressmeta);
> +		off += inode->extent_isize;
>  	}
>  
> +	if (inode->extent_meta_isize) {
> +		char *extents = erofs_create_extent_buffer(&inode->i_extents,
> +						   inode->extent_meta_isize);
> +		if (IS_ERR(extents))
> +			return false;
> +		ret = dev_write(extents, off, inode->extent_meta_isize);
> +		free(extents);
> +		if (ret)
> +			return false;
> +	}
>  	inode->bh = NULL;
>  	erofs_iput(inode);
>  	return erofs_bh_flush_generic_end(bh);
> @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)
>  
>  	init_list_head(&inode->i_subdirs);
>  	init_list_head(&inode->i_xattrs);
> +	init_list_head(&inode->i_extents);
>  
>  	inode->idata_size = 0;
>  	inode->xattr_isize = 0;
> -	inode->extent_isize = 0;
> +	inode->extent_meta_isize = 0;
>  
>  	inode->bh = inode->bh_inline = inode->bh_data = NULL;
>  	inode->idata = NULL;
> @@ -961,4 +1079,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
>  
>  	return erofs_mkfs_build_tree(inode);
>  }
> -
> -- 
> 2.9.3
> 
