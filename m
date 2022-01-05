Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DC484BE1
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 01:53:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JT9w23WTpz2xDV
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 11:53:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a+ezEO8l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a+ezEO8l; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JT9w007Zkz2xDV
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 11:53:35 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5E3A2B81851;
 Wed,  5 Jan 2022 00:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BDCC36AED;
 Wed,  5 Jan 2022 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641344010;
 bh=jergCAhRYTU+TiCYuJkBvbFhW93KpBAqa0tzEQwCpaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a+ezEO8l8Gs7Dzxh9b+lG4M4Ef4A7YmBGejtMGerWh16YPH1vJhK4fGLiZ2arxwnw
 yMtIvOZZRvYyix9h+Gt/FOMlWZ0RD/k2rd+zLCeVgKW/2jhTEXLFgUYxXWmuCx35Ng
 UFimf040DwjBfsG/MT1S8I5V/wpmozzBcI17oV69g0iRE7ZGD5neLHOJ/9nEMDy6Lm
 kXW872zZ0haOESz0xB/XpNUXownWsGFdJFP8LQKiQK8HmCmQNdeszoXWB/kG4qP8KO
 bqAOe4YYxSYFzJHLdYx+QqbjnOqWKdigSFj5dDDQuZaTMTuNz3AszG3mBInfsDga8W
 Eah6bT5La7TWQ==
Date: Wed, 5 Jan 2022 08:51:40 +0800
From: Gao Xiang <xiang@kernel.org>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v2 1/3] erofs-utils: lib: Add some comments about
 const-ness around iterate API
Message-ID: <20220104235901.GA25291@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Kelvin Zhang <zhangkelvin@google.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Gao Xiang <xiang@kernel.org>
References: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
 <20211222014917.265476-1-zhangkelvin@google.com>
 <CAOSmRzgOB-78BSc4Ug-xNnS+Cc6x8AZ8zEVTYPU4iiKcOowVWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzgOB-78BSc4Ug-xNnS+Cc6x8AZ8zEVTYPU4iiKcOowVWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jan 04, 2022 at 03:37:51PM -0800, Kelvin Zhang wrote:
> friendly ping

I already merged them. Didn't I?
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=2be280dc28ace9c3840aa5e6ca7ff90ef4212cd1

Thanks,
Gao Xiang

> 
