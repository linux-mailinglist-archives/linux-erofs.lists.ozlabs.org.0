Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3D87457A
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 02:07:14 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jrCNbtB5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqrk74lZnz3c2K
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 12:07:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jrCNbtB5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tqrk41WfKz3btQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 12:07:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9535161BB0;
	Thu,  7 Mar 2024 01:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A7C433F1;
	Thu,  7 Mar 2024 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709773625;
	bh=4bqWptoKbnRgrpqaRERXOF58F2B3DTRxO8EnLm4nMi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jrCNbtB5YcSuEDMNq1BjhKJby+ulYRhhfEgvyaD6HS83j6LLzr4zGgEum1aMRBPuI
	 bV3ZqX/QGlLYpzAuXjV2syAfOSsMspXu+++FJ6AddCtrWXg1vgtknrlRHyt1MuptGl
	 DiNEnMUvG54BNfY8Z0CYT2qahjhlM7IcISZHkepKoPMjXPt1M9F4vI9MLCOg/gRbMW
	 YT3oeSDCQ4AFaUyKpuxJVN1MJib+7weIJLayFbKDCst0gaO6YBVOZup3advBOCUzQo
	 oOuIsyhSAGkmt8LB4v3bfbDR1rWzpcAEW/kNBL3XcMyxQ8YzzTEbYuZH5Jpm2vb/Fn
	 wDjmX6zgF4g/A==
Message-ID: <b3601f0d-c315-4763-bbab-4174fe0af713@kernel.org>
Date: Thu, 7 Mar 2024 09:07:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
 <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
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

On 2024/3/6 14:51, Gao Xiang wrote:
> 
> 
> On 2024/3/6 13:31, Gao Xiang wrote:
>> There are mainly two reasons that thp_get_unmapped_area() should be
>> used for EROFS as other filesystems:
>>
>>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>>     mappings");
>>
>>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>>     THPs for read-only mmapped files (e.g. shared libraries) even without
>>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>>     for non-DAX").
> 
> Refine this part as
> 
>   - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
>     which enable THPs for mmapped files (e.g. shared libraries) even without
>     ...
> 
>>
>> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")
> 
> Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
> Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")
> 
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
