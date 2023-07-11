Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5E74F35B
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 17:26:30 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rv9BbNYM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0l8N0rbFz3bZM
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 01:26:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rv9BbNYM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0l8J1r3gz30Q4
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 01:26:24 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4DDC36152D;
	Tue, 11 Jul 2023 15:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3CDC433C8;
	Tue, 11 Jul 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689089180;
	bh=nNzm7/fIFcKCgpTFubxPRirAZXOaJPx4vFAcO8ouciE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rv9BbNYM+e8Xg4BZoWlF/P6n2/aoo3KcJ1HEBSlAp/+jPoJHPNV/tRT61i+oX7ha7
	 7UQ4iHAl6NT/Elm2keUAYAQ+mu3GeCSBfduZo0q1Ep3hQ0rkzwYd8IFPrH12F/MUkk
	 DcRX4ILiOGBRYfb0lerztsVcm4pniu2t+4dM9RIEiMiU4augIAzndnm85IIKhzBX/e
	 +FjE6LmpR4VNz62CIw2oaIF0loo8TOjd6Iuc2Rvb57DTZ19IradlyAf+K+pcWK1Jrr
	 QiVvHcJzN09pZeMr6s9iDRriPUeM5OtMiFB3TDmgV3TE1EBTn0CRju+tJEme1yhb91
	 luQKwi8QDU4Cg==
Message-ID: <1e8b9935-9a1c-3417-124f-0a8694e06f30@kernel.org>
Date: Tue, 11 Jul 2023 23:26:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
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

On 2023/6/28 0:12, Gao Xiang wrote:
> It's unnecessary to use kmap_atomic() compared with kmap_local_page().
> In addition, kmap_atomic() is deprecated now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
