Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96B96D2B2
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725526994;
	bh=2u4zkYv1NHDubp6FnpW+UrzXp7Agt/neKeU39wN/bxE=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=R1HfAQ+uPB5fc2Mp8dB6ckpqVHUO2tSEMVJT1Hk+C9IOsH/xwjDxY7wWpkOubxUai
	 L/E1AfIl0cNOzqjPmqf9qhAylm9EAzC25uUkaeIhl9DtA1cbg4FjdPcvK+dM151krC
	 MliR6aZfWTNS5t2qJdqzxmano97eb5SYQgLC6boxoVjlW6+lnQ5Rw/QQrsphZ1hNka
	 cKwtVmID0iCcIac3rFwGEWjbI209uu9bk55I9dF76924r7XgentYXqW0/kfcMZZZYf
	 1HOzxD1N6z2yQSs88nxo5nPUWJyt0fepkNTZ4I5bKl5UrOyxInu5bvVEngBF16VRYo
	 a3J44CDaa4wDQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WztgQ45dpz2ytm
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:03:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725526993;
	cv=none; b=am8S7CQKPJV/vIwIjGiaAbYUg4kPtqlEMx9ojoCPvdJFHYh2uT9zeo4HlhmEBjN7ytVH0F3vEWT7H2RED0PzDU+hkengz4aXRFTJcW2JXO89Td0whTalQK+KMsbIUUqJUljU5gVN3Lfnbh1C/IQZAKHVLUTqnJwQkHU/WZqcvl3qOsbB0lRRFOmuZd8PkKgF9a5LrKp1KiDzbu8WxYK7/gemyF35Grz1JPq1sy1o0ot3CVVHB5gGUkN1242FkG7f2COj6AsFNLkMcaJ0wlJ9zi0LjJzsYpWls4pyZZhaE9756Hnk0OS7pwTphmKGZXhxVcXT4GHsraPtPFA2F7kyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725526993; c=relaxed/relaxed;
	bh=2u4zkYv1NHDubp6FnpW+UrzXp7Agt/neKeU39wN/bxE=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=gE1YhXO4B+cEIULVNEueDuAwx9lA3MLPXnWL+UO5oloaAldS8kWKvTs/Jc8JmQLMXY0JAfhh+5VkwFYUR3Q3e+iaUEbLFS3yhfeCwWxk/G7wlEBaHqasxVldWuAEiUuU+cfN3Ur9EPgi2BOtMhlP1paltHoYJ8nAxog5HHSKoFtqkKiTBlNWxpHBwthtpQbAqeahNm/Gu5Y6+yL6NzLMUTl5kb9yzG0oZ0z72PA8/6Irn8s4xdBH82USYe6c8oVFugTAJi7LB3RqTNlFY5YE/gCX9JsR4ys2L4aqy5xX0OIAZB4ISNgbvp0zynN2Gi8Sh4a5vftVgCZpZnQKBun8+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=arVgj21q; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=arVgj21q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WztgN6Hj6z2xnc
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:03:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6FA2D5C10D3;
	Thu,  5 Sep 2024 09:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8019C4CEC3;
	Thu,  5 Sep 2024 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526990;
	bh=C7QqHkaQizpgmyQockOjinfASfHPk1I3HmbJdZeXzKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=arVgj21qrZsiyH0cldhkDd/KtA7OfMr/dfTaY+OIMMDNAjsujCSP1GDSCVam9o2VT
	 VOT6i/k9t/2IU8shBVQ/wJ0ANas8LxfvXhHvNJygr9e0XrgKBAlf03+xbygwlkCu/Y
	 GUNMjq2lH0T+OCglFp7wc0qafhE5X+pbjL573zTanBKEG/cSZfLr/e7RYrfABsqsae
	 jnC0mybgZZazptJOQqg6M7jicugDcTvC0/wfY0MDXNLYtDv/VgH69Y/RhFRD5JNThd
	 e+XoKdWW6mybffnCLHDt6n38zd354VzX/JogkNNlpTD+BrvwhgtYQjEMfIKGbuK6nD
	 4FFQsSrgu0szA==
Message-ID: <867c7fb8-480f-402e-b88e-54499d4db3b7@kernel.org>
Date: Thu, 5 Sep 2024 17:03:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] erofs: mark experimental fscache backend
 deprecated
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
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
> Although fscache is still described as "General Filesystem Caching" for
> network filesystems and other things such as ISO9660 filesystems, it has
> actually become a part of netfslib recently, which was unexpected at the
> time when "EROFS over fscache" proposed (2021) since EROFS is entirely a
> disk filesystem and the dependency is redundant.
> 
> Mark it deprecated and it will be removed after "fanotify pre-content
> hooks" lands, which will provide the same functionality for EROFS.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
