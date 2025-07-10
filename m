Return-Path: <linux-erofs+bounces-581-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66537AFFB7D
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:59:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd6gL2RNKz30Vb;
	Thu, 10 Jul 2025 17:59:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752134350;
	cv=none; b=J99FZGFKSCO0+jNtLJyHMEnmRReYjtIYHsV1G3ij52wHSC+g7Gr+hLczMzRa7gpQ4v6So2Xj4bd0nd9KrWv5rGZGZmd++EmMOIefbpjgDpuny9moajEs20sVkPFFXe9M1zy52fa/R25f6wChyBNjLoT+012WX+KUGpQ2vJ//YezrgDhs/+ldRopiXkzcEgPoFByZVfNMOc7dL+BlIdZ9OzZflUEzJxT8L52DMF09AEzbBbAIum61TaY244KcbLgWcBUtWEXTswTP6f078f7v3AIvgBdKdLxZ/GRoU0O8GGwShaKPzIZ0SkkXiD6glqEBz5beLwaq7vjUhpsse+QrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752134350; c=relaxed/relaxed;
	bh=6HUKWPlo7iGSaMJI1npmCWXYt4qgmbdhnHqubqAN3lM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kGGkUBtH0dP/eURN8nAo7rWgnL+rbVmNvMMY0UW7foev/mP9OtgRhtYjEgmDJfJJt7o77s7U3NjzyRfg6NsNrhNGHs8omtftW7Cjh82LKiizkgG35kQRHgs2LCnOxrKGjcc4lxFIux2MM0bwlyquM9ePkPovQE7BdMscS1RBitDfFm5QeDn4AYmNTjJNWu+I8/AdnSVe4KySQwsD/Rngs8Qf81EoIK/KyqLSiUeWST8PnYGE35nWl2avH/yvWh2JDkefDEgnX6iSK1r5EtdD9SqsXkc6jzOl643TfMbsE75Yhk/jdMEaswZiVPeT5k6q02CWHTVLmw8UFCVMtNT1AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fNSlVgfY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fNSlVgfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd6gK4Jl8z2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:59:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6E7376147C;
	Thu, 10 Jul 2025 07:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F52C4CEF4;
	Thu, 10 Jul 2025 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134347;
	bh=8b54bDcLpykq7/jN9RXeM/Bx9RPEsuWayXBfpLBFqFM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fNSlVgfYPGH9Vy7/3YkzhYttzbfnbjAeeF+MUEiiS8pvd2kug5GBOeha04IBQajng
	 zgvXT3Ut8QGvsZCnnmLg2sOVX2PBGtuCRRF1Z3ZZZ+jNnhUCENk7G7ub2ll03zRL0L
	 EN8n6KYiCaNZlqyiGcCPImL0dV3HC4J/uh4noBiIZCA+vKhcanzUmony/Nxw8oMruh
	 FIw9hQhUXHwxBBEodh/deU7i8Jn8RkrHDM6dY3QNUnIY+1eOiA4Bsn6MWiWTVKujsM
	 n1cavEUa6e8tVXiaenvuB+fDjmh0re2/2OvBd1CZbrQsO2X6gbrFzj11yQr7GAtEK6
	 4wcAlBJ4lVPBw==
Message-ID: <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
Date: Thu, 10 Jul 2025 15:59:02 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
 <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/10/25 15:46, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/10 15:36, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(),
>> it can enhance performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/erofs/dir.c      | 8 ++++++++
>>   fs/erofs/internal.h | 3 +++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index cff61c5a172b..04113851fc0f 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>       int err = 0;
>>       bool initial = true;
>>   @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           }
>>           cond_resched();
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>> +                dbstart, min(nr_pages - dbstart,
>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index a32c03a80c70..ef9d1ee8c688 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>   +/* maximum readahead pages of directory */
>> +#define MAX_DIR_RA_PAGES    4
> 
> Could we set it as a per-sb sysfs configuration for users to config?

Xiang,

Oh, that will be better, how about introducing new sysfs in separated patch?

Thanks,

> 
> Thanks,
> Gao Xiang


