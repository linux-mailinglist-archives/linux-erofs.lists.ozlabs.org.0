Return-Path: <linux-erofs+bounces-1697-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE9CFC55F
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 08:27:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmKPP0CNLz2xbQ;
	Wed, 07 Jan 2026 18:27:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767770856;
	cv=none; b=NHL7aNTmK0VRU1KpyOstqneFMm1oYkmzFRUcLbI/STB9k3C4ILHCrWpuB9/rmkAMLHBdsBLKZvGaOeK1BjrzF0nbGp8tJ7y503xyc4+0OacLJuv3OxPjIUuZmj81XIB67AP0ClgNRuMKpTUz84IVGMBa8Qrs4s4n+7HBMofqtaIFLQrb3M2DdpTtLFrs7CB4dofQaMjhnJoVkLgw7PfCGtATpHTGJxYR3jgNbIxpKtirUJfpvR5lHgrLq9tEnvI0rNa5AGox7ek7wMEUnrC4y+93RO8ds1x/iblQSc8XmFJ1sS81me3UeDBKMRfRzPp/Jt9WL4y2CgRs2xHnZjxFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767770856; c=relaxed/relaxed;
	bh=wIhoN/2ww2lPKEHlSOgFqyKLzkhSgxbhOitTMCYTPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1vKqYf4Esx0Ww3lstyarN5UbipggjGcKxBnpbHIqMr9ACLlpT/HnLYNS5pgoAclspVazFQoxLejcIAyqy2bz++E1SxfQfXqtl3CxcbtJaQj5tFBSb0urHQfghvdtlabWWi//0OeEoClAoT2Vxt+o8GKA0E0ly3p1axEBpLnadROpy63yLJrzt+HLEdYN9FxcmUp4IdB7Id56vUr8diDSZUyi5zW7Ii9HgS6xO6ddqAipK+FL1dlMzpNoMh2jVifC3oRw157qPx1/S4mn6VhkZZTRaltiuFX5WsBEFUsqwb6Ofbghh5Z2EYLdz3D0Ah2xSmLJRmUDPLty3LD3u+KJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xvT0nxsC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xvT0nxsC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmKPL0KYkz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 18:27:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767770847; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wIhoN/2ww2lPKEHlSOgFqyKLzkhSgxbhOitTMCYTPKg=;
	b=xvT0nxsC8t14N4YfGvtSQXGNC5a6hDjWXf+Ae2PtZTlTE2Fs3yZQvyIQFeqSDqAgGbN9nhkR4X39nEzPiSpLmpSAFS+LHWDTWi6no5CsvEc5hdVqPjx2tcofVa+rf6px5Ar4sHZTxU4GIKSzNVFO4Oj3mWSbIMWxEeC9+gid6eU=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwY.RhZ_1767770844 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 15:27:24 +0800
Message-ID: <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
Date: Wed, 7 Jan 2026 15:27:23 +0800
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
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
 <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/7 15:17, Hongbo Li wrote:
> Hi, Xiang
> 

...

>>>>> +
>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>> +{
>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>> +    struct erofs_inode_fingerprint fp;
>>>>> +    struct inode *sharedinode;
>>>>> +    unsigned long hash;
>>>>> +
>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>> +        return false;
>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>> +    if (!fp.size)
>>>>> +        return false;
>>>>
>>>> Why not just:
>>>>
>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>          return false;
>>>>
>>>
>>> When erofs_sb_has_ishare_xattrs returns false, erofs_xattr_fill_ishare_fp also considers success.
>>
>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>
> 
> The MOUNT_INODE_SHARE flag is passed from user's mount option. And it is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do the check when the superblock without ishare_xattrs. (It seems the mount options is static, although it is useless for mounting with inode_share on one EROFS image without ishare_xattrs).
> So should we check that if the superblock has not ishare_xattrs feature, and we return -ENOSUPP?

I think you should just mask off the INODE_SHARE if the on-disk
compat feature is unavailable, and print a warning just like
FSDAX fallback.

Thanks,
Gao Xiang

