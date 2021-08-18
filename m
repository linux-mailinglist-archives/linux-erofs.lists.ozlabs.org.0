Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1293F05E4
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 16:12:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqVFw02PHz3bjG
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 00:12:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hOeFRign;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hOeFRign; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqVFr4qYgz2xff
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 00:12:00 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66310610A7;
 Wed, 18 Aug 2021 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629295918;
 bh=AQfgKebWJLpeUBl2arSYIWfhz41gG8NbDvI7MDRVrSE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hOeFRigng7zChfxruaxhq7Uqn6Bx6YDu948lJMmvuy1kzjuMZo8GSDqD2QdERXBPn
 2Uggqe0k/CDDxqPnO1+5pa4sQd8j9rpFSgl6Ayxm0eD9gcpyplPL303fvxW8/U97Jg
 lSexQmYBWQ2M8kd/do8MCkHQkrD8p+uM53SBVZHE6gkP/IV51GsKrmqH6x5cMGL+Ym
 VoPwLpIcKRwPSay8rRrYaJH91HBP94GKgFLmIlv/0KzDPbx+HZxqSiO2qMpKPUdXym
 8BI+9X02ct1IkGXQ0XgaMUl5XRYIbNezqmpj0knFnU3L7oFZ7xIQHOXC8hMkDQ/0fU
 wyonOm5Si/aIA==
Subject: Re: [PATCH 2/2] erofs: add fiemap support with iomap
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
 <20210813052931.203280-3-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <39e06954-8fc2-3d08-dff5-8e39c97ac259@kernel.org>
Date: Wed, 18 Aug 2021 22:11:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813052931.203280-3-hsiangkao@linux.alibaba.com>
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
Cc: nl6720 <nl6720@gmail.com>, Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/13 13:29, Gao Xiang wrote:
> This adds fiemap support for both uncompressed files and compressed
> files by using iomap infrastructure.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
