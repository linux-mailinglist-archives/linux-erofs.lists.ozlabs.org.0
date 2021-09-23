Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67D416006
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 15:34:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFbkJ369Kz2ynL
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 23:34:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Irw1kK6r;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Irw1kK6r; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFbkF2Kj1z2yNZ
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 23:34:45 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB2761164;
 Thu, 23 Sep 2021 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632404081;
 bh=LqLYzE3HwM72W3M0qWRK4FmjKgjMOvzgm/+ibZFzY0M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Irw1kK6rPdCI9lE15ZkdAlF4md7Hovl3fABqEG9n0dgVhh3L3MH5O+srgtpw+jgkH
 Bg6AcWdBMrBzcQ21M1paqUcHpl1WoPdp/x8yUSv3q3swPS4TQCXGdJHTC9RL9Pk6uF
 owihBAnugJ3mkYk+oLlSVfhXnfghE3QVg/n6Ze+R4pBagWRE9aweluInkferJu44uQ
 WqzCpZ55gHywmeGsNR4g8rcRk6jAZ0rK8TjR0PvMqYwVvnEA4+U6KI5+w4CY4/1LMR
 mVm+zWFKJbRM/XvW6a7lqf3bUzvNGrcEH+mkxhn42WYWuFOrxXLtdXfaZBb3BUzVX5
 hgC4FlpY64s/g==
Subject: Re: [PATCH 1/2] erofs: fix up erofs_lookup tracepoint
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20210921143531.81356-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <4823f65a-5282-0496-44ab-0d471a5b2b27@kernel.org>
Date: Thu, 23 Sep 2021 21:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210921143531.81356-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/9/21 22:35, Gao Xiang wrote:
> Fix up a misuse that the filename pointer isn't always valid in
> the ring buffer, and we should copy the content instead.
> 
> Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
> Cc: stable@vger.kernel.org # 4.19+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
