Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B194E53D
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 04:51:04 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgWZ4NbA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WhzY20kXWz2yGC
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 12:51:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgWZ4NbA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WhzXx2swLz2xTj
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Aug 2024 12:50:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723431051; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EEPLK9GLy1kjJhI/SAL0q7HAqC2YEO4ky44VhWTi5pA=;
	b=pgWZ4NbAy7fuRTgC/bav9jbnrDz/WUKKQT9qOF1z4hS7MFniEDGHcRjMzIBnLF8ld0xZYhcLOQ5r9p+6uYaJhwfORVMlvQp3tbSoSt4BjMHS8I9sZQdI/enF+JR7Kglv6rZbpQj+rt64K+RCe4XOnAgZXsEYHHnPj/lC7iHjnNM=
Received: from 30.221.133.68(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCWetqT_1723430993)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 10:50:50 +0800
Message-ID: <573368d1-caf0-4ab0-a7b2-6d51b956b8da@linux.alibaba.com>
Date: Mon, 12 Aug 2024 10:50:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: add support for symlink file in
 erofs_ilookup()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
 <561ee8da-92b8-424f-ba28-bbd5614d77b7@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <561ee8da-92b8-424f-ba28-bbd5614d77b7@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/8/12 10:24, Gao Xiang wrote:
>
>
> On 2024/8/11 16:09, Hongzhen Luo wrote:
>> When the `path` contains symbolic links, erofs_ilookup() does not
>> function properly. This adds support for symlink files.
>
> Can you explain what's the use cases of this patch?
>
> It seems both erofsfuse and fsck.erofs --extract don't need this.
>
Some third-party applications (such as Alibaba DADI) require obtaining 
block mapping information of files based on their paths using liberofs. 
When file paths include symbolic links, the current erofs_ilookup() 
function fails to correctly locate the inode. This submission enhances 
erofs_ilookup()'s support for symbolic link files.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   lib/namei.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/namei.c b/lib/namei.c
>> index 6f35ee6..dce2991 100644
>> --- a/lib/namei.c
>> +++ b/lib/namei.c
>> @@ -195,6 +195,22 @@ struct nameidata {
>>       unsigned int    ftype;
>>   };
>>   +static int link_path_walk(const char *name, struct nameidata *nd);
>> +
>> +static int step_into_link(struct nameidata *nd, struct erofs_inode *vi)
>> +{
>> +    char buf[EROFS_MAX_BLOCK_SIZE];
>> +    int err;
>> +
>> +    if (vi->i_size > EROFS_MAX_BLOCK_SIZE)
>> +        return -EINVAL;
>
> No, symlink size is independent to EROFS_MAX_BLOCK_SIZE, currently
> it's hard-code as 4096.
>
Okay, I will make the corresponding modifications in the next version.
>> +    memset(buf, 0, sizeof(buf));
>> +    err = erofs_pread(vi, buf, vi->i_size, 0);
>> +    if (err)
>> +        return err;
>> +    return link_path_walk(buf, nd);
>> +}
>> +
>>   int erofs_namei(struct nameidata *nd, const char *name, unsigned 
>> int len)
>>   {
>>       erofs_nid_t nid = nd->nid;
>> @@ -233,6 +249,11 @@ int erofs_namei(struct nameidata *nd, const char 
>> *name, unsigned int len)
>>               return PTR_ERR(de);
>>             if (de) {
>> +            vi.nid = de->nid;
>> +            ret = erofs_read_inode_from_disk(&vi);
>> +            if (S_ISLNK(vi.i_mode)) {
>> +                return step_into_link(nd, &vi);
>> +            }
>
> Why need brace here?

Yes, the braces are not necessary, and I will clean them up later.

>
> Thanks,
> Gao Xiang

---

Thanks,

Hongzhen Luo

