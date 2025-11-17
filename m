Return-Path: <linux-erofs+bounces-1382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C07C6239E
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 04:14:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8tC96MHPz2yFy;
	Mon, 17 Nov 2025 14:14:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763349285;
	cv=none; b=TmXanpv6UIrJe5OMxtdoQQzP/izWHT9SYKE6G/GMNQVxAK9Ga7AHcV8HFeV3ONsl5SX3NIJaBxyN1kxJIJgkTMlizaSdEhZtuivsVTsnkz3l0RIdat/e1eGOw64EtqCFaTPSj5DoRlXXQCt3whR1GuRMybb4jCwyy/MpcstG3ncq8paL/wDvDyoH+e08VdmU8LbH42+3sjRXdZY6/EZF9vZMwDne7ARhEWwoZPU8xr2sn3LkQ7yKrVVorO7LANJIQiJKEGYMcBmpp9YkQRztwYJXb/kUa53IOB3Wh7U0gbrYRTAwXZyCuVZfRuZuFCET52Vh4v8qUt+K/KMb3tuUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763349285; c=relaxed/relaxed;
	bh=wMsfYhg1aXUFUvFTMjtwy0+CEgBFMsKcyL7EqjPIMn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KZsWGULjgUaoJLdtnUxj/mP1K9PlR+BBICGHUTBW3OiFXmlL04f37zu48hd52HOR/QWx8KicTB/2GnRc3EuTvY2ec/sXvDp0AyPcnmC/8NKA0P5cW4t9YRAKaD5PXIMAij2s3nb4A+z6y6OtN9wqnZK/1pqXP9ZWLiAIcs1sOPg0gVtSKtHrPYsSQM7TB3JitmJpBeqG6hJ4BDoS0KUaJ4e/V3GOwKaQaIqqoe2ts0j0d/kJ0scJz7mNssig8fNzhaNfZMcrfofsdjQmyTNgvww5XXhvIQ6gTfwA1qeEE0wQOZV36SOh6EcjaMXJac2m77shi+5RyqjXF3J8hhPp4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Op/bC3jP; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Op/bC3jP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8tC649Xgz2xS2
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 14:14:41 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wMsfYhg1aXUFUvFTMjtwy0+CEgBFMsKcyL7EqjPIMn8=;
	b=Op/bC3jPoNFVhV7JcxfgkaayLtrVj11xdxW4DZ7YIt9sApGFESOuOy+jNvbz6/oCyy4zohP2f
	BNuDKWRvF3jxrXfs2MmY0sKE7T+pot228856tnZE9cEcBrqjFd8hRq31tDfCnpNR/TT2BoWmK6B
	o5QgkUBawdC9yx/4h/B5qXg=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d8t9H1fwsz1T4GD;
	Mon, 17 Nov 2025 11:13:07 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 26A7818046E;
	Mon, 17 Nov 2025 11:14:37 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 11:14:36 +0800
Message-ID: <cb040afb-a025-4dbb-9866-4772b24a3b8e@huawei.com>
Date: Mon, 17 Nov 2025 11:14:35 +0800
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
Subject: Re: [PATCH v8 6/9] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-7-lihongbo22@huawei.com>
 <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ac1b5431-e71f-430d-8309-8d007dc449b9@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang

On 2025/11/17 11:06, Gao Xiang wrote:
> 
> 
> On 2025/11/14 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
> 
> ...
> 
> 
>> +
>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile;
>> +    struct inode *dedup;
>> +
>> +    dedup = EROFS_I(inode)->ishare;
>> +    if (!dedup)
>> +        return -EINVAL;
>> +
>> +    realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, 
>> "erofs_ishare_file",
>> +                     O_RDONLY, &erofs_file_fops);
>> +    if (IS_ERR(realfile))
>> +        return PTR_ERR(realfile);
>> +
>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>> +    realfile->private_data = EROFS_I(inode);
>> +    file->private_data = realfile;
>> +    return 0;
> 

My apologies, I got it wrong. The latest code wasn't synced. The most 
current version should be this one.

static int erofs_ishare_file_open(struct inode *inode, struct file *file)
{
	struct file *realfile;
	struct inode *dedup;
	char *buf, *filepath;

	dedup = EROFS_I(inode)->ishare;
	if (!dedup)
		return -EINVAL;

	buf = kmalloc(PATH_MAX, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;
	filepath = file_path(file, buf, PATH_MAX);
	if (IS_ERR(filepath)) {
		kfree(buf);
		return -PTR_ERR(filepath);
	}
	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, filepath + 1,
				     O_RDONLY, &erofs_file_fops);
	kfree(buf);
	if (IS_ERR(realfile))
		return PTR_ERR(realfile);

	file_ra_state_init(&realfile->f_ra, file->f_mapping);
	ihold(dedup);
	realfile->private_data = EROFS_I(inode);
	file->private_data = realfile;
	return 0;
}

I changed the "erofs_ishare_file" with filepath + 1 to display the 
realpath of the original file.

Thanks,
Hongbo

> Again, as Amir mentioned before, it should be converted to use (at least)
> some of backing file interfaces, please see:
>    file_user_path() and file_user_inode() in include/linux/fs.h
> 
> Or are you sure /proc/<pid>/maps is shown as expected?
> 
> Thanks,
> Gao Xiang

