Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F28A11AD7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 08:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1736925859;
	bh=5X41kuSTLjPmElmbH3JBIkxyyCTj/CB7OjEHLGXgVuo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=exBPQcpPJ+ecLdiTsCreu8ni1CUSPUUy67KoutmysMB8RG5TVlrNO/O68geRnvdI/
	 qKkk+rNOhM17wh4k2lX745b732PxPKYoPEYBuTsHQQmYyZtMW8LiKV72Hwi2XYIFIL
	 KT3LcY/pwu6wWF7PpJgrnomLmg44Koii6EpxJtMsDjdmwFnJArquKlEV+XshYV1fx2
	 0IamBgO5K0U4VCc4GkyGrU2Lm+d/K/eDgreaolsjaFE31O1IElbfxgDIDxow333/6N
	 7t/SsxUU8vB3dl+2GyQOVkpha4oXyY9tPBm15ZfM+t0c3CYmv6Z2Q1n3VjlPzXun7R
	 j+bYH9NTsrLag==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXyDM69kcz3bZN
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 18:24:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736925854;
	cv=none; b=ASOVXabzgADYR2nd2x9x9Ifq1Q8A5t7VPDnqDlDAlFxcC4oIdjmbV4MLfIb8zyWwW4UkyT+aGhE7oX58Oced3d4pxLh0glM6Bg8FkHHC+R3+F0cH27wZgKBK5KL2lNIrsdihO/m26Md9BIjXasAkl6VEdT31BDMeGscQYhF6USlxnwtrihuOloK6jsuxatFpv68CxrFkcT1Hf+KJKEwaA5Qe8Mb1jNfSaSdDjOEQfCAcF490HJh3UWDTcu84ZL144DjPsRvp74BzmwrdDp+9+lgVihmOvxSwRikUC0vDnK0DPA2rQ35wcQvLXEfgbkspRGDXj0NCpnNZQJrObKruMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736925854; c=relaxed/relaxed;
	bh=5X41kuSTLjPmElmbH3JBIkxyyCTj/CB7OjEHLGXgVuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J5KflTF1ItON8L5NV+RfIPCGUpD0OkQ4FYQLlyeFPdPEm0AMVjtnLXL3OSjOH+OciyWC0EY1gNokRbsdKQb23yfAumCYRdj8U0bTQNx3ou9Bw1b7H3ko3D07EIcgPFTG7lAjspFqYDsm2f2ke0UAc2ZWZYXHB4erjgHdRVGsN2V8A9PKSQx/cb4xiYHzMYR8btgNFHZRkuP4ltePKA2wzCfAk/OuVAMJ3hCO2HD4obE8ZN/mXdY3ENOPibplTjA5SQFkInLIjwhVHp/nndY0/9JY/bFmT5n1M4vMPu+nqjqxgg3V9oryTLs3EvxCozl6Dp+p8cVXtFP6dwH89YjHKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 329 seconds by postgrey-1.37 at boromir; Wed, 15 Jan 2025 18:24:12 AEDT
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXyDD4KYmz30DD
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 18:24:11 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YXy8S3gRbz1kxtR;
	Wed, 15 Jan 2025 15:20:56 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7236514010C;
	Wed, 15 Jan 2025 15:24:06 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jan 2025 15:24:05 +0800
Message-ID: <78ad9c5a-02c3-4e3f-8fb1-23f8dbf4d3b8@huawei.com>
Date: Wed, 15 Jan 2025 15:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: <xiang@kernel.org>, <chao@kernel.org>, <hsiangkao@linux.alibaba.com>
References: <20250115070936.119975-1-lihongbo22@huawei.com>
Content-Language: en-US
In-Reply-To: <20250115070936.119975-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/15 15:09, Hongbo Li wrote:
> erofs has add file-backed mount support. In this scenario, only buffer
> io is allowed. So we enhance the io mode by implementing the direct
> io. Also, this can make the iov_iter (user buffer) interact with the
> backed file's page cache directly.
> 
Base on this, we might decrease the memory overhead by the following io 
stack:

erofs io (buffer io, direct io) --> fileio --> file-backed's page cache.

That means we can implement direct page cache pass-through in EROFS, and 
the under mounted file use buffer io for the backed file system.

Thanks,
Hongbo

> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c   |  11 +++--
>   fs/erofs/fileio.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..b5baff61be16 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -395,9 +395,14 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	if (IS_DAX(inode))
>   		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>   #endif
> -	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
> -		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> -				    NULL, 0, NULL, 0);
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		if (inode->i_sb->s_bdev)
> +			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> +						NULL, 0, NULL, 0);
> +		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
> +			return generic_file_read_iter(iocb, to);
> +	}
> +
>   	return filemap_read(iocb, to, 0);
>   }
>   
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 33f8539dda4a..76ed16a8ee75 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -10,12 +10,17 @@ struct erofs_fileio_rq {
>   	struct bio bio;
>   	struct kiocb iocb;
>   	struct super_block *sb;
> +	ssize_t ret;
> +	void *private;
>   };
>   
>   struct erofs_fileio {
> +	struct file *file;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev dev;
>   	struct erofs_fileio_rq *rq;
> +	size_t total;
> +	size_t done;
>   };
>   
>   static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
> @@ -24,6 +29,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   			container_of(iocb, struct erofs_fileio_rq, iocb);
>   	struct folio_iter fi;
>   
> +	rq->ret = ret;
>   	if (ret > 0) {
>   		if (ret != rq->bio.bi_iter.bi_size) {
>   			bio_advance(&rq->bio, ret);
> @@ -43,6 +49,17 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   	kfree(rq);
>   }
>   
> +static void erofs_fileio_end_io(struct bio *bio)
> +{
> +	struct erofs_fileio_rq *rq =
> +			container_of(bio, struct erofs_fileio_rq, bio);
> +	struct erofs_fileio *io = rq->private;
> +
> +	if (rq->ret > 0) {
> +		io->done += rq->ret;
> +	}
> +}
> +
>   static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   {
>   	struct iov_iter iter;
> @@ -189,7 +206,112 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
>   	erofs_fileio_rq_submit(io.rq);
>   }
>   
> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct kiocb *iocb,
> +				  struct iov_iter *iter)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct erofs_map_blocks *map = &io->map;
> +	struct iov_iter dest_iter = *iter;
> +	unsigned int cur = 0, end = io->total, len;
> +	loff_t pos = iocb->ki_pos;
> +	int err = 0;
> +
> +	while (cur < end) {
> +		/* submit the last fileio rq */
> +		if (io->rq) {
> +			erofs_fileio_rq_submit(io->rq);
> +			io->rq = NULL;
> +		}
> +
> +		if (!in_range(pos + cur, map->m_la, map->m_llen)) {
> +			map->m_la = pos + cur;
> +			map->m_llen = end - cur;
> +			err = erofs_map_blocks(inode, map);
> +			if (err)
> +				break;
> +		}
> +
> +		len = min_t(loff_t, map->m_llen, end - cur);
> +		/* split the whole iter with (cur, len) */
> +		dest_iter = *iter;
> +		iov_iter_advance(&dest_iter, cur);
> +		iov_iter_truncate(&dest_iter, len);
> +		if (map->m_flags & EROFS_MAP_META) {
> +			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +			void *src;
> +
> +			src = erofs_read_metabuf(&buf, inode->i_sb, map->m_pa, EROFS_KMAP);
> +			if (IS_ERR(src)) {
> +				err = PTR_ERR(src);
> +				break;
> +			}
> +			if (copy_to_iter(src, len, &dest_iter) != len) {
> +				erofs_put_metabuf(&buf);
> +				err = -EIO;
> +				break;
> +			}
> +			erofs_put_metabuf(&buf);
> +			io->done += len;
> +		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
> +			iov_iter_zero(len, &dest_iter);
> +			io->done += len;
> +		} else {
> +			io->dev = (struct erofs_map_dev) {
> +				.m_pa = map->m_pa,
> +				.m_deviceid = map->m_deviceid,
> +			};
> +			err = erofs_map_dev(inode->i_sb, &io->dev);
> +			if (err)
> +				break;
> +			io->rq = erofs_fileio_rq_alloc(&io->dev);
> +			io->rq->private = io;
> +			io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> SECTOR_SHIFT;
> +			io->rq->bio.bi_end_io = erofs_fileio_end_io;
> +
> +			if (bio_iov_iter_get_pages(&io->rq->bio, &dest_iter)) {
> +				err = -EIO;
> +				break;
> +			}
> +			io->dev.m_pa += len;
> +		}
> +		cur += len;
> +	}
> +
> +	return err;
> +}
> +
> +static ssize_t erofs_fileio_direct_io(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	size_t i_size = i_size_read(inode);
> +	struct erofs_fileio io = {};
> +	int err = 0;
> +
> +	if (unlikely(iocb->ki_pos >= i_size))
> +		return 0;
> +
> +	iter->count = min_t(size_t, iter->count,
> +			    max_t(size_t, 0, i_size - iocb->ki_pos));
> +
> +	io.total = iter->count;
> +	if (!io.total)
> +		return 0;
> +
> +	err = erofs_fileio_scan_iter(&io, iocb, iter);
> +	if (err)
> +		return err;
> +	erofs_fileio_rq_submit(io.rq);
> +	if (io.total != io.done)
> +		return -EIO;
> +
> +	iov_iter_advance(iter, io.done);
> +	return io.done;
> +}
> +
>   const struct address_space_operations erofs_fileio_aops = {
>   	.read_folio = erofs_fileio_read_folio,
>   	.readahead = erofs_fileio_readahead,
> +	.direct_IO = erofs_fileio_direct_io,
>   };
