Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23D785B01
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 16:46:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uM30tP6c;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW8Cy4Pgcz3c5C
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 00:46:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uM30tP6c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW8Cw10gpz3bxt
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 00:46:04 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1263E6115B;
	Wed, 23 Aug 2023 14:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137BC433C8;
	Wed, 23 Aug 2023 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692801961;
	bh=bBXsUp0X1R7nK3RLb32WT1JFGUjXY8/gRLSJsyg+0xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uM30tP6cvNodqN4Xb678hssReK+ew5y/CQFjIFqVB+A+RnAliFjohQGSJfQdYgaeW
	 dumqpLoziUs7mBspR9t6smRTZk7WDq1AqKHs2IjOVnV41rOH8BY3vvsfz7ES5QUvWE
	 2++wZbRUr7haRXT3gtQhlDAxdbsiS5kre1XqFjzYSpjq5iqkBg7o1tTlz/gGuWT15E
	 herRVFYTYw8hFDOKdd5qa+DIARxvvNJSSjHWI4Tpvp/l6SMHdWs2CHZqy9P5HDYzn1
	 y7EmJYQLf5XclEOm9Tns1C/ZXcNNDFXqHTb1jICzAY3S/6h247A4pJE0JAXDNCIFyx
	 fIL7RSv8E/rbw==
Message-ID: <d3d35593-3359-3a96-c0b9-531455b288ef@kernel.org>
Date: Wed, 23 Aug 2023 22:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] erofs: add necessary kmem_cache_create flags for
 erofs inode cache
Content-Language: en-US
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
 <20230815094849.53249-2-mengferry@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230815094849.53249-2-mengferry@linux.alibaba.com>
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

On 2023/8/15 17:48, Ferry Meng wrote:
> To improve memory access efficiency and enable statistics functionality,
> add SLAB_MEM_SPREAD and SLAB_ACCOUNT flag during erofs_icachep's allocation
> time.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
