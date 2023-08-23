Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C98785BE4
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:19:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MIF4DIvC;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW8z020pjz3c5L
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 01:19:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MIF4DIvC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW8yx4kmjz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 01:19:53 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EA59965BFD;
	Wed, 23 Aug 2023 15:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B698C433C9;
	Wed, 23 Aug 2023 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692803991;
	bh=uBDCkLnKfifcqL2Bn9zaiIl1ike83ejaqgx7O/VU6sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MIF4DIvCZ2PUVz6JOKztBA3cNJ3uI8b9s3MnjQuFNMJjvUSVkJrk39vOTkzmOw5H3
	 SIJD9w1KF9XJtW9eI3KJOHGBkgJxVMvBMQhxU77XfN04uIjcbpWH69UMCdZ4sXsFGL
	 B8HDXu5I0iXGf7c1h0VbWjosL9MXXwuaeQDpU9bcWik+va9kCJiBQr/aZqNosOFVxF
	 Hh0Xrg5+HZpwQPRFPKhn9JWR9weL5bJ1mjCrJ6nEDta/TdfDvv2P55k9mcmoeOcizY
	 DOhMkWBxIY0AUL88qwa16JBTBoPTfOKXVMDM+I0nBh2MJVUsvoJzaj5iyxokCDhrCr
	 w9J/W0IDqeNmg==
Message-ID: <cac0a547-7a90-aad4-8911-63f38883c966@kernel.org>
Date: Wed, 23 Aug 2023 23:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
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
> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
> incomplete pcluster for later read or not.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
