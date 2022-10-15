Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3995FF813
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 04:47:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mq72v3VmVz3c7H
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 13:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rPiCtlEZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rPiCtlEZ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mq72l5Cc3z2yn3
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Oct 2022 13:47:27 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 536D861CAE;
	Sat, 15 Oct 2022 02:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80363C433D6;
	Sat, 15 Oct 2022 02:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665802042;
	bh=/BEvo3ho6FYtrscyZeC1vth4Xpjqk5rZmS+7kUDD5OI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rPiCtlEZtQiGq1E7XrZhAFA0O1qzqF0/xQsfUhdnrJWJFMRs92ye+mRMP9RqTkADU
	 rjanlnZIcpQeHSAfYkfgonyFALyXv2CSbr02cdf9OBOD9FQVSADMug3/hvY0V5UNYQ
	 S1cnh84h9L/IetZ2gT0YnFgimWtPgM+tw9CUqu5c7xKjvuNnwTdxWJ0ETQQQLRh7AP
	 jOblHNxziYCd9Cng2eDsfll80ma6Z/IAkM4sztnu27TE7umLDQWhvact1FaIQ7IjfH
	 ceSdsTGFfwQO0UBnIm1DQ/FNs1YPl/GIPJmZlI4u821v69TgAsZrIdyMY+YyN5qjuG
	 F1rgGf9e+cX2A==
Message-ID: <21f00900-92da-f70f-2dc7-bbaab05be529@kernel.org>
Date: Sat, 15 Oct 2022 10:47:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] erofs: fix invalid unmapped accesses in
 z_erofs_fill_inode_lazy()
To: Yue Hu <zbestahu@163.com>, xiang@kernel.org
References: <20221005013528.62977-1-zbestahu@163.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221005013528.62977-1-zbestahu@163.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/5 9:35, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
