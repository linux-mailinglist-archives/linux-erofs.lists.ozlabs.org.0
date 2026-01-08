Return-Path: <linux-erofs+bounces-1719-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF19D0292F
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 13:20:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn3rh1l8Pz2yGL;
	Thu, 08 Jan 2026 23:20:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767874820;
	cv=none; b=LyuG4KYy4y0SAuo0ITOsRSj1cAfpIBMsnDlTvU6lcDMIiq3dHB9BOxFhFgaGF/78HKxsZpUvPAVLZ79PdId6e+xDM4BeIFtsJSHZA+gFj8etGH1cpHcTuTp4Gd7w/CkUXaNogEKhaRb6ipQNq7Zlsyu/thdUVIjr8Esncx7MS+ZfStVdAKvjiBN5Z+XP1VXCWXxiHbEuDkVG7JOiB9jB700CT0GIlpXOR3ooQDUeghZzPv+/bNu0k69+cfHoSC4AF966LraS3WphGvix9y6D8m/ke6vZAkzFpIsPMPX95YtYmocqRdSE5CLi9402FEm1au37bamb0zYkELTbI0o9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767874820; c=relaxed/relaxed;
	bh=DokPCpI+DXeppXDY77AhxNya3KTD8hrJouXcEIui7k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MLgCK7RWCZjY1uCRv3JE6ZjkHotdBOFUmvx6KN0oMs2lOHzXR7KwFgyCcR3Dh52M52KNU1EDEz7q1700NDCIc4VWl5ilVdgAL43wcu/p40CrsIXsSEW5wAK34EzxrkQiUFYtZUFyBC1jhMEXNoDGLShKFKJMpJsvD+9IYMmRt/GoiUql0PRmeqdt7bUKmK39MBrLrbG5qDjQnN7TBvg8GWg4JlT7LYEPK2MQbxtIdZynv0ZnXRxtQWNstljiErUdMCmv26TdD4wFhoL9i9REYyQNjyV+HJszsQlOMmbqBsZMXNkXucsih9FyfZKvy9tEHj1NWC20ocpibsljOkjDfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GIpn2P3f; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GIpn2P3f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn3rd4HkYz2xjN
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 23:20:16 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DokPCpI+DXeppXDY77AhxNya3KTD8hrJouXcEIui7k0=;
	b=GIpn2P3f0KYTczqlD5hfRTSljCiL0x5m4qHG3fqaAdXJNYsPunVQIu5oZNpKUbDElhXnflxh9
	eT9s5UfISoOb7shIwIbx8F3mG9VFrvezUZEQnV6VU8poNouPmFEexhq393oezRnTDO/p0Ky0Og/
	FRVsZPzngqetCFpCkNIxcWk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dn3mj70FGzRhQT;
	Thu,  8 Jan 2026 20:16:53 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 520062012A;
	Thu,  8 Jan 2026 20:20:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 20:20:09 +0800
Message-ID: <bb8e14f4-dbab-4974-a180-b436a00625d1@huawei.com>
Date: Thu, 8 Jan 2026 20:20:08 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi, Xiang

On 2026/1/7 14:08, Gao Xiang wrote:
> 
> 
> On 2025/12/31 17:01, Hongbo Li wrote:

...

>> +
>> +static int erofs_ishare_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    iput(realfile->f_inode);
>> +    fput(realfile);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>> +                       struct iov_iter *to)
>> +{
>> +    struct file *realfile = iocb->ki_filp->private_data;
>> +    struct kiocb dedup_iocb;
>> +    ssize_t nread;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +
>> +    /* fallback to the original file in DIRECT mode */
>> +    if (iocb->ki_flags & IOCB_DIRECT)
>> +        realfile = iocb->ki_filp;
>> +
>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>> +    nread = filemap_read(&dedup_iocb, to, 0);
>> +    iocb->ki_pos = dedup_iocb.ki_pos;
> 
> I think it will not work for the AIO cases.
> 
> In order to make it simplified, how about just
> allowing sync and non-direct I/O first, and
> defering DIO/AIO support later?
> 

Ok, but what about doing the fallback logic:

1. For direct io: fallback to the original file.
2. For AIO: initialize the sync io by init_sync_kiocb (May be we can 
just replace kiocb_clone with init_sync_kiocb).

Thanks,
Hongbo

>> +    file_accessed(iocb->ki_filp);
> 
> I don't think it's useful in practice.
> 

Just keep in consistent with filemap_read?

> 
>> +    return nread;
>> +}
>> +
>> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    vma_set_file(vma, realfile);
>> +    return generic_file_readonly_mmap(file, vma);
>> +}
>> +

...

>> @@ -649,6 +659,16 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_op = &erofs_sops;
>> +    if (sbi->domain_id &&
>> +        (!sbi->fsid && !test_opt(&sbi->opt, INODE_SHARE))) {
>> +        errorfc(fc, "domain_id should be with fsid or inode_share 
>> option");
>> +        return -EINVAL;
>> +    }
> 
> Is that really needed?
> 

Ok, I will remove it in next version.

Thanks,
Hongbo

> 
> 
>> +    if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, 
>> INODE_SHARE)) {
>> +        errorfc(fc, "dax is not allowed when inode_share is on");
> 
>          errorfc(fc, "FSDAX is not allowed when inode_share is on");
> 
> Thanks,
> Gao Xiang

