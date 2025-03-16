Return-Path: <linux-erofs+bounces-60-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2465A63336
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 02:39:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFgkq3s4lz2ybQ;
	Sun, 16 Mar 2025 12:39:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742089171;
	cv=none; b=ABjVWi3OSRGmY0vZu895t30YoDGWAusBDd9M3Slf+GodkCIJ6OOzUaAY9STcJcByTfJjdZX/xXoWNmk24U39Hz3ruOk7xJfbFOxJV5kezOOHjM5qL8FWZ4UqXmHFNzHs4veFwp0WRAsNqc2fWiGM/v7Tyck4hMeX44cnJhimY5GkA8+wtrLG/N7x/bSxDDPQc5hE/nv72r1fTnv4s+jj8uZhYhcmPNZXxUTqS5W5MeLtOVVsLp3ZBbGEjNkWcQB4u8JzVSqCCW9z8cQVcMR2HFH1M1dxA+QR6/sTde5vkEU6OsIqRUyAXx9fZP+7NFPYidLSgpaM+DmPw7GgnxzzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742089171; c=relaxed/relaxed;
	bh=NXuDk/9tyV+nDkXuLbNV4+E7+NlbtpDqh1C7F45Cmpk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T1VmWzDW7GqlmMh63V4d8E08btU2bFcoH//UJmj1DGaljosirsvMXyjT59Mnws5scZn+nAbcEpsAmupHcInJwMUD2UaMHUqPI3JMPPYhuXOOpMZj2bNsieHKgSf5z8MxbrifPkwMFQ82Q7Uib6OU9S6m1++DE1vON3D9GYAoqV3Z7JO18kFqyq/5VFTfGyTQN/fs8Ptl0U4ViHr14L4LWpQlFfhbB1M8ZKb4KHI54b8pKF5nfZn7WOmEfe4R4vrz9z4ZIItWNhreN0kr6SGMbMEfAmKK11XI2BSaK1C+LgbWYOrzMxyHq/AgnHhSaBKbbVPuaqT9g2ivvs1rPk/CXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ATMpC5U4; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ATMpC5U4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFgkp4sMzz2yS7
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 12:39:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D256C5C075E;
	Sun, 16 Mar 2025 01:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D60AC4CEE5;
	Sun, 16 Mar 2025 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742089168;
	bh=tHdAxXD2Buvw5a8n+0GqZroHLjBlPAlQ/L5CGsmDE5U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ATMpC5U48eo7jJ4/LTTVicXCcSZ/X4mQJBU06wcHhkLip8t4gdFJt71OWQJXd93rA
	 Ru2X9gbotuEGu42s6mv7KViod7ys7Vafvxz3e2FDKi6ZJva+W2vhrGYfvPwtJDsYoB
	 DLCdmt+bZyWi38p3pQ5ue67EeYOkOc7ROa4V59VEg8/Cw9b/2fpAcoo4gLpmXBXYn+
	 ukN8guuUxm6V32xUE1KWbEV75/IR5XTVHeNg6hRt++kL+qOTrXtwi5mCwOiVWVNMe0
	 6Qm7HyPRVcZLunm5D/d58qoDGUmI05OSr00MVMInpLOxRcB7WTq72JVhavCUqJL6qQ
	 JgIGY+i5qOZ9g==
Message-ID: <7d2c029d-13f4-4318-8cd0-37512d0bc258@kernel.org>
Date: Sun, 16 Mar 2025 09:39:27 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] erofs: simplify tail inline pcluster handling
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
 <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250225114038.3259726-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/2/25 19:40, Gao Xiang wrote:
> Use `z_idata_size != 0` to indicate that ztailpacking is enabled.
> `Z_EROFS_ADVISE_INLINE_PCLUSTER` cannot be ignored, as `h_idata_size`
> could be non-zero prior to erofs-utils 1.6 [1].
> 
> Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
> features are mutually exclusive for a given inode.
> 
> [1] https://git.kernel.org/xiang/erofs-utils/c/547bea3cb71a
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

