Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5987768580
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:19:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mzmS/wXf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDMQk418cz2yFB
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:19:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mzmS/wXf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDMQg3l7jz2xgp
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:19:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AAD1460C1F;
	Sun, 30 Jul 2023 13:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D698EC433C7;
	Sun, 30 Jul 2023 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690723145;
	bh=ReFQLttxiY4n0bfqQsyLuaghrwvNw1jeGn6XDUjPWaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mzmS/wXfHhm2Eg3rfdDX0fHS5M6b17nR0Hj67PYsCqDdgje39ptXa/1SjsMFyrha/
	 ps6vHe5xHCX/0K176eT4S3ZIahRwpiErYbubTOw5xFk4JxIU4GnVbcTb8n9XclpvRv
	 +aFUM7Q7W97cm/C1bj6cuPk2hbIQrUNUBeq+yl1SG7Pu1qOJ++u8qbnyP5iedkRLI1
	 Ivgd/pMnZR3JFRd75kvUUGH2EUaqDcuKUJhBvIhzjNHMeeOEKPTh6bzhbJdz7KehK6
	 5Sulp3RaDUq7jxJJk9AouvM0nO6Fs8gINQwqZuXCyFdwtlecHunRQwQF5Q07+jvI6l
	 C/Pt6at/Co92Q==
Message-ID: <bd2a6743-c5d0-27b5-bb69-fa11b93f4146@kernel.org>
Date: Sun, 30 Jul 2023 21:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/2] erofs: boost negative xattr lookup with bloom
 filter
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, hsiangkao@linux.alibaba.com,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230722094538.11754-1-jefflexu@linux.alibaba.com>
 <20230722094538.11754-3-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230722094538.11754-3-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/7/22 17:45, Jingbo Xu wrote:
> Optimise the negative xattr lookup with bloom filter.
> 
> The bit value for the bloom filter map has a reverse semantics for
> compatibility.  That is, the bit value of 0 indicates existence, while
> the bit value of 1 indicates the absence of corresponding xattr.
> 
> The initial version is _only_ enabled when xattr_filter_reserved is
> zero.  The filter map internals may change in the future, in which case
> the reserved flag will be set non-zero and we don't need bothering the
> compatible bits again at that time.  For now disable the optimization if
> this reserved flag is non-zero.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks
