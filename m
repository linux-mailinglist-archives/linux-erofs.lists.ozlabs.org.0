Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E76E397F
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:47:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PztLj1xYkz3cMb
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iIQnBNiO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iIQnBNiO;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PztLf0k2bz3c73
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:47:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4AA1F61362;
	Sun, 16 Apr 2023 14:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3863AC433D2;
	Sun, 16 Apr 2023 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681656423;
	bh=x/zF9nQGcQmo9J0zDMKFR6/60lK6sJYHHMJyzn5OqyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iIQnBNiOrw67ku333VmuCHTxqwb3OmXUK8Tk+5/KZ2gLTOY0bfRi3eDvWFA/pIGeA
	 NmFzgRsURvpnN4rqgwJVnNKUXjB8FlULg+y+5nr1n5H0dI6ilHOu+AztB4wtCkiofi
	 4n55gx+KIoztTEnVrxCkB9wCENvp83H8+EJVuPu0TzipeY6H79cVcg2EeEDc9omcjm
	 ZG2nBD1kxyqYii1JrvTwIsAah1hhvhakzn/9PrLAyE1i3QbCwaSSzn1bEYGYy/Bzs/
	 qwNOgHCzJMQlssacdK2HPRhDHMMloZsLhRknSUtJxvGNzVTUARTfyyvvGoQ4y9YEi4
	 vV5Z1QGdyWbvg==
Message-ID: <363cf8e8-326b-6547-b780-268ce2e3c1a5@kernel.org>
Date: Sun, 16 Apr 2023 22:47:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: fix potential overflow calculating xattr_isize
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
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

On 2023/4/14 14:18, Jingbo Xu wrote:
> Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
> from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
> of 256K (64K * 4).
> 
> Thus declare xattr_isize as unsigned int to avoid the potential overflow.
> 
> Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Good catch!

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
