Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A4C94E581
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 05:14:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CxZiSxTo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wj04T2xl8z2yGC
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 13:14:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CxZiSxTo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wj04M4HHGz2xcX
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Aug 2024 13:14:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723432477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V//ud6/Ri3ECq1P3wD1a+WTcvEvQ3h5qu0OcnlOJsCY=;
	b=CxZiSxToCeRtGVBAFW/n9TbFNMNXH5pTHxpakUJklX3duibQTTk08tx0Cd01XfYQQwwBM3x9fYjgeb6PKlAjEhqPtWrPW9QSFmsxXCC5EixbFohuPPgE4KExds4fS6WhoVM2Y7j3NlUwWrE0pLvWSf9PHqpn2fw6i5/6XVxnds0=
Received: from 30.221.133.68(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCXNttc_1723432475)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 11:14:36 +0800
Message-ID: <19da3c76-b44f-4377-a653-e3e9d76966de@linux.alibaba.com>
Date: Mon, 12 Aug 2024 11:14:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: add support for symlink file in
 erofs_ilookup()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
 <561ee8da-92b8-424f-ba28-bbd5614d77b7@linux.alibaba.com>
 <573368d1-caf0-4ab0-a7b2-6d51b956b8da@linux.alibaba.com>
 <2b831007-f633-439c-b8a1-287b6658c6bf@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <2b831007-f633-439c-b8a1-287b6658c6bf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2024/8/12 11:03, Gao Xiang wrote:
>
>
> On 2024/8/12 10:50, Hongzhen Luo wrote:
>>
>> On 2024/8/12 10:24, Gao Xiang wrote:
>>>
>>>
>>> On 2024/8/11 16:09, Hongzhen Luo wrote:
>>>> When the `path` contains symbolic links, erofs_ilookup() does not
>>>> function properly. This adds support for symlink files.
>>>
>>> Can you explain what's the use cases of this patch?
>>>
>>> It seems both erofsfuse and fsck.erofs --extract don't need this.
>>>
>> Some third-party applications (such as Alibaba DADI) require 
>> obtaining block mapping information of files based on their paths 
>> using liberofs. When file paths include symbolic links, the current 
>> erofs_ilookup() function fails to correctly locate the inode. This 
>> submission enhances erofs_ilookup()'s support for symbolic link files.
>
> Why it cannot be implemented in the application itself?
> Following block mapping and obtain the symlinked file block
> mapping is weird for erofs itself to resolve.
>
> Thanks,
> Gao Xiang

That makes sense. Thanks for pointing it out, and please disregard this 
patch.

---

Thanks,

Hongzhen Luo

