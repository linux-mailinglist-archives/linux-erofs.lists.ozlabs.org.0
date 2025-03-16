Return-Path: <linux-erofs+bounces-62-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A63A6333C
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 02:56:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFh694JYdz2ybQ;
	Sun, 16 Mar 2025 12:56:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742090177;
	cv=none; b=AyD8cCjtc/rPOp8ZZVPDYzHEM9efIwELFZw1z71eoj8nYMyceHMHztAbKi/T3aFxVmthXOERZYeQrdVXSnp9MKmd5YqBCbiht7KE5jf+c/WiPcWty2oGXDOpFtpKHZzfaaaT1pvt9/d2uby0o5huMPjFl4Ay201kOjo/Oj/+RetAwSgOwW/PWhrhPWCpK/43jZVIWbLBhO1WCHpr2BboMQpllFRroKgEoEMXHcQOAzWMO0NpjcRhvwCH6tJNVoS9pDQlDCWmqlWoqwKMvRfDL/YxAnZ1hU79LIc8CqnGQqdQ8C1EM9IH2NvWq2h3yRtO1AW6CqnFldaTpNgZnIC+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742090177; c=relaxed/relaxed;
	bh=LWqeu7FAGhoerWAbcqqGMjkIsG1fQmLa9/SV/XK8NkU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hc6s92CwrZ9C9ZrDv5IXNRqQFcTYoQzAW5ZtzEkqoaRDPE/2pFJan5o7iNf242q9aejuOda+ME4sAlKZKKskiLbrqdxbNy1rGA6rkUq95l8aONJ9/PcXHkUM3JWaCzsopn3prS+lXKnAi9W41MW0L55ekpKwOXsROtyEszrRCDx+jvBhwqHFTc6Q8QC4plXjS9eic8/oREIZsl5SDksfn8tMroVFzgtsIWfBheBfrYIdQBn6wlaMxUTkpKZs5klD+2AewFkBqVVaTWaoTrFAmDzvsZ6xmNC6HBQyexL8JL6vGbORosnONSOGP5CxkUA6roFd+vwv9JRa7Gw2+hpmlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fe0+MTYT; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fe0+MTYT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFh685fBpz2ySZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 12:56:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 13BD45C432F;
	Sun, 16 Mar 2025 01:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72768C4CEE5;
	Sun, 16 Mar 2025 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742090174;
	bh=TSApGeq561AKpnh0Qf+XWrQjdOoTxwaKJz/vBCl6scw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fe0+MTYTctzs+5mldrlTR8Vc8OwHqtMst5vYqn0Nh+J3vSHWbtoqQPB8WMeBfx9kH
	 nBQOFIL5Tyl77NCadB3gcUD0pv0GfHmtcPTOMr7y3pFEuLT3EW7dW63+au6kZGsWTz
	 nGn7Ph0HtiVTFiccRYL3FCKSOY4fwk/JtKmkduRldIOuOtBqDr6u3jLjkALVwzA3mX
	 FMMf/IYHPeQ/SOgOmvTaeICFgAkLoVxgEKZPtPSmhUsG6FZcSGh2FbKyCI7kL/r85m
	 o/RnqtVRam5m7h6bx1RMAJTDXkSjBdogYD9gsyzDLjUV2fKu7R0VpNaGGUAxroNg8E
	 D3NGJ8xhER1+g==
Message-ID: <2e0ede6e-3cfc-45fd-b287-2d41e561939e@kernel.org>
Date: Sun, 16 Mar 2025 09:56:13 +0800
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
Subject: Re: [PATCH] erofs: move {in,out}pages into struct
 z_erofs_decompress_req
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250305124007.1810731-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250305124007.1810731-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/3/5 20:40, Gao Xiang wrote:
> It seems that all compressors need those two values, so just move
> them into the common structure.
> 
> `struct z_erofs_lz4_decompress_ctx` can be dropped too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

