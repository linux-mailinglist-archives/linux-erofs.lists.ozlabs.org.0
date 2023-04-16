Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18206E393A
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:29:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PzsyC5CkRz3bbZ
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AtWc1soE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AtWc1soE;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzsy84QbZz3bbZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:29:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8D12760E15;
	Sun, 16 Apr 2023 14:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B3CC433D2;
	Sun, 16 Apr 2023 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655358;
	bh=7FStxHBdst1il4TwvF6jUyQJzCfiTLjd/zo+/SZnMGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AtWc1soElWRYxqrPL3w7G5ukmunGLzsMGO7GgYIE+VusxKsZ2nZNV+IIyMYprPhMB
	 gPq+5PM/eZ45zDuYF7HcmQd6sIItNHbbzqoyNbmvgNyIDPpkJ5wDIP8JXToUPOUVWA
	 RnaIXsinVRjZw3fFTQrEH90s05tlpoHrsmG+xTrg8Z8mKmas5YG8oEedSl3m+uS0pB
	 vcB4mR1Y0W6z9WGGarE4Z8GjIAKbfQzjbLP6YBhm5WwevB3ixz8pSZIeLj/HkPV63O
	 Ux0Ob+ZsdnB/MLlufnE/i1XEYaYnuvDkaQDT5QfistxrY1rw3Issz+z0favyNUicCr
	 wqyFQcAIhCenw==
Message-ID: <1cc4f1e8-d15d-37d0-b59b-b073fe0cf976@kernel.org>
Date: Sun, 16 Apr 2023 22:29:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-4-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
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

On 2023/3/30 16:29, Jingbo Xu wrote:
> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
