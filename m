Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AC5FF818
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 04:50:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mq75t5ydDz3c7H
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Oct 2022 13:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MvXRlz+l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MvXRlz+l;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mq75q0ryGz2yn3
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Oct 2022 13:50:06 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 36FDD61C3D;
	Sat, 15 Oct 2022 02:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED403C433C1;
	Sat, 15 Oct 2022 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665802204;
	bh=DC9cQh2iywyg4Y6PZKDaIDzvavBQlm9a/fexbxAjr0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MvXRlz+lKRXYZ7f+hCajHWH7xh9Y4gXeXKX9s+H1pNwHPsC4uB2l46ONHV14DU0om
	 XzUxnKE4QH4KTo4LCkTUO+/z16stjftGzUPAgNQ79gq7pIeBeYHY/aOQ5iArUMfebk
	 yg6FaVw22RVhjDPUlOJnvvmEsH2CQAKTNJI5qyTqlg9WJyhrY2UkTO4yglKa6QlPvA
	 3VvdQlDqzxIyOz1VXT4NfUZsPGLcnpb2Ini9CnvgekVAQBJOlyzyIbuYeywWUKnzzJ
	 lq8wnYJE85BEUOH5zX3vZvQU8f/4HKNxf/YtTS4o9FSnVrSqEoJYM2MkfsutOMhxv5
	 hUGd10phwRMqw==
Message-ID: <cb1474f7-b1fd-f22a-4250-77f2e931a742@kernel.org>
Date: Sat, 15 Oct 2022 10:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] erofs: shouldn't churn the mapping page for duplicated
 copies
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20221012045056.13421-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221012045056.13421-1-hsiangkao@linux.alibaba.com>
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

On 2022/10/12 12:50, Gao Xiang wrote:
> If other duplicated copies exist in one decompression shot, should
> leave the old page as is rather than replace it with the new duplicated
> one.  Otherwise, the following cold path to deal with duplicated copies
> will use the invalid bvec.  It impacts compressed data deduplication.
> 
> Also, shift the onlinepage EIO bit to avoid touching the signed bit.
> 
> Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
