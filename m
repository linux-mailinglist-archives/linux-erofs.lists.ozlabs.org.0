Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D147F9C4
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 03:27:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMhPx43L6z2ynV
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:27:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hHI1kTM7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hHI1kTM7; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMhPs6h1yz2yMs
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 13:26:57 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A7DD1B80DE1;
 Mon, 27 Dec 2021 02:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE7EC36AE8;
 Mon, 27 Dec 2021 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640572013;
 bh=SkwoH0pcS6jBuRjzm7Hv7BMeiIl1c9ow9BrQdEKuqVE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hHI1kTM7XHXzx+r41zLGVnuu8HYDv3bRJ8atfPDRbantqI4XFUOFeUoJaMxOdIlbo
 IQgO8Skt955qDaGaZQBP8TQ9kXiaXHiqG23jzFZkRK2gnNYvez/9d72cnjo7Bx59F5
 4XXu2Xbur3554jB2CgzxUhtDqhtnnJfyjqhJiLJLrLHGTTMhOHl1wpuA9jC2fcNPvo
 hxs0ekOyRp9HSt9QmxCFIX1rmO9+iPqiBscCNT8Yv7C7lyrJGG1jmCryaXjFce2eD7
 7B0XqvMlHAbEXXmQZghiSg1WSqlb1Qt3fAIyKejMd2UZw6NfNq4QuMV1VtkmsBoXHd
 g0jV2HtIH7nnw==
Message-ID: <872ff3d8-199b-8272-234d-c05075afe619@kernel.org>
Date: Mon, 27 Dec 2021 10:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/5] erofs: introduce z_erofs_fixup_insize
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-3-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211225070626.74080-3-hsiangkao@linux.alibaba.com>
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
Cc: Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/12/25 15:06, Gao Xiang wrote:
> To prepare for the upcoming ztailpacking feature, introduce
> z_erofs_fixup_insize() and pageofs_in to wrap up the process
> to get the exact compressed size via zero padding.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
