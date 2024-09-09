Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6F971AC3
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 15:21:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2SCY0RBZz2yRD
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 23:21:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725888087;
	cv=none; b=Tc7nkglJTGENC1Kn5TrnuC123n/yCnrLKnxj248LB1v0DL5Ntx2wzaAqMSqLlZ0fQx9r9y8qKhlgzweglgF+KROh30J5Y1R83cQWWxyOqgqcKGLHw82ZE4L1OiBC9nrjMPqWbSn/vdcYJrD3Cbf7vX39McHIArKDHtAE1j8AnX5iRRmFjodH/SsKAlJ8y73/6YVQwal9OannYXWQPCs4ET0dbJIGBdA52TnAlJ2i9sfYhTBxke57itMnKCT0EQ1ToKdzhbjssBVD7LVRb+NbR50iRInv/IR9SM6TP/X5aJYEz07BRO3yq+VZBBLmiif5HiGqg2Eswue+pDerz2yCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725888087; c=relaxed/relaxed;
	bh=xtDKlk++b9rEjm2wZIZSJwpvnA+n9QUFgyYlxTYR+c8=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=U5/SpmEsdiRjNh8m2+HyC5zVkskUJA7LrJwddyt9V2yp6UvI2cBuIOifJ39+VmdgPg4KKA5TPE1hIAOj5I0HA5mYw8jDqp9FFpmYJx4ckcjfCGcpFwV6TTpnZ/iEqnbeeRVfvRKz0uMlNHsuTVVL/WB3UkWY+qHCVrGplgDplIz9LviYBeva+8RUUoigBlWBdOHXakJpeHpbIzDJ7HvGvxZpzeCbDubj2V9rNaa5zn3/3BvZ7RR44u6hkNCQ4HReHXKtGmYYLyHyxN2cnk5TDBuJuDaD2mt6cKlFmkNAc7+oY+3eGOY4dtK5qAxyZf32g4fGRO2fX7o8nh3ABVVH8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vvPVg+GZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vvPVg+GZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2SCT3CP7z2yGD
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 23:21:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725888078; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xtDKlk++b9rEjm2wZIZSJwpvnA+n9QUFgyYlxTYR+c8=;
	b=vvPVg+GZ3IZ4m5Tlb+KEkkRERYHTF2bLlPvNsx1ERAHe1xZj/772RplGBR3bebEqlzcSEKEQ9z/WAdgvAub6wlUX0mzQZZFGDkgcO6erozGxXHWzol4zCRSHf3imGt1LlPuR7le+C/FlzcANe2CUseQzI5dN9JR4mkoU0jaHo6g=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEfKbpz_1725888076)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 21:21:17 +0800
Message-ID: <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
Date: Mon, 9 Sep 2024 21:21:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Colin,

On 2024/9/9 20:48, Colin Walters wrote:
> 
> 
> On Sun, Sep 8, 2024, at 11:19 PM, Gao Xiang wrote:
>> Fast symlink can be used if the on-disk symlink data is stored
>> in the same block as the on-disk inode, so we don’t need to trigger
>> another I/O for symlink data.  However, correctly fs correction could be
>> reported _incorrectly_ if inode xattrs are too large.
>>
>> In fact, these should be valid images although they cannot be handled as
>> fast symlinks.
>>
>> Many thanks to Colin for reporting this!
> 
> Yes, though feel free to also add
> Reported-by: https://honggfuzz.dev/
> or so...not totally sure how to credit it "kernel style" bit honggfuzz very much helped me find this bug (indirectly).

Ok, it sounds good to me.
I will add this later.

> 
> 
> 
>>
>> Reported-by: Colin Walters <walters@verbum.org>
>> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - sent out a wrong version (`m_pofs += vi->xattr_isize` was missed).
>>
>>   fs/erofs/inode.c | 20 ++++++--------------
>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..f2cab9e4f3bc 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode
>> *inode, void *kaddr,
>>   			      unsigned int m_pofs)
>>   {
>>   	struct erofs_inode *vi = EROFS_I(inode);
>> -	unsigned int bsz = i_blocksize(inode);
>> +	loff_t off;
>>   	char *lnk;
>>
>> -	/* if it cannot be handled with fast symlink scheme */
>> -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
>> -	    inode->i_size >= bsz || inode->i_size < 0) {
>> +	m_pofs += vi->xattr_isize;
>> +	/* check if it cannot be handled with fast symlink scheme */
>> +	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
>> +	    check_add_overflow(m_pofs, inode->i_size, &off) ||
>> +	    off > i_blocksize(inode)) {
>>   		inode->i_op = &erofs_symlink_iops;
>>   		return 0;
>>   	}
> 
> This change LGTM.
> 
>> @@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode,
>> void *kaddr,
>>   	if (!lnk)
>>   		return -ENOMEM;
>>
>> -	m_pofs += vi->xattr_isize;
>> -	/* inline symlink data shouldn't cross block boundary */
>> -	if (m_pofs + inode->i_size > bsz) {
> 
> It can cross a boundary but it still can't be *bigger* right? IOW do we still need to check here for inode->i_size > bsz or is that handled by something else generic?

It can be bigger.

Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
(non-fastsymlink cases), but mostly consider this as 4KiB though
regardless of on-disk block sizes.

Thanks,
Gao Xiang



