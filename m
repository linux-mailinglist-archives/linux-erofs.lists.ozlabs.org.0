Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F09D785B3A
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 16:56:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfSWOBIV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW8SG0kKxz3c56
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 00:56:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfSWOBIV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW8SB3lNrz3c1M
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 00:56:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B7A4E6137C;
	Wed, 23 Aug 2023 14:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1CEC433CA;
	Wed, 23 Aug 2023 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692802600;
	bh=6S+2S2otZqoFjmZl2ckQ6GZtxYGNl9rwq86awBfdKco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jfSWOBIVGGcZc3GoOkreZDc5Lr1MOIz8Ci4Mn1anb7kBR41lP/xFXq8qjROBoex0U
	 +BE3upw+vU4GlgQVYG3W0muBub0hW/uNhYxF2IsKTfRZJeJ6exZvjN76Dgq6RF7dou
	 8zcRIsXc9yASEmlqkab8qWxvaoWn3uu2b7F5ItX9NROTKO1n8EdqkUmQYwyU/RUOZv
	 dBkt4lqvL1C9kZrOgs/4K1GBYtDQgC5x3Mj//hfchG2Ie5E31TUQUhetLUUR5edFph
	 NWJR6oGV+8kQir3gUpwAsh1kVbFhtvYPzyDgn5t8zIOjm6cGHljgeyhOajH2Fu2IkL
	 POGm6kHb99CuQ==
Message-ID: <df3df9e2-73c7-4e9b-afbd-85078f24d235@kernel.org>
Date: Wed, 23 Aug 2023 22:56:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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
> A trivial cleanup to make the fragment handling logic more clear.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
