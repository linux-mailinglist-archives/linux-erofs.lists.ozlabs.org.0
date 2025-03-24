Return-Path: <linux-erofs+bounces-121-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73700A6D3C0
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Mar 2025 06:38:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLhgL0KN5z2yVb;
	Mon, 24 Mar 2025 16:38:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742794733;
	cv=none; b=HmYfaQ3GcQJOprw0qbYBIQy7IOlR94RvdZSMTv8mnhTPs8S4+pIVZIYBl8hsR/l0QI+VokCWc1eQhAFTzjDwntKCikkWLi9Xvz12FK5qlYsiNZMvq1esXpxbDXB6ApDKO0xLfHhkDPDonC0hLRvGHo12QRoe+u3aK9iqjLzhpwltC3YwXCBzEzlxphzjeVXGp8b7iqkZklZa3PhOwajcZPdyqTco42MpCE3ISoOYdVW1R/SVZM6ZP7L/hnFltUAqAvuNsGnkwqBOLeZ/xtj/OX3i2msXLZ0qVOpcIuHbzH0ZK2TPO9HPxrGL2bYVwxcYwtC6p99BCbZd32SaN9P4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742794733; c=relaxed/relaxed;
	bh=FDMrLqm53KFAhLOC56lZhEDhwBrZGA04d5nSbAkLOkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fl5x+7ay2yZzuCkAamwZ8J8wehPIm9Pv8rYuOz/Ti+52LMq4TxZqiqEjOwoqy5MktA9na4YsC82f7OVX5WtxFE8Zv2UXcKWaP22iET40hL1Nyrvxk68ZntpRNRueTYIrn1mlwT0ILHOAq70yJqbegsnfjvB1Y6yt3PI2CLWAYgwXgDvjpmKbdNkk8up4rlz4zvUZ9JK6K0hc9X0jeush1fN6DHHsYSsQ8A6tPTgIcXllYcvbZxFYB8g6YMjeNRieiFlYYDN7SftAWUrK3BheJEDTY1x94TI68dLIoliKh+FgGbwjQtmSwdhvpuUJ3elQdWfgCc2AN7D+aXjwwFnD+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IQnzcmN9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IQnzcmN9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZLhgH6fydz2yRd
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Mar 2025 16:38:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742794726; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FDMrLqm53KFAhLOC56lZhEDhwBrZGA04d5nSbAkLOkE=;
	b=IQnzcmN9YSwBADR+RctGdgVCa+tiAB2fXhuQhpfmFox8IRSIp/UeOD/plm5Zgt5K78BX/H5IajTsRT/p2QkyQjiBUG1TIRW36QIKzY08NrW9ppa0fiGsrFf4g4kSowRu0NWBH5xOTpCjGSi1Rjz04ERMYfmk0hwV9OQ6JBHtVTE=
Received: from 30.221.129.81(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WSVM5yc_1742794713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Mar 2025 13:38:44 +0800
Message-ID: <44791273-5a2c-4088-9237-8d8eda28f8aa@linux.alibaba.com>
Date: Mon, 24 Mar 2025 13:38:29 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/7] erofs: support domain-specific page cache
 share
To: linux-erofs@lists.ozlabs.org
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
 <20250301145002.2420830-4-hongzhen@linux.alibaba.com>
 <b9fccfab-77bc-4a77-b480-e8da1995e520@huawei.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b9fccfab-77bc-4a77-b480-e8da1995e520@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/3/22 09:22, Hongbo Li wrote:
>
>
> On 2025/3/1 22:49, Hongzhen Luo wrote:
>> Only files in the same domain will share the page cache. Also modify
>> the sysfs related content in preparation for the upcoming page cache
>> share feature.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fs/erofs/super.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 6af02cc8b8c6..ceab0c29b061 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -489,6 +489,8 @@ static int erofs_fc_parse_param(struct fs_context 
>> *fc,
>>           if (!sbi->fsid)
>>               return -ENOMEM;
>>           break;
>> +#endif
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || 
>> defined(CONFIG_EROFS_FS_INODE_SHARE)
>>       case Opt_domain_id:
>>           kfree(sbi->domain_id);
>>           sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
>> @@ -558,16 +560,16 @@ static void erofs_set_sysfs_name(struct 
>> super_block *sb)
>>   {
>>       struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   -    if (sbi->domain_id)
>> +    if (sbi->domain_id && !sbi->ishare_key)
>>           super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
>>                            sbi->fsid);
>>       else if (sbi->fsid)
>>           super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
>> -    else if (erofs_is_fileio_mode(sbi))
> I think there is no need to change this, because the inode page cache 
> is just a mode for reading, not like a super block type.

Apologies for the late reply, I've been occupied with other tasks recently.

Yeah, let me take a look and I'll make changes afterward.

Thanks,

Hongzhen

>> +    else if (!sb->s_bdi || !sb->s_bdi->dev)
>> +        super_set_sysfs_name_id(sb);
>> +    else
>>           super_set_sysfs_name_generic(sb, "%s",
>>                            bdi_dev_name(sb->s_bdi));
>> -    else
>> -        super_set_sysfs_name_id(sb);
>>   }
>>     static int erofs_fc_fill_super(struct super_block *sb, struct 
>> fs_context *fc)
>> @@ -965,6 +967,8 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>       if (sbi->fsid)
>>           seq_printf(seq, ",fsid=%s", sbi->fsid);
>> +#endif
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND) || 
>> defined(CONFIG_EROFS_FS_INODE_SHARE)
>>       if (sbi->domain_id)
>>           seq_printf(seq, ",domain_id=%s", sbi->domain_id);
>>   #endif

