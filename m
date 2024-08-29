Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B7E9637EC
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 03:43:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvPFZ3bDvz2ypx
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 11:43:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724895823;
	cv=none; b=lhvjDSzj3MR/KZrpgSu3vmw/yp44x9V54aM1D0lKCg8AJH0uecHBQ5vs+z29dZl4yJ2ciLQYEm1DScVz3rDCx92KHxDfhvu5R7uV9PytqtQgV3hmWQY5yoRa1fvVfEhWG7W2vl7/A59s0uRSI1Ic/afPr75inRHsIZfOOkrwEswL1i+Um5Q36ixM6stWXS94VArQAnabFeVr7gUeOW9TKv7c2PF2HHCgVlE0G9ha/UoLs5g2gWu6mQJifeQe+Pddz9CTZWW61ob8I8QDvnZOOYTCDId5J/dm2plkQYnxesh+8NGW0qRtmYznDU4S+RyvSSfGJAr6YCuslhltIqFbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724895823; c=relaxed/relaxed;
	bh=13FW3FFsyZcmYCaM9j3DtMhT0e5P6uK0Ttk2a2OjxDk=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=L1y3S6Gdi6J3UU7eiodSUpiJ0IJWMhP6ZAgkV2u+Zo4rnzJDMF6ktgd26kL4TsYj8SaFYAZYNp0AWm8eKGaCvjwzqeWYvjmMn2Dxa942e22R8PwLA8p+jdo50msONxya/YNShg64g0Bb/fiZcstNT3+85izKr7ERDNLzeJ8y/kJfuEuxB+7MziiZZqLM+jvP2LsAkhLIOKta+xREN/IkZA5tl3qBv35PscM3aJq9VQLI1dgCwHyMaJteZd3RknQCcBIWKa39dzvaRNPgm0bf0i9BEED/O50BeyCNKXjU+GNTUs3rRY0yeX5wIe96OQu7o8H60FbQ0UcICbTPwYvBZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvPFW2TNMz2yGF
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 11:43:39 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WvPDv54Qcz4f3kw5
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 09:43:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 392B51A0568
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 09:43:27 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4U70s9mWOUIDA--.61429S3;
	Thu, 29 Aug 2024 09:43:27 +0800 (CST)
Message-ID: <491c1962-1f9e-4aca-b263-eb6eb88140e0@huaweicloud.com>
Date: Thu, 29 Aug 2024 09:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: David Howells <dhowells@redhat.com>
References: <11c591fd-221b-4eeb-a0bd-e9e303d391a6@huaweicloud.com>
 <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
 <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
 <988772.1724850113@warthog.procyon.org.uk>
 <1043618.1724861676@warthog.procyon.org.uk>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <1043618.1724861676@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHL4U70s9mWOUIDA--.61429S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYv7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r
	1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWbO339AKwAAst
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
Cc: Baokun Li <libaokun@huaweicloud.com>, Christian Brauner <brauner@kernel.org>, Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, stable@kernel.org, Yu Kuai <yukuai3@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On 2024/8/29 0:14, David Howells wrote:
> Baokun Li <libaokun@huaweicloud.com> wrote:
>
>>> You couldn't do that anyway, since kernel_file_open() steals the caller's ref
>>> if successful.
>> Ignoring kernel_file_open(), we now put a reference count of the dentry
>> whether cachefiles_open_file() returns true or false.
> Actually, I'm wrong kernel_file_open() doesn't steal a ref.
>
> David
>
>
Thanks for confirming this.
I will send a new version using the new solution.


Cheers,
Baokun

