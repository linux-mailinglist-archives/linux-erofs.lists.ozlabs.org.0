Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20B445F26
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 05:28:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HlnZ72n5Fz2yZv
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 15:28:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dl6F+N3K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Dl6F+N3K; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlnZ371GJz2y0C
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Nov 2021 15:28:27 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C083361262;
 Fri,  5 Nov 2021 04:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636086504;
 bh=KZOiKhQ37VKIy+d/W2ttFzNr4HxULf9Bi5Iicv0PObM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Dl6F+N3KlqI8X9b/nUwQLhPvPIM0orpJdUwqYg/glhXi8zgw9M0xc+qkRC2e8AhbS
 y4a4WHFfqJI0URbpxXCH6tExIOFis3Eld0O13L4X3fKW9oQ6ShdHBIHAlg9qQaEGJa
 7btYQhkExffycgG+kg1dXTSgBJc92ydUL7Q+Sw/95TffAKFqybW/3rYcdnKIVKPdXe
 eHSV+yPvd4m7D7o0Nn3fQLeJuzTmB4KBgzaQGN93B9YSdq47MtaNDSphim9gXDVcfA
 tb7vPR46cB2F9/2RWAmzPV6jD4xeiHKe+yOyUE+Jdov6wCTTooDuxreWEhkAJaXi09
 cC/4GfslMKotQ==
Message-ID: <1dd327ac-b4c0-6c03-7250-dd8a9be44657@kernel.org>
Date: Fri, 5 Nov 2021 12:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] erofs: fix unsafe pagevec reuse of hooked pclusters
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20211103174953.3209-1-xiang@kernel.org>
 <20211103182006.4040-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211103182006.4040-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/11/4 2:20, Gao Xiang wrote:
> There are pclusters in runtime marked with Z_EROFS_PCLUSTER_TAIL
> before actual I/O submission. Thus, the decompression chain can be
> extended if the following pcluster chain hooks such tail pcluster.
> 
> As the related comment mentioned, if some page is made of a hooked
> pcluster and another followed pcluster, it can be reused for in-place
> I/O (since I/O should be submitted anyway):
>   _______________________________________________________________
> |  tail (partial) page |          head (partial) page           |
> |_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|
> 
> However, it's by no means safe to reuse as pagevec since if such
> PRIMARY_HOOKED pclusters finally move into bypass chain without I/O
> submission. It's somewhat hard to reproduce with LZ4 and I just found
> it (general protection fault) by ro_fsstressing a LZMA image for long
> time.
> 
> I'm going to actively clean up related code together with multi-page
> folio adaption in the next few months. Let's address it directly for
> easier backporting for now.
> 
> Call trace for reference:
>    z_erofs_decompress_pcluster+0x10a/0x8a0 [erofs]
>    z_erofs_decompress_queue.isra.36+0x3c/0x60 [erofs]
>    z_erofs_runqueue+0x5f3/0x840 [erofs]
>    z_erofs_readahead+0x1e8/0x320 [erofs]
>    read_pages+0x91/0x270
>    page_cache_ra_unbounded+0x18b/0x240
>    filemap_get_pages+0x10a/0x5f0
>    filemap_read+0xa9/0x330
>    new_sync_read+0x11b/0x1a0
>    vfs_read+0xf1/0x190
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <xiang@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
