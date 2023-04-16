Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EF6E393D
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:30:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pzsz55pNCz3cMf
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:30:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MKfxBOgp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MKfxBOgp;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pzsz26dchz3bbZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:30:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E811060CA0;
	Sun, 16 Apr 2023 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B670C433EF;
	Sun, 16 Apr 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681655404;
	bh=89mDZMg+xFD90cl8I+iHM3Ipz3bqJ7SUgk7XUSskT+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MKfxBOgpd2hhrO2Y75pAox3UaFwmdLc6eF+v750eqizYlHV2Q4s8VqzljIVfY+HZn
	 q95idOePRhMn97tre5JmMIEj88MBicX6YTQTMPc1xtmuS1tNRkDCW6y6rr+Xb0LLzs
	 +6CrdzXnrfTDegmjsF/qyng2SjGSqFCYFzUaLArnBuqUjwtvvFuvNSoCxSooXXRtPf
	 4UTGXOTc4Blfnuees7S3sec0Xt6Ds1a6dRyOwhIiLPrZxzs42BjsjjA32KT2QIuccu
	 4P7UBja4fOZnp6PE9MufnnmljsQduab3ycCc1P2zuGqGsDIktvvb4qslZr8KOaNtCT
	 u61EZ4o1TGBGg==
Message-ID: <90dcc3c0-2100-5c30-d4ad-1058b386fe8f@kernel.org>
Date: Sun, 16 Apr 2023 22:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: don't warn ztailpacking feature anymore
Content-Language: en-US
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230227084457.3510-1-zbestahu@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230227084457.3510-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/2/27 16:44, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The ztailpacking feature has been merged for a year, it has been mostly
> stable now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
