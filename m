Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FFE497A97
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 09:47:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jj3XY3kFVz30QD
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 19:47:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VFN/jRr3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VFN/jRr3; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jj3XT6hyHz2yZ6
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jan 2022 19:47:53 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 12CA8B80ECF;
 Mon, 24 Jan 2022 08:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8791C340E1;
 Mon, 24 Jan 2022 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643014068;
 bh=HZnUCYDMYPExwgg8l+2jKgG2vC3k8LkS337NzZjY9ow=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VFN/jRr3qc85voQcohH3lFZn4SfTddsIg5JiyZJUafhLLo/hjVpaQgCgt6/hANh2b
 cVqydYjIyfc1OfVSM/1jNkO4djf+Nnbt3ddigda4dUO6mynA0lqE/IotzoIb9UuDgA
 n/6D1uqgQ8JgHuWnY5Sqs+pXMhA8jxuqreD1XX1EPL/nf0kAfKcEZs7zcAqfX0BZ0x
 XaSqHfWE/DV0bHYqyJEC2JHwjJEy8HtuPlgXtovuQOqUTdm26F0PhxGsDe5U31Zm2Y
 NWIsn70jJBOQCIwu4xh06UBXzyo9J+y4aKM4HCg82xBbOU/QIOFBORXuLVRQ8tH4ET
 ADBpF4hOJUsdw==
Message-ID: <280ffeb4-4145-79c6-d8b8-081cab0ba1b0@kernel.org>
Date: Mon, 24 Jan 2022 16:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] erofs: avoid unnecessary z_erofs_decompressqueue_work()
 declaration
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/1/21 17:14, Gao Xiang wrote:
> Just code rearrange. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
