Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id B90688D3976
	for <lists+linux-erofs@lfdr.de>; Wed, 29 May 2024 16:36:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nA44ULb5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VqBZw5q0vz78n6
	for <lists+linux-erofs@lfdr.de>; Thu, 30 May 2024 00:28:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nA44ULb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VqBZn3X5kz3w42
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 May 2024 00:28:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716992920; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Oje62Ov6FUBQ4DHAsaEy7GE8Yt2ouQ/knXBYAIm0bWE=;
	b=nA44ULb5xJ6tFuy3VlrLqB30VPIl+K8JluatXFs6eG7c21ZvZkM+GYJjGisEx0Y8Qk1mEj/Gm2ecu4zQ6njC/uUZrvnlmn6g/WstrIx5AeSdrhG0kHW9OXBVXOTr+J7fdiWWBmOSwkx7YVyfKnEpJzvx4Y0gtVwno/4scY2TrF0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7U1T.u_1716992916;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7U1T.u_1716992916)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 22:28:37 +0800
Message-ID: <2dc48e89-cd3f-4736-8847-4d23bcad27e5@linux.alibaba.com>
Date: Wed, 29 May 2024 22:28:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] cachefiles: some bugfixes and cleanups for
 ondemand requests
To: Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, libaokun@huaweicloud.com
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240529-lehrling-verordnen-e5040aa65017@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240529-lehrling-verordnen-e5040aa65017@brauner>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

On 2024/5/29 19:07, Christian Brauner wrote:
> On Wed, 22 May 2024 19:42:56 +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Hi all!
>>
>> This is the third version of this patch series. The new version has no
>> functional changes compared to the previous one, so I've kept the previous
>> Acked-by and Reviewed-by, so please let me know if you have any objections.
>>
>> [...]
> 
> So I've taken that as a fixes series which should probably make it upstream
> rather sooner than later. Correct?

Yeah, many thanks for picking these up!  AFAIK, they've already been
landed downstream for a while so it'd be much better to address
these upstream. :-)

Thanks,
Gao Xiang

> 
> ---
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [01/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
>          https://git.kernel.org/vfs/vfs/c/cc5ac966f261
> [02/12] cachefiles: remove requests from xarray during flushing requests
>          https://git.kernel.org/vfs/vfs/c/0fc75c5940fa
> [03/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
>          https://git.kernel.org/vfs/vfs/c/de3e26f9e5b7
> [04/12] cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/da4a82741606
> [05/12] cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
>          https://git.kernel.org/vfs/vfs/c/3e6d704f02aa
> [06/12] cachefiles: add consistency check for copen/cread
>          https://git.kernel.org/vfs/vfs/c/a26dc49df37e
> [07/12] cachefiles: add spin_lock for cachefiles_ondemand_info
>          https://git.kernel.org/vfs/vfs/c/0a790040838c
> [08/12] cachefiles: never get a new anonymous fd if ondemand_id is valid
>          https://git.kernel.org/vfs/vfs/c/4988e35e95fc
> [09/12] cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
>          https://git.kernel.org/vfs/vfs/c/4b4391e77a6b
> [10/12] cachefiles: Set object to close if ondemand_id < 0 in copen
>          https://git.kernel.org/vfs/vfs/c/4f8703fb3482
> [11/12] cachefiles: flush all requests after setting CACHEFILES_DEAD
>          https://git.kernel.org/vfs/vfs/c/85e833cd7243
> [12/12] cachefiles: make on-demand read killable
>          https://git.kernel.org/vfs/vfs/c/bc9dde615546
