Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B049C9DA4E6
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 10:37:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyvW00CkXz2ysd
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 20:37:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732700266;
	cv=none; b=odhzCfVrSnYJnzj57B0v8AK3bMFXFBAYeAZW77pjnhxIIYuTnP4Bow16BlMLvYyxIHk94uuur8cS2YNfBfB13tWkl8x02r1hxaXSkCo2TbnOru70Dl8glorv2lQNJTxMaUyXtq1KD8m2XnxvIKRSvm6PGd+T2P7kv8yIjeXrGusaIxNsqeEvugE/HnrPgy5MnzhNRKXyz6g4ptsZaVc5bMWyZ0/eMrUSH7hnutQpb0Ota0gVP06lzffZiOoUyglu9MVMUy1tT54d9r+ToBTVH8/HLCOZXU1Zp+XCq0+unp9foo05zoLCRpdRUPQwfhjc8+g099u0T1voXhOkmJHw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732700266; c=relaxed/relaxed;
	bh=nG4fzIQ5T3scukB+pCFL6C1E6SQa80CooWxsJZK9Ojs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TZeqp4XbstZgsz2t6jPKSNuI5x+RClEoMQ94n+1GqHXdpKI31Hi1CkWIcNx6+RL7bt+a9HUSV6pTVbSXql4FOeAlsm05UOJ/kfv1MPU3Xhocb/4c18/zRXif4ABzueNHX1w6vLFpQ0RA6IZoOJDTKD0ZpopKLGd2GWrBKDs2erDzXZfdR4qT9RfriFXiBDIe/GA1/+ldgLAk5My2DBIvx60D/ePBgP4lsJ10aq2WhVnR25eWaKBNWM/lO4/x9F+1jYmrvVUSEsR9qYuzO+8RHiQ/bxsXpGaRgcNuV0dhYKLG0CKuGwFOq4X6vrzbBYPJQhNwYxkfWsa/2r4kqcYwIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YjpER5yu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YjpER5yu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XyvVs6gDRz2xt7
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 20:37:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732700254; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nG4fzIQ5T3scukB+pCFL6C1E6SQa80CooWxsJZK9Ojs=;
	b=YjpER5yuvqTxPK3eBC93UIvj+x+tWIyla0WzJMoXn0/Gp5hf1DviyY8b2U3PRfsZfgjnqTxlmtF0NJ098eQlOO6SSJS47N+ok4GE0JWttbVa0GgMgLo0zeQCXzaZgcuyrcDn9K8bHuvunHL2xxPwEvgpYb9GJWwmPYX8+KIElk8=
Received: from 30.221.131.189(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WKM1fI5_1732700243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:37:33 +0800
Message-ID: <a4e268ef-c97e-4644-922a-111e06cda681@linux.alibaba.com>
Date: Wed, 27 Nov 2024 17:37:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: rebuild: set the appropriate `dev` field
 for dirs
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241127092856.4106149-1-hongzhen@linux.alibaba.com>
 <20241127092856.4106149-2-hongzhen@linux.alibaba.com>
 <6b6beaf3-f6c4-4580-82b6-017b92c8e2af@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <6b6beaf3-f6c4-4580-82b6-017b92c8e2af@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/11/27 17:31, Gao Xiang wrote:
>
>
> On 2024/11/27 17:28, Hongzhen Luo wrote:
>> Currently, setting a default `dev` value (i.e., 0) for directories
>> during parsing tar files can lead to the following error:
>>
>> <E> erofs: bogus i_mode (0) @ nid 0
>> <E> erofs: failed to read inode @ 0
>>
>> Consider the following incremental build scenario, where the path
>> "dir1/dir2" is currently being parsed in tarerofs_parse_tar() and
>> the directory "dir1" has never appeared before. 
>> erofs_rebuild_get_dentry()
>> will call erofs_rebuild_mkdir() to allocate a new inode for "dir1",
>> with its `dev` field set to 0 by default.
>>
>> During the dump tree phase, since `dir1->dev` matches `sbi->dev` 
>> (both are 0),
>> erofs_rebuild_load_basedir() will be called to read the contents of 
>> directory
>> "dir1" from the disk. However, since there is no information for the 
>> new directory
>> "dir1" on the disk, the above error occurs.
>>
>> This patch resolves the above issue by setting the appropriate value
>> for the directory's `dev` field during the tar file parsing phase.
>>
>> Fixes: f64d9d02576b ("erofs-utils: introduce incremental builds")
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   include/erofs/rebuild.h | 1 +
>>   lib/rebuild.c           | 7 +++++--
>>   lib/tar.c               | 2 ++
>>   3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
>> index b37bc80e8a3c..b71cfdf1fff4 100644
>> --- a/include/erofs/rebuild.h
>> +++ b/include/erofs/rebuild.h
>> @@ -22,6 +22,7 @@ struct erofs_rebuild_getdentry_ctx {
>>       bool *whout;
>>       bool *opq;
>>       bool to_head;
>> +    int dev;
>>   };
>>     struct erofs_dentry *erofs_rebuild_get_dentry(struct 
>> erofs_rebuild_getdentry_ctx *ctx);
>> diff --git a/lib/rebuild.c b/lib/rebuild.c
>> index 58f1701b3721..3fcb5c92b562 100644
>> --- a/lib/rebuild.c
>> +++ b/lib/rebuild.c
>> @@ -27,7 +27,7 @@
>>   #endif
>>     static struct erofs_dentry *erofs_rebuild_mkdir(struct 
>> erofs_inode *dir,
>> -                        const char *s)
>> +                        const char *s, int dev)
>>   {
>>       struct erofs_inode *inode;
>>       struct erofs_dentry *d;
>> @@ -47,6 +47,7 @@ static struct erofs_dentry 
>> *erofs_rebuild_mkdir(struct erofs_inode *dir,
>>       inode->i_gid = getgid();
>>       inode->i_mtime = inode->sbi->build_time;
>>       inode->i_mtime_nsec = inode->sbi->build_time_nsec;
>> +    inode->dev = dev;
>
> Why not just use inode->dir->dev?
>
> Thanks,
> Gao Xiang

Yes, I didn't see that; this makes it much simpler. I'll give it a try 
and send another version of the patch later.

---

Thanks,

Hongzhen Luo

