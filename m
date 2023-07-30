Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C34B768564
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:04:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IrIK0NzX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDM683nj0z2yFD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:04:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IrIK0NzX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDM654c3Yz2yDr
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:04:45 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C7AF560C34;
	Sun, 30 Jul 2023 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9CBC433C8;
	Sun, 30 Jul 2023 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690722283;
	bh=LbTRsMIn2pfq69jUpFsw8eMAQoJ9qEQbZDQQkb/RwlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IrIK0NzXbn3PEbZ04Zdv2z/rXX/H//DWmr1onoJVB8EvqzRyEUv1sRISRe31mhy0J
	 cnaHdB8BD/gh15pogDZ/10W0mErx1Ji9YHv/tp7QsFswspDooYYZ5wD5czNcX/b3Mk
	 HScG6o3jD4DjOq8PQejoDyNYw9tlmLbMjkLD1cr88NXy49CxmLBo85a0GHr4cWpxk3
	 kbEUOdzCD85LeeLG64DmoasJ5+KirImUyLez1ibyZGRcwtcX6Um34z02HLNfyXZeI3
	 M8zgxagwSVXrkZuy/vl5Se36OHRZrKNrSPcmiedLs53KWqeER3oe3AYMGbCBsQcVaA
	 h/SQS9+/WKePg==
Message-ID: <ed18eaf6-e5c9-2de8-d6b3-a5f121e4c61e@kernel.org>
Date: Sun, 30 Jul 2023 21:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, hsiangkao@linux.alibaba.com,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
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

On 2023/7/17 19:27, Jingbo Xu wrote:
> Later we're going to try the self-contained image verification.
> The current superblock checksum feature has quite limited
> functionality, instead, merkle trees can provide better protection
> for image integrity.
> 
> xxhash is also used in the following xattr name filter feature.  It is
> redundant for one filesystem to rely on two hashing algorithms at the
> same time.
> 
> Since the superblock checksum is a compatible feature, just deprecate
> it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
