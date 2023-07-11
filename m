Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA974F17B
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 16:16:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J0QIjzR0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0jb71xM4z3bdG
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 00:16:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J0QIjzR0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0jb41Jjjz30Cg
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 00:15:59 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2543161360;
	Tue, 11 Jul 2023 14:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CEDC433C8;
	Tue, 11 Jul 2023 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689084957;
	bh=On2BKpEOWSQ/BMVqSw9pQkazv2WShBvkytvoEXHEvNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0QIjzR0VKaQUf+jq4CQCl3IJV2Uuj3PlSfGFGgUuwJWRBEcfU5rY78q1ytfBy7xC
	 hi/q5Crm0qfDwzSf8IsChnhYFeMEncC9BH3XYvOyuEzpezuK7ssKw/i8qe8r89ZRc1
	 3ZsUQqJB0TmCug9PCoyU4hvp7hGYIQiBdAPhiDAjDkn6h3NhnTXZVG9hMY6ejYsUAR
	 D5ItK0HOjKoCb9J2Sc+HtoavirOy90rBgJJWp86x65kvbwY8wVi0NXOjJwGJF95QDw
	 PBB0V4vatu59/WvGFkb6zuLuQDpSiJZgYYwvSPR6EQ1WF0SdbKkC/GUjqCJrAlc5CF
	 4H+avgiE0pXag==
Message-ID: <0e927b36-2c2d-4639-4dda-fd51154a30b2@kernel.org>
Date: Tue, 11 Jul 2023 22:15:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: fix fsdax unavailability for chunk-based regular
 files
Content-Language: en-US
To: Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org,
 jefflexu@linux.alibaba.com, huyue2@coolpad.com
References: <20230711062130.7860-1-yinxin.x@bytedance.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230711062130.7860-1-yinxin.x@bytedance.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/7/11 14:21, Xin Yin wrote:
> DAX can be used to share page cache between VMs, reducing guest memory
> overhead. And chunk based data format is widely used for VM and
> container image. So enable dax support for it, make erofs better used
> for VM scenarios.
> 
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
