Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB05AD5CD
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 17:10:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLsQv6vZmz300l
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 01:10:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=exYKUhxT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=exYKUhxT;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLsQn6tyYz2xfm
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 01:10:41 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AE25461325;
	Mon,  5 Sep 2022 15:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494AAC433D7;
	Mon,  5 Sep 2022 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662390638;
	bh=pmChB25I0/xOioQuvfxS4anHlEB/iWlW/oPqp/l37GY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=exYKUhxTTuUxLlAx8IzrxsRZycm6/RCghmfrKnf2Y+jgggnhvGFRKOfDw938k0eN7
	 Ka4/6j2Tuj9Zt3Y7X48mHrSvXPQT9guosY4ssOdTs8TzsrlYLI3Nv0vyGfXCiff25g
	 oGcKLVvtoTelM/rTwKUu8ympPdTQ2bUDucZKu/lUv0CpFG/t96Bpd0eBgBtqg4gCAO
	 e9FM9ZW6Nw0N97ZcWZGujwsngRoxOZE4XkM26Vr7u4r1qfaD/sKHzGCn3D9ay7+Kck
	 qjp+hPfCYI/J9b5M4VtpggZ4OO68EL+fS0AvERDajOWIHN2BUedv9uXH9fFqY8X3Ty
	 rErhw2shs1pLw==
Message-ID: <ef807497-6394-8274-71ce-ace51db31398@kernel.org>
Date: Mon, 5 Sep 2022 23:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Content-Language: en-US
To: Sun Ke <sunke32@huawei.com>, xiang@kernel.org
References: <20220815034829.3940803-1-sunke32@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220815034829.3940803-1-sunke32@huawei.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/8/15 11:48, Sun Ke wrote:
> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> it should return a negative error code instead of 0.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
