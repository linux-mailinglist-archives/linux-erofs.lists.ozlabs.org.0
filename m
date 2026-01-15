Return-Path: <linux-erofs+bounces-1877-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00371D220E0
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 02:44:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds5PC4ctdz2xrC;
	Thu, 15 Jan 2026 12:43:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768441439;
	cv=none; b=orRli4GBly5xWtCoG1iEkg1r6B/BgAmGpBsUjuYDp1ohATa+MFH0hHPKLd0J3bzsaZE7iFcI3+kqf5aZ5dH2BZQBTFs+9iYrfzj3YfVVJRC/i93JB7ZrST1sbR3dTdAwGM05a0Q/kTjuunJR2B5l1/rnbjfjCwliyqg/adBWGZQG2KyyBAMgIQyYON/Wtv2rrl6jQ0f8bWDLiGViFDyrXEIYEy+MS/V0ISaWegcOfMqUkZpRrloBq4UpJY9jzzp/K5Hal0mqMi3x7b9CPx/Wj55bujurS7l6yebWRF3fSEJK1J7TUJg+266mBGnXwLBNgoPn+/EzrKZj33VGOxz66w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768441439; c=relaxed/relaxed;
	bh=VOr47FbS0wDXn2jkEdscUYJCk7XAlkjlew+1NUKh7yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9Fso3mACY8BUShOoBa25UEy9iQlsZaE7Qoitu0l1dwkbJiUL6hZ6qRK2caoY1VZ4WmpB59vhGJBwJh7IQbjWOF9VlB1CVWtbjvNWyeVXG1aUVt+Ko3Ysq6nNSNLo/N5fObdoXeSK91baSudFsEQ3cpKOVZfPobUynNtx7qxfCgXAdXBOvdofJ4FkH96DEa2W9jiJucGTNhJKbUOJndo2OC7ycawMEKpsiFmE7AiLqXLT1W6PN8xJ/6lYnVy5x9xjedM5djjKHhIvhfmNFwwW12oRlFDNrv/9kFZPqUVLLH1bY07FzTRNydPJM06b7EGVDlywhbTyMqQwowT7rEjrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xPXoxb5B; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xPXoxb5B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds5P83rhwz2xqj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 12:43:55 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768441430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VOr47FbS0wDXn2jkEdscUYJCk7XAlkjlew+1NUKh7yE=;
	b=xPXoxb5B0B1DlbTFTLAta8iTdJ/+7hHkElyr7RCm4B4moclWHFm+Y6tSzSa/EaAjAdpVq6VbbFtboNplexhZs8QaOhAVeg1Ne8XgyUSlkFwNotT76X0rhAOzRrxCuO6wBdS2Wse42JMSKLFLXzb+WCZ6N+gmQYHRf2WR0zTvWrY=
Received: from 30.221.132.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx4jmrW_1768441428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 09:43:49 +0800
Message-ID: <2f378658-ec10-4091-9f8d-02b19351cd44@linux.alibaba.com>
Date: Thu, 15 Jan 2026 09:43:48 +0800
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
Subject: Re: [PATCH v14 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-8-lihongbo22@huawei.com>
 <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
 <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6ccc0f3f-56a5-4edb-a4c9-72d6e5090b7b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/15 09:21, Hongbo Li wrote:
> Hi,Xiang
> 
> On 2026/1/14 18:18, Gao Xiang wrote:
>>
>>
>> On 2026/1/9 18:28, Hongbo Li wrote:
>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>
> ...
> 
>>> +
>>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>>> +{
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +
>>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>>> +    INIT_LIST_HEAD(&vi->ishare_list);
>>> +    spin_lock_init(&vi->ishare_lock);
>>> +    return 0;
>>> +}
>>> +
>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>> +{
>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>> +    struct erofs_inode_fingerprint fp;
>>> +    struct inode *sharedinode;
>>> +    unsigned long hash;
>>> +
>>> +    if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>>> +        return false;
>>> +    hash = xxh32(fp.opaque, fp.size, 0);
>>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>>> +                   &fp);
>>> +    if (!sharedinode) {
>>> +        kfree(fp.opaque);
>>> +        return false;
>>> +    }
>>> +
>>> +    vi->sharedinode = sharedinode;
>>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>>> +        if (erofs_inode_is_data_compressed(vi->datalayout)) {
>>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
>>
>> It seems that it caused a build warning:
>> https://lore.kernel.org/r/202601130827.dHbGXL3Y-lkp@intel.com
>>
>>> +        } else {
>>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>>> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
>>> +            if (erofs_is_fileio_mode(sbi))
>>> +                sharedinode->i_mapping->a_ops = &erofs_fileio_aops;
>>> +#endif
>>> +        }
>>
>> Can we introduce a new helper for those aops setting? such as:
>>
>> void erofs_inode_set_aops(struct erofs_inode *inode,
>>                struct erofs_inode *realinode, bool no_fscache)
> 
> Yeah, good idea. So it also can be reuse in erofs_fill_inode.
> 
> And how about declearing it as "int erofs_iode_set_aops(struct erofs_inode *inode, struct erofs_inode *realinode, bool no_fscache)"; because the compressed case may return -EOPNOTSUPP and it seems we cannot break this in advance.

yes, `int` return is good.

>  And can we mark it inline?

you could move this one to internal.h.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

