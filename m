Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E16A685C
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 08:44:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRR8j4tQkz3cR7
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 18:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K9cAlsei;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=K9cAlsei;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRR8Z1tLMz3cK6
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Mar 2023 18:44:45 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo22so912408pjb.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 23:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677656683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyS0C1HTG0tduNh0L7kbfvu/lzkj/LLnrbNqiht2ZzQ=;
        b=K9cAlseifIqk8MiACuzD0FGxhZR1aO2o9ZI8Os17fFA2mqSVr3dKiYJTt/IYZ7fl+u
         ph0RgCHRQsX5j+/PFetqA0UZzNvofS3/Dv1itfS9vNFho8Msr4EOmv5uvqKjH1sJFitg
         Ipq/ff3fRNu/rOEERARAji3c2kKrBUgRcEYBz7Buj0+tkckiZI7xOrVGkcLVAknLO40H
         vCCp4Z3R2BUOda+siG2WGrSE18a9VgvjpH5HfaXJ9eZppUpXcgb1JNeNbkPuxmKYXXhT
         1EFNgd6CjRvv3aO7iChwxCFKN+F5lgSTXXEWRJ1vGeQLQJ9bSx29v/3TXgIrlKhQA3az
         sQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677656683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jyS0C1HTG0tduNh0L7kbfvu/lzkj/LLnrbNqiht2ZzQ=;
        b=NLnzewDknUgYYO5Da117M0pgqr/5li+XW2sbYlx7Sy+WnDqL1icmruCwgOm27aJUoj
         YdbWfR4VnH5PWydNmC/2/tn6HT/rpbXvFiigE1mie6a+Rv7dDTEimpaVfzqULR9p7glz
         FA5KzEFuW6JLX/ctNazJ8cM0w+XBo3U1L99rC0fk3V8tPGkNy1aydmFLkeIRL9CGOGVf
         K9/b64VYM3tuK6/M4wFfObrqKUdRm2e891QaDXZgNJM+HYk1//uL0+jDG/55q5F4Rkni
         dS/TYJjgOQNEWqNS9WyqAtZq7JZVkBjqfyD0CSP3kwuZCr9fRcnCWKJKzgHUF91IZojV
         eEmQ==
X-Gm-Message-State: AO0yUKU94Ubz5nMI6aPVW1la8qMVHwMfRzJ8MmMSr+xPh7lbd7ikA5dZ
	5r014Qg9ielrE0x5w4X5bBKgxQ==
X-Google-Smtp-Source: AK7set/RvUa8pCt4yFC8gzSIzxh9lcNDOWsMuNnBPKvNbcp5EZJSGPNF8q5pVqT9V7lAOUXoxsmxcQ==
X-Received: by 2002:a17:903:2447:b0:19c:c9da:a62e with SMTP id l7-20020a170903244700b0019cc9daa62emr6447929pls.54.1677656683026;
        Tue, 28 Feb 2023 23:44:43 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b0019a6cce2060sm7663725pld.57.2023.02.28.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 23:44:42 -0800 (PST)
Message-ID: <1c8b966e-8208-e9c9-c75b-9ebf2a138059@bytedance.com>
Date: Wed, 1 Mar 2023 15:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Re: [PATCH] erofs: support for mounting a single block device
 with multiple devices
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230301070417.13084-1-zhujia.zj@bytedance.com>
 <c3c10f27-7941-6ccc-fa60-b5a289bf03ba@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <c3c10f27-7941-6ccc-fa60-b5a289bf03ba@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/3/1 15:08, Gao Xiang 写道:
> Hi Jia,
> 
> On 2023/3/1 15:04, Jia Zhu wrote:
>> In order to support mounting multi-layer container image as a block
>> device, add single block device with multiple devices feature for EROFS.
> 
> In order to support mounting multi-blob container image as a single
> flattened block device, add flattened block device feature for EROFS.
> 
Thanks, I would revise it.
>>
>> In this mode, all meta/data contents will be mapped into one block 
>> address.
>> User could directly mount the block device by EROFS.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
>> ---
>>   fs/erofs/data.c  | 8 ++++++--
>>   fs/erofs/super.c | 5 +++++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index e16545849ea7..870b1f7fe1d4 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -195,9 +195,9 @@ int erofs_map_dev(struct super_block *sb, struct 
>> erofs_map_dev *map)
>>   {
>>       struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
>>       struct erofs_device_info *dif;
>> +    bool flatdev = !!sb->s_bdev;
> 
> I'd like to land it in sbi and set it in advance?
> 
I'll revise that in next version.
> Also, did you test this patch?

I've tested the patch using the following steps mentioned by
https://github.com/dragonflyoss/image-service/pull/1111

1. Compose a (nbd)block device from an EROFS image.
2. mount -t erofs /dev/nbdx /mnt/
3. compare the md5sum between source dir and /mnt dir.

> 
> Thanks,
> Gao Xiang
> 
> 
>>       int id;
>> -    /* primary device by default */
>>       map->m_bdev = sb->s_bdev;
>>       map->m_daxdev = EROFS_SB(sb)->dax_dev;
>>       map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
>> @@ -210,12 +210,16 @@ int erofs_map_dev(struct super_block *sb, struct 
>> erofs_map_dev *map)
>>               up_read(&devs->rwsem);
>>               return -ENODEV;
>>           }
>> +        if (flatdev) {
>> +            map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
>> +            map->m_deviceid = 0;
>> +        }
>>           map->m_bdev = dif->bdev;
>>           map->m_daxdev = dif->dax_dev;
>>           map->m_dax_part_off = dif->dax_part_off;
>>           map->m_fscache = dif->fscache;
>>           up_read(&devs->rwsem);
>> -    } else if (devs->extra_devices) {
>> +    } else if (devs->extra_devices && !flatdev) {
>>           down_read(&devs->rwsem);
>>           idr_for_each_entry(&devs->tree, dif, id) {
>>               erofs_off_t startoff, length;
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 19b1ae79cec4..4f9725b0950c 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -226,6 +226,7 @@ static int erofs_init_device(struct erofs_buf 
>> *buf, struct super_block *sb,
>>       struct erofs_fscache *fscache;
>>       struct erofs_deviceslot *dis;
>>       struct block_device *bdev;
>> +    bool flatdev = !!sb->s_bdev;
>>       void *ptr;
>>       ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
>> @@ -248,6 +249,10 @@ static int erofs_init_device(struct erofs_buf 
>> *buf, struct super_block *sb,
>>           if (IS_ERR(fscache))
>>               return PTR_ERR(fscache);
>>           dif->fscache = fscache;
>> +    } else if (flatdev) {
>> +        dif->bdev = sb->s_bdev;
>> +        dif->dax_dev = EROFS_SB(sb)->dax_dev;
>> +        dif->dax_part_off = sbi->dax_part_off;
>>       } else {
>>           bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
>>                         sb->s_type);
