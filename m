Return-Path: <linux-erofs+bounces-1429-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA6C7ECD9
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 03:12:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dF8VQ0h0Jz2yvN;
	Mon, 24 Nov 2025 13:12:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763950366;
	cv=none; b=hKbjujiqlGJTCeJZar7f7/HEkqycuHEyooT3Kb3p/E+qJbSFVw1gVjwtP/TSVensxl2/lCxOrMDMuyX5Sbk8LgFPyADeO0Maiz/Q6jdkqyoTLxsVQoB51RvakqBQa6sljKWRnHxFIFhVAp0QiI8ZPTglJjmPGm8pS4wDTn+5bFgLGtQUAPUVJunf5JwCAnhDNUqw7ddqGsGOLoZM1rWXnx/WDO9yObjbf2SE+7g3OH9e9Yjff9PdQnej/s9jJCLUx76wev9SXO6b+EZgGdfg499YRlOWZTLLrsydegyreZKSs/+8aD1eA/C/s10nE6361Ci6QbFsDE+G8zIZ44XroA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763950366; c=relaxed/relaxed;
	bh=qaEe4P+NeZq5F6dQfgixkx26QzD0xNJvljj20rsl5B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aJf57hFlBXwBi0ZfEZOdRFjyd+4upMu22SLmFV09nwFl78yAsrTm0Q9pl4UbIBpiDjoFdUEWmsH3Q4w0YbieGfQChqGdXWP2OFz6pbcAOX7edTNMG4t1fVX6+JiPu4SWpSbfOCAUhhuVv5HBabPq3nUwG4L1QS4xiXd4z1UyKTQC9uWdxC4nAxd+1WdeSHDkHus4q5ytogoATsUmV/aDMWUxSDsLDRsO0IiIHgDDKtkAQJNbA7XTOXUEovG8Rmc5H02PkvP+sU6pXPk4SGfbwpBBh/HI1yieS+asuZQYCpCqo+GyRQOMTaj4grF9hf693boVwGEJ03ISW/VAZ+DDQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HcJkQ+ei; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HcJkQ+ei;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dF8VM6pPcz2yvB
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 13:12:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763950356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qaEe4P+NeZq5F6dQfgixkx26QzD0xNJvljj20rsl5B4=;
	b=HcJkQ+ei1qHdnBG7gV1latjYeKtNTuSJL1zlV+Tb5x2dDoa0TKHYMsHcpbDS7d4X7oct+WAu3NWjFHNJCBL4TyxtAM7+rtifst0f7stu3Xh0TE6I7LRdWGyLv0Uo4WekEdFw/A0d6laSeHSB3d7xIpqzXIoCMs1VT2+kX57O/BM=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt9f2KY_1763950354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Nov 2025 10:12:35 +0800
Message-ID: <d9bb6036-c7b5-4fd9-b4e5-73cc64b76578@linux.alibaba.com>
Date: Mon, 24 Nov 2025 10:12:33 +0800
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
Subject: Re: [PATCH v2] erofs: limit the level of fs stacking for file-backed
 mounts
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
 <20251122062332.1408580-1-hsiangkao@linux.alibaba.com>
 <058b9c29-6e07-4661-8b83-b05d8762b524@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <058b9c29-6e07-4661-8b83-b05d8762b524@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/24 10:03, Hongbo Li wrote:
> Hi Xiang,
> 
> On 2025/11/22 14:23, Gao Xiang wrote:
>> Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
>> mounting itself).
>>
>> Reviewed-by: Sheng Yong <shengyong1@xiaomi.com>
>> Fixes: fb176750266a ("erofs: add file-backed mount support")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Change since v1:
>>   - Return -ENOTBLK instead of -EINVAL since userspace tools like
>>     util-linux will fall back to using loop to mount again.
>>
>>     Don't use -ELOOP compared to other stacked fses, since -ENOTBLK is
>>     more suitable: it means the kernel can't handle it anymore.
>>
>>   fs/erofs/super.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index f3f8d8c066e4..2db534f76464 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -639,6 +639,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>       sbi->blkszbits = PAGE_SHIFT;
>>       if (!sb->s_bdev) {
>> +        /*
>> +         * (File-backed mounts) EROFS claims it's safe to nest other
>> +         * fs contexts (including its own) due to self-controlled RO
>> +         * accesses/contexts and no side-effect changes that need to
>> +         * context save & restore so it can reuse the current thread
>> +         * context.  However, it still needs to bump `s_stack_depth` to
>> +         * avoid kernel stack overflow from nested filesystems.
>> +         */
>> +        if (erofs_is_fileio_mode(sbi)) {
>> +            sb->s_stack_depth =
>> +                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
>> +            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>> +                erofs_err(sb, "maximum fs stacking depth exceeded");
> 
> Since it will success once the max stack depth is exceeded, a warning would be better? Otherwise it looks good me.

But that is not a kernel fallback, and the kernel mount already fails,
I think erroring out is more proper.

Thanks,
Gao Xiang

> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Thanks,
> Hongbo
> 
>> +                return -ENOTBLK;
>> +            }
>> +        }
>>           sb->s_blocksize = PAGE_SIZE;
>>           sb->s_blocksize_bits = PAGE_SHIFT;


