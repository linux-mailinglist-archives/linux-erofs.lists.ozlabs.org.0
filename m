Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5876A0F73
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 19:30:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PN1lz3RDYz3cXX
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Feb 2023 05:30:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E1Vs560f;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E1Vs560f;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PN1lt6qRQz2yRV
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Feb 2023 05:30:02 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1D5B1B81AA9;
	Thu, 23 Feb 2023 18:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD50FC433EF;
	Thu, 23 Feb 2023 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677176997;
	bh=FDtSn6RCdhK29pIP/7am1BjCvIl0avHM6OD1PRsuEaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1Vs560faX2Rwvsoa/KWKQjxFyh/MR7/JgHP73Iu2kiW6lgV/x3diRoIFEEP5DBuV
	 OWy6Qgt7UTJuNTevYMjETeogFTbw6tiCCo3YhnUwmmqqTvnGB5+or+HFQp+k1I1LU3
	 +oOVG9bPs0UK8xzae2LTQqHEhtiJg//LIeAPnida//rcqW/rCuppLvad6pbfhNMfCE
	 XdAgxvQ5MGRfEfPJirnvdcY3Q1rF/c21AYOe7vQyIS6HWdsX+fGK3Hj7nUm6jw4hYW
	 IogWCTeKjzf96djhht+bjzzxx9yPkzeNUGHoX+96vGaQvpY4eg5aizuHHfGnHN607g
	 HnA7oxsGW9hRA==
Date: Thu, 23 Feb 2023 18:29:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
Message-ID: <Y/ewpGQkpWvOf7qh@gmail.com>
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
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
Cc: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>, Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
> From: Sandeep Dhavale <dhavale@google.com>
> 
> Using per-cpu thread pool we can reduce the scheduling latency compared
> to workqueue implementation. With this patch scheduling latency and
> variation is reduced as per-cpu threads are high priority kthread_workers.
> 
> The results were evaluated on arm64 Android devices running 5.10 kernel.

I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.

Why is this more complex solution better than simply removing WQ_UNBOUND?

- Eric
