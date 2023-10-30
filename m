Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569227DBC19
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Oct 2023 15:50:42 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q6Z7Mrmq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SJx5q3JHDz3cDk
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 01:50:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q6Z7Mrmq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SJx5k223sz2xdZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 01:50:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8B5E3B80D0D;
	Mon, 30 Oct 2023 14:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC56C433C7;
	Mon, 30 Oct 2023 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698677429;
	bh=Lq3kUlbKODK3hpI0ykMHy/CoeP2mot4776pgkJO0T1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6Z7Mrmq5c4vvIr47jfTjs9fdgEa++nxwoO9Bf2u8e37HFW2+2KorqY/7h8lqm428
	 fS6UZKX/tKN63ZhJs01OjeQ+6+DsAP6csmXTLrgiA+T+EUZSJ/haAe2/b4DY5lnVYI
	 j+rWINl2eAcywmAgsJ01ACcmCQlwI8SwNPnY9mOyJZyBq0QZzjP1RDwGWKcNw5Jh0f
	 F72zQK1BnujuzswhhEdOre0NwjOZRBbczJiAvXzxMTq8ZyW7NJ+MhaH5hMOoY/nY80
	 uMNKsCqLTcqw6GkBDb4yrIDWdyvu9AnFVwt7EroRZIY6C0Qkz+6wMsQxgNkIuq4+c/
	 S06GXugMAg2Bw==
Message-ID: <c5450fd8-d4da-bbf9-006e-33428506bc2b@kernel.org>
Date: Mon, 30 Oct 2023 22:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] erofs: don't warn MicroLZMA format anymore
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231021020137.1646959-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231021020137.1646959-1-hsiangkao@linux.alibaba.com>
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

On 2023/10/21 10:01, Gao Xiang wrote:
> The LZMA algorithm support has been landed for more than one year since
> Linux 5.16.  Besides, the new XZ Utils 5.4 has been available in most
> Linux distributions.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
