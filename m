Return-Path: <linux-erofs+bounces-1558-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9ECD8744
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:35:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db7c75KGKz2xlP;
	Tue, 23 Dec 2025 19:35:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766478903;
	cv=none; b=easIoUVOHaAVzFI0s3q+9QSYWww/djGvLJAVrOeqarmpvXmgbisTaPRvgyiTbrtu0lnmEAn6Me6t1B8vQLv8cGGvsSD7FlinBIx/dC1iv8Kw6d9Odp9/BU952lS28JAsfEpWGiVfAfcbmBELrVGaaBLW0iHZzNk4IIWEB6UEq1xDOtGTXxO9SrVUJB9tDEHlAswPbiRXFgxgjWC8yGvIbkDuaxIhfwC9Lxfq5ZkfKHa2WRHFw8dv7jPxLyQ+9t6BsY3VZ3ONOQgQYA+CR2H8k1Ry7xvh7MnfSdKoH3nMkky8YYCsJfmw8s05SQfrRkY7QK/7MtbVHqxHq1pQdq4dgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766478903; c=relaxed/relaxed;
	bh=5n5OK+w8gxWpMj71tDuhpwqNAOAZ1mzZmlORbv1RSSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XjA4+6T/iwnen1Ieqi2BfNksrdA6n4aPDEnvW/u2PhgQ3oIgMV5BiZB8SKnlhXXLqu+U5HH9kOvwGTh7RVEK7YCdMgYvGkEczvEhW+s7qhl3f/0ftTO8OkrU2LZl8Z0eYqjQTymiududb1cpPNXtsvj688o+3evhWjZBFaiM19alic+VsJL8/NCl6vEsqprFYYxFKCSJi3on0oykswCLL9Wf57aUopmzHC92tlvCBNQkzUS7T4dHK6FhtmSFGWAIl7xI1v6vB/rB22aXWyWtX4ytLxiFwM7w1RgUQoYrCm/TF0PewtU8gGb0OVQAfixtYkIjzqv/+aI0cHBw9OS1Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZnnDLibg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZnnDLibg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db7c62yQvz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:35:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478897; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=5n5OK+w8gxWpMj71tDuhpwqNAOAZ1mzZmlORbv1RSSE=;
	b=ZnnDLibgp1o2AVfqBYPZ8PY3bLCjO7KkHN/fBcQdWWFB+sKcbzdglvWGfcgt17JuvLVkuz3WErD0kOHCQByzHZQon+o/tkgimzySAecB1k1DuVBfO0p05iQ+SPKbjP8X5/UfGozhAeNpObpmA0L+8T1TO8KqfNSVJ8fni6n69/k=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX7w8h_1766478896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:34:56 +0800
Message-ID: <7f03a68f-1831-4158-899c-06ef3317cf67@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:34:56 +0800
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
Subject: Re: [PATCH v10 08/10] erofs: support unencoded inodes for page cache
 share
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-9-lihongbo22@huawei.com>
 <b2bb83da-8b76-40eb-b563-a0aa9c5436dc@linux.alibaba.com>
In-Reply-To: <b2bb83da-8b76-40eb-b563-a0aa9c5436dc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 16:15, Gao Xiang wrote:
> 
> 
> On 2025/12/23 09:56, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the
>> memory usage for reading all files in two different minor versions
>> of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     |      49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     |      48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
> 
> ...
> 
>> index 4b46016bcd03..269b53b3ed79 100644
>> --- a/fs/erofs/ishare.c
>> +++ b/fs/erofs/ishare.c
>> @@ -197,6 +197,37 @@ const struct file_operations erofs_ishare_fops = {
>>       .splice_read    = filemap_splice_read,
>>   };
>> +/*
>> + * erofs_ishare_iget - find the backing inode.
>> + */
>> +struct inode *erofs_ishare_iget(struct inode *inode)
> 
> Just:
> 
> struct inode *erofs_get_real_inode(struct inode *inode)
> 
> `ishare_` prefix seems useless here.
> 
>> +{
>> +    struct erofs_inode *vi, *vi_dedup;
>> +    struct inode *realinode;
>> +
>> +    if (!erofs_is_ishare_inode(inode))
>> +        return igrab(inode);

Also please `return inode;` directly if `erofs_is_ishare_inode`
is off.

No need to bump the inode reference unnecessarily if ishare is off;

>> +
>> +    vi_dedup = EROFS_I(inode);
>> +    spin_lock(&vi_dedup->lock);
>> +    /* fall back to all backing inodes */
>> +    DBG_BUGON(list_empty(&vi_dedup->backing_head));
>> +    list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
>> +        realinode = igrab(&vi->vfs_inode);
>> +        if (realinode)
>> +            break;
>> +    }
>> +    spin_unlock(&vi_dedup->lock);
>> +
>> +    DBG_BUGON(!realinode);
>> +    return realinode;
>> +}
>> +
>> +void erofs_ishare_iput(struct inode *realinode)
> 
> Just:
> 
> erofs_put_real_inode().
> 
> Thanks,
> Gao Xiang


