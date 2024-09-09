Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D7970C60
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 05:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725853083;
	bh=EZI2S0nTJGEDcrhLu8hUHbGE2IRU/Z8/fi+wmshz1Lw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=dneFmwGLv1TjY5Nn0PEefBpFQYjWK40he2Y5niyyukW4zIdmKsVesU+GTz3X1QoOJ
	 gFszrG5RiUbghgrvdGj6sQ0XKHsEdamrvyHDi/ghO7l89f9QHDkwxuH63rpUebKKvT
	 BVoTMtmw2xkzj72qWMhlkprpi6bV+c3F/EdpLsgqZUoSH8qazee5trc3wK8vSjTFC6
	 WEOhZSPYYX45Ih49zA75/pLT1vq0R+wgTxJYsx9H0uv4J2pqaftj8clANL0F7SOpLn
	 PW9BXV3AhUoJ8PQxq9q5klzSmgDVtEl74HKgMIlk9MudfxSrG4+zo3fxiY+ZGOFgKf
	 3OVsiNJS5cnIw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2CGM0f0cz2yMk
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 13:38:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725853081;
	cv=none; b=nqG6PVsZGTfTVfFPAItTCkJaKLlCAOO3fUIOOp6WNJRgPKAuvep2zJnlmzC3kSmRTcHdv4vVWbfBZrXk0FbfRvmn/6Dxq+gWbvqg58YT09Ob2OTlG0qrC4lS19JVmDaJXlhPzOLCE6HErNjmXEd78/NzMuVFLTdoMJ0uGt1nOWhF8gWzt80dTUshbgGXBFwZm6RVoKv4w64jlOA+4bMR3I/ww8Htp9v2h2+Pv4mecxs0r+mqdnMiebIaEPRwfgF12Oo/HNqUitFCwNLUBdOqzfqzWeKTOKGWonYkeLZZSUADPxzsJGdSUkzBg450g3ZQKA3SNexYyIi+4xzKJIWbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725853081; c=relaxed/relaxed;
	bh=EZI2S0nTJGEDcrhLu8hUHbGE2IRU/Z8/fi+wmshz1Lw=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To:Content-Type; b=IQYAdGO83UbO6dlfmWSnPkLskj5dhJmmB5e4swzQ3zwkDp2t0BzykJl5vusDRg1i0EA0L321Qmfa+FUQM8Tp2EwRpMKwVcisNplPnUi8YQ5upDa2Pi6Q953blZ5YJD+qQCxWrV7oBAE+8BPxauK5V4DBcp1RrxJ1G+rAqHAYvSV2TmMyrLwPeVpn9Rp6jlmKy2hALNKXeWtpHlVgZSP47FoRRrPTO4LQPeibRNCYzZuuEZCPsO1ATVVDq4NwZ4OGnDERg7g9IJYc3uLLuZdC8LZhh/mxXfUd5mMhpQSDj4vSMDD8k7kYL4T0Ow6CmUmz32apgcWI0MnUWB/KYsZrNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vLe0vO0g; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vLe0vO0g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2CGJ5HZRz2xf2
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 13:38:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5629FA42547;
	Mon,  9 Sep 2024 03:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884FBC4CEC9;
	Mon,  9 Sep 2024 03:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853077;
	bh=Ebsht7pufR8973XS6Pew/zX/2W72fELou862g4wEc/4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vLe0vO0g3h4DHaXN1Ji6laLgSaDkXmxsegVdqr+Xd4XL8O17ZrtKeJlzWIownnYxf
	 VjSqE5TKc+iX6p08aHG6BoGMGL4nYZEjcusoFCpb2jS54KCs+l8DEq5ZT8wDQ29F08
	 /9TqIpFLPRR03M8qQq0QZro6F7n453HqDlQr2TU58uEv6BMIWT3KxDFF/ZD9q95T+M
	 qBL0sIMFNPxmRLwtsfDYUXUrQqDbmvVP+nCdmJl1xm0R0+Wk4zUbn3vr3PHBYxLzZe
	 iPZAm0rYIhtmxvCj3kmbsX9ZMb1q4iT4dnX1iFFncCtPABS0h3YeFJ/m/C1EVnpZoz
	 0JEym1WJ8MYGg==
Message-ID: <aacfdf82-6b8f-44ef-9efd-e5356147d91b@kernel.org>
Date: Mon, 9 Sep 2024 11:37:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yiyang Wu <toolmanp@tlmp.cc>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
 <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
 <ZtV/speqypBt99sE@debian>
Content-Language: en-US
In-Reply-To: <ZtV/speqypBt99sE@debian>
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/2 17:04, Gao Xiang via Linux-erofs wrote:
> On Mon, Sep 02, 2024 at 04:52:30PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/9/2 16:31, Yiyang Wu wrote:
>>> Remove open coding in erofs_fill_symlink.
>>>
>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
>>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
>>
>> If a patch is unchanged, you have two ways to handle:
>>   - resend the patch with new received "Reviewed-by";
>>   - just send the updated [PATCH 2/2] with new version
>>     and `--in-reply-to=<old message id>`.
>>
>> I will apply this patch first.
> 
> I applied this patch as
> 
>  From b3c5375ceb2944a7e4d34a6fb106ecd4614260d7 Mon Sep 17 00:00:00 2001
> From: Yiyang Wu <toolmanp@tlmp.cc>
> Date: Mon, 2 Sep 2024 16:31:46 +0800
> Subject: erofs: use kmemdup_nul in erofs_fill_symlink
> 
> Remove open coding in erofs_fill_symlink.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> Link: https://lore.kernel.org/r/20240902083147.450558-2-toolmanp@tlmp.cc
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
