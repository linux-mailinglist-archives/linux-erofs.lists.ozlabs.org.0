Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BA96D1E6
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 10:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725524533;
	bh=xbrqMv4DaUYnY1vV9HUKyfkULu+xPGI8bX/+hJO0VC0=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eEn5rN07vHNYTgfVZ1mElr0gMrWOyHe+tXB3HBCFrHtImyS+Tj66rCW3JBLFw1/XG
	 M/IB2N3AhVf9CsvZZz5fz01e8xiqxnybJAlvyAv2sq34UBx7FZUHD/JDOC3Imk+K42
	 /k/yz+uDrgZRAxwJQYrIk9VqPKddh3YrwFYQ5YNiaSMeWFpJpE0hQa/cKtkWoXLGGX
	 SHI1urFu/r29CxBAtvH0BJLIYUoNGVNYceVDJYFMhr0rCiHvI4Kh0dW2Rf+QFOQzzq
	 kBtOGYGS0oNHSJsBcqrpngiAC7SOIa6N/jH5wJ53C6gCA0PSI4OircdAYmhVimsMSD
	 tiU2cLMItPFZw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzsm50sL5z2ytR
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 18:22:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725524528;
	cv=none; b=at4nLkcqbi/wt/s5f1uwjkroWDeGdlx83lHF27lo/uxOnKyPwwT218lfMPelnSAeH5d1e5A9vr5ZxR6hfTtl0W7BztxiaxazFFC4KdfQyuGsRBrDjoTZZbNhAhAvRHX5CdV+CS4FJz7AwpkVDwbuOgx7GKerjjUXmUJF5jddEAmi8yvs9jXygUugT/FTHANsh40naDsJFYGZIJsvEQrNzQeWokBN9BJyP+FCYYXoA9Xm+HWyjySsUwrJLamPBrGl//DjhRdIq5ib6zy0/G38zudxvo4yz17XYKffT5xzy0zUl8KUDaIljUz2q0XKCoLyDYAd+4Lk/1zmodIMPAO59g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725524528; c=relaxed/relaxed;
	bh=xbrqMv4DaUYnY1vV9HUKyfkULu+xPGI8bX/+hJO0VC0=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=gs0ERj5oG24HZbMfZYNn6RroEc4d4gIhUDwjq3ogIaEziem1OXiSmy9LhOudB+IqOxQsGWCNPe7rYRXkdT1Nps+NozHpvJwRiNH/Qf0ZhkXf3UctqLyidTKhXnbAljaI+acQ5C5SJmWvR05BGI6uP0SOMmbpaiPfMQBjH+8A+1NUrVFINEfm+6e2HrWgucWRwcZO0x40QAoKANO78vTtjhuwaxpHHKvloe7ut5RhmW7+213I3gMdElpVh0axc4BHOWAg7Y89FQs5BatjX2AJCGbReAa/tfB/FP/bIFC51a4Zv11quzU3bD02QZoeDMtFWvyxtJK2FSSeqR4hpZjamA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rX/XEl58; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rX/XEl58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzsm045HWz2yRZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 18:22:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 403F15C55FB;
	Thu,  5 Sep 2024 08:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9177EC4CEC4;
	Thu,  5 Sep 2024 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524526;
	bh=6O+X9dfhS4zYptfRJFP88uQaZ4Yq66gOjR9HYND0g7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rX/XEl58dPKRF1VsQ8bD4j8oviaDA9YSMCjJz+w0osDco+qHCSPyHMI+amXUb92pW
	 paeYLsn+WMS32YnIC9luYH3VRkoMoLNYV0U0PaxmC8hw9F1E+28DMuOvZXc/wJYCfl
	 j81N0Oa9ctNOGSAVqvbfh/tP18cFp0Jq6BQRE3rp7YN1oiQMSjx6eLC8+ODNCYRiJk
	 1pa9czZhaWEL3WZQQupZvTmP0HNNoGgevubkGZOQdmYeLLo3MiKYj0GZ0VrKZJr3v5
	 Ub5RQ7Ldp3KaqQBcOlNTi4RJSytcFEGG8an3Q8lUsUyVYPN0V985Pl26K60sxIg87Y
	 44mYVY2kwjaqA==
Message-ID: <e0a6cccc-c982-4d8c-95a4-afa63da6aa7b@kernel.org>
Date: Thu, 5 Sep 2024 16:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/30 11:28, Gao Xiang wrote:
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
> 
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
> 
> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>   - Fscache infrastructure has recently been moved into new Netfslib
>     which is an unexpected dependency to EROFS really, although it
>     originally claims "it could be used for caching other things such as
>     ISO9660 filesystems too." [3]
> 
>   - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>     enhancements.  For example, the failover feature took more than
>     one year, and the deamonless feature is still far behind now;
> 
>   - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>     perfectly supersede "erofs over fscache" in a simpler way since
>     developers (mainly containerd folks) could leverage their existing
>     caching mechanism entirely in userspace instead of strictly following
>     the predefined in-kernel caching tree hierarchy.
> 
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
> 
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> 
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
