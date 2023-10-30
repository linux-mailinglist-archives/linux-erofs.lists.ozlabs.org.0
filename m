Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B050B7DBC43
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Oct 2023 16:02:06 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JNCp0Re0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SJxM04Jkgz3cM7
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 02:02:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JNCp0Re0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SJxLv5WvTz3c4t
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 02:01:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7626060A67;
	Mon, 30 Oct 2023 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26EC433C9;
	Mon, 30 Oct 2023 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698678117;
	bh=92Q/lSc3g35CgKz+O/OyvcRiuLvIU5Y/apcn+mfhqQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNCp0Re0ZeD+k26H6TgV+j6Unr0JuNIY/D8vYxtywvmP3VjCn1E/eThekiACYZpds
	 cq4uECfOjMasN3tWzQoB5IhRVEuBUipCtvDC6gdV9UsJ9O3o74jhkSGJPR8z14ofVu
	 qSixbTSNk522ZNUAeAQ4STqohuoTHD6f91vwjYezR0a3C0BIMP5voesimcoTyzc6Yb
	 CFcw01IOu8bz8IPrq+RsJepOm/VIRVyetYQC1Q0Hcoma/sLa/bMauvvLSByGYUK4HI
	 JfKfOTwhUxaSwkzhvsywLdpxCeJ4h3DbCjp92CMrAil3rAZ0BHE7uAqiqksHQxvPzB
	 RjE9ey3gWLd1w==
Message-ID: <73c052d2-2283-3bf9-2717-cc199cbd8c0f@kernel.org>
Date: Mon, 30 Oct 2023 23:01:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] erofs: simplify compression configuration parser
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20231021020109.1646299-1-hsiangkao@linux.alibaba.com>
 <20231022130957.11398-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231022130957.11398-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/10/22 21:09, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> a callback instead of a hard-coded switch for each algorithm for
> simplicity.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
