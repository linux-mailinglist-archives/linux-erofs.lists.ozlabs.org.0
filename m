Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AAF6ABA3F
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:45:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVYbG01j5z3cFH
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:45:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVYb76b39z3bfk
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:45:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdE1F8n_1678095901;
Received: from 30.221.131.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdE1F8n_1678095901)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 17:45:02 +0800
Message-ID: <19551cbd-f4b9-b53a-bbfb-08c88b81321b@linux.alibaba.com>
Date: Mon, 6 Mar 2023 17:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
 <20230302143915.111739-2-jefflexu@linux.alibaba.com>
 <20230306151606.00000ebd.zbestahu@gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230306151606.00000ebd.zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/6/23 3:16 PM, Yue Hu wrote:
> On Thu,  2 Mar 2023 22:39:14 +0800
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> As the first step of converting hardcoded blocksize to that specified in
>> on-disk superblock, convert all call sites of hardcoded blocksize to
>> sb->s_blocksize except for:
>>
>> 1) use sbi->blkszbits instead of sb->s_blocksize in
>> erofs_superblock_csum_verify() since sb->s_blocksize has not been
>> updated with the on-disk blocksize yet when the function is called.
>>
>> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
>> since the inode operated on may be an anonymous inode in fscache mode.
>> Currently the anonymous inode is allocated from an anonymous mount
>> maintained in erofs, while in the near future we may allocate anonymous
>> inodes from a generic API directly and thus have no access to the
>> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
>> anonymous inodes in fscache mode.
>>
>> Be noted that this patch only gets rid of the hardcoded blocksize, in
>> preparation for actually setting the on-disk block size in the following
>> patch.  The hard limit of constraining the block size to PAGE_SIZE still
>> exists until the next patch.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index 51b7ac7166d9..21fc6897d225 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -42,7 +42,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>>  		if (!sbi->lz4.max_pclusterblks) {
>>  			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
>>  		} else if (sbi->lz4.max_pclusterblks >
>> -			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
>> +			   Z_EROFS_PCLUSTER_MAX_SIZE >> sb->s_blocksize_bits) {
> 
> erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE)?

Okay.

>> @@ -422,7 +423,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>>  		return -EFSCORRUPTED;
>>  	}
>>  out:
>> -	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
>> +	map->m_plen = (u64)m->compressedblks << sb->s_blocksize_bits;
> 
> erofs_pos(sb, m->compressedblks)?

Okay.  I will update all these in the next version.

Thanks for the comment!


-- 
Thanks,
Jingbo
