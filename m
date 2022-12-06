Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8A644548
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 15:06:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRMf610QGz3bY2
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 01:06:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CqoPJECp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CqoPJECp;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRMdz1kv8z3bWq
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 01:06:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 24E076176F;
	Tue,  6 Dec 2022 14:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A433BC433D6;
	Tue,  6 Dec 2022 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670335570;
	bh=6zLPU/OP1JWlfpeQndEkK8OuCR2c+jVhP4zLqlVSafw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CqoPJECp4snefzmLN8YHf4xDiaVTGO/ocKknsuyfYBHcFXuv57J7QJJOp56+4RCYo
	 SpABtmiT+8iB596flQZ8vkNI4HWfGsYxIxLttX1Q6YHkqzVCaqSJ80ge3idl9enchL
	 DaeyHWh263fs7Bd3brizd/CYY+JQu48SEbi7YzLW56CLJD6TCkITAwB1cucgZkMLlb
	 T0md7P/PediemqfQt6CBlJYC2aEz9kVkxCEu5j2YSkybm3tpzUXRESwMDhkN8uw5eT
	 v3IaFlbA6DjiSA67YyibRFiaKsLT5W/Qu5S9HVEXVVk5y3J+eUW1U4gkguITQTR2vV
	 7AOM+SgTjEkvw==
Message-ID: <50922c87-3415-7986-c8ce-67d16754b442@kernel.org>
Date: Tue, 6 Dec 2022 22:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: enable large folios for iomap mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/11/30 14:04, Jingbo Xu wrote:
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> recalimed or invalidated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
