Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBDE45677D
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 02:33:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwK1831tgz302C
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 12:33:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W1CMDHQT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=W1CMDHQT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwK121JFdz2xB0
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Nov 2021 12:32:54 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00A5261452;
 Fri, 19 Nov 2021 01:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637285571;
 bh=rPLxw7lgKJe6f34Wjl+d5PM0+fwtkcZm0azpKL1YgbI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W1CMDHQTScFlzQXcwOJDyh9eTAJQBwQu9PaNJkMSiY7L4CtI31TDpPBIWkyu6wNzl
 kFifP/o1bydsfVILVdO8GEHzqkFS5pG3UcuBxQgV2T+S7m6+Q/JHyruuQof2l4MGr6
 K5M3WVOaQBTegnkvSjne9jhKZSu4wyXiAk45dkaMb5Dk13AiKSo67rrQ7wjEtz9Zcd
 ccr0Nh5NmaWtZ3LSg/mnCkmmGjcCwtgVTEtt9C0hsEnFFvPgFSTGR+LiMbWuZCXhOw
 +uxPBYo9sx0k74hSGjOg0cl5nYl2Ka3X8ur/wNM26OVaWxJxNUywemxW9Jepr50yHs
 CDYx8LGUVRrvA==
Message-ID: <5e299ea7-0d23-2d9e-d401-be561287c9f6@kernel.org>
Date: Fri, 19 Nov 2021 09:32:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] erofs: fix deadlock when shrink erofs slab
Content-Language: en-US
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20211118135844.3559-1-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211118135844.3559-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/18 21:58, Huang Jianan via Linux-erofs wrote:
> We observed the following deadlock in the stress test under low
> memory scenario:
> 
> Thread A                               Thread B
> - erofs_shrink_scan
>   - erofs_try_to_release_workgroup
>    - erofs_workgroup_try_to_freeze -- A
>                                         - z_erofs_do_read_page
>                                          - z_erofs_collection_begin
>                                           - z_erofs_register_collection
>                                            - erofs_insert_workgroup
>                                             - xa_lock(&sbi->managed_pslots) -- B
>                                             - erofs_workgroup_get
>                                              - erofs_wait_on_workgroup_freezed -- A
>    - xa_erase
>     - xa_lock(&sbi->managed_pslots) -- B
> 
> To fix this, it need to hold the xa lock before freeze the workgroup
> beacuse we will operate xarry. So let's hold the lock before access
> each workgroup, just like when we using the radix tree before.
> 
> Fixes: 64094a04414f ("erofs: convert workstn to XArray")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
