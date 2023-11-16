Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADE7EDB74
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Nov 2023 07:13:08 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+usEBGN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SW8pn5C98z3cVL
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Nov 2023 17:13:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+usEBGN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SW8pf3Qhjz30f8
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Nov 2023 17:12:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6F6AFCE1B28;
	Thu, 16 Nov 2023 06:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABACC433C7;
	Thu, 16 Nov 2023 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700115172;
	bh=iy5Fs/OoTBft6okzKEHs4fWRTYP2PNevTk5pW3gTixU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N+usEBGNPd2bk9KP44cNiNV+2/hhvIGR0r4eabOjhvJVfTZ6aQQG3QNCMTXJYj9tV
	 UnU2WdlJVpkiSLIt/FmK51ksMNZtxygpMRRi6PCoaNjIQ5if7KNKxGzXKSLzjUKiKG
	 gnZg9dQDa1/uEl+8XzPm/4Y+c+LMkuX/043n4s5SbIDJfJNb8R7oUBDnEJbPUyLs7N
	 2o3ZM+a+0ZY39vIHhPef4LLTqTP0UriN6TtiaDsMIV9mtQOqRwD2Xornmezz8fOd1a
	 tHBY09sEcvo9/QgZagWT2g32TucDP8u2G4FZ0ju8tTbUpQQRSdYbZ4fdnLTn5WW85/
	 dhTvrpazq3q3w==
Message-ID: <c37b72d8-f607-bbce-f5ba-58f554e07b85@kernel.org>
Date: Thu, 16 Nov 2023 14:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/11/14 15:07, Jingbo Xu wrote:
> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:erofs_map_dev+0xbd/0x1c0
>   Call Trace:
>    <TASK>
>    erofs_fscache_data_read_slice+0xa7/0x340
>    erofs_fscache_data_read+0x11/0x30
>    erofs_fscache_readahead+0xd9/0x100
>    read_pages+0x47/0x1f0
>    page_cache_ra_order+0x1e5/0x270
>    filemap_get_pages+0xf2/0x5f0
>    filemap_read+0xb8/0x2e0
>    vfs_read+0x18d/0x2b0
>    ksys_read+0x53/0xd0
>    do_syscall_64+0x42/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
