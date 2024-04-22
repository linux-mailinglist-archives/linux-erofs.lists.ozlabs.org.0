Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB028ACC2D
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 13:40:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dTD5s2w2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNNbF1fxnz3cgf
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 21:40:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dTD5s2w2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNNb81g4Jz3cTp
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 21:40:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713785999; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S7SoECJTVFW/s3jcVtwRCqtgqjwR+nyvH9E4BtCL//g=;
	b=dTD5s2w2a9TuJC6myaWTTHm2gGqzuMByE5dBsGQpNjkzdsEfDjznh9gnhPU7W1/XsX//h3WnG3tZkWr8LlXboM/ImUc7VQMSopnpXvrlA2RcI99UUHrWaIu3RNDN864rczZf6JEIrsFd5zBUWBhda4eXEGFWFwY+X0ROoX0ZwsA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W534KMu_1713785996;
Received: from 30.221.150.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W534KMu_1713785996)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 19:39:58 +0800
Message-ID: <2a7edcc0-6890-412d-b2ba-8bfa8694beeb@linux.alibaba.com>
Date: Mon, 22 Apr 2024 19:39:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
 <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
 <4e8dd4f5-29dc-9459-6ba2-f399258952dc@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <4e8dd4f5-29dc-9459-6ba2-f399258952dc@huawei.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/22/24 7:31 PM, Baokun Li wrote:
> Hi Jingbo,
> 
> On 2024/4/22 18:25, Jingbo Xu wrote:
>>
>> On 4/19/24 8:36 PM, Baokun Li wrote:
>>
>>> @@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct
>>> erofs_dev_context *devs)
>>>     static void erofs_fc_free(struct fs_context *fc)
>>>   {
>>> -    struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = fc->s_fs_info;
>>> +
>>> +    if (!sbi)
>>> +        return;
>>
>> This is the only difference comparing to the original code literally.
>> Is there any chance that fc->s_fs_info can be NULL when erofs_fc_free()
>> is called?
>>
>> Otherwise looks good to me.
>>
> When sget_fc() executes successfully, fc->s_fs_info is set to NULL,
> so the following NULL pointer dereference may occur:
> 
> do_new_mount
>   vfs_get_tree
>     erofs_fc_get_tree
>       get_tree_bdev
>         sget_dev
>           sget_fc
>             s = alloc_super
>             s->s_fs_info = fc->s_fs_info;
>             fc->s_fs_info = NULL;
>         fill_super
>         // return error
>         deactivate_locked_super
>           kfree(sbi);
>   put_fs_context
>     sbi = fc->s_fs_info
>     kfree(sbi->fsid)
> 

Alright, fc->s_fs_info is transferred to s->s_fs_info and set to NULL.

Feel free to add:

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
