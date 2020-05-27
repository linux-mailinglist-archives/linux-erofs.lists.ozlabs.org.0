Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE001E358B
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 04:25:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Wvmj4Sq8zDqNg
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 12:24:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=163.53.93.243;
 helo=sender2-op-o12.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.a=rsa-sha256 header.s=zohomail header.b=O1wVSKL/; 
 dkim-atps=neutral
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn
 [163.53.93.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WvmX5x97zDqMb
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2020 12:24:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1590546258; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=ZnYvOUtYMYLJ+ov1f0ZviO9eq8zJsKGnIbnMCBRqolA0EiupUvUAjP3m4dn429OWuVORt3052ZfXqPJg5L+ioQTgfDdcnl0BXXF4Mv2y48hrNhcP2cKLbB0GdZ+sJCXq45gVS84exa348A84nSu8t41V02d49ugmLeSynq4yz6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1590546258;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=Qu8AaCGtrZ4iLySK2ku0eqD270AMzVoy6bIFwNj1OrQ=; 
 b=btorHssi2RfPG89W5Ru0XzTyR8u4pumrMd1H/90goVbedsc9VYkVE/EEfmxy62yeZnAhOpMlbXgjaAWcLB7XQkA1JDQLABp3E/IfxcZayR3M3hPouaZ81T4B+AG+YX0fT/ioTqCfQGXIXJ2GXIs4lDa9Bjic5arxk+cEx7XW518=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=mykernel.net;
 spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
 dmarc=pass header.from=<cgxu519@mykernel.net>
 header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590546258; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=Qu8AaCGtrZ4iLySK2ku0eqD270AMzVoy6bIFwNj1OrQ=;
 b=O1wVSKL/hC7fRrWALqx+KybSKlw76a6M42KH6j0hlNPI0bbV2+rjXOXsumrsGloS
 2EPqnw95EYvEab8+Cnc5nodxetAo6VLFtBo3IfANAM85Hi1P6DW9HafDq7Q4ErenQm+
 70sf+6/hRCn4oFM3NQO4eGVuMTXTAnYHDbvoysYw=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 1590546255132940.1735964302926;
 Wed, 27 May 2020 10:24:15 +0800 (CST)
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
To: Gao Xiang <hsiangkao@redhat.com>, Chao Yu <yuchao0@huawei.com>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
 <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <451e6933-0465-6863-7972-999bd1cdf61f@huawei.com>
 <20200527021628.GA10771@hsiangkao-HP-ZHAN-66-Pro-G1>
From: cgxu <cgxu519@mykernel.net>
Message-ID: <5d650808-e326-142c-048b-2c574741cd96@mykernel.net>
Date: Wed, 27 May 2020 10:24:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200527021628.GA10771@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 5/27/20 10:16 AM, Gao Xiang wrote:
> On Wed, May 27, 2020 at 09:55:17AM +0800, Chao Yu wrote:
> 
> ...
> 
>>>>
>>>> Originally, we set erofs_listxattr to ->listxattr only
>>>> when the config macro CONFIG_EROFS_FS_XATTR is enabled,
>>>> it means that erofs_listxattr() never returns -EOPNOTSUPP
>>>> in any case, so actually there is no logic change here,
>>>> right?
>>>
>>> Yeah, I agree there is no logic change, so I'm fine with the patch.
>>> But I'm little worry about if return 0 is actually wrong here...
>>>
>>> see the return value at:
>>> http://man7.org/linux/man-pages/man2/listxattr.2.html
>>
>> Yeah, I guess vfs should check that whether lower filesystem has set .listxattr
>> callback function to decide to return that value, something like:
>>
>> static ssize_t
>> ecryptfs_listxattr(struct dentry *dentry, char *list, size_t size)
>> {
>> ...
>> 	if (!d_inode(lower_dentry)->i_op->listxattr) {
>> 		rc = -EOPNOTSUPP;
>> 		goto out;
>> 	}
>> ...
>> 	rc = d_inode(lower_dentry)->i_op->listxattr(lower_dentry, list, size);
>> ...
>> }
> 
> This approach seems better. ;) Let me recheck all of this.
> Maybe we could submit a patch to fsdevel for some further advice...
> 

I agree that doing the check in vfs layer looks tidy and unified.
However, we should be aware this change may break user space tools.


Thanks,
cgxu
