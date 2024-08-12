Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA394E55D
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 05:04:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lWRyOB57;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Whzr65t8xz2yFQ
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Aug 2024 13:04:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lWRyOB57;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Whzr10rX3z2xTj
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Aug 2024 13:03:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723431834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tEWqNgGXclGGgpn8qBYjJAls43HIg5NyTNbUPtjLkno=;
	b=lWRyOB57hKnd9ydqPtdH2ev+nAB8JZ6xuDsPt/n4t4WbwxHR5CzWcrWoOWgpfGIsRtbD0pVdSaNDuvjAlY6+LYpoSiSc/6z6FOpVS2C2eQQ5UOw2kzcDu4DbE3NL3vtBNMAX1ob3Oy1EDXwiYNZBfIm3axg/N9yr7qWnXtwqUXc=
Received: from 30.97.48.226(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCWyJTc_1723431831)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 11:03:52 +0800
Message-ID: <2b831007-f633-439c-b8a1-287b6658c6bf@linux.alibaba.com>
Date: Mon, 12 Aug 2024 11:03:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: add support for symlink file in
 erofs_ilookup()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240811080957.2179279-1-hongzhen@linux.alibaba.com>
 <561ee8da-92b8-424f-ba28-bbd5614d77b7@linux.alibaba.com>
 <573368d1-caf0-4ab0-a7b2-6d51b956b8da@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <573368d1-caf0-4ab0-a7b2-6d51b956b8da@linux.alibaba.com>
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



On 2024/8/12 10:50, Hongzhen Luo wrote:
> 
> On 2024/8/12 10:24, Gao Xiang wrote:
>>
>>
>> On 2024/8/11 16:09, Hongzhen Luo wrote:
>>> When the `path` contains symbolic links, erofs_ilookup() does not
>>> function properly. This adds support for symlink files.
>>
>> Can you explain what's the use cases of this patch?
>>
>> It seems both erofsfuse and fsck.erofs --extract don't need this.
>>
> Some third-party applications (such as Alibaba DADI) require obtaining block mapping information of files based on their paths using liberofs. When file paths include symbolic links, the current erofs_ilookup() function fails to correctly locate the inode. This submission enhances erofs_ilookup()'s support for symbolic link files.

Why it cannot be implemented in the application itself?
Following block mapping and obtain the symlinked file block
mapping is weird for erofs itself to resolve.

Thanks,
Gao Xiang
