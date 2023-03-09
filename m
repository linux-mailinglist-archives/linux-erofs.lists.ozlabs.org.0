Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553926B26EB
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:32:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXWqS0wsjz3cd2
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:32:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RsXUbPU2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RsXUbPU2;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXWqP3ZfQz2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:32:33 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E7B08B81F43;
	Thu,  9 Mar 2023 14:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483CC433D2;
	Thu,  9 Mar 2023 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678372347;
	bh=M9nBZUKdAbo7aqhUgYcmb5vUfX+KWQ3bKb7HjgwvMms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RsXUbPU2wJ0ZZHbaci+AdPqdWRIFlQeMTCGpk6kw2nDbgjrPaKV1nswhz3+VGjds1
	 07lEfdc7xIVPwQUrgfA+Q6zeBMG8XkDsmCNbLxaA86WZ74OeBpfIUyjUJD20dzpktz
	 rIbYwXdcgFRg2Y0YGLOkPAKOtwEyNqYW7XRtgWuypHSlWk8ccTIwtJjzSipGaFn1bG
	 qSJPu8FeX+QiDruDgELBaPQECknbR+BgiC4csSCm7RG183IxpFvxGz+V3GvBz2gEWf
	 /BhsT6gnZLkxpK36eCKYGD/RhdhVLnYrNDHU9jTlCKi/4v+NgM7NLnlRefn0Z7xCao
	 iN4fPVyPU/BgA==
Message-ID: <c62316f1-ef98-84cb-8a59-e5880b664ea7@kernel.org>
Date: Thu, 9 Mar 2023 22:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com
References: <20230303063731.66760-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230303063731.66760-1-frank.li@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/3/3 14:37, Yangtao Li wrote:
> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
