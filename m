Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A5785B4C
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 16:58:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qoYVhH+g;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW8V36Zj4z3c5C
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 00:58:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qoYVhH+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW8V03YcDz3c1M
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 00:58:16 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A2E376196E;
	Wed, 23 Aug 2023 14:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C5C433C7;
	Wed, 23 Aug 2023 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692802694;
	bh=IFDY2WCMwGuW7nIrMMNoTRbgjk0aaNwEZ39jkkpVN30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qoYVhH+gZQSkCpzLt83I9gdEUoSxw88C88tamhsmayNjDYnvwTJ5x4Z/HL/34nEi6
	 hyR94y+S9xmHNBPe2rO1nXgzd+yoOb72P9jXlZiRccDBlGqQVu16iOFhcbmWRilwXk
	 4QhdGHJ6lFMJRswVBp5bZMmHhUncYkQA1KeNUyu7AkA0GlFlh4oDyyIXU9knyIoeoO
	 ROi8QJT3LOCuaDpcezcm0ZBeEp1atXDNiIwm6XRCG708uClpajGFIK2qLMTfj8SB/4
	 Cs7pkiOYr5fRCvwa/zh/EDJOrAjmGMkxKWqnpl9f5dvhYkZjReJzd6QLB+Hky8rHTG
	 tU8G887hazdag==
Message-ID: <38c0fb97-40a4-9c46-4b57-9f0f13928b0c@kernel.org>
Date: Wed, 23 Aug 2023 22:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] erofs: avoid obsolete {collector,collection} terms
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/8/17 16:28, Gao Xiang wrote:
> {collector,collection} were once reserved in order to indicate different
> runtime logical extent instance of multi-reference pclusters.
> 
> However, de-duplicated decompression has been landed in a more flexable
> way, thus `struct z_erofs_collection` was formally removed in commit
> 87ca34a7065d ("erofs: get rid of `struct z_erofs_collection'").
> 
> Let's handle the remaining leftovers, for example:
>      `z_erofs_collector_begin` => `z_erofs_pcluster_begin`
>      `z_erofs_collector_end` => `z_erofs_pcluster_end`
> 
> as well as some comments.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
