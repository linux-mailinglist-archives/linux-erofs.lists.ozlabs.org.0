Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6EA76A77F
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 05:32:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFLJT1Dvsz2yw4
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 13:32:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFLJL6btXz2yDH
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Aug 2023 13:32:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VokGhI8_1690860714;
Received: from 30.221.145.62(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VokGhI8_1690860714)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 11:31:56 +0800
Message-ID: <3e48e203-6c34-45af-64bb-224a65bcddc1@linux.alibaba.com>
Date: Tue, 1 Aug 2023 11:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs-utils: generate preallocated extents for tarerofs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230729133201.16894-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230729133201.16894-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/29/23 9:32 PM, Gao Xiang wrote:
> -int erofs_blob_remap(struct erofs_sb_info *sbi)
> +int tarerofs_write_chunk_data(struct erofs_inode *inode, erofs_off_t data_offset)
> +{
> +	struct erofs_sb_info *sbi = inode->sbi;
> +	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
> +	unsigned int count, unit, device_id;
> +	erofs_off_t chunksize, len, pos;
> +	erofs_blk_t blkaddr;
> +	struct erofs_inode_chunk_index *idx;
> +
> +	if (chunkbits < sbi->blkszbits)
> +		chunkbits = sbi->blkszbits;
> +	if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
> +		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
> +
> +	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
> +	if (sbi->extra_devices) {
> +		device_id = 1;
> +		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
> +		unit = sizeof(struct erofs_inode_chunk_index);
> +		DBG_BUGON(erofs_blkoff(sbi, data_offset));
> +		blkaddr = erofs_blknr(sbi, data_offset);
> +	} else {
> +		device_id = 0;
> +		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
> +		DBG_BUGON(erofs_blkoff(sbi, datablob_size));
> +		blkaddr = erofs_blknr(sbi, datablob_size);
> +		datablob_size += round_up(inode->i_size, erofs_blksiz(sbi));
> +	}
> +	chunksize = 1ULL << chunkbits;
> +	count = DIV_ROUND_UP(inode->i_size, chunksize);
> +
> +	inode->extent_isize = count * unit;
> +	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
> +	if (!idx)
> +		return -ENOMEM;
> +	inode->chunkindexes = idx;
> +
> +	for (pos = 0; pos < inode->i_size; pos += len) {
> +		struct erofs_blobchunk *chunk;
> +
> +		len = min_t(erofs_off_t, inode->i_size - pos, chunksize);
> +
> +		chunk = erofs_get_unhashed_chunk(device_id, blkaddr,
> +						 data_offset);
> +		if (IS_ERR(chunk))
> +			return PTR_ERR(chunk);

inode->chunkindexes needs to be freed on error path.

> +
> +		*(void **)idx++ = chunk;
> +		blkaddr += erofs_blknr(sbi, len);
> +		data_offset += len;
> +	}
> +	inode->datalayout = EROFS_INODE_CHUNK_BASED;
> +	return 0;
> +}
> +


-- 
Thanks,
Jingbo
