Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B74D5D30
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 09:22:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFJpM1rB5z2yxW
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 19:22:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TE9++wo/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TE9++wo/; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFJpK1Skwz2xXX
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 19:22:49 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BB668B82AE0;
 Fri, 11 Mar 2022 08:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970FAC340E9;
 Fri, 11 Mar 2022 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646986965;
 bh=e53sKv4/sgMFpOpcsVCcWxcvQgALDrGx04R8j5M2NDM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TE9++wo/LoCYqL/K1eeBz9E2iczzxCqObmv7bbjlO6qJ6xPmONV2725LmVH6TlRvq
 9OAgaBrySe7rG/ylbo+VV2hfdqUillTiMozXS3mCIX6eGeohU/1aKgYPLTiyZo8mVB
 +W0wBqM63+vXlyz+whB0oT0864reB+jbKKqHK18EfimGtCyhD4KchrZvuQBY7gkUfj
 Ja20r1OMZ13JASbR+RDlKbDDkorHCkjFGeUiGEtkGXkdnYTAeESxiVJ6dg3Iudi+Yl
 OdQ8XpOdVrGGOEAuDyTWYL+UbJaaJnApx2sldcTCu2dnESnlknNax/FP3bHNw3F/G4
 tOaUljyoKZw5A==
Message-ID: <98f5a81d-23a5-4003-c7fd-d40d9ff46a1f@kernel.org>
Date: Fri, 11 Mar 2022 16:22:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] Documentation/filesystem/dax: update DAX description on
 erofs
Content-Language: en-US
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
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
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/3/8 11:41, Hongnan Li wrote:
> From: lihongnan <hongnan.lhn@alibaba-inc.com>
> 
> Add missing erofs fsdax description since fsdax has been supported
> on erofs from Linux 5.15.
> 
> Signed-off-by: lihongnan <hongnan.lhn@alibaba-inc.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
