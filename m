Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E777F66BFDD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Jan 2023 14:34:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NwY0q5tf3z3cDs
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jan 2023 00:34:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fONRzZNg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fONRzZNg;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NwXzB4h21z3bV1
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jan 2023 00:33:26 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 920B0B80EB2;
	Mon, 16 Jan 2023 13:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27658C433F0;
	Mon, 16 Jan 2023 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673876002;
	bh=8Zia7ZHB568TJdtIEcvHjN2X53KnODEVRlchESw9mRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fONRzZNgopJXhtv2O6ZL1jhUbC3LBxZOvLkS9Dg0teRoWfwj98LqSPct2NqLGFaar
	 OfMDE/2tOTJJAvE/AOr8js19I5R0DB1iobrYKsNv4gIW7LpMJK0o6t2acyuIAJAzkh
	 Q2kTyc8/nz54DE45xRql1fxIPNkO3sbRO0q9NNh+euUoKezz4K/1xDni9jXHl+di/d
	 LygmCEH5eglLccjh3DFoT6yuHUxx8B4Y3IFm5buggzAu+iQYcQJchUps/3i+G7DrEO
	 3xxQFc7JYTL5wO7joweHoz1AEjzkXs5LCgOsd5kcoACinTICY5RM+ZmuHFP/D3nKT5
	 URrX01/XPLkKQ==
Message-ID: <42aaafa6-e4ba-9a78-fe24-79a1ae457e5b@kernel.org>
Date: Mon, 16 Jan 2023 21:33:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] erofs: add documentation for 'domain_id' mount
 option
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230112065431.124926-1-jefflexu@linux.alibaba.com>
 <20230112065431.124926-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230112065431.124926-2-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/12 14:54, Jingbo Xu wrote:
> Since the EROFS share domain feature for fscache mode has been available
> since Linux v6.1, let's add documentation for 'domain_id' mount option.
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
