Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC44378DB
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 16:14:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbRDf1Kfvz3c6f
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Oct 2021 01:14:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hAXfeT3J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hAXfeT3J; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbRDb5Fykz2yJM
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Oct 2021 01:14:23 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70DBE6128B;
 Fri, 22 Oct 2021 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634912060;
 bh=+LSY+lBk0VcuOK02x0pQs2CrnIpazX/toffgrseGQyY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hAXfeT3Jic73fLZMdK8YRmHF5RZi7ruaRofFMaNNGra6c76vy2N7ilhOlk/pRhUfp
 wudfYpCeSxxZuCTZOoFiKSH5dy6csKZ54ofX0ewHkcJUVyM7OnQJJgVxW4h2V+2n5j
 vxMoBngmpyL+zktNNa9/9rTmO9I9sqA4Dxs+EmJ9mvvQel7WdXd/nn9XC5SLd5Tbn3
 T0DehnnwApJ2I02tbi4BcBJz7q59SrPO3+2dMe66R9xfTH06Nqr5gHM062Ed9lTV4W
 H5yrlUF9M+Tcm7paXADd2Mi3OLtU4+P3UqNi+cx2q208lumJm8qhcupx2eFdJVtzcE
 L8ZovpOi4X3vQ==
Message-ID: <b4d6a7ab-15a3-8bcd-7627-ea9c3200c012@kernel.org>
Date: Fri, 22 Oct 2021 22:14:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/10/22 17:01, Gao Xiang wrote:
> Currently, ->lru is a way to arrange non-LRU pages and has some
> in-kernel users. In order to minimize noticable issues of page
> reclaim and cache thrashing under high memory presure, limited
> temporary pages were all chained with ->lru and can be reused
> during the request. However, it seems that ->lru could be removed
> when folio is landing.
> 
> Let's use page->private to chain temporary pages for now instead
> and transform EROFS formally after the topic of the folio / file
> page design is finalized.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
