Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407356B26F0
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 15:34:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXWsy0RW1z3cTk
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 01:34:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sQoKF2uX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sQoKF2uX;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXWss32fLz2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 01:34:41 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 11056B81F4D;
	Thu,  9 Mar 2023 14:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085EDC433D2;
	Thu,  9 Mar 2023 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678372477;
	bh=ZsnqhLeziSj/YtY1oiLcjsHq/QNNk3mZ9dJ9Pt4h/ng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQoKF2uX7GbyTVc/Pr2PeE1QT3nPbvZF+Y+F7cEOrqQHjgItkt1f2bAAHf9ydq26T
	 XrIIQ95xwSeGTa0eXY/Fs4XMlQq77DgbZCgR68c3WOXszRmozUiwM8QVMpoeZ/K9UK
	 Mw/Mfl4QUf8W0S3yNq69LQNux/zy+0BAbx/WoL5ji9Nxio5hGyysunQsT70aUgcWAX
	 VucYSy2r8kXoi0HpLoix+aqGzosa8o1jtuHNuJOgQp3X4doPGb+BU2lU1FGKlb0hFH
	 2NrB6qD7kzIhlfxAfvVidHyAUy7CHM0qSNwOWCiQm2PhPKuxEqcQRgk1g3/H1z4uEA
	 79fB2mHqt35Qw==
Message-ID: <56992244-f656-8945-94d1-801223530259@kernel.org>
Date: Thu, 9 Mar 2023 22:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] erofs: get rid of an useless DBG_BUGON
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
 <20230309053148.9223-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230309053148.9223-2-hsiangkao@linux.alibaba.com>
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

On 2023/3/9 13:31, Gao Xiang wrote:
> `err` could be -EINTR and it should not be the case.  Actually such
> DBG_BUGON is useless.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
