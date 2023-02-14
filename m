Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41369678F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Feb 2023 16:03:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGPbV1XhWz3cK5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Feb 2023 02:03:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pemf4PCS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pemf4PCS;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGPbR24Hqz3c9r
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Feb 2023 02:03:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8AB4BB81DD3;
	Tue, 14 Feb 2023 15:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D0BC433EF;
	Tue, 14 Feb 2023 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676386991;
	bh=QLQZyyz2dCE0X2QY3OFwV/Rc+966QInmCo2XHAK53SY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pemf4PCSWgePk+z/D5uD/EWjuniQPvddeiPT7hxTKuKbNYYrH6H2vAcwEdFacmipP
	 IbfDF6DM8xrX88Z5Yhv5zeABiLpHc4X+wZPxfsWpLVSZJL0/Kgt/2WGpHrq6Ybxwl3
	 IebWYIt6eLiv8mTsNwPGhQ1TAcOf+wVPcQmhTfW2u1AIzuJdtK/O7J3VI+beP6hRWJ
	 +etTg17dbrv0ofAjZLEB3hT0xfomaIgW+EGXx9Y4SQIJLdots9FfOBqMQ3wQoQAU66
	 A/RvUFVFYD1IPtTdZmnZR+mZZqf4YbSlPzzLBd3SYm6uPxKXWIWKrxia/eH0e9hBoQ
	 Nl32ySXeMvwCA==
Message-ID: <9ed76b53-7d24-d49f-3c82-4530e9998ff5@kernel.org>
Date: Tue, 14 Feb 2023 23:03:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/4] erofs: remove unused device mapping in meta
 routine
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com
References: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
 <20230209063913.46341-2-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230209063913.46341-2-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/2/9 14:39, Jingbo Xu wrote:
> Currently metadata is always on bootstrap, and thus device mapping is
> not needed so far.  Remove the redundant device mapping in the meta
> routine.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

